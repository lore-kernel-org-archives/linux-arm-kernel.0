From: nm@ti.com (Menon, Nishanth)
Date: Fri, 20 May 2011 08:23:02 -0500
Subject: [PATCH V4] OMAP3+: SR Layer Cleanup
In-Reply-To: <1305268062-20046-1-git-send-email-shweta.gulati@ti.com>
References: <1305268062-20046-1-git-send-email-shweta.gulati@ti.com>
Message-ID: <BANLkTi=sLwrdaOanRNDM+NsnBGjxn5G6nQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 13, 2011 at 01:27, Shweta Gulati <shweta.gulati@ti.com> wrote:
[...]
> diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> index 3cd91ac..b1b11de 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> @@ -29,6 +29,7 @@
>
> ?#include "omap_hwmod_common_data.h"
>
> +#include "smartreflex.h"
> ?#include "prm-regbits-34xx.h"
> ?#include "cm-regbits-34xx.h"
> ?#include "wd_timer.h"
> @@ -2904,6 +2905,10 @@ static struct omap_hwmod_class omap36xx_smartreflex_hwmod_class = {
> ?};
>
> ?/* SR1 */
> +static struct omap_smartreflex_dev_attr sr1_dev_attr = {
> + ? ? ? .sensor_voltdm_name ? = "mpu_iva",
> +};

[...]
> diff --git a/arch/arm/mach-omap2/smartreflex.h b/arch/arm/mach-omap2/smartreflex.h
> index 5f35b9e..aeeec5f 100644
> --- a/arch/arm/mach-omap2/smartreflex.h
> +++ b/arch/arm/mach-omap2/smartreflex.h
> @@ -197,6 +197,16 @@ struct omap_sr_nvalue_table {
> ?};
>
> ?/**
> + * struct omap_smartreflex_dev_attr - Smartreflex Device attribute.
> + *
> + * @sensor_voltdm_name: ? ? ? Name of voltdomain of SR instance
> + */
> +
> +struct omap_smartreflex_dev_attr {
> + ? ? ? const char ? ? ?*sensor_voltdm_name;
> +};
> +

This structure is in #ifdef CONFIG_SMART_REFLEX and breaks
hwmod_data.c when built without SR.
please move it out of the #ifdef in your next rev.

Regards,
Nishanth Menon
