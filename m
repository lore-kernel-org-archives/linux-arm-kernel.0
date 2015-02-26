From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Fri, 27 Feb 2015 10:26:44 +1100
Subject: [PATCH] Fix offset2lib issue for x86*, ARM*, PowerPC and MIPS
In-Reply-To: <20150226143815.09386fe280c7bd8797048bb2@linux-foundation.org>
References: <54EB735F.5030207@upv.es>
 <CAGXu5j+SBRcj+BGyxEwUzgKsB2fdzNiPY37Q=JTsf=-QbGwoGA@mail.gmail.com>
 <20150223205436.15133mg1kpyojyik@webmail.upv.es>
 <20150224073906.GA16422@gmail.com>
 <20150226143815.09386fe280c7bd8797048bb2@linux-foundation.org>
Message-ID: <20150227102644.18a0ea5f@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

[Just resending to correct addresses - sorry for those who get a duplicate]

On Thu, 26 Feb 2015 14:38:15 -0800 Andrew Morton <akpm@linux-foundation.org> wrote:
>
> diff -puN fs/binfmt_elf.c~fix-offset2lib-issue-for-x86-arm-powerpc-and-mips-fix fs/binfmt_elf.c
> --- a/fs/binfmt_elf.c~fix-offset2lib-issue-for-x86-arm-powerpc-and-mips-fix
> +++ a/fs/binfmt_elf.c
> @@ -22,6 +22,7 @@
>  #include <linux/slab.h>
>  #include <linux/personality.h>
>  #include <linux/elfcore.h>
> +#include <linux/elf-randomization.h>
>  #include <linux/init.h>
>  #include <linux/highuid.h>
>  #include <linux/compiler.h>
> @@ -2300,6 +2301,26 @@ out:
>  
>  #endif		/* CONFIG_ELF_CORE */
>  
> +/* Not all architectures implement mmap_rnd() */
> +unsigned long __weak mmap_rnd(void)
> +{
> +}
> +
> +/*
> + * Not all architectures use randomize_et_dyn(), so use __weak to let the
> + * linker omit it from vmlinux
> + */
> +unsigned long __weak randomize_et_dyn(unsigned long base)
> +{
> +	unsigned long ret;
> +
> +	if ((current->personality & ADDR_NO_RANDOMIZE) ||
> +		!(current->flags & PF_RANDOMIZE))
> +		return base;
> +	ret = base + mmap_rnd();
> +	return max(ret, base);
> +}
> +  

Didn't we have some trouble with some compilers when the weak function
(mmap_rnd) was defined and used in the same file i.e. the wrong one was
used?

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150227/3c80d6c1/attachment.sig>
