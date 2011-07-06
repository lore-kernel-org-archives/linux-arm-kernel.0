From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 6 Jul 2011 11:31:47 +0800
Subject: [PATCH v2 3/3] mmc: sdhci-esdhc-imx: add device tree probe support
In-Reply-To: <CACxGe6sj4yt7o1yohgdgRxx0aBGrCyYxA3qHmV-npCArjNWWUw@mail.gmail.com>
References: <1309879568-25837-1-git-send-email-shawn.guo@linaro.org>
	<1309879568-25837-4-git-send-email-shawn.guo@linaro.org>
	<CACxGe6sj4yt7o1yohgdgRxx0aBGrCyYxA3qHmV-npCArjNWWUw@mail.gmail.com>
Message-ID: <20110706033146.GA26172@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 05, 2011 at 11:54:34AM -0600, Grant Likely wrote:
> On Tue, Jul 5, 2011 at 9:26 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> > The patch adds device tree probe support for sdhci-esdhc-imx driver.
> >
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > Cc: Wolfram Sang <w.sang@pengutronix.de>
> > Cc: Chris Ball <cjb@laptop.org>
> > Cc: Grant Likely <grant.likely@secretlab.ca>
> > ---
> > ?.../devicetree/bindings/mmc/fsl-imx-esdhc.txt ? ? ?| ? 40 ++++++++
> > ?drivers/mmc/host/sdhci-esdhc-imx.c ? ? ? ? ? ? ? ? | ?102 +++++++++++++++++++-
> > ?2 files changed, 137 insertions(+), 5 deletions(-)
> > ?create mode 100644 Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
> >
> > diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
> > new file mode 100644
> > index 0000000..351d239
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
> > @@ -0,0 +1,40 @@
> > +* Freescale Enhanced Secure Digital Host Controller (eSDHC) for i.MX
> > +
> > +The Enhanced Secure Digital Host Controller on Freescale i.MX family
> > +provides an interface for MMC, SD, and SDIO types of memory cards.
> > +
> > +Required properties:
> > +- compatible : Should be "fsl,<chip>-esdhc"
> > +- reg : Should contain eSDHC registers location and length
> > +- interrupts : Should contain eSDHC interrupt
> > +- cd-type : String, card detection (CD) method. ?Supported values are:
> > + ? ?"none" : No CD
> > + ? ?"controller" : Uses eSDHC controller internal CD signal
> > + ? ?"gpio" : Uses GPIO pin for CD
> > + ? ?"permanent" : No CD because card is permanently wired to host
> > +- wp-type : String, write protection (WP) method. ?Supported values are:
> > + ? ?"none" : No WP
> > + ? ?"controller" : Uses eSDHC controller internal WP signal
> > + ? ?"gpio" : Uses GPIO pin for WP
> > +- gpios : Should specify GPIOs in this order: CD GPIO, WP GPIO, if
> > + ?properties cd-type and wp-type are "gpio".
> 
> Again, be explicit in your gpios property names.  Create a different
> property for each gpio: cd-gpios and wp-gpios.
> 
Sorry. I fixed the example below.  But this one got missed.

> As for wp-type and cd-type, I think you can drop them.  Default to
> internal controller CD and WP pins.  Use gpio if cd-gpios or wp-gpios
> is present, and define specific properties for the no-wp, no-cd and
> fixed-card cases.  (can you tell that I'm not a fan of the "*-type"
> binding for this driver?)  :-)
> 
Ok, I'm getting to know you.

> > +
> > +Examples:
> > +
> > +esdhc at 70004000 {
> > + ? ? ? compatible = "fsl,imx51-esdhc";
> > + ? ? ? reg = <0x70004000 0x4000>;
> > + ? ? ? interrupts = <1>;
> > + ? ? ? fsl,cd-type = "controller";
> > + ? ? ? fsl,wp-type = "controller";
> > +};
> > +
> > +esdhc at 70008000 {
> > + ? ? ? compatible = "fsl,imx51-esdhc";
> > + ? ? ? reg = <0x70008000 0x4000>;
> > + ? ? ? interrupts = <2>;
> > + ? ? ? fsl,cd-type = "gpio";
> > + ? ? ? fsl,wp-type = "gpio";
> > + ? ? ? cd-gpios = <&gpio0 6 0>; /* GPIO1_6 */
> > + ? ? ? wp-gpios = <&gpio0 5 0>; /* GPIO1_5 */
> > +};
> > diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> > index 1edda29..593d6b9 100644
> > --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> > +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> > @@ -20,6 +20,9 @@
> > ?#include <linux/mmc/host.h>
> > ?#include <linux/mmc/mmc.h>
> > ?#include <linux/mmc/sdio.h>
> > +#include <linux/of.h>
> > +#include <linux/of_device.h>
> > +#include <linux/of_gpio.h>
> > ?#include <mach/esdhc.h>
> > ?#include "sdhci-pltfm.h"
> > ?#include "sdhci-esdhc.h"
> > @@ -72,6 +75,14 @@ static struct platform_device_id imx_esdhc_devtype[] = {
> > ? ? ? ?}
> > ?};
> >
> > +static const struct of_device_id imx_esdhc_dt_ids[] = {
> > + ? ? ? { .compatible = "fsl,imx25-esdhc", .data = &imx_esdhc_devtype[IMX25_ESDHC], },
> > + ? ? ? { .compatible = "fsl,imx35-esdhc", .data = &imx_esdhc_devtype[IMX35_ESDHC], },
> > + ? ? ? { .compatible = "fsl,imx51-esdhc", .data = &imx_esdhc_devtype[IMX51_ESDHC], },
> > + ? ? ? { .compatible = "fsl,imx53-esdhc", .data = &imx_esdhc_devtype[IMX53_ESDHC], },
> > + ? ? ? { /* sentinel */ }
> > +};
> > +
> > ?static inline int is_imx25_esdhc(struct pltfm_imx_data *data)
> > ?{
> > ? ? ? ?return data->devtype == IMX25_ESDHC;
> > @@ -305,24 +316,96 @@ static irqreturn_t cd_irq(int irq, void *data)
> > ? ? ? ?return IRQ_HANDLED;
> > ?};
> >
> > +#ifdef CONFIG_OF
> > +static const char *cd_types[] = {
> > + ? ? ? [ESDHC_CD_NONE] ? ? ? ? = "none",
> > + ? ? ? [ESDHC_CD_CONTROLLER] ? = "controller",
> > + ? ? ? [ESDHC_CD_GPIO] ? ? ? ? = "gpio",
> > + ? ? ? [ESDHC_CD_PERMANENT] ? ?= "permanent",
> > +};
> > +
> > +static const char *wp_types[] = {
> > + ? ? ? [ESDHC_WP_NONE] ? ? ? ? = "none",
> > + ? ? ? [ESDHC_WP_CONTROLLER] ? = "controller",
> > + ? ? ? [ESDHC_WP_GPIO] ? ? ? ? = "gpio",
> > +};
> > +
> > +static int __devinit sdhci_esdhc_imx_probe_dt(struct platform_device *pdev)
> > +{
> > + ? ? ? const struct of_device_id *of_id =
> > + ? ? ? ? ? ? ? ? ? ? ? of_match_device(imx_esdhc_dt_ids, &pdev->dev);
> > + ? ? ? struct device_node *np = pdev->dev.of_node;
> > + ? ? ? struct esdhc_platform_data *boarddata;
> > + ? ? ? int err, i;
> > + ? ? ? const char *cd, *wp;
> > +
> > + ? ? ? if (!np)
> > + ? ? ? ? ? ? ? return -ENODEV;
> > +
> > + ? ? ? boarddata = kzalloc(sizeof(*boarddata), GFP_KERNEL);
> > + ? ? ? if (!boarddata)
> > + ? ? ? ? ? ? ? return -ENOMEM;
> > + ? ? ? pdev->dev.platform_data = boarddata;
> 
> This is illegal.  As far as device drivers are concerned,
> pdev->dev.platform_data is immutable and must not be changed.
> Otherwise they break the driver model.  If you need to keep around a
> platform_data structure, then it needs to be stored in the driver
> private data.  Your best option is to refactor the driver to not
> reference pdev->dev.platform_data after probe() exits.
> 
Ok.  I saw a patch from Troy doing this.  Will incorporate it into
the series.

Regards,
Shawn

> > +
> > + ? ? ? err = of_property_read_string(np, "fsl,cd-type", &cd);
> > + ? ? ? if (err)
> > + ? ? ? ? ? ? ? return err;
> > + ? ? ? for (i = 0; i < ARRAY_SIZE(cd_types); i++)
> > + ? ? ? ? ? ? ? if (!strcasecmp(cd, cd_types[i])) {
> > + ? ? ? ? ? ? ? ? ? ? ? boarddata->cd_type = i;
> > + ? ? ? ? ? ? ? ? ? ? ? break;
> > + ? ? ? ? ? ? ? }
> > +
> > + ? ? ? err = of_property_read_string(np, "fsl,wp-type", &wp);
> > + ? ? ? if (err)
> > + ? ? ? ? ? ? ? return err;
> > + ? ? ? for (i = 0; i < ARRAY_SIZE(wp_types); i++)
> > + ? ? ? ? ? ? ? if (!strcasecmp(wp, wp_types[i])) {
> > + ? ? ? ? ? ? ? ? ? ? ? boarddata->wp_type = i;
> > + ? ? ? ? ? ? ? ? ? ? ? break;
> > + ? ? ? ? ? ? ? }
> > +
> > + ? ? ? boarddata->cd_gpio = of_get_gpio(np, 0);
> > + ? ? ? boarddata->wp_gpio = of_get_gpio(np, 1);
> > +
> > + ? ? ? pdev->id_entry = of_id->data;
> > +
> > + ? ? ? return 0;
> > +}
> > +#else
> > +static inline int sdhci_esdhc_imx_probe_dt(struct platform_device *pdev)
> > +{
> > + ? ? ? return 0;
> > +}
> > +#endif
> > +
> > ?static int __devinit sdhci_esdhc_imx_probe(struct platform_device *pdev)
> > ?{
> > + ? ? ? struct device_node *np = pdev->dev.of_node;
> > ? ? ? ?struct sdhci_pltfm_host *pltfm_host;
> > ? ? ? ?struct sdhci_host *host;
> > - ? ? ? struct esdhc_platform_data *boarddata;
> > + ? ? ? struct esdhc_platform_data *boarddata = NULL;
> > ? ? ? ?struct clk *clk;
> > ? ? ? ?int err;
> > ? ? ? ?struct pltfm_imx_data *imx_data;
> >
> > + ? ? ? err = sdhci_esdhc_imx_probe_dt(pdev);
> > + ? ? ? if (err)
> > + ? ? ? ? ? ? ? return err;
> > +
> > ? ? ? ?host = sdhci_pltfm_init(pdev, &sdhci_esdhc_imx_pdata);
> > - ? ? ? if (IS_ERR(host))
> > - ? ? ? ? ? ? ? return PTR_ERR(host);
> > + ? ? ? if (IS_ERR(host)) {
> > + ? ? ? ? ? ? ? err = PTR_ERR(host);
> > + ? ? ? ? ? ? ? goto err_sdhci_pltfm;
> > + ? ? ? }
> >
> > ? ? ? ?pltfm_host = sdhci_priv(host);
> >
> > ? ? ? ?imx_data = kzalloc(sizeof(struct pltfm_imx_data), GFP_KERNEL);
> > - ? ? ? if (!imx_data)
> > - ? ? ? ? ? ? ? return -ENOMEM;
> > + ? ? ? if (!imx_data) {
> > + ? ? ? ? ? ? ? err = -ENOMEM;
> > + ? ? ? ? ? ? ? goto err_imx_data;
> > + ? ? ? }
> >
> > ? ? ? ?imx_data->devtype = pdev->id_entry->driver_data;
> > ? ? ? ?pltfm_host->priv = imx_data;
> > @@ -416,12 +499,17 @@ no_board_data:
> > ? ? ? ?clk_put(pltfm_host->clk);
> > ?err_clk_get:
> > ? ? ? ?kfree(imx_data);
> > +err_imx_data:
> > ? ? ? ?sdhci_pltfm_free(pdev);
> > +err_sdhci_pltfm:
> > + ? ? ? if (np)
> > + ? ? ? ? ? ? ? kfree(boarddata);
> > ? ? ? ?return err;
> > ?}
> >
> > ?static int __devexit sdhci_esdhc_imx_remove(struct platform_device *pdev)
> > ?{
> > + ? ? ? struct device_node *np = pdev->dev.of_node;
> > ? ? ? ?struct sdhci_host *host = platform_get_drvdata(pdev);
> > ? ? ? ?struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> > ? ? ? ?struct esdhc_platform_data *boarddata = host->mmc->parent->platform_data;
> > @@ -444,6 +532,9 @@ static int __devexit sdhci_esdhc_imx_remove(struct platform_device *pdev)
> >
> > ? ? ? ?sdhci_pltfm_free(pdev);
> >
> > + ? ? ? if (np)
> > + ? ? ? ? ? ? ? kfree(boarddata);
> > +
> > ? ? ? ?return 0;
> > ?}
> >
> > @@ -451,6 +542,7 @@ static struct platform_driver sdhci_esdhc_imx_driver = {
> > ? ? ? ?.driver ? ? ? ? = {
> > ? ? ? ? ? ? ? ?.name ? = "sdhci-esdhc-imx",
> > ? ? ? ? ? ? ? ?.owner ?= THIS_MODULE,
> > + ? ? ? ? ? ? ? .of_match_table = imx_esdhc_dt_ids,
> > ? ? ? ?},
> > ? ? ? ?.id_table ? ? ? = imx_esdhc_devtype,
> > ? ? ? ?.probe ? ? ? ? ?= sdhci_esdhc_imx_probe,
> > --
> > 1.7.4.1
