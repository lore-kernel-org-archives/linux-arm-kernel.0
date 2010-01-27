From: LW@KARO-electronics.de (=?iso-8859-15?Q?Lothar_Wa=DFmann?=)
Date: Wed, 27 Jan 2010 14:30:49 +0100
Subject: [PATCH 1/3] rtc: driver for the DryIce block found in i.MX25 chips
In-Reply-To: <e62d43482b15f0d3f9a25a9868434cd34df0dd76.1264596212.git.baruch@tkos.co.il>
References: <cover.1264596212.git.baruch@tkos.co.il>
	<e62d43482b15f0d3f9a25a9868434cd34df0dd76.1264596212.git.baruch@tkos.co.il>
Message-ID: <19296.16393.211432.933296@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Baruch Siach writes:
> This driver is based on code from Freescale which accompanies their i.MX25 PDK
> board, with some cleanup.
> 
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
>  drivers/rtc/Kconfig     |   10 +
>  drivers/rtc/Makefile    |    1 +
>  drivers/rtc/rtc-imxdi.c |  559 +++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 570 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/rtc/rtc-imxdi.c
> 
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index 8167e9e..83bd602 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -527,6 +527,16 @@ config RTC_DRV_MSM6242
>  	  This driver can also be built as a module. If so, the module
>  	  will be called rtc-msm6242.
>  
> +config RTC_DRV_IMXDI
> +	tristate "Freescale IMX DryIce Real Time Clock"
> +	depends on ARCH_MX25
> +	depends on RTC_CLASS
> +	help
> +	   Support for Freescale IMX DryIce RTC
> +
> +	   This driver can also be built as a module, if so, the module
> +	   will be called "rtc-imxdi".
> +
>  config RTC_MXC
>  	tristate "Freescale MXC Real Time Clock"
>  	depends on ARCH_MXC
> diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
> index e5160fd..f2d3420 100644
> --- a/drivers/rtc/Makefile
> +++ b/drivers/rtc/Makefile
> @@ -44,6 +44,7 @@ obj-$(CONFIG_RTC_DRV_EFI)	+= rtc-efi.o
>  obj-$(CONFIG_RTC_DRV_EP93XX)	+= rtc-ep93xx.o
>  obj-$(CONFIG_RTC_DRV_FM3130)	+= rtc-fm3130.o
>  obj-$(CONFIG_RTC_DRV_GENERIC)	+= rtc-generic.o
> +obj-$(CONFIG_RTC_DRV_IMXDI)	+= rtc-imxdi.o
>  obj-$(CONFIG_RTC_DRV_ISL1208)	+= rtc-isl1208.o
>  obj-$(CONFIG_RTC_DRV_M41T80)	+= rtc-m41t80.o
>  obj-$(CONFIG_RTC_DRV_M41T94)	+= rtc-m41t94.o
> diff --git a/drivers/rtc/rtc-imxdi.c b/drivers/rtc/rtc-imxdi.c
> new file mode 100644
> index 0000000..12a6df5
> --- /dev/null
> +++ b/drivers/rtc/rtc-imxdi.c
[...]
> +static int dryice_rtc_probe(struct platform_device *pdev)
> +{
> +	struct resource *res;
> +	struct imxdi_dev *imxdi = NULL;
> +	int rc = 0;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		return -ENODEV;
> +
> +	imxdi = kzalloc(sizeof(*imxdi), GFP_KERNEL);
> +	if (!imxdi)
> +		return -ENOMEM;
> +
> +	imxdi->pdev = pdev;
> +	imxdi->irq = -1;
> +
> +	if (!request_mem_region(res->start, resource_size(res),
> +				pdev->name)) {
> +		rc = -EBUSY;
> +		goto err_free_mem;
> +	}
> +	imxdi->ioaddr = ioremap(res->start, resource_size(res));
> +	if (imxdi->ioaddr == NULL) {
> +		rc = -ENOMEM;
> +		goto err_release_region;
> +	}
> +	imxdi->irq = platform_get_irq(pdev, 0);
> +
> +	init_waitqueue_head(&imxdi->write_wait);
> +
> +	INIT_WORK(&imxdi->work, dryice_work);
> +
> +	mutex_init(&imxdi->write_mutex);
> +
> +	imxdi->clk = clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(imxdi->clk)) {
> +		rc = -ENODEV;
>
rc = PTR_ERR(imxdi->clk);


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
