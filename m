From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Fri, 25 Aug 2017 10:25:10 +0900
Subject: [PATCH 09/14] arm64: kexec_file: add sha256 digest check in
 purgatory
In-Reply-To: <CAKv+Gu_GX4cBw=UxMj89Eu7jLDTXRdPE=cF7xorxxYasaTGvOQ@mail.gmail.com>
References: <20170824081811.19299-1-takahiro.akashi@linaro.org>
 <20170824081811.19299-10-takahiro.akashi@linaro.org>
 <CAKv+Gu_GX4cBw=UxMj89Eu7jLDTXRdPE=cF7xorxxYasaTGvOQ@mail.gmail.com>
Message-ID: <20170825012509.GA7265@akashi-kouhiroshi-no-MacBook-Air.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 24, 2017 at 10:13:49AM +0100, Ard Biesheuvel wrote:
> On 24 August 2017 at 09:18, AKASHI Takahiro <takahiro.akashi@linaro.org> wrote:
> > Most of sha256 code is based on crypto/sha256-glue.c, particularly using
> > non-neon version.
> >
> > Please note that we won't be able to re-use lib/mem*.S for purgatory
> > because unaligned memory access is not allowed in purgatory where mmu
> > is turned off.
> >
> > Since purgatory is not linked with the other part of kernel, care must be
> > taken of selecting an appropriate set of compiler options in order to
> > prevent undefined symbol references from being generated.
> >
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > ---
> >  arch/arm64/crypto/sha256-core.S_shipped |  2 +
> >  arch/arm64/purgatory/Makefile           | 21 ++++++++-
> >  arch/arm64/purgatory/entry.S            | 13 ++++++
> >  arch/arm64/purgatory/purgatory.c        | 20 +++++++++
> >  arch/arm64/purgatory/sha256-core.S      |  1 +
> >  arch/arm64/purgatory/sha256.c           | 79 +++++++++++++++++++++++++++++++++
> >  arch/arm64/purgatory/sha256.h           |  1 +
> >  arch/arm64/purgatory/string.c           | 32 +++++++++++++
> >  arch/arm64/purgatory/string.h           |  5 +++
> >  9 files changed, 173 insertions(+), 1 deletion(-)
> >  create mode 100644 arch/arm64/purgatory/purgatory.c
> >  create mode 100644 arch/arm64/purgatory/sha256-core.S
> >  create mode 100644 arch/arm64/purgatory/sha256.c
> >  create mode 100644 arch/arm64/purgatory/sha256.h
> >  create mode 100644 arch/arm64/purgatory/string.c
> >  create mode 100644 arch/arm64/purgatory/string.h
> >
> > diff --git a/arch/arm64/crypto/sha256-core.S_shipped b/arch/arm64/crypto/sha256-core.S_shipped
> > index 3ce82cc860bc..9ce7419c9152 100644
> > --- a/arch/arm64/crypto/sha256-core.S_shipped
> > +++ b/arch/arm64/crypto/sha256-core.S_shipped
> > @@ -1210,6 +1210,7 @@ sha256_block_armv8:
> >         ret
> >  .size  sha256_block_armv8,.-sha256_block_armv8
> >  #endif
> > +#ifndef __PURGATORY__
> >  #ifdef __KERNEL__
> >  .globl sha256_block_neon
> >  #endif
> > @@ -2056,6 +2057,7 @@ sha256_block_neon:
> >         add     sp,sp,#16*4+16
> >         ret
> >  .size  sha256_block_neon,.-sha256_block_neon
> > +#endif
> >  #ifndef        __KERNEL__
> >  .comm  OPENSSL_armcap_P,4,4
> >  #endif
> 
> Could you please try to find another way to address this?
> sha256-core.S_shipped is generated code from the accompanying Perl
> script, and that script is kept in sync with upstream OpenSSL. Also,
> the performance delta between the generic code is not /that/
> spectacular, so we may simply use that instead.

I see.
Do you mean that "generic" code is a C source?

Thanks,
-Takahiro AKASHI

> 
> > diff --git a/arch/arm64/purgatory/Makefile b/arch/arm64/purgatory/Makefile
> > index c2127a2cbd51..d9b38be31e0a 100644
> > --- a/arch/arm64/purgatory/Makefile
> > +++ b/arch/arm64/purgatory/Makefile
> > @@ -1,14 +1,33 @@
> >  OBJECT_FILES_NON_STANDARD := y
> >
> > -purgatory-y := entry.o
> > +purgatory-y := entry.o purgatory.o sha256.o sha256-core.o string.o
> >
> >  targets += $(purgatory-y)
> >  PURGATORY_OBJS = $(addprefix $(obj)/,$(purgatory-y))
> >
> > +# Purgatory is expected to be ET_REL, not an executable
> >  LDFLAGS_purgatory.ro := -e purgatory_start -r --no-undefined \
> >                                         -nostdlib -z nodefaultlib
> > +
> >  targets += purgatory.ro
> >
> > +GCOV_PROFILE   := n
> > +KASAN_SANITIZE := n
> > +KCOV_INSTRUMENT        := n
> > +
> > +# Some kernel configurations may generate additional code containing
> > +# undefined symbols, like _mcount for ftrace and __stack_chk_guard
> > +# for stack-protector. Those should be removed from purgatory.
> > +
> > +CFLAGS_REMOVE_purgatory.o = -pg
> > +CFLAGS_REMOVE_sha256.o = -pg
> > +CFLAGS_REMOVE_string.o = -pg
> > +
> > +NO_PROTECTOR := $(call cc-option, -fno-stack-protector)
> > +KBUILD_CFLAGS += $(NO_PROTECTOR)
> > +
> > +KBUILD_AFLAGS += -D__PURGATORY__
> > +
> >  $(obj)/purgatory.ro: $(PURGATORY_OBJS) FORCE
> >                 $(call if_changed,ld)
> >
> > diff --git a/arch/arm64/purgatory/entry.S b/arch/arm64/purgatory/entry.S
> > index bc4e6b3bf8a1..74d028b838bd 100644
> > --- a/arch/arm64/purgatory/entry.S
> > +++ b/arch/arm64/purgatory/entry.S
> > @@ -6,6 +6,11 @@
> >  .text
> >
> >  ENTRY(purgatory_start)
> > +       adr     x19, .Lstack
> > +       mov     sp, x19
> > +
> > +       bl      purgatory
> > +
> >         /* Start new image. */
> >         ldr     x17, arm64_kernel_entry
> >         ldr     x0, arm64_dtb_addr
> > @@ -15,6 +20,14 @@ ENTRY(purgatory_start)
> >         br      x17
> >  END(purgatory_start)
> >
> > +.ltorg
> > +
> > +.align 4
> > +       .rept   256
> > +       .quad   0
> > +       .endr
> > +.Lstack:
> > +
> >  .data
> >
> >  .align 3
> > diff --git a/arch/arm64/purgatory/purgatory.c b/arch/arm64/purgatory/purgatory.c
> > new file mode 100644
> > index 000000000000..7fcbefa786bc
> > --- /dev/null
> > +++ b/arch/arm64/purgatory/purgatory.c
> > @@ -0,0 +1,20 @@
> > +/*
> > + * purgatory: Runs between two kernels
> > + *
> > + * Copyright (c) 2017 Linaro Limited
> > + * Author: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > + */
> > +
> > +#include "sha256.h"
> > +
> > +void purgatory(void)
> > +{
> > +       int ret;
> > +
> > +       ret = verify_sha256_digest();
> > +       if (ret) {
> > +               /* loop forever */
> > +               for (;;)
> > +                       ;
> > +       }
> > +}
> > diff --git a/arch/arm64/purgatory/sha256-core.S b/arch/arm64/purgatory/sha256-core.S
> > new file mode 100644
> > index 000000000000..24f5ce25b61e
> > --- /dev/null
> > +++ b/arch/arm64/purgatory/sha256-core.S
> > @@ -0,0 +1 @@
> > +#include "../crypto/sha256-core.S_shipped"
> > diff --git a/arch/arm64/purgatory/sha256.c b/arch/arm64/purgatory/sha256.c
> > new file mode 100644
> > index 000000000000..5d20d81767e3
> > --- /dev/null
> > +++ b/arch/arm64/purgatory/sha256.c
> > @@ -0,0 +1,79 @@
> > +#include <linux/kexec.h>
> > +#include <linux/purgatory.h>
> > +#include <linux/types.h>
> > +
> > +/*
> > + * Under KASAN, those are defined as un-instrumented version, __memxxx()
> > + */
> > +#undef memcmp
> > +#undef memcpy
> > +#undef memset
> > +
> > +#include "string.h"
> > +#include <crypto/hash.h>
> > +#include <crypto/sha.h>
> > +#include <crypto/sha256_base.h>
> > +
> > +u8 purgatory_sha256_digest[SHA256_DIGEST_SIZE] __section(.kexec-purgatory);
> > +struct kexec_sha_region purgatory_sha_regions[KEXEC_SEGMENT_MAX]
> > +                                               __section(.kexec-purgatory);
> > +
> > +asmlinkage void sha256_block_data_order(u32 *digest, const void *data,
> > +                                       unsigned int num_blks);
> > +
> > +static int sha256_init(struct shash_desc *desc)
> > +{
> > +       return sha256_base_init(desc);
> > +}
> > +
> > +static int sha256_update(struct shash_desc *desc, const u8 *data,
> > +                                                       unsigned int len)
> > +{
> > +       return sha256_base_do_update(desc, data, len,
> > +                               (sha256_block_fn *)sha256_block_data_order);
> > +}
> > +
> > +static int __sha256_base_finish(struct shash_desc *desc, u8 *out)
> > +{
> > +       /* we can't do crypto_shash_digestsize(desc->tfm) */
> > +       unsigned int digest_size = 32;
> > +       struct sha256_state *sctx = shash_desc_ctx(desc);
> > +       __be32 *digest = (__be32 *)out;
> > +       int i;
> > +
> > +       for (i = 0; digest_size > 0; i++, digest_size -= sizeof(__be32))
> > +               put_unaligned_be32(sctx->state[i], digest++);
> > +
> > +       *sctx = (struct sha256_state){};
> > +       return 0;
> > +}
> > +
> > +static int sha256_final(struct shash_desc *desc, u8 *out)
> > +{
> > +       sha256_base_do_finalize(desc,
> > +                               (sha256_block_fn *)sha256_block_data_order);
> > +
> > +       return __sha256_base_finish(desc, out);
> > +}
> > +
> > +int verify_sha256_digest(void)
> > +{
> > +       char __sha256_desc[sizeof(struct shash_desc) +
> > +               sizeof(struct sha256_state)] CRYPTO_MINALIGN_ATTR;
> > +       struct shash_desc *desc = (struct shash_desc *)__sha256_desc;
> > +       struct kexec_sha_region *ptr, *end;
> > +       u8 digest[SHA256_DIGEST_SIZE];
> > +
> > +       sha256_init(desc);
> > +
> > +       end = purgatory_sha_regions + ARRAY_SIZE(purgatory_sha_regions);
> > +       for (ptr = purgatory_sha_regions; ptr < end; ptr++)
> > +               sha256_update(desc, (uint8_t *)(ptr->start), ptr->len);
> > +
> > +       sha256_final(desc, digest);
> > +
> > +       if (memcmp(digest, purgatory_sha256_digest, sizeof(digest)))
> > +               return 1;
> > +
> > +       return 0;
> > +}
> > diff --git a/arch/arm64/purgatory/sha256.h b/arch/arm64/purgatory/sha256.h
> > new file mode 100644
> > index 000000000000..54dc3c33c469
> > --- /dev/null
> > +++ b/arch/arm64/purgatory/sha256.h
> > @@ -0,0 +1 @@
> > +extern int verify_sha256_digest(void);
> > diff --git a/arch/arm64/purgatory/string.c b/arch/arm64/purgatory/string.c
> > new file mode 100644
> > index 000000000000..33233a210a65
> > --- /dev/null
> > +++ b/arch/arm64/purgatory/string.c
> > @@ -0,0 +1,32 @@
> > +#include <linux/types.h>
> > +
> > +void *memcpy(void *dst, const void *src, size_t len)
> > +{
> > +       int i;
> > +
> > +       for (i = 0; i < len; i++)
> > +               ((u8 *)dst)[i] = ((u8 *)src)[i];
> > +
> > +       return NULL;
> > +}
> > +
> > +void *memset(void *dst, int c, size_t len)
> > +{
> > +       int i;
> > +
> > +       for (i = 0; i < len; i++)
> > +               ((u8 *)dst)[i] = (u8)c;
> > +
> > +       return NULL;
> > +}
> > +
> > +int memcmp(const void *src, const void *dst, size_t len)
> > +{
> > +       int i;
> > +
> > +       for (i = 0; i < len; i++)
> > +               if (*(char *)src != *(char *)dst)
> > +                       return 1;
> > +
> > +       return 0;
> > +}
> > diff --git a/arch/arm64/purgatory/string.h b/arch/arm64/purgatory/string.h
> > new file mode 100644
> > index 000000000000..cb5f68dd84ef
> > --- /dev/null
> > +++ b/arch/arm64/purgatory/string.h
> > @@ -0,0 +1,5 @@
> > +#include <linux/types.h>
> > +
> > +int memcmp(const void *s1, const void *s2, size_t len);
> > +void *memcpy(void *dst, const void *src, size_t len);
> > +void *memset(void *dst, int c, size_t len);
> > --
> > 2.14.1
> >
