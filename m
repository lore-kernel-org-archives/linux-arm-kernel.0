From: mpa@pengutronix.de (Markus Pargmann)
Date: Thu, 30 May 2013 11:10:54 +0200
Subject: [PATCH v6 01/10] ASoC: phycore-ac97: Add DT support
In-Reply-To: <20130529135342.GB29528@S2101-09.ap.freescale.net>
References: <1369752478-30260-1-git-send-email-mpa@pengutronix.de>
 <1369752478-30260-2-git-send-email-mpa@pengutronix.de>
 <20130529135342.GB29528@S2101-09.ap.freescale.net>
Message-ID: <20130530091054.GA31548@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 29, 2013 at 09:53:45PM +0800, Shawn Guo wrote:
> On Tue, May 28, 2013 at 04:47:49PM +0200, Markus Pargmann wrote:
> > Add devicetree support for this audio soc fabric driver.
> > 
> > platform_of_node and cpu_of_node are set according to the fsl,audmux
> > phandle.
> > 
> > This patch adds handling of ac97 reset functions according to fsl ac97
> > support. They are setup from here to avoid board specific code in the
> > generic fsl-ssi driver.
> > 
> > This patch changes the handling of pca100 boards from non-DT to DT only.
> > pcm043 is still handled without DT.
> > 
> > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> > ---
> > 
> > Notes:
> >     Changes in v6:
> >      - phycore-ac97 now manages the ac97 reset functions of the boards using
> >        this combination of ssi-codec.
> >      - Removed preprocessor ifs for DT, non-DT distinction. pcm043 is now
> >        non-DT only and pca100 DT only.
> >     
> >     Changes in v4:
> >      - New property phytec,audmux to check which audmux setup should be
> >        executed. Checking for fsl,imx21-audmux and fsl,imx31-audmux.
> >     
> >     Changes in v3:
> >      - Add some more information in the commit message.
> >     
> >     Changes in v2:
> >      - Simplify the driver, by combining audmux port configurations. The
> >        audmux driver actually knows on which platform he is running and
> >        will return the appropriate error code if we use functions for
> >        another platform. So we don't need to have the knowledge about it
> >        in phycore-ac97 and can try both functions. This removes the need
> >        of different compatibilities and renames it to phycore-ac97.
> >      - Use a phandle for the cpu_dai link.
> >      - Add devicetree binding documentation.
> >      - Rename binding to phytec,phycore-ac97 and fsl,ssi to phytec,ssi
> >     
> >     Changes in v2:
> >      - Simplify the driver, by combining audmux port configurations. The
> >        audmux driver actually knows on which platform he is running and
> >        will return the appropriate error code if we use functions for
> >        another platform. So we don't need to have the knowledge about it
> >        in phycore-ac97 and can try both functions. This removes the need
> >        of different compatibilities and renames it to imx27-ac97.
> >      - Use a phandle for the cpu_dai link.
> >      - Add devicetree binding documentation.
> >      - Rename binding to phytec,phycore-ac97 and fsl,ssi to phytec,ssi
> > 
> >  .../bindings/sound/phytec,phycore-ac97.txt         |  14 ++
> >  sound/soc/fsl/phycore-ac97.c                       | 241 ++++++++++++++++++---
> >  2 files changed, 229 insertions(+), 26 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/sound/phytec,phycore-ac97.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/sound/phytec,phycore-ac97.txt b/Documentation/devicetree/bindings/sound/phytec,phycore-ac97.txt
> > new file mode 100644
> > index 0000000..41201ff
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/sound/phytec,phycore-ac97.txt
> > @@ -0,0 +1,14 @@
> > +Phytec phycore AC97
> > +
> > +Required properties:
> > +- compatible: "phytec,phycore-ac97"
> > +- phytec,ssi: A phandle to the ssi device that is connected to ac97.
> > +- phytec,audmux: A phandle to the audmux device.
> > +
> > +Example:
> > +
> > +sound {
> > +	compatible = "phytec,phycore-ac97";
> > +	phytec,ssi = <&ssi1>;
> > +	phytec,audmux = <&audmux>;
> > +};
> > diff --git a/sound/soc/fsl/phycore-ac97.c b/sound/soc/fsl/phycore-ac97.c
> > index ae403c2..bf2c600 100644
> > --- a/sound/soc/fsl/phycore-ac97.c
> > +++ b/sound/soc/fsl/phycore-ac97.c
> > @@ -20,8 +20,14 @@
> >  #include <asm/mach-types.h>
> >  
> >  #include "imx-audmux.h"
> > +#include "fsl_ssi.h"
> > +
> > +#define DRV_NAME "phycore-audio-fabric"
> >  
> >  static struct snd_soc_card imx_phycore;
> > +static struct device_node *phycore_dai_cpu_node;
> > +static void (*phycore_ac97_reset) (struct snd_ac97 *ac97);
> > +static void (*phycore_ac97_warm_reset)(struct snd_ac97 *ac97);
> >  
> >  static struct snd_soc_ops imx_phycore_hifi_ops = {
> >  };
> > @@ -32,12 +38,12 @@ static struct snd_soc_dai_link imx_phycore_dai_ac97[] = {
> >  		.stream_name	= "HiFi",
> >  		.codec_dai_name		= "wm9712-hifi",
> >  		.codec_name	= "wm9712-codec",
> > -		.cpu_dai_name	= "imx-ssi.0",
> > -		.platform_name	= "imx-ssi.0",
> 
> I do not think these and phycore_ac97_plat_name changes are necessary,
> since of_node will always take precedence over name in match.

They are necessary, snd_soc_register_card returns with -EINVAL if both,
name and of_node, are set.

> 
> >  		.ops		= &imx_phycore_hifi_ops,
> >  	},
> >  };
> >  
> > +static const char phycore_ac97_plat_name[] = "imx-ssi.0";
> > +
> >  static struct snd_soc_card imx_phycore = {
> >  	.name		= "PhyCORE-ac97-audio",
> >  	.owner		= THIS_MODULE,
> > @@ -45,40 +51,52 @@ static struct snd_soc_card imx_phycore = {
> >  	.num_links	= ARRAY_SIZE(imx_phycore_dai_ac97),
> >  };
> >  
> > -static struct platform_device *imx_phycore_snd_ac97_device;
> > +static void phycore_ac97_imx21_audmux(void)
> > +{
> > +	imx_audmux_v1_configure_port(MX27_AUDMUX_HPCR1_SSI0,
> > +		IMX_AUDMUX_V1_PCR_SYN | /* 4wire mode */
> > +		IMX_AUDMUX_V1_PCR_TFCSEL(3) |
> > +		IMX_AUDMUX_V1_PCR_TCLKDIR | /* clock is output */
> > +		IMX_AUDMUX_V1_PCR_RXDSEL(3));
> > +	imx_audmux_v1_configure_port(3,
> > +		IMX_AUDMUX_V1_PCR_SYN | /* 4wire mode */
> > +		IMX_AUDMUX_V1_PCR_TFCSEL(0) |
> > +		IMX_AUDMUX_V1_PCR_TFSDIR |
> > +		IMX_AUDMUX_V1_PCR_RXDSEL(0));
> > +}
> > +
> > +static void phycore_ac97_imx31_audmux(void)
> > +{
> > +	imx_audmux_v2_configure_port(3,
> > +		IMX_AUDMUX_V2_PTCR_SYN | /* 4wire mode */
> > +		IMX_AUDMUX_V2_PTCR_TFSEL(0) |
> > +		IMX_AUDMUX_V2_PTCR_TFSDIR,
> > +		IMX_AUDMUX_V2_PDCR_RXDSEL(0));
> > +	imx_audmux_v2_configure_port(0,
> > +		IMX_AUDMUX_V2_PTCR_SYN | /* 4wire mode */
> > +		IMX_AUDMUX_V2_PTCR_TCSEL(3) |
> > +		IMX_AUDMUX_V2_PTCR_TCLKDIR, /* clock is output */
> > +		IMX_AUDMUX_V2_PDCR_RXDSEL(3));
> > +}
> > +
> >  static struct platform_device *imx_phycore_snd_device;
> >  
> > +static struct platform_device *imx_phycore_snd_ac97_device;
> > +
> >  static int __init imx_phycore_init(void)
> >  {
> >  	int ret;
> >  
> > -	if (machine_is_pca100()) {
> > -		imx_audmux_v1_configure_port(MX27_AUDMUX_HPCR1_SSI0,
> > -			IMX_AUDMUX_V1_PCR_SYN | /* 4wire mode */
> > -			IMX_AUDMUX_V1_PCR_TFCSEL(3) |
> > -			IMX_AUDMUX_V1_PCR_TCLKDIR | /* clock is output */
> > -			IMX_AUDMUX_V1_PCR_RXDSEL(3));
> > -		imx_audmux_v1_configure_port(3,
> > -			IMX_AUDMUX_V1_PCR_SYN | /* 4wire mode */
> > -			IMX_AUDMUX_V1_PCR_TFCSEL(0) |
> > -			IMX_AUDMUX_V1_PCR_TFSDIR |
> > -			IMX_AUDMUX_V1_PCR_RXDSEL(0));
> > -	} else if (machine_is_pcm043()) {
> > -		imx_audmux_v2_configure_port(3,
> > -			IMX_AUDMUX_V2_PTCR_SYN | /* 4wire mode */
> > -			IMX_AUDMUX_V2_PTCR_TFSEL(0) |
> > -			IMX_AUDMUX_V2_PTCR_TFSDIR,
> > -			IMX_AUDMUX_V2_PDCR_RXDSEL(0));
> > -		imx_audmux_v2_configure_port(0,
> > -			IMX_AUDMUX_V2_PTCR_SYN | /* 4wire mode */
> > -			IMX_AUDMUX_V2_PTCR_TCSEL(3) |
> > -			IMX_AUDMUX_V2_PTCR_TCLKDIR, /* clock is output */
> > -			IMX_AUDMUX_V2_PDCR_RXDSEL(3));
> > +	if (machine_is_pcm043()) {
> > +		phycore_ac97_imx31_audmux();
> >  	} else {
> >  		/* return happy. We might run on a totally different machine */
> >  		return 0;
> >  	}
> >  
> > +	imx_phycore_dai_ac97[0].cpu_dai_name = phycore_ac97_plat_name;
> > +	imx_phycore_dai_ac97[0].platform_name = phycore_ac97_plat_name;
> > +
> >  	imx_phycore_snd_ac97_device = platform_device_alloc("soc-audio", -1);
> >  	if (!imx_phycore_snd_ac97_device)
> >  		return -ENOMEM;
> > @@ -108,18 +126,189 @@ fail2:
> >  	platform_device_del(imx_phycore_snd_ac97_device);
> >  fail1:
> >  	platform_device_put(imx_phycore_snd_ac97_device);
> > +	imx_phycore_dai_ac97[0].cpu_dai_name = NULL;
> > +	imx_phycore_dai_ac97[0].platform_name = NULL;
> >  	return ret;
> >  }
> >  
> >  static void __exit imx_phycore_exit(void)
> >  {
> > +	if (!machine_is_pcm043())
> > +		return;
> > +
> >  	platform_device_unregister(imx_phycore_snd_device);
> >  	platform_device_unregister(imx_phycore_snd_ac97_device);
> > +
> > +	imx_phycore_dai_ac97[0].cpu_dai_name = NULL;
> > +	imx_phycore_dai_ac97[0].platform_name = NULL;
> >  }
> >  
> >  late_initcall(imx_phycore_init);
> >  module_exit(imx_phycore_exit);
> >  
> > +
> > +static const struct of_device_id imx_phycore_ac97_of_dev_id[] = {
> > +	{
> > +		.compatible = "phytec,phycore-ac97",
> > +	}, {
> > +		/* sentinel */
> > +	}
> > +};
> > +MODULE_DEVICE_TABLE(of, imx_phycore_ac97_of_dev_id);
> > +
> > +
> > +/*
> > + * Pointer to AC97 reset functions for specific boards
> > + */
> > +#if IS_ENABLED(CONFIG_MACH_PCA100)
> > +extern void pca100_ac97_cold_reset(struct snd_ac97 *ac97);
> > +extern void pca100_ac97_warm_reset(struct snd_ac97 *ac97);
> > +#else
> > +void pca100_ac97_cold_reset(struct snd_ac97 *ac97) { }
> > +void pca100_ac97_warm_reset(struct snd_ac97 *ac97) { }
> 
> static?

Thanks, added.

> 
> > +#endif
> > +
> > +#if IS_ENABLED(CONFIG_MACH_PCM043)
> > +extern void pcm043_ac97_cold_reset(struct snd_ac97 *ac97);
> > +extern void pcm043_ac97_warm_reset(struct snd_ac97 *ac97);
> > +#else
> > +void pcm043_ac97_cold_reset(struct snd_ac97 *ac97) { }
> > +void pcm043_ac97_warm_reset(struct snd_ac97 *ac97) { }
> > +#endif
> > +
> > +static void phycore_soc_ac97_reset(struct snd_ac97 *ac97)
> > +{
> > +	if (phycore_ac97_reset)
> > +		phycore_ac97_reset(ac97);
> > +	/* First read sometimes fails, do a dummy read */
> > +	fsl_ssi_ac97_read(ac97, 0);
> 
> This function is unavailable until patch #7, right?

Yes, sorry, I missed to update the order of the patches. I will fix it.

> 
> > +}
> > +
> > +static void phycore_soc_ac97_warm_reset(struct snd_ac97 *ac97)
> > +{
> > +	if (phycore_ac97_warm_reset)
> > +		phycore_ac97_warm_reset(ac97);
> > +
> > +	/* First read sometimes fails, do a dummy read */
> > +	fsl_ssi_ac97_read(ac97, 0);
> > +}
> > +
> > +static int phycore_ac97_setup_devices(struct platform_device *pdev)
> > +{
> > +	int ret;
> > +
> > +	imx_phycore_snd_device = platform_device_alloc("wm9712-codec", -1);
> > +	if (!imx_phycore_snd_device)
> > +		return -ENOMEM;
> > +
> > +	ret = platform_device_add(imx_phycore_snd_device);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "ASoC: Platform device allocation failed\n");
> > +		goto fail1;
> > +	}
> > +
> > +	ret = snd_soc_register_card(&imx_phycore);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "ASoC: soc card registration failed\n");
> > +		goto fail2;
> > +	}
> > +	return 0;
> > +
> > +fail2:
> > +	platform_device_del(imx_phycore_snd_device);
> > +fail1:
> > +	platform_device_put(imx_phycore_snd_device);
> > +	return ret;
> > +}
> > +
> > +static int imx_phycore_ac97_probe(struct platform_device *pdev)
> > +{
> > +	int ret;
> > +	struct device_node *ssi_np;
> > +	struct device_node *audmux_np;
> > +	const char *sprop;
> > +	const char *p;
> > +
> > +	imx_phycore.dev = &pdev->dev;
> > +
> > +	audmux_np = of_parse_phandle(pdev->dev.of_node, "phytec,audmux", 0);
> > +	if (!audmux_np) {
> > +		dev_err(&pdev->dev, "Failed to parse phytec,audmux phandle\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (of_device_is_compatible(audmux_np, "fsl,imx21-audmux")) {
> > +		phycore_ac97_imx21_audmux();
> > +	} else if (of_device_is_compatible(audmux_np, "fsl,imx31-audmux")) {
> > +		phycore_ac97_imx31_audmux();
> > +	} else {
> > +		dev_err(&pdev->dev, "Unknown audmux, failed to setup audmux\n");
> > +		of_node_put(audmux_np);
> > +		return -EINVAL;
> > +	}
> > +	of_node_put(audmux_np);
> > +
> > +	ssi_np = of_parse_phandle(pdev->dev.of_node, "phytec,ssi", 0);
> > +	if (!ssi_np) {
> > +		dev_err(&pdev->dev, "No valid ssi phandle found\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	imx_phycore_dai_ac97[0].cpu_of_node = ssi_np;
> > +	imx_phycore_dai_ac97[0].platform_of_node = ssi_np;
> > +	phycore_dai_cpu_node = ssi_np;
> > +
> > +	sprop = of_get_property(of_find_node_by_path("/"), "compatible", NULL);
> > +	p = strrchr(sprop, ',');
> > +	if (p)
> > +		sprop = p + 1;
> > +
> > +	if (!strcmp(sprop, "imx27-pca100")) {
> 
> Since this is a phycore/phytec specific ASoC-machine driver, what's the
> problem with matching the machine compatible string by simply calling
> of_machine_is_compatible()?

Changed.

> 
> > +		phycore_ac97_reset = pca100_ac97_cold_reset;
> > +		phycore_ac97_warm_reset = pca100_ac97_warm_reset;
> > +	} else if (!strcmp(sprop, "imx35-pcm043")) {
> > +		phycore_ac97_reset = pcm043_ac97_cold_reset;
> > +		phycore_ac97_warm_reset = pcm043_ac97_warm_reset;
> > +	} else {
> > +		dev_err(&pdev->dev, "Failed to set AC97 reset functions, unknown board.\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	fsl_ssi_ac97_set_reset(phycore_soc_ac97_reset,
> > +			phycore_soc_ac97_warm_reset);
> > +
> > +	ret = phycore_ac97_setup_devices(pdev);
> > +	if (ret)
> > +		of_node_put(phycore_dai_cpu_node);
> > +
> > +	return ret;
> > +}
> > +
> > +static int imx_phycore_ac97_remove(struct platform_device *pdev)
> > +{
> > +	of_node_put(phycore_dai_cpu_node);
> > +	phycore_dai_cpu_node = NULL;
> > +
> > +	platform_device_unregister(imx_phycore_snd_device);
> 
> snd_soc_unregister_card() call is missing?

Yes.

Thanks,

Markus

> 
> Shawn
> 
> > +
> > +	phycore_ac97_reset = NULL;
> > +	phycore_ac97_warm_reset = NULL;
> > +
> > +	return 0;
> > +}
> > +
> > +static struct platform_driver imx_phycore_ac97_driver = {
> > +	.probe		= imx_phycore_ac97_probe,
> > +	.remove		= imx_phycore_ac97_remove,
> > +	.driver		= {
> > +		.name	= DRV_NAME,
> > +		.owner	= THIS_MODULE,
> > +		.of_match_table = imx_phycore_ac97_of_dev_id,
> > +	},
> > +};
> > +
> > +module_platform_driver(imx_phycore_ac97_driver);
> > +
> >  MODULE_AUTHOR("Sascha Hauer <s.hauer@pengutronix.de>");
> > -MODULE_DESCRIPTION("PhyCORE ALSA SoC driver");
> > +MODULE_DESCRIPTION(DRV_NAME ": PhyCORE ALSA SoC fabric driver");
> >  MODULE_LICENSE("GPL");
> > -- 
> > 1.8.2.1
> > 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
