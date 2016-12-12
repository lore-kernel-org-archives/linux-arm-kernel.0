From: will.deacon@arm.com (Will Deacon)
Date: Mon, 12 Dec 2016 11:29:14 +0000
Subject: [PATCH 1/2] arm64: setup: introduce kaslr_offset()
In-Reply-To: <1481417456-28826-2-git-send-email-alex.popov@linux.com>
References: <1481417456-28826-1-git-send-email-alex.popov@linux.com>
 <1481417456-28826-2-git-send-email-alex.popov@linux.com>
Message-ID: <20161212112914.GC21248@arm.com>
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

You could probably just stick this in asm/memory.h, since that's where
kimage_vaddr is declared and it would save adding a new header file.

> diff --git a/arch/arm64/include/uapi/asm/setup.h b/arch/arm64/include/uapi/asm/setup.h
> index 9cf2e46..26631c8 100644
> --- a/arch/arm64/include/uapi/asm/setup.h
> +++ b/arch/arm64/include/uapi/asm/setup.h
> @@ -16,8 +16,8 @@
>   * You should have received a copy of the GNU General Public License
>   * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>   */
> -#ifndef __ASM_SETUP_H
> -#define __ASM_SETUP_H
> +#ifndef _UAPI__ASM_SETUP_H
> +#define _UAPI__ASM_SETUP_H
>  
>  #include <linux/types.h>

You can drop this hunk.

With those changes:

Acked-by: Will Deacon <will.deacon@arm.com>

Will
