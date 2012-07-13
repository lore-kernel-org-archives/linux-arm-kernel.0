From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 13 Jul 2012 16:24:26 +0000
Subject: [PATCH 00/11] make struct of_device_id.data const
In-Reply-To: <20120713134638.GH592@pengutronix.de>
References: <1342182734-321-1-git-send-email-y> <5000175E.4070702@gmail.com>
 <20120713134638.GH592@pengutronix.de>
Message-ID: <201207131624.27266.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 13 July 2012, Uwe Kleine-K?nig wrote:
> On Fri, Jul 13, 2012 at 07:41:02AM -0500, Rob Herring wrote:
> > On 07/13/2012 07:32 AM, y at pengutronix.de wrote:
> > > From: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> > > 
> > > this series' goal is to make struct of_device_id.data const.
> > > Conceptually a driver must not modify the data contained there so making
> > > it const is the right thing.
> > > 
> > > This change might introduce warnings because drivers don't use const to
> > > access the data pointed to by of_device_id.data. In most cases the fix
> > > is to add some consts.
> > > 
> > > This series (apart from adding this const in patch 10) fixes all drivers
> > > covered by all arm defconfigs (based on v3.5-rc6).
> > > 
> > 
> > What about other arches?
>
> I didn't looked at them, mainly because I don't have the scripts for
> arches other than arm to do such testing. Also note that it introduces
> only some warnings, but no breakage. So adding the const in the merge
> window might be ok?!

I think it makes sense to change the drivers that are easy to find now:

git grep -A6 of_device_id | grep '\<data\>.*='  | brain

arch/c6x/platforms/plldata.c-   { .compatible = "ti,c6455-pll", .data = c6455_setup_clocks },
arch/mips/lantiq/irq.c- { .compatible = "lantiq,icu", .data = icu_of_init },
arch/powerpc/platforms/83xx/suspend.c-          .data = &pmc_types[0],
arch/powerpc/platforms/cell/celleb_pci.c-               .data = &celleb_fake_pci_spec,
arch/powerpc/platforms/cell/celleb_pci.c-               .data = &celleb_epci_spec,
arch/powerpc/sysdev/fsl_msi.c-          .data = (void *)&mpic_msi_feature,
drivers/atm/fore200e.c-         .data = (void *) &fore200e_bus[1],
drivers/char/xilinx_hwicap/xilinx_hwicap.c-     { .compatible = "xlnx,opb-hwicap-1.00.b", .data = &buffer_icap_config},
drivers/i2c/busses/i2c-mpc.c-   {.compatible = "mpc5200-i2c", .data = &mpc_i2c_data_52xx, },
drivers/macintosh/mediabay.c-   .data           = &keylargo_mb_ops,
drivers/mfd/da9052-i2c.c-       { .compatible = "dlg,da9053-aa", .data = &da9052_i2c_id[1] },
drivers/net/can/mscan/mpc5xxx_can.c-    { .compatible = "fsl,mpc5200-mscan", .data = &mpc5200_can_data, },
drivers/scsi/qlogicpti.c-               .data = &qpti_template,
drivers/usb/host/fsl-mph-dr-of.c-       { .compatible = "fsl-usb2-mph", .data = &fsl_usb2_mpc8xxx_pd, },
drivers/watchdog/mpc8xxx_wdt.c-         .data = &(struct mpc8xxx_wdt_type) {

I'm optimistic that this list covers the vast majority of the non-ARM
drivers, and some of them don't even need any changes. I've done
patches for the others below.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/platforms/83xx/suspend.c    |    2 +-
 arch/powerpc/platforms/cell/celleb_pci.c |    2 +-
 arch/powerpc/sysdev/fsl_msi.c            |    8 ++++----
 drivers/i2c/busses/i2c-mpc.c             |   12 ++++++------
 drivers/macintosh/mediabay.c             |    8 ++++----
 drivers/mfd/da9052-i2c.c                 |    4 ++--
 drivers/net/can/mscan/mpc5xxx_can.c      |    6 +++---
 drivers/scsi/qlogicpti.c                 |    2 +-
 drivers/watchdog/mpc8xxx_wdt.c           |    2 +-
 10 files changed, 23 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/platforms/83xx/suspend.c b/arch/powerpc/platforms/83xx/suspend.c
index 1a04671..1d769a2 100644
--- a/arch/powerpc/platforms/83xx/suspend.c
+++ b/arch/powerpc/platforms/83xx/suspend.c
@@ -326,7 +326,7 @@ static int pmc_probe(struct platform_device *ofdev)
 	const struct of_device_id *match;
 	struct device_node *np = ofdev->dev.of_node;
 	struct resource res;
-	struct pmc_type *type;
+	const struct pmc_type *type;
 	int ret = 0;
 
 	match = of_match_device(pmc_match, &ofdev->dev);
diff --git a/arch/powerpc/platforms/cell/celleb_pci.c b/arch/powerpc/platforms/cell/celleb_pci.c
index 5822141..abc8af4 100644
--- a/arch/powerpc/platforms/cell/celleb_pci.c
+++ b/arch/powerpc/platforms/cell/celleb_pci.c
@@ -472,7 +472,7 @@ int __init celleb_setup_phb(struct pci_controller *phb)
 {
 	struct device_node *dev = phb->dn;
 	const struct of_device_id *match;
-	struct celleb_phb_spec *phb_spec;
+	const struct celleb_phb_spec *phb_spec;
 	int rc;
 
 	match = of_match_node(celleb_phb_match, dev);
diff --git a/arch/powerpc/sysdev/fsl_msi.c b/arch/powerpc/sysdev/fsl_msi.c
index 6e097de..51ffafa 100644
--- a/arch/powerpc/sysdev/fsl_msi.c
+++ b/arch/powerpc/sysdev/fsl_msi.c
@@ -368,7 +368,7 @@ static int __devinit fsl_of_msi_probe(struct platform_device *dev)
 	int err, i, j, irq_index, count;
 	int rc;
 	const u32 *p;
-	struct fsl_msi_feature *features;
+	const struct fsl_msi_feature *features;
 	int len;
 	u32 offset;
 	static const u32 all_avail[] = { 0, NR_MSI_IRQS };
@@ -502,15 +502,15 @@ static const struct fsl_msi_feature vmpic_msi_feature = {
 static const struct of_device_id fsl_of_msi_ids[] = {
 	{
 		.compatible = "fsl,mpic-msi",
-		.data = (void *)&mpic_msi_feature,
+		.data = &mpic_msi_feature,
 	},
 	{
 		.compatible = "fsl,ipic-msi",
-		.data = (void *)&ipic_msi_feature,
+		.data = &ipic_msi_feature,
 	},
 	{
 		.compatible = "fsl,vmpic-msi",
-		.data = (void *)&vmpic_msi_feature,
+		.data = &vmpic_msi_feature,
 	},
 	{}
 };
diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
index b76731e..57f7703 100644
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -647,7 +647,7 @@ static int __devinit fsl_i2c_probe(struct platform_device *op)
 	}
 
 	if (match->data) {
-		struct mpc_i2c_data *data = match->data;
+		const struct mpc_i2c_data *data = match->data;
 		data->setup(op->dev.of_node, i2c, clock, data->prescaler);
 	} else {
 		/* Backwards compatibility */
@@ -730,24 +730,24 @@ static int mpc_i2c_resume(struct device *dev)
 SIMPLE_DEV_PM_OPS(mpc_i2c_pm_ops, mpc_i2c_suspend, mpc_i2c_resume);
 #endif
 
-static struct mpc_i2c_data mpc_i2c_data_512x __devinitdata = {
+static const struct mpc_i2c_data mpc_i2c_data_512x __devinitdata = {
 	.setup = mpc_i2c_setup_512x,
 };
 
-static struct mpc_i2c_data mpc_i2c_data_52xx __devinitdata = {
+static const struct mpc_i2c_data mpc_i2c_data_52xx __devinitdata = {
 	.setup = mpc_i2c_setup_52xx,
 };
 
-static struct mpc_i2c_data mpc_i2c_data_8313 __devinitdata = {
+static const struct mpc_i2c_data mpc_i2c_data_8313 __devinitdata = {
 	.setup = mpc_i2c_setup_8xxx,
 };
 
-static struct mpc_i2c_data mpc_i2c_data_8543 __devinitdata = {
+static const struct mpc_i2c_data mpc_i2c_data_8543 __devinitdata = {
 	.setup = mpc_i2c_setup_8xxx,
 	.prescaler = 2,
 };
 
-static struct mpc_i2c_data mpc_i2c_data_8544 __devinitdata = {
+static const struct mpc_i2c_data mpc_i2c_data_8544 __devinitdata = {
 	.setup = mpc_i2c_setup_8xxx,
 	.prescaler = 3,
 };
diff --git a/drivers/macintosh/mediabay.c b/drivers/macintosh/mediabay.c
index 831d751..3f8d032 100644
--- a/drivers/macintosh/mediabay.c
+++ b/drivers/macintosh/mediabay.c
@@ -63,7 +63,7 @@ struct media_bay_info {
 	int				value_count;
 	int				timer;
 	struct macio_dev		*mdev;
-	struct mb_ops*			ops;
+	const struct mb_ops*		ops;
 	int				index;
 	int				cached_gpio;
 	int				sleeping;
@@ -669,7 +669,7 @@ static int media_bay_resume(struct macio_dev *mdev)
 
 /* Definitions of "ops" structures.
  */
-static struct mb_ops ohare_mb_ops = {
+static const struct mb_ops ohare_mb_ops = {
 	.name		= "Ohare",
 	.content	= ohare_mb_content,
 	.power		= ohare_mb_power,
@@ -678,7 +678,7 @@ static struct mb_ops ohare_mb_ops = {
 	.un_reset_ide	= ohare_mb_un_reset_ide,
 };
 
-static struct mb_ops heathrow_mb_ops = {
+static const struct mb_ops heathrow_mb_ops = {
 	.name		= "Heathrow",
 	.content	= heathrow_mb_content,
 	.power		= heathrow_mb_power,
@@ -687,7 +687,7 @@ static struct mb_ops heathrow_mb_ops = {
 	.un_reset_ide	= heathrow_mb_un_reset_ide,
 };
 
-static struct mb_ops keylargo_mb_ops = {
+static const struct mb_ops keylargo_mb_ops = {
 	.name		= "KeyLargo",
 	.init		= keylargo_mb_init,
 	.content	= keylargo_mb_content,
diff --git a/drivers/mfd/da9052-i2c.c b/drivers/mfd/da9052-i2c.c
index 82c9d64..352c58b 100644
--- a/drivers/mfd/da9052-i2c.c
+++ b/drivers/mfd/da9052-i2c.c
@@ -46,7 +46,7 @@ static int da9052_i2c_enable_multiwrite(struct da9052 *da9052)
 	return 0;
 }
 
-static struct i2c_device_id da9052_i2c_id[] = {
+static const struct i2c_device_id da9052_i2c_id[] = {
 	{"da9052", DA9052},
 	{"da9053-aa", DA9053_AA},
 	{"da9053-ba", DA9053_BA},
@@ -104,7 +104,7 @@ static int __devinit da9052_i2c_probe(struct i2c_client *client,
 		const struct of_device_id *deviceid;
 
 		deviceid = of_match_node(dialog_dt_ids, np);
-		id = (const struct i2c_device_id *)deviceid->data;
+		id = deviceid->data;
 	}
 #endif
 
diff --git a/drivers/net/can/mscan/mpc5xxx_can.c b/drivers/net/can/mscan/mpc5xxx_can.c
index 5caa572..8a8df82 100644
--- a/drivers/net/can/mscan/mpc5xxx_can.c
+++ b/drivers/net/can/mscan/mpc5xxx_can.c
@@ -251,7 +251,7 @@ static struct of_device_id mpc5xxx_can_table[];
 static int __devinit mpc5xxx_can_probe(struct platform_device *ofdev)
 {
 	const struct of_device_id *match;
-	struct mpc5xxx_can_data *data;
+	const struct mpc5xxx_can_data *data;
 	struct device_node *np = ofdev->dev.of_node;
 	struct net_device *dev;
 	struct mscan_priv *priv;
@@ -380,12 +380,12 @@ static int mpc5xxx_can_resume(struct platform_device *ofdev)
 }
 #endif
 
-static struct mpc5xxx_can_data __devinitdata mpc5200_can_data = {
+static const struct mpc5xxx_can_data __devinitdata mpc5200_can_data = {
 	.type = MSCAN_TYPE_MPC5200,
 	.get_clock = mpc52xx_can_get_clock,
 };
 
-static struct mpc5xxx_can_data __devinitdata mpc5121_can_data = {
+static const struct mpc5xxx_can_data __devinitdata mpc5121_can_data = {
 	.type = MSCAN_TYPE_MPC5121,
 	.get_clock = mpc512x_can_get_clock,
 };
diff --git a/drivers/scsi/qlogicpti.c b/drivers/scsi/qlogicpti.c
index b191dd5..53ed15b 100644
--- a/drivers/scsi/qlogicpti.c
+++ b/drivers/scsi/qlogicpti.c
@@ -1305,7 +1305,7 @@ static int __devinit qpti_sbus_probe(struct platform_device *op)
 	match = of_match_device(qpti_match, &op->dev);
 	if (!match)
 		return -EINVAL;
-	tpnt = match->data;
+	tpnt = (void *)match->data;
 
 	/* Sometimes Antares cards come up not completely
 	 * setup, and we get a report of a zero IRQ.
diff --git a/drivers/watchdog/mpc8xxx_wdt.c b/drivers/watchdog/mpc8xxx_wdt.c
index 40f7bf1..e6a038a 100644
--- a/drivers/watchdog/mpc8xxx_wdt.c
+++ b/drivers/watchdog/mpc8xxx_wdt.c
@@ -193,7 +193,7 @@ static int __devinit mpc8xxx_wdt_probe(struct platform_device *ofdev)
 	int ret;
 	const struct of_device_id *match;
 	struct device_node *np = ofdev->dev.of_node;
-	struct mpc8xxx_wdt_type *wdt_type;
+	const struct mpc8xxx_wdt_type *wdt_type;
 	u32 freq = fsl_get_sys_freq();
 	bool enabled;
 
