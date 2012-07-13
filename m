From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 13 Jul 2012 19:49:35 +0200
Subject: [PATCH 00/11] make struct of_device_id.data const
In-Reply-To: <201207131624.27266.arnd@arndb.de>
References: <1342182734-321-1-git-send-email-y> <5000175E.4070702@gmail.com>
 <20120713134638.GH592@pengutronix.de>
 <201207131624.27266.arnd@arndb.de>
Message-ID: <20120713174935.GN592@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, Jul 13, 2012 at 04:24:26PM +0000, Arnd Bergmann wrote:
> On Friday 13 July 2012, Uwe Kleine-K?nig wrote:
> > On Fri, Jul 13, 2012 at 07:41:02AM -0500, Rob Herring wrote:
> > > On 07/13/2012 07:32 AM, y at pengutronix.de wrote:
> > > > From: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> > > > 
> > > > this series' goal is to make struct of_device_id.data const.
> > > > Conceptually a driver must not modify the data contained there so making
> > > > it const is the right thing.
> > > > 
> > > > This change might introduce warnings because drivers don't use const to
> > > > access the data pointed to by of_device_id.data. In most cases the fix
> > > > is to add some consts.
> > > > 
> > > > This series (apart from adding this const in patch 10) fixes all drivers
> > > > covered by all arm defconfigs (based on v3.5-rc6).
> > > > 
> > > 
> > > What about other arches?
> >
> > I didn't looked at them, mainly because I don't have the scripts for
> > arches other than arm to do such testing. Also note that it introduces
> > only some warnings, but no breakage. So adding the const in the merge
> > window might be ok?!
> 
> I think it makes sense to change the drivers that are easy to find now:
> 
> git grep -A6 of_device_id | grep '\<data\>.*='  | brain
> 
> arch/c6x/platforms/plldata.c-   { .compatible = "ti,c6455-pll", .data = c6455_setup_clocks },
> arch/mips/lantiq/irq.c- { .compatible = "lantiq,icu", .data = icu_of_init },
> arch/powerpc/platforms/83xx/suspend.c-          .data = &pmc_types[0],
> arch/powerpc/platforms/cell/celleb_pci.c-               .data = &celleb_fake_pci_spec,
> arch/powerpc/platforms/cell/celleb_pci.c-               .data = &celleb_epci_spec,
> arch/powerpc/sysdev/fsl_msi.c-          .data = (void *)&mpic_msi_feature,
> drivers/atm/fore200e.c-         .data = (void *) &fore200e_bus[1],
> drivers/char/xilinx_hwicap/xilinx_hwicap.c-     { .compatible = "xlnx,opb-hwicap-1.00.b", .data = &buffer_icap_config},
> drivers/i2c/busses/i2c-mpc.c-   {.compatible = "mpc5200-i2c", .data = &mpc_i2c_data_52xx, },
> drivers/macintosh/mediabay.c-   .data           = &keylargo_mb_ops,
> drivers/mfd/da9052-i2c.c-       { .compatible = "dlg,da9053-aa", .data = &da9052_i2c_id[1] },
> drivers/net/can/mscan/mpc5xxx_can.c-    { .compatible = "fsl,mpc5200-mscan", .data = &mpc5200_can_data, },
> drivers/scsi/qlogicpti.c-               .data = &qpti_template,
> drivers/usb/host/fsl-mph-dr-of.c-       { .compatible = "fsl-usb2-mph", .data = &fsl_usb2_mpc8xxx_pd, },
> drivers/watchdog/mpc8xxx_wdt.c-         .data = &(struct mpc8xxx_wdt_type) {
> 
> I'm optimistic that this list covers the vast majority of the non-ARM
> drivers, and some of them don't even need any changes. I've done
> patches for the others below.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/powerpc/platforms/83xx/suspend.c    |    2 +-
>  arch/powerpc/platforms/cell/celleb_pci.c |    2 +-
>  arch/powerpc/sysdev/fsl_msi.c            |    8 ++++----
>  drivers/i2c/busses/i2c-mpc.c             |   12 ++++++------
>  drivers/macintosh/mediabay.c             |    8 ++++----
>  drivers/mfd/da9052-i2c.c                 |    4 ++--
>  drivers/net/can/mscan/mpc5xxx_can.c      |    6 +++---
>  drivers/scsi/qlogicpti.c                 |    2 +-
>  drivers/watchdog/mpc8xxx_wdt.c           |    2 +-
>  10 files changed, 23 insertions(+), 26 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/83xx/suspend.c b/arch/powerpc/platforms/83xx/suspend.c
> index 1a04671..1d769a2 100644
> --- a/arch/powerpc/platforms/83xx/suspend.c
> +++ b/arch/powerpc/platforms/83xx/suspend.c
> @@ -326,7 +326,7 @@ static int pmc_probe(struct platform_device *ofdev)
>  	const struct of_device_id *match;
>  	struct device_node *np = ofdev->dev.of_node;
>  	struct resource res;
> -	struct pmc_type *type;
> +	const struct pmc_type *type;
>  	int ret = 0;
>  
>  	match = of_match_device(pmc_match, &ofdev->dev);
> diff --git a/arch/powerpc/platforms/cell/celleb_pci.c b/arch/powerpc/platforms/cell/celleb_pci.c
> index 5822141..abc8af4 100644
> --- a/arch/powerpc/platforms/cell/celleb_pci.c
> +++ b/arch/powerpc/platforms/cell/celleb_pci.c
> @@ -472,7 +472,7 @@ int __init celleb_setup_phb(struct pci_controller *phb)
>  {
>  	struct device_node *dev = phb->dn;
>  	const struct of_device_id *match;
> -	struct celleb_phb_spec *phb_spec;
> +	const struct celleb_phb_spec *phb_spec;
>  	int rc;
>  
>  	match = of_match_node(celleb_phb_match, dev);
> diff --git a/arch/powerpc/sysdev/fsl_msi.c b/arch/powerpc/sysdev/fsl_msi.c
> index 6e097de..51ffafa 100644
> --- a/arch/powerpc/sysdev/fsl_msi.c
> +++ b/arch/powerpc/sysdev/fsl_msi.c
> @@ -368,7 +368,7 @@ static int __devinit fsl_of_msi_probe(struct platform_device *dev)
>  	int err, i, j, irq_index, count;
>  	int rc;
>  	const u32 *p;
> -	struct fsl_msi_feature *features;
> +	const struct fsl_msi_feature *features;
>  	int len;
>  	u32 offset;
>  	static const u32 all_avail[] = { 0, NR_MSI_IRQS };
> @@ -502,15 +502,15 @@ static const struct fsl_msi_feature vmpic_msi_feature = {
>  static const struct of_device_id fsl_of_msi_ids[] = {
>  	{
>  		.compatible = "fsl,mpic-msi",
> -		.data = (void *)&mpic_msi_feature,
> +		.data = &mpic_msi_feature,
This looks unrelated.

>  	},
>  	{
>  		.compatible = "fsl,ipic-msi",
> -		.data = (void *)&ipic_msi_feature,
> +		.data = &ipic_msi_feature,
>  	},
>  	{
>  		.compatible = "fsl,vmpic-msi",
> -		.data = (void *)&vmpic_msi_feature,
> +		.data = &vmpic_msi_feature,
>  	},
>  	{}
>  };
> diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
> index b76731e..57f7703 100644
> --- a/drivers/i2c/busses/i2c-mpc.c
> +++ b/drivers/i2c/busses/i2c-mpc.c
> @@ -647,7 +647,7 @@ static int __devinit fsl_i2c_probe(struct platform_device *op)
>  	}
>  
>  	if (match->data) {
> -		struct mpc_i2c_data *data = match->data;
> +		const struct mpc_i2c_data *data = match->data;
>  		data->setup(op->dev.of_node, i2c, clock, data->prescaler);
>  	} else {
>  		/* Backwards compatibility */
> @@ -730,24 +730,24 @@ static int mpc_i2c_resume(struct device *dev)
>  SIMPLE_DEV_PM_OPS(mpc_i2c_pm_ops, mpc_i2c_suspend, mpc_i2c_resume);
>  #endif
>  
> -static struct mpc_i2c_data mpc_i2c_data_512x __devinitdata = {
> +static const struct mpc_i2c_data mpc_i2c_data_512x __devinitdata = {
I guess this results in a warning until after patch 10 is applied? (A
few more down below.)

In the meantime I expanded my defconfig build script to handle powerpc,
too. I'll check these. I think I'll have to let the build run over
night...

Thanks Arnd for your effort.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
