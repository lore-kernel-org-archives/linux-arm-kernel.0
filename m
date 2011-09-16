From: jamie@jamieiles.com (Jamie Iles)
Date: Fri, 16 Sep 2011 11:39:31 +0100
Subject: [PATCH 16/19] ARM: move iotable mappings within the vmalloc region
In-Reply-To: <1316156850-31013-17-git-send-email-nico@fluxnic.net>
References: <1316156850-31013-1-git-send-email-nico@fluxnic.net>
	<1316156850-31013-17-git-send-email-nico@fluxnic.net>
Message-ID: <20110916103931.GB3130@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

On Fri, Sep 16, 2011 at 03:07:27AM -0400, Nicolas Pitre wrote:
> From: Nicolas Pitre <nicolas.pitre@linaro.org>
> 
> In order to remove the build time variation between different SOCs with
> regards to VMALLOC_END, the iotable mappings are now allocated inside
> the vmalloc region.  This allows for VMALLOC_END to be identical across
> all machines.
> 
> Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> ---
>  arch/arm/include/asm/pgtable.h |    8 +------
>  arch/arm/mm/mmu.c              |   42 +++++++++++++++++++++++++++++----------
>  2 files changed, 32 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
> index 5750704e02..950dee3ce2 100644
> --- a/arch/arm/include/asm/pgtable.h
> +++ b/arch/arm/include/asm/pgtable.h
> @@ -21,7 +21,6 @@
>  #else
>  
>  #include <asm/memory.h>
> -#include <mach/vmalloc.h>
>  #include <asm/pgtable-hwdef.h>
>  
>  /*
> @@ -31,15 +30,10 @@
>   * any out-of-bounds memory accesses will hopefully be caught.
>   * The vmalloc() routines leaves a hole of 4kB between each vmalloced
>   * area for the same reason. ;)
> - *
> - * Note that platforms may override VMALLOC_START, but they must provide
> - * VMALLOC_END.  VMALLOC_END defines the (exclusive) limit of this space,
> - * which may not overlap IO space.
>   */
> -#ifndef VMALLOC_START
>  #define VMALLOC_OFFSET		(8*1024*1024)
>  #define VMALLOC_START		(((unsigned long)high_memory + VMALLOC_OFFSET) & ~(VMALLOC_OFFSET-1))
> -#endif
> +#define VMALLOC_END		0xff000000UL

Only a minor nit, but I think this requires an update to 
Documentation/arm/memory.txt as this says that VMALLOC_END -> feffffff 
is free for platform use but this won't ever be true now.

Jamie
