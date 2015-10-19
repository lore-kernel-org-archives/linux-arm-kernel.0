From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 19 Oct 2015 11:40:13 +0100
Subject: [PATCH] pinctrl: mvebu: armada-38x: add suspend/resume support
In-Reply-To: <CAPv3WKfxmwKaPA7BUffwsn8rweSShCSVaCyH4nrQcUkNk7uB2Q@mail.gmail.com>
References: <1445117328-31678-1-git-send-email-mw@semihalf.com>
 <20151017222927.GR32532@n2100.arm.linux.org.uk>
 <CAPv3WKed+Q3K0ky9b9AAYSymB-tE0O=57UdrgM+7Cx-X9PeVcA@mail.gmail.com>
 <20151018160123.6694b4be@free-electrons.com>
 <CAPv3WKdKea-85_0xUv218OVfhnfMvisYXh8qRNRjvmNkweSUJg@mail.gmail.com>
 <20151019092320.33d48dba@free-electrons.com>
 <CAPv3WKfxmwKaPA7BUffwsn8rweSShCSVaCyH4nrQcUkNk7uB2Q@mail.gmail.com>
Message-ID: <20151019104013.GX32532@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 19, 2015 at 11:25:49AM +0200, Marcin Wojtas wrote:
> Thomas,
> 
> 2015-10-19 9:23 GMT+02:00 Thomas Petazzoni
> <thomas.petazzoni@free-electrons.com>:
> > Hello,
> >
> > On Mon, 19 Oct 2015 08:04:49 +0200, Marcin Wojtas wrote:
> >
> >> > I don't like this. The mvebu_pinctrl_soc_info structure is meant to be
> >> > a read-only structure that only describes static information giving
> >> > SoC-specific details for pin-muxing. The idea is that in the event
> >> > where you had multiple pinctrl in the same system, you would still have
> >> > only one instance of mvebu_pinctrl_soc_info.
> >>
> >> Ok, understood. What with current static globals, like mpp_base? This
> >> is a problem when we consider hypothetical multi-pintrl system...
> >
> > The current driver is indeed not designed for multiple instances of the
> > same pinctrl controller. But that's exactly what Russell is asking for.
> >
> 
> In each mvebu pinctl there are <soc>_mpp_ctrl_get/set force usage of
> global mpp_base. In order not to use it this way the functions have to
> be redesigned. IMO having an acces to pdev would be sufficient (please
> see my proposal below), but yet I don't have a clear idea, how to do
> it,

I'm not sure having access to pdev would be sufficient -
struct mvebu_pinctrl is entirely private to pinctrl-mvebu.c, so you
wouldn't be able to dereference the driver data.

> > So it should be the other way around: the SoC-specific driver create a
> > structure, and this structure points back to the mvebu_pinctrl
> > structure.
> >
> 
> How about a following compromise:
> Instead of forcing pm_info, we can add a generic pointer to struct
> mvebu_pinctrl, e.g. void *priv; and enable passing it in a way I
> proposed before.
> 
> This way each SoC-specific driver can attach whatever is needed for
> its operation. For example in A38X/AXP it would be *base,
> *mpp_saved_regs and nregs gathered in one structure, but it wouldn't
> force anything specific for other machines. As a result in A38X/AXP in
> suspend/resume routines, there would be no globals in use at all.

The one thing I don't like about passing a 'void *' around is that it
will try to be re-used with __iomem pointers, and that'll cause sparse
to complain (quite rightfully - since sparse is designed to detect
direct dereferences of iomem pointers, and to do that it doesn't let
you trivially cast to/from an __iomem pointer to a normal pointer.
(not without using __force, which shouldn't be used in drivers.)

I wonder if there's a fairly nice solution to this:

Move away from mvebu_pinctrl_probe(), to
	void *mvebu_pinctrl_alloc(struct device *, size_t private_size);
	int mvebu_pinctrl_add(void *);

where mvebu_pinctrl_alloc() allocates and initialises the struct
mvebu_pinctrl, plus padding plus the private size.  The padding is
necessary to ensure that anything placed in the private area is
properly aligned (eg, 8-byte aligned.)  (This idea comes from netdev's
private data handling.)

These set the driver data to the private area, and return a pointer
to that private area.

Arrange for the get/set/whatever else functions to be passed this
same pointer.

What this means is that the individual drivers:

* get their private data wrapped up into the driver private data
* still don't need to know anything about mvebu_pinctrl
* can get at their private data using platform_get_drvdata()
* don't need any globals for anything

Something like this (by way of illustration):

 drivers/pinctrl/mvebu/pinctrl-armada-38x.c | 27 +++++++--
 drivers/pinctrl/mvebu/pinctrl-mvebu.c      | 97 ++++++++++++++++++++----------
 drivers/pinctrl/mvebu/pinctrl-mvebu.h      |  3 +
 3 files changed, 90 insertions(+), 37 deletions(-)

diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-38x.c b/drivers/pinctrl/mvebu/pinctrl-armada-38x.c
index 6ec82c62dff7..1dc76f6f6486 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-38x.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-38x.c
@@ -24,6 +24,10 @@
 
 static void __iomem *mpp_base;
 
+struct armada_38x_pinctrl_priv {
+	void __iomem *mpp_base;
+};
+
 static int armada_38x_mpp_ctrl_get(unsigned pid, unsigned long *config)
 {
 	return default_mpp_ctrl_get(mpp_base, pid, config);
@@ -421,6 +425,7 @@ static struct pinctrl_gpio_range armada_38x_mpp_gpio_ranges[] = {
 static int armada_38x_pinctrl_probe(struct platform_device *pdev)
 {
 	struct mvebu_pinctrl_soc_info *soc = &armada_38x_pinctrl_info;
+	struct armada_38x_pinctrl_priv *priv;
 	const struct of_device_id *match =
 		of_match_device(armada_38x_pinctrl_of_match, &pdev->dev);
 	struct resource *res;
@@ -428,10 +433,14 @@ static int armada_38x_pinctrl_probe(struct platform_device *pdev)
 	if (!match)
 		return -ENODEV;
 
+	priv = mvebu_pinctrl_alloc(pdev, sizeof(*priv));
+	if (!priv)
+		return -ENOMEM;
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	mpp_base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(mpp_base))
-		return PTR_ERR(mpp_base);
+	priv->mpp_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(priv->mpp_base))
+		return PTR_ERR(priv->mpp_base);
 
 	soc->variant = (unsigned) match->data & 0xff;
 	soc->controls = armada_38x_mpp_controls;
@@ -443,7 +452,10 @@ static int armada_38x_pinctrl_probe(struct platform_device *pdev)
 
 	pdev->dev.platform_data = soc;
 
-	return mvebu_pinctrl_probe(pdev);
+	/* until the set/get functions are converted */
+	mpp_base = priv->mpp_base;
+
+	return mvebu_pinctrl_add(priv);
 }
 
 static int armada_38x_pinctrl_remove(struct platform_device *pdev)
@@ -451,6 +463,13 @@ static int armada_38x_pinctrl_remove(struct platform_device *pdev)
 	return mvebu_pinctrl_remove(pdev);
 }
 
+static int armada_38x_pinctrl_suspend(struct platform_device *pdev)
+{
+	struct armada_38x_pinctrl_priv *priv = platform_get_drvdata(pdev);
+	...
+	return 0;
+}
+
 static struct platform_driver armada_38x_pinctrl_driver = {
 	.driver = {
 		.name = "armada-38x-pinctrl",
diff --git a/drivers/pinctrl/mvebu/pinctrl-mvebu.c b/drivers/pinctrl/mvebu/pinctrl-mvebu.c
index 77d2221d379d..e2f50fce2466 100644
--- a/drivers/pinctrl/mvebu/pinctrl-mvebu.c
+++ b/drivers/pinctrl/mvebu/pinctrl-mvebu.c
@@ -55,6 +55,9 @@ struct mvebu_pinctrl {
 	struct mvebu_pinctrl_function *functions;
 	unsigned num_functions;
 	u8 variant;
+
+	/* driver private data follows, must be last */
+	u64 private[0];
 };
 
 static struct mvebu_pinctrl_group *mvebu_pinctrl_find_group_by_pid(
@@ -470,8 +473,7 @@ static int _add_function(struct mvebu_pinctrl_function *funcs, int *funcsize,
 	return 0;
 }
 
-static int mvebu_pinctrl_build_functions(struct platform_device *pdev,
-					 struct mvebu_pinctrl *pctl)
+static int mvebu_pinctrl_build_functions(struct mvebu_pinctrl *pctl)
 {
 	struct mvebu_pinctrl_function *funcs;
 	int num = 0, funcsize = pctl->desc.npins;
@@ -479,7 +481,7 @@ static int mvebu_pinctrl_build_functions(struct platform_device *pdev,
 
 	/* we allocate functions for number of pins and hope
 	 * there are fewer unique functions than pins available */
-	funcs = devm_kzalloc(&pdev->dev, funcsize *
+	funcs = devm_kzalloc(pctl->dev, funcsize *
 			     sizeof(struct mvebu_pinctrl_function), GFP_KERNEL);
 	if (!funcs)
 		return -ENOMEM;
@@ -498,7 +500,7 @@ static int mvebu_pinctrl_build_functions(struct platform_device *pdev,
 			ret = _add_function(funcs, &funcsize,
 					    grp->settings[s].name);
 			if (ret == -EOVERFLOW)
-				dev_err(&pdev->dev,
+				dev_err(pctl->dev,
 					"More functions than pins(%d)\n",
 					pctl->desc.npins);
 			if (ret < 0)
@@ -527,7 +529,7 @@ static int mvebu_pinctrl_build_functions(struct platform_device *pdev,
 
 			/* allocate group name array if not done already */
 			if (!f->groups) {
-				f->groups = devm_kzalloc(&pdev->dev,
+				f->groups = devm_kzalloc(pctl->dev,
 						 f->num_groups * sizeof(char *),
 						 GFP_KERNEL);
 				if (!f->groups)
@@ -545,10 +547,39 @@ static int mvebu_pinctrl_build_functions(struct platform_device *pdev,
 	return 0;
 }
 
-int mvebu_pinctrl_probe(struct platform_device *pdev)
+static struct mvebu_pinctrl *private_to_pctl(void *private)
+{
+	return container_of(private, struct mvebu_pinctrl, private);
+}
+
+void *mvebu_pinctrl_alloc(struct platform_device *pdev, size_t private_size)
 {
-	struct mvebu_pinctrl_soc_info *soc = dev_get_platdata(&pdev->dev);
+	struct device *dev = &pdev->dev;
 	struct mvebu_pinctrl *pctl;
+
+	pctl = devm_kzalloc(dev, offsetof(struct mvebu_pinctrl, private) +
+			    private_size, GFP_KERNEL);
+	if (!pctl) {
+		dev_err(dev, "unable to alloc driver\n");
+		return NULL;
+	}
+
+	pctl->desc.name = dev_name(dev);
+	pctl->desc.owner = THIS_MODULE;
+	pctl->desc.pctlops = &mvebu_pinctrl_ops;
+	pctl->desc.pmxops = &mvebu_pinmux_ops;
+	pctl->desc.confops = &mvebu_pinconf_ops;
+	pctl->dev = dev;
+
+	platform_set_drvdata(pdev, pctl->private);
+
+	return pctl->private;
+}
+
+int mvebu_pinctrl_add(void *private)
+{
+	struct mvebu_pinctrl *pctl = private_to_pctl(private);
+	struct mvebu_pinctrl_soc_info *soc = dev_get_platdata(pctl->dev);
 	struct pinctrl_pin_desc *pdesc;
 	unsigned gid, n, k;
 	unsigned size, noname = 0;
@@ -557,25 +588,11 @@ int mvebu_pinctrl_probe(struct platform_device *pdev)
 	int ret;
 
 	if (!soc || !soc->controls || !soc->modes) {
-		dev_err(&pdev->dev, "wrong pinctrl soc info\n");
+		dev_err(pctl->dev, "wrong pinctrl soc info\n");
 		return -EINVAL;
 	}
 
-	pctl = devm_kzalloc(&pdev->dev, sizeof(struct mvebu_pinctrl),
-			GFP_KERNEL);
-	if (!pctl) {
-		dev_err(&pdev->dev, "unable to alloc driver\n");
-		return -ENOMEM;
-	}
-
-	pctl->desc.name = dev_name(&pdev->dev);
-	pctl->desc.owner = THIS_MODULE;
-	pctl->desc.pctlops = &mvebu_pinctrl_ops;
-	pctl->desc.pmxops = &mvebu_pinmux_ops;
-	pctl->desc.confops = &mvebu_pinconf_ops;
 	pctl->variant = soc->variant;
-	pctl->dev = &pdev->dev;
-	platform_set_drvdata(pdev, pctl);
 
 	/* count controls and create names for mvebu generic
 	   register controls; also does sanity checks */
@@ -602,10 +619,10 @@ int mvebu_pinctrl_probe(struct platform_device *pdev)
 		}
 	}
 
-	pdesc = devm_kzalloc(&pdev->dev, pctl->desc.npins *
+	pdesc = devm_kzalloc(pctl->dev, pctl->desc.npins *
 			     sizeof(struct pinctrl_pin_desc), GFP_KERNEL);
 	if (!pdesc) {
-		dev_err(&pdev->dev, "failed to alloc pinctrl pins\n");
+		dev_err(pctl->dev, "failed to alloc pinctrl pins\n");
 		return -ENOMEM;
 	}
 
@@ -617,9 +634,9 @@ int mvebu_pinctrl_probe(struct platform_device *pdev)
 	 * allocate groups and name buffers for unnamed groups.
 	 */
 	size = pctl->num_groups * sizeof(*pctl->groups) + noname * 8;
-	p = devm_kzalloc(&pdev->dev, size, GFP_KERNEL);
+	p = devm_kzalloc(pctl->dev, size, GFP_KERNEL);
 	if (!p) {
-		dev_err(&pdev->dev, "failed to alloc group data\n");
+		dev_err(pctl->dev, "failed to alloc group data\n");
 		return -ENOMEM;
 	}
 	pctl->groups = p;
@@ -668,7 +685,7 @@ int mvebu_pinctrl_probe(struct platform_device *pdev)
 		unsigned num_settings;
 
 		if (!grp) {
-			dev_warn(&pdev->dev, "unknown pinctrl group %d\n",
+			dev_warn(pctl->dev, "unknown pinctrl group %d\n",
 				mode->pid);
 			continue;
 		}
@@ -699,19 +716,19 @@ int mvebu_pinctrl_probe(struct platform_device *pdev)
 		grp->num_settings = num_settings;
 	}
 
-	ret = mvebu_pinctrl_build_functions(pdev, pctl);
+	ret = mvebu_pinctrl_build_functions(pctl);
 	if (ret) {
-		dev_err(&pdev->dev, "unable to build functions\n");
+		dev_err(pctl->dev, "unable to build functions\n");
 		return ret;
 	}
 
-	pctl->pctldev = pinctrl_register(&pctl->desc, &pdev->dev, pctl);
+	pctl->pctldev = pinctrl_register(&pctl->desc, pctl->dev, pctl);
 	if (IS_ERR(pctl->pctldev)) {
-		dev_err(&pdev->dev, "unable to register pinctrl driver\n");
+		dev_err(pctl->dev, "unable to register pinctrl driver\n");
 		return PTR_ERR(pctl->pctldev);
 	}
 
-	dev_info(&pdev->dev, "registered pinctrl driver\n");
+	dev_info(pctl->dev, "registered pinctrl driver\n");
 
 	/* register gpio ranges */
 	for (n = 0; n < soc->ngpioranges; n++)
@@ -720,9 +737,23 @@ int mvebu_pinctrl_probe(struct platform_device *pdev)
 	return 0;
 }
 
+int mvebu_pinctrl_probe(struct platform_device *pdev)
+{
+	void *private;
+
+	private = mvebu_pinctrl_alloc(pdev, 0);
+	if (!private) {
+		dev_err(&pdev->dev, "unable to alloc driver\n");
+		return -ENOMEM;
+	}
+
+	return mvebu_pinctrl_add(private);
+}
+
 int mvebu_pinctrl_remove(struct platform_device *pdev)
 {
-	struct mvebu_pinctrl *pctl = platform_get_drvdata(pdev);
+	void *private = platform_get_drvdata(pdev);
+	struct mvebu_pinctrl *pctl = private_to_pctl(private);
 	pinctrl_unregister(pctl->pctldev);
 	return 0;
 }
diff --git a/drivers/pinctrl/mvebu/pinctrl-mvebu.h b/drivers/pinctrl/mvebu/pinctrl-mvebu.h
index 65a98e6f7265..aad87f9aad13 100644
--- a/drivers/pinctrl/mvebu/pinctrl-mvebu.h
+++ b/drivers/pinctrl/mvebu/pinctrl-mvebu.h
@@ -204,4 +204,7 @@ static inline int default_mpp_ctrl_set(void __iomem *base, unsigned int pid,
 int mvebu_pinctrl_probe(struct platform_device *pdev);
 int mvebu_pinctrl_remove(struct platform_device *pdev);
 
+void *mvebu_pinctrl_alloc(struct platform_device *pdev, size_t private_size);
+int mvebu_pinctrl_add(void *private);
+
 #endif

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
