From: abhijitpagare@ti.com (Pagare, Abhijit)
Date: Wed, 20 Jan 2010 12:25:17 +0530
Subject: [PATCH] OMAP CPU ID: fix OMAP4 build failure
In-Reply-To: <alpine.DEB.2.00.1001191412130.3977@utopia.booyaka.com>
References: <alpine.DEB.2.00.1001191412130.3977@utopia.booyaka.com>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C07CC987@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hello Paul,


> -----Original Message-----
> From: linux-omap-owner at vger.kernel.org [mailto:linux-omap-
> owner at vger.kernel.org] On Behalf Of Paul Walmsley
> Sent: Wednesday, January 20, 2010 2:44 AM
> To: abhijit.pagare at ti.com
> Cc: tony at atomide.com; linux-omap at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org
> Subject: [PATCH] OMAP CPU ID: fix OMAP4 build failure
> 
> 
> Hello Abhijit,
> 
> it seems that my for_2.6.34 branch does not build unless the following
> patch, or one like it, is included.  Any comments?
> 
> 
> - Paul
> 
> 
> From: Paul Walmsley <paul@pwsan.com>
> 
> 
> omap_4430sdp_defconfig currently does not build due to some missing CPU
> IDs:
> 
> In file included from arch/arm/mach-omap2/powerdomains.h:59,
>                  from arch/arm/mach-omap2/io.c:42:
> arch/arm/mach-omap2/powerdomains44xx.h:39: error: 'CHIP_IS_OMAP4430'
> undeclared here (not in a function)
> 
> ... so add CHIP_IS_OMAP4430ES1.  Note that this is not yet set by
> mach-omap2/id.c; this is for TI to fix.
> 
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Abhijit Pagare <abhijit.pagare@ti.com>
> ---
>  arch/arm/plat-omap/include/plat/cpu.h |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-
> omap/include/plat/cpu.h
> index 9a028bd..8ada0ef 100644
> --- a/arch/arm/plat-omap/include/plat/cpu.h
> +++ b/arch/arm/plat-omap/include/plat/cpu.h
> @@ -44,7 +44,7 @@
>  int omap_type(void);
> 
>  struct omap_chip_id {
> -	u8 oc;
> +	u16 oc;

I think the latest patch-set that I had posted has this change in it. You can refer to the patch in the link below

http://marc.info/?l=linux-omap&m=126088474831309&w=2

>  	u8 type;
>  };
> 
> @@ -470,8 +470,10 @@ IS_OMAP_TYPE(3517, 0x3517)
>  #define CHIP_IS_OMAP3430ES3_0		(1 << 5)
>  #define CHIP_IS_OMAP3430ES3_1		(1 << 6)
>  #define CHIP_IS_OMAP3630ES1		(1 << 7)
> +#define CHIP_IS_OMAP4430ES1		(1 << 8)
> 
>  #define CHIP_IS_OMAP24XX		(CHIP_IS_OMAP2420 | CHIP_IS_OMAP2430)
> +#define CHIP_IS_OMAP4430		CHIP_IS_OMAP4430ES1

I had used this flag earlier as there was nothing fixed as to name it as ES1 that time. So now it can be migrated from CHIP_IS_OMAP4430 to CHIP_IS_OMAP4430ES1. I think CHIP_IS_OMAP4430 would be redundant in that case and should be removed. A patch would be essential to take care of that in the places where it is used. If you feel the same I can send a patch for fixing this.


Regards,
Abhijit

> 
>  /*
>   * "GE" here represents "greater than or equal to" in terms of ES
> --
> 1.6.6.rc2.5.g49666
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
