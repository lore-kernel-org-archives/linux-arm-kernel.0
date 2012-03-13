From: vishwanath.bs@ti.com (Vishwanath Sripathy)
Date: Tue, 13 Mar 2012 16:04:13 +0530
Subject: [PATCH 6/6] ARM: OMAP3+: SmartReflex Class3: restrict CPU to run
 on
In-Reply-To: <1331634381-31436-7-git-send-email-j-pihet@ti.com>
References: <1331634381-31436-1-git-send-email-j-pihet@ti.com>
 <1331634381-31436-7-git-send-email-j-pihet@ti.com>
Message-ID: <ef588847b5162cc1174c7cdeffc74ffd@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: linux-omap-owner at vger.kernel.org [mailto:linux-omap-
> owner at vger.kernel.org] On Behalf Of jean.pihet at newoldbits.com
> Sent: Tuesday, March 13, 2012 3:56 PM
> To: linux-omap at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; Kevin Hilman
> Cc: Nishanth Menon; Jean Pihet
> Subject: [PATCH 6/6] ARM: OMAP3+: SmartReflex Class3: restrict CPU
> to run on
>
> From: Nishanth Menon <nm@ti.com>
>
> Use SmartReflex AVS Class3 initialization only for OMAP343x family
> of
> processors.
>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Jean Pihet <j-pihet@ti.com>
> ---
>  arch/arm/mach-omap2/smartreflex-class3.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/smartreflex-class3.c
> b/arch/arm/mach-omap2/smartreflex-class3.c
> index 9dcda93..735937a 100644
> --- a/arch/arm/mach-omap2/smartreflex-class3.c
> +++ b/arch/arm/mach-omap2/smartreflex-class3.c
> @@ -11,6 +11,7 @@
>   * published by the Free Software Foundation.
>   */
>
> +#include <plat/cpu.h>
>  #include "smartreflex.h"
>
>  static int sr_class3_enable(struct voltagedomain *voltdm,
> @@ -58,6 +59,10 @@ static struct omap_sr_class_data class3_data = {
>  /* Smartreflex Class3 init API to be called from board file */
>  static int __init sr_class3_init(void)
>  {
> +	/* Enable this class only for OMAP343x */
> +	if (!cpu_is_omap343x())
> +		return -EINVAL;
Wouldn't this break SR on OMAP3630 and OMAP4? Shouldn't this be done once
you have SR1.5 support in mainline?

Vishwa
> +
>  	pr_info("SmartReflex Class3 initialized\n");
>  	return sr_register_class(&class3_data);
>  }
> --
> 1.7.5.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-
> omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
