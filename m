From: james.morse@arm.com (James Morse)
Date: Wed, 07 Feb 2018 18:37:16 +0000
Subject: [PATCH v7 05/11] arm64: kexec_file: create purgatory
In-Reply-To: <20171204025801.12161-6-takahiro.akashi@linaro.org>
References: <20171204025801.12161-1-takahiro.akashi@linaro.org>
 <20171204025801.12161-6-takahiro.akashi@linaro.org>
Message-ID: <5A7B475C.2080008@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Akashi,

On 04/12/17 02:57, AKASHI Takahiro wrote:
> This is a basic purgatory, or a kind of glue code between the two kernels,
> for arm64.
> 
> Since purgatory is assumed to be relocatable (not executable) object by
> kexec generic code, arch_kexec_apply_relocations_add() is required in
> general. Arm64's purgatory, however, is a simple asm and all the references
> can be resolved as local, no re-linking is needed here.
> 
> Please note that even if we don't support digest check at purgatory we

(You knew what I was going to ask!)


> need purgatory_sha_regions and purgatory_sha256_digest as they are
> referenced by generic kexec code.

As somewhere to store the values? If we aren't doing the validation could we add
something about why not to the commit message? I think its because we only worry
about memory corruption for kdump, and for kdump we unmap the crash-kernel
region during normal-operation to prevent it getting corrupted.

As we aren't doing the hash validation, could we hide its core-code behind some
ARCH_HAS_KEXEC_PURGATORY_HASH, instead of defining dummy symbols and doing
unnecessary work to fill them in?


> diff --git a/arch/arm64/purgatory/entry.S b/arch/arm64/purgatory/entry.S
> new file mode 100644
> index 000000000000..fe6e968076db
> --- /dev/null
> +++ b/arch/arm64/purgatory/entry.S
> @@ -0,0 +1,55 @@
> +/*
> + * kexec core purgatory
> + */
> +#include <linux/linkage.h>
> +#include <uapi/linux/kexec.h>
> +
> +#define SHA256_DIGEST_SIZE	32 /* defined in crypto/sha.h */
> +
> +.text
> +
> +ENTRY(purgatory_start)
> +	/* Start new image. */
> +	ldr	x17, __kernel_entry
> +	ldr	x0, __dtb_addr
> +	mov	x1, xzr
> +	mov	x2, xzr
> +	mov	x3, xzr
> +	br	x17
> +END(purgatory_start)

Is this what arm64_relocate_new_kernel() drops into? I thought that had the
kernel boot register values already so we wouldn't need another trampoline for
kexec_file_load()...

.. but now that I look, it doesn't have the DTB, presumably because for regular
kexec we don't know where user-space put it.

Could we add some x0_for_kexec that is 0 by default (if that's the ABI), or the
DTB address for kexec_file_load()? This would avoid this extra trampoline, and
patching in the values from load_other_segments().

I'd love to avoid an in-kernel purgatory! (its code with funny
compile/link/relocation requirements that is impossible to debug)


Thanks,

James
