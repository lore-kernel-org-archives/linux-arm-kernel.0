From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 27 Aug 2013 16:53:51 +0530
Subject: [PATCH 2/2] ARM: OMAP4+: Move SRAM data to DT
In-Reply-To: <1377598305-15539-3-git-send-email-rnayak@ti.com>
References: <1377598305-15539-1-git-send-email-rnayak@ti.com>
 <1377598305-15539-3-git-send-email-rnayak@ti.com>
Message-ID: <521C8C47.2000502@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 27 August 2013 03:41 PM, Rajendra Nayak wrote:
> Use drivers/misc/sram.c driver to manage SRAM on all DT only
> OMAP platforms (am33xx, am43xx, omap4 and omap5) instead of
> the existing private implementation.
> 
> Address and size related data  is removed from mach-omap2/sram.c
> and now passed to drivers/misc/sram.c from DT.
> 
> Users can hence use general purpose allocator apis instead of
> OMAP private ones to manage and use SRAM.
> 
> Currently there are no users on SRAM on these platfoms.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>

Nice getting rid of code.

> diff --git a/arch/arm/mach-omap2/sram.h b/arch/arm/mach-omap2/sram.h
> index ca7277c..3f83b80 100644
> --- a/arch/arm/mach-omap2/sram.h
> +++ b/arch/arm/mach-omap2/sram.h
> @@ -80,4 +80,3 @@ static inline void omap_push_sram_idle(void) {}
>  #else
>  #define OMAP4_SRAM_PA		0x40300000
>  #endif
> -#define AM33XX_SRAM_PA		0x40300000

I guess OMAP4_SRAM_PA is left in the code to take care of errata I688?
How about removing the iotable entry for SRAM on OMAP4 and converting
omap_barriers_init() to use the gen_pool API instead of passing an
incremented address to DT?

SRAM driver is a postcore initcall so I think you it will be ready
before first WFI hits (which is when the errata triggers).

Thanks,
Sekhar
