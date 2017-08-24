From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 24 Aug 2017 18:04:40 +0100
Subject: [PATCH 09/14] arm64: kexec_file: add sha256 digest check in
 purgatory
In-Reply-To: <20170824081811.19299-10-takahiro.akashi@linaro.org>
References: <20170824081811.19299-1-takahiro.akashi@linaro.org>
 <20170824081811.19299-10-takahiro.akashi@linaro.org>
Message-ID: <20170824170440.GD29665@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 24, 2017 at 05:18:06PM +0900, AKASHI Takahiro wrote:
> Most of sha256 code is based on crypto/sha256-glue.c, particularly using
> non-neon version.
> 
> Please note that we won't be able to re-use lib/mem*.S for purgatory
> because unaligned memory access is not allowed in purgatory where mmu
> is turned off.
> 
> Since purgatory is not linked with the other part of kernel, care must be
> taken of selecting an appropriate set of compiler options in order to
> prevent undefined symbol references from being generated.

What is the point in performing this check in the purgatory code, when
this will presumably have been checked when the image is loaded?

[...]

> diff --git a/arch/arm64/purgatory/entry.S b/arch/arm64/purgatory/entry.S
> index bc4e6b3bf8a1..74d028b838bd 100644
> --- a/arch/arm64/purgatory/entry.S
> +++ b/arch/arm64/purgatory/entry.S
> @@ -6,6 +6,11 @@
>  .text
>  
>  ENTRY(purgatory_start)
> +	adr	x19, .Lstack
> +	mov	sp, x19
> +
> +	bl	purgatory
> +
>  	/* Start new image. */
>  	ldr	x17, arm64_kernel_entry
>  	ldr	x0, arm64_dtb_addr
> @@ -15,6 +20,14 @@ ENTRY(purgatory_start)
>  	br	x17
>  END(purgatory_start)
>  
> +.ltorg
> +
> +.align 4
> +	.rept	256
> +	.quad	0
> +	.endr
> +.Lstack:
> +
>  .data

Why is the stack in .text?

Does this need to be zeroed?

If it does, why not something like:

	.fill	PURGATORY_STACK_SIZE 1, 0

>  
>  .align 3
> diff --git a/arch/arm64/purgatory/purgatory.c b/arch/arm64/purgatory/purgatory.c
> new file mode 100644
> index 000000000000..7fcbefa786bc
> --- /dev/null
> +++ b/arch/arm64/purgatory/purgatory.c
> @@ -0,0 +1,20 @@
> +/*
> + * purgatory: Runs between two kernels
> + *
> + * Copyright (c) 2017 Linaro Limited
> + * Author: AKASHI Takahiro <takahiro.akashi@linaro.org>
> + */
> +
> +#include "sha256.h"
> +
> +void purgatory(void)
> +{
> +	int ret;
> +
> +	ret = verify_sha256_digest();
> +	if (ret) {
> +		/* loop forever */
> +		for (;;)
> +			;
> +	}
> +}

Surely we can do something slightly better than a busy loop? e.g.
something like the __no_granule_support loop in head.s?

> diff --git a/arch/arm64/purgatory/sha256-core.S b/arch/arm64/purgatory/sha256-core.S
> new file mode 100644
> index 000000000000..24f5ce25b61e
> --- /dev/null
> +++ b/arch/arm64/purgatory/sha256-core.S
> @@ -0,0 +1 @@
> +#include "../crypto/sha256-core.S_shipped"
> diff --git a/arch/arm64/purgatory/sha256.c b/arch/arm64/purgatory/sha256.c
> new file mode 100644
> index 000000000000..5d20d81767e3
> --- /dev/null
> +++ b/arch/arm64/purgatory/sha256.c
> @@ -0,0 +1,79 @@
> +#include <linux/kexec.h>
> +#include <linux/purgatory.h>
> +#include <linux/types.h>
> +
> +/*
> + * Under KASAN, those are defined as un-instrumented version, __memxxx()
> + */
> +#undef memcmp
> +#undef memcpy
> +#undef memset

This doesn't look like the right place for this undeffery; it looks
rather fragile.

> +
> +#include "string.h"
> +#include <crypto/hash.h>
> +#include <crypto/sha.h>
> +#include <crypto/sha256_base.h>
> +
> +u8 purgatory_sha256_digest[SHA256_DIGEST_SIZE] __section(.kexec-purgatory);
> +struct kexec_sha_region purgatory_sha_regions[KEXEC_SEGMENT_MAX]
> +						__section(.kexec-purgatory);
> +
> +asmlinkage void sha256_block_data_order(u32 *digest, const void *data,
> +					unsigned int num_blks);
> +
> +static int sha256_init(struct shash_desc *desc)
> +{
> +	return sha256_base_init(desc);
> +}
> +
> +static int sha256_update(struct shash_desc *desc, const u8 *data,
> +							unsigned int len)
> +{
> +	return sha256_base_do_update(desc, data, len,
> +				(sha256_block_fn *)sha256_block_data_order);
> +}
> +
> +static int __sha256_base_finish(struct shash_desc *desc, u8 *out)
> +{
> +	/* we can't do crypto_shash_digestsize(desc->tfm) */
> +	unsigned int digest_size = 32;
> +	struct sha256_state *sctx = shash_desc_ctx(desc);
> +	__be32 *digest = (__be32 *)out;
> +	int i;
> +
> +	for (i = 0; digest_size > 0; i++, digest_size -= sizeof(__be32))
> +		put_unaligned_be32(sctx->state[i], digest++);
> +
> +	*sctx = (struct sha256_state){};
> +	return 0;
> +}
> +
> +static int sha256_final(struct shash_desc *desc, u8 *out)
> +{
> +	sha256_base_do_finalize(desc,
> +				(sha256_block_fn *)sha256_block_data_order);
> +
> +	return __sha256_base_finish(desc, out);
> +}
> +
> +int verify_sha256_digest(void)
> +{
> +	char __sha256_desc[sizeof(struct shash_desc) +
> +		sizeof(struct sha256_state)] CRYPTO_MINALIGN_ATTR;
> +	struct shash_desc *desc = (struct shash_desc *)__sha256_desc;
> +	struct kexec_sha_region *ptr, *end;
> +	u8 digest[SHA256_DIGEST_SIZE];
> +
> +	sha256_init(desc);
> +
> +	end = purgatory_sha_regions + ARRAY_SIZE(purgatory_sha_regions);
> +	for (ptr = purgatory_sha_regions; ptr < end; ptr++)
> +		sha256_update(desc, (uint8_t *)(ptr->start), ptr->len);
> +
> +	sha256_final(desc, digest);
> +
> +	if (memcmp(digest, purgatory_sha256_digest, sizeof(digest)))
> +		return 1;
> +
> +	return 0;
> +}
> diff --git a/arch/arm64/purgatory/sha256.h b/arch/arm64/purgatory/sha256.h
> new file mode 100644
> index 000000000000..54dc3c33c469
> --- /dev/null
> +++ b/arch/arm64/purgatory/sha256.h
> @@ -0,0 +1 @@
> +extern int verify_sha256_digest(void);
> diff --git a/arch/arm64/purgatory/string.c b/arch/arm64/purgatory/string.c
> new file mode 100644
> index 000000000000..33233a210a65
> --- /dev/null
> +++ b/arch/arm64/purgatory/string.c
> @@ -0,0 +1,32 @@
> +#include <linux/types.h>
> +
> +void *memcpy(void *dst, const void *src, size_t len)
> +{
> +	int i;
> +
> +	for (i = 0; i < len; i++)
> +		((u8 *)dst)[i] = ((u8 *)src)[i];
> +
> +	return NULL;
> +}
> +
> +void *memset(void *dst, int c, size_t len)
> +{
> +	int i;
> +
> +	for (i = 0; i < len; i++)
> +		((u8 *)dst)[i] = (u8)c;
> +
> +	return NULL;
> +}
> +
> +int memcmp(const void *src, const void *dst, size_t len)
> +{
> +	int i;
> +
> +	for (i = 0; i < len; i++)
> +		if (*(char *)src != *(char *)dst)
> +			return 1;
> +
> +	return 0;
> +}

How is the compiler prevented from "optimising" these into calls to
themselves?

I suspect these will need to be written in asm.

Thanks,
Mark.
