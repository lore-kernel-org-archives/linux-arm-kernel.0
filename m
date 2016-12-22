From: ynorov@caviumnetworks.com (Yury Norov)
Date: Thu, 22 Dec 2016 11:48:58 +0530
Subject: [PATCH 1/2] arm64: setup: introduce kaslr_offset()
In-Reply-To: <1481417456-28826-2-git-send-email-alex.popov@linux.com>
References: <1481417456-28826-1-git-send-email-alex.popov@linux.com>
 <1481417456-28826-2-git-send-email-alex.popov@linux.com>
Message-ID: <20161222061857.GA26502@yury-N73SV>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 11, 2016 at 03:50:55AM +0300, Alexander Popov wrote:
> Introduce kaslr_offset() similarly to x86_64 for fixing kcov.
> 
> Signed-off-by: Alexander Popov <alex.popov@linux.com>
> ---
>  arch/arm64/include/asm/setup.h      | 19 +++++++++++++++++++
>  arch/arm64/include/uapi/asm/setup.h |  4 ++--
>  arch/arm64/kernel/setup.c           |  8 ++++----
>  3 files changed, 25 insertions(+), 6 deletions(-)
>  create mode 100644 arch/arm64/include/asm/setup.h
> 
> diff --git a/arch/arm64/include/asm/setup.h b/arch/arm64/include/asm/setup.h
> new file mode 100644
> index 0000000..e7b59b9
> --- /dev/null
> +++ b/arch/arm64/include/asm/setup.h
> @@ -0,0 +1,19 @@
> +/*
> + * arch/arm64/include/asm/setup.h
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef __ASM_SETUP_H
> +#define __ASM_SETUP_H
> +
> +#include <uapi/asm/setup.h>
> +
> +static inline unsigned long kaslr_offset(void)
> +{
> +	return kimage_vaddr - KIMAGE_VADDR;
> +}
> +
> +#endif

Hi Alexander,

I found today's linux-next master broken:
In file included from init/main.c:88:0:
./arch/arm64/include/asm/setup.h:14:100: error: redefinition of ?kaslr_offset?
In file included from ./arch/arm64/include/asm/page.h:54:0,
   from ./include/linux/mm_types.h:16,
   from ./include/linux/sched.h:27,
   from ./arch/arm64/include/asm/compat.h:25,
   from ./arch/arm64/include/asm/stat.h:23,
   from ./include/linux/stat.h:5,
   from ./include/linux/module.h:10,
   from init/main.c:15:
/arch/arm64/include/asm/memory.h:168:100: note: previous definition of ?kaslr_offset? was here scripts/Makefile.build:293: recipe for target 'init/main.o' failed
make[1]: *** [init/main.o] Error 1

It looks like you declare kaslr_offset() twice - in this patch, and in 7ede8665f
(arm64: setup: introduce kaslr_offset()). 

Yury
