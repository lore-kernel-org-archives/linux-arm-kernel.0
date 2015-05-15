From: djkurtz@chromium.org (Daniel Kurtz)
Date: Fri, 15 May 2015 22:17:33 +0800
Subject: [PATCH 1/5] soc: mediatek: Add infracfg misc driver support
In-Reply-To: <1431372206-1237-2-git-send-email-s.hauer@pengutronix.de>
References: <1431372206-1237-1-git-send-email-s.hauer@pengutronix.de>
 <1431372206-1237-2-git-send-email-s.hauer@pengutronix.de>
Message-ID: <CAGS+omADXpnBnLvuH+xNmatL+89kLBELz6KqMFid7SOx=veiAg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On Tue, May 12, 2015 at 3:23 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> This adds support for some miscellaneous bits of the infracfg controller.
> The mtk_infracfg_set/clear_bus_protection functions are necessary for
> the scpsys power domain driver to handle the bus protection bits which
> are contained in the infacfg register space.
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/soc/mediatek/Kconfig        |  9 +++++
>  drivers/soc/mediatek/Makefile       |  1 +
>  drivers/soc/mediatek/mtk-infracfg.c | 80 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 90 insertions(+)
>  create mode 100644 drivers/soc/mediatek/mtk-infracfg.c
>
> diff --git a/drivers/soc/mediatek/Kconfig b/drivers/soc/mediatek/Kconfig
> index bcdb22d..6fae66f 100644
> --- a/drivers/soc/mediatek/Kconfig
> +++ b/drivers/soc/mediatek/Kconfig
> @@ -9,3 +9,12 @@ config MTK_PMIC_WRAP
>           Say yes here to add support for MediaTek PMIC Wrapper found
>           on different MediaTek SoCs. The PMIC wrapper is a proprietary
>           hardware to connect the PMIC.
> +
> +config MTK_INFRACFG

nit: Could you alphabetize these config options - so this one before
MTK_PMIC_WRAP

> +       tristate "MediaTek INFRACFG Support"
> +       depends on ARCH_MEDIATEK

I've seen several drivers like this now:

  depends on ARCH_MEDIATEK || COMPILE_TEST


> +       select REGMAP
> +       help
> +         Say yes here to add support for the MediaTek INFRACFG controller. The
> +         INFRACFG controller contains various infrastructure registers not
> +         directly associated to any device.
> diff --git a/drivers/soc/mediatek/Makefile b/drivers/soc/mediatek/Makefile
> index ecaf4de..ce39119 100644
> --- a/drivers/soc/mediatek/Makefile
> +++ b/drivers/soc/mediatek/Makefile
> @@ -1 +1,2 @@
>  obj-$(CONFIG_MTK_PMIC_WRAP) += mtk-pmic-wrap.o
> +obj-$(CONFIG_MTK_INFRACFG) += mtk-infracfg.o

alphabetize here, too.

> diff --git a/drivers/soc/mediatek/mtk-infracfg.c b/drivers/soc/mediatek/mtk-infracfg.c
> new file mode 100644
> index 0000000..b3ebfae
> --- /dev/null
> +++ b/drivers/soc/mediatek/mtk-infracfg.c
> @@ -0,0 +1,80 @@
> +#include <linux/regmap.h>
> +#include <linux/export.h>
> +#include <linux/jiffies.h>
> +#include <linux/soc/mediatek/infracfg.h>
> +#include <asm/processor.h>

and... alphabetize headers here.

I'm not sure if people care, but I find it makes it much easier to
merge/add things later if these lists are already sorted.
Same "please alphabetize" comments for the mtk-scpsys patch, so I
won't repeat them.

> +
> +#define INFRA_TOPAXI_PROTECTEN         0x0220
> +#define INFRA_TOPAXI_PROTECTSTA1       0x0228
> +
> +/**
> + * mtk_infracfg_set_bus_protection - enable bus protection
> + * @regmap: The infracfg regmap
> + * @mask: The mask containing the protection bits to be enabled.
> + *
> + * This function enables the bus protection bits for disabled power
> + * domains so that the system does not hanf when some unit accesses the
> + * bus while in power down.
> + */
> +int mtk_infracfg_set_bus_protection(struct regmap *infracfg, u32 mask)
> +{
> +       unsigned long expired;
> +       u32 val;
> +       int ret;
> +
> +       regmap_update_bits(infracfg, INFRA_TOPAXI_PROTECTEN, mask, mask);
> +
> +       expired = jiffies + HZ;
> +
> +       while (1) {
> +               ret = regmap_read(infracfg, INFRA_TOPAXI_PROTECTSTA1, &val);
> +               if (ret)
> +                       return ret;
> +
> +               if ((val & mask) == mask)
> +                       break;
> +
> +               cpu_relax();
> +               if (time_after(jiffies, expired))
> +                       return -EIO;

I think we should check for timeout first, and then cpu_relax() if
there is still time left (here and in
mtk_infracfg_clear_bus_protection()).  Otherwise we end up doing one
final cpu_relax() without rechecking the register we are polling
(again, I have the same comment for the timeout loops in mtk-scpsys).

Also, shouldn't we return -ETIMEOUT if we timeout?

Thanks!
-Dan

> +       }
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(mtk_infracfg_set_bus_protection);
> +
> +/**
> + * mtk_infracfg_clear_bus_protection - disable bus protection
> + * @regmap: The infracfg regmap
> + * @mask: The mask containing the protection bits to be disabled.
> + *
> + * This function disables the bus protection bits previously enabled with
> + * mtk_infracfg_set_bus_protection.
> + */
> +int mtk_infracfg_clear_bus_protection(struct regmap *infracfg, u32 mask)
> +{
> +       unsigned long expired;
> +       int ret;
> +
> +       regmap_update_bits(infracfg, INFRA_TOPAXI_PROTECTEN, mask, 0);
> +
> +       expired = jiffies + HZ;
> +
> +       while (1) {
> +               u32 val;
> +
> +               ret = regmap_read(infracfg, INFRA_TOPAXI_PROTECTSTA1, &val);
> +               if (ret)
> +                       return ret;
> +
> +               if (!(val & mask))
> +                       break;
> +
> +               cpu_relax();
> +               if (time_after(jiffies, expired))
> +                       return -EIO;
> +       }
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(mtk_infracfg_clear_bus_protection);
> --
> 2.1.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
