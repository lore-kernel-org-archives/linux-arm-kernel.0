From: benoit.thebaudeau@advansee.com (=?utf-8?Q?Beno=C3=AEt_Th=C3=A9baudeau?=)
Date: Fri, 22 Jun 2012 21:04:06 +0200 (CEST)
Subject: [PATCH] gpio/mxc: use the edge_sel feature if available
In-Reply-To: <Pine.LNX.4.64.1206221540390.17552@axis700.grange>
Message-ID: <1463885754.3196304.1340391846559.JavaMail.root@advansee.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guennadi,

On Fri, Jun 22, 2012 at 03:46:25PM +0200, Guennadi Liakhovetski wrote:
> Sorry for a delay,

No problem. Since you're talking about that, I'm wondering what the usual answer
delays are on Linux mailing lists. I've posted my first official Linux patches
last week. Some have been almost instantly applied. Others had answers that I
took into account, then nothing. Others had no answer at all (especially on
linux-media and rtc-linux). I'm not sure what to expect, if I should post to
other mailing lists, do something or simply wait.

> just a minor nit-pick below:
> On Wed, 20 Jun 2012, Beno?t Th?baudeau wrote:
> > @@ -74,13 +77,14 @@ static struct mxc_gpio_hwdata
> > imx1_imx21_gpio_hwdata = {
> >  	.icr2_reg	= 0x2c,
> >  	.imr_reg	= 0x30,
> >  	.isr_reg	= 0x34,
> > +	.edge_sel_reg	= -1,
> 
> Maybe better use a meaningful error code like -EINVAL?
> 
> [snip]
> 
> > @@ -338,10 +365,15 @@ static void __devinit mxc_gpio_get_hw(struct
> > platform_device *pdev)
> >  		return;
> >  	}
> >  
> > -	if (hwtype == IMX31_GPIO)
> > -		mxc_gpio_hwdata = &imx31_gpio_hwdata;
> > -	else
> > +	switch (hwtype) {
> > +	case IMX31_GPIO:
> > +		imx31_imx35_gpio_hwdata.edge_sel_reg = -1;
> 
> ditto

Here you are.

Regards,
Beno?t


[PATCH] gpio/mxc: use the edge_sel feature if available

Some mxc processors have an edge_sel feature, which allows the IRQ to be
triggered by any edge.

This patch makes use of this feature if available, which skips mxc_flip_edge().

Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Linus Walleij <linus.walleij@stericsson.com>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: <linux-arm-kernel@lists.infradead.org>
Signed-off-by: Beno?t Th?baudeau <benoit.thebaudeau@advansee.com>
---
 .../devicetree/bindings/gpio/fsl-imx-gpio.txt      |    2 +-
 .../arch/arm/boot/dts/imx51.dtsi                   |    8 +--
 .../arch/arm/boot/dts/imx53.dtsi                   |   14 ++--
 .../arch/arm/boot/dts/imx6q.dtsi                   |   14 ++--
 .../arch/arm/mach-imx/mm-imx25.c                   |   10 +--
 .../arch/arm/mach-imx/mm-imx3.c                    |    7 +-
 .../arch/arm/mach-imx/mm-imx5.c                    |   40 +++++------
 .../drivers/gpio/gpio-mxc.c                        |   71 ++++++++++++++++----
 8 files changed, 104 insertions(+), 62 deletions(-)

diff --git linux-next-HEAD-072e7c8.orig/Documentation/devicetree/bindings/gpio/fsl-imx-gpio.txt linux-next-HEAD-072e7c8/Documentation/devicetree/bindings/gpio/fsl-imx-gpio.txt
index 4363ae4..33a0345 100644
--- linux-next-HEAD-072e7c8.orig/Documentation/devicetree/bindings/gpio/fsl-imx-gpio.txt
+++ linux-next-HEAD-072e7c8/Documentation/devicetree/bindings/gpio/fsl-imx-gpio.txt
@@ -14,7 +14,7 @@ Required properties:
 Example:
 
 gpio0: gpio at 73f84000 {
-	compatible = "fsl,imx51-gpio", "fsl,imx31-gpio";
+	compatible = "fsl,imx51-gpio", "fsl,imx35-gpio";
 	reg = <0x73f84000 0x4000>;
 	interrupts = <50 51>;
 	gpio-controller;
diff --git linux-next-HEAD-072e7c8.orig/arch/arm/boot/dts/imx51.dtsi linux-next-HEAD-072e7c8/arch/arm/boot/dts/imx51.dtsi
index 39eb88e..5236e42 100644
--- linux-next-HEAD-072e7c8.orig/arch/arm/boot/dts/imx51.dtsi
+++ linux-next-HEAD-072e7c8/arch/arm/boot/dts/imx51.dtsi
@@ -127,7 +127,7 @@
 			};
 
 			gpio1: gpio at 73f84000 {
-				compatible = "fsl,imx51-gpio", "fsl,imx31-gpio";
+				compatible = "fsl,imx51-gpio", "fsl,imx35-gpio";
 				reg = <0x73f84000 0x4000>;
 				interrupts = <50 51>;
 				gpio-controller;
@@ -137,7 +137,7 @@
 			};
 
 			gpio2: gpio at 73f88000 {
-				compatible = "fsl,imx51-gpio", "fsl,imx31-gpio";
+				compatible = "fsl,imx51-gpio", "fsl,imx35-gpio";
 				reg = <0x73f88000 0x4000>;
 				interrupts = <52 53>;
 				gpio-controller;
@@ -147,7 +147,7 @@
 			};
 
 			gpio3: gpio at 73f8c000 {
-				compatible = "fsl,imx51-gpio", "fsl,imx31-gpio";
+				compatible = "fsl,imx51-gpio", "fsl,imx35-gpio";
 				reg = <0x73f8c000 0x4000>;
 				interrupts = <54 55>;
 				gpio-controller;
@@ -157,7 +157,7 @@
 			};
 
 			gpio4: gpio at 73f90000 {
-				compatible = "fsl,imx51-gpio", "fsl,imx31-gpio";
+				compatible = "fsl,imx51-gpio", "fsl,imx35-gpio";
 				reg = <0x73f90000 0x4000>;
 				interrupts = <56 57>;
 				gpio-controller;
diff --git linux-next-HEAD-072e7c8.orig/arch/arm/boot/dts/imx53.dtsi linux-next-HEAD-072e7c8/arch/arm/boot/dts/imx53.dtsi
index 2b5caf9..39ea1a5 100644
--- linux-next-HEAD-072e7c8.orig/arch/arm/boot/dts/imx53.dtsi
+++ linux-next-HEAD-072e7c8/arch/arm/boot/dts/imx53.dtsi
@@ -129,7 +129,7 @@
 			};
 
 			gpio1: gpio at 53f84000 {
-				compatible = "fsl,imx53-gpio", "fsl,imx31-gpio";
+				compatible = "fsl,imx53-gpio", "fsl,imx35-gpio";
 				reg = <0x53f84000 0x4000>;
 				interrupts = <50 51>;
 				gpio-controller;
@@ -139,7 +139,7 @@
 			};
 
 			gpio2: gpio at 53f88000 {
-				compatible = "fsl,imx53-gpio", "fsl,imx31-gpio";
+				compatible = "fsl,imx53-gpio", "fsl,imx35-gpio";
 				reg = <0x53f88000 0x4000>;
 				interrupts = <52 53>;
 				gpio-controller;
@@ -149,7 +149,7 @@
 			};
 
 			gpio3: gpio at 53f8c000 {
-				compatible = "fsl,imx53-gpio", "fsl,imx31-gpio";
+				compatible = "fsl,imx53-gpio", "fsl,imx35-gpio";
 				reg = <0x53f8c000 0x4000>;
 				interrupts = <54 55>;
 				gpio-controller;
@@ -159,7 +159,7 @@
 			};
 
 			gpio4: gpio at 53f90000 {
-				compatible = "fsl,imx53-gpio", "fsl,imx31-gpio";
+				compatible = "fsl,imx53-gpio", "fsl,imx35-gpio";
 				reg = <0x53f90000 0x4000>;
 				interrupts = <56 57>;
 				gpio-controller;
@@ -197,7 +197,7 @@
 			};
 
 			gpio5: gpio at 53fdc000 {
-				compatible = "fsl,imx53-gpio", "fsl,imx31-gpio";
+				compatible = "fsl,imx53-gpio", "fsl,imx35-gpio";
 				reg = <0x53fdc000 0x4000>;
 				interrupts = <103 104>;
 				gpio-controller;
@@ -207,7 +207,7 @@
 			};
 
 			gpio6: gpio at 53fe0000 {
-				compatible = "fsl,imx53-gpio", "fsl,imx31-gpio";
+				compatible = "fsl,imx53-gpio", "fsl,imx35-gpio";
 				reg = <0x53fe0000 0x4000>;
 				interrupts = <105 106>;
 				gpio-controller;
@@ -217,7 +217,7 @@
 			};
 
 			gpio7: gpio at 53fe4000 {
-				compatible = "fsl,imx53-gpio", "fsl,imx31-gpio";
+				compatible = "fsl,imx53-gpio", "fsl,imx35-gpio";
 				reg = <0x53fe4000 0x4000>;
 				interrupts = <107 108>;
 				gpio-controller;
diff --git linux-next-HEAD-072e7c8.orig/arch/arm/boot/dts/imx6q.dtsi linux-next-HEAD-072e7c8/arch/arm/boot/dts/imx6q.dtsi
index 8c90cba..da78fd8 100644
--- linux-next-HEAD-072e7c8.orig/arch/arm/boot/dts/imx6q.dtsi
+++ linux-next-HEAD-072e7c8/arch/arm/boot/dts/imx6q.dtsi
@@ -260,7 +260,7 @@
 			};
 
 			gpio1: gpio at 0209c000 {
-				compatible = "fsl,imx6q-gpio", "fsl,imx31-gpio";
+				compatible = "fsl,imx6q-gpio", "fsl,imx35-gpio";
 				reg = <0x0209c000 0x4000>;
 				interrupts = <0 66 0x04 0 67 0x04>;
 				gpio-controller;
@@ -270,7 +270,7 @@
 			};
 
 			gpio2: gpio at 020a0000 {
-				compatible = "fsl,imx6q-gpio", "fsl,imx31-gpio";
+				compatible = "fsl,imx6q-gpio", "fsl,imx35-gpio";
 				reg = <0x020a0000 0x4000>;
 				interrupts = <0 68 0x04 0 69 0x04>;
 				gpio-controller;
@@ -280,7 +280,7 @@
 			};
 
 			gpio3: gpio at 020a4000 {
-				compatible = "fsl,imx6q-gpio", "fsl,imx31-gpio";
+				compatible = "fsl,imx6q-gpio", "fsl,imx35-gpio";
 				reg = <0x020a4000 0x4000>;
 				interrupts = <0 70 0x04 0 71 0x04>;
 				gpio-controller;
@@ -290,7 +290,7 @@
 			};
 
 			gpio4: gpio at 020a8000 {
-				compatible = "fsl,imx6q-gpio", "fsl,imx31-gpio";
+				compatible = "fsl,imx6q-gpio", "fsl,imx35-gpio";
 				reg = <0x020a8000 0x4000>;
 				interrupts = <0 72 0x04 0 73 0x04>;
 				gpio-controller;
@@ -300,7 +300,7 @@
 			};
 
 			gpio5: gpio at 020ac000 {
-				compatible = "fsl,imx6q-gpio", "fsl,imx31-gpio";
+				compatible = "fsl,imx6q-gpio", "fsl,imx35-gpio";
 				reg = <0x020ac000 0x4000>;
 				interrupts = <0 74 0x04 0 75 0x04>;
 				gpio-controller;
@@ -310,7 +310,7 @@
 			};
 
 			gpio6: gpio at 020b0000 {
-				compatible = "fsl,imx6q-gpio", "fsl,imx31-gpio";
+				compatible = "fsl,imx6q-gpio", "fsl,imx35-gpio";
 				reg = <0x020b0000 0x4000>;
 				interrupts = <0 76 0x04 0 77 0x04>;
 				gpio-controller;
@@ -320,7 +320,7 @@
 			};
 
 			gpio7: gpio at 020b4000 {
-				compatible = "fsl,imx6q-gpio", "fsl,imx31-gpio";
+				compatible = "fsl,imx6q-gpio", "fsl,imx35-gpio";
 				reg = <0x020b4000 0x4000>;
 				interrupts = <0 78 0x04 0 79 0x04>;
 				gpio-controller;
diff --git linux-next-HEAD-072e7c8.orig/arch/arm/mach-imx/mm-imx25.c linux-next-HEAD-072e7c8/arch/arm/mach-imx/mm-imx25.c
index 6ff3714..8e8ddb8 100644
--- linux-next-HEAD-072e7c8.orig/arch/arm/mach-imx/mm-imx25.c
+++ linux-next-HEAD-072e7c8/arch/arm/mach-imx/mm-imx25.c
@@ -90,11 +90,11 @@ static const struct resource imx25_audmux_res[] __initconst = {
 
 void __init imx25_soc_init(void)
 {
-	/* i.mx25 has the i.mx31 type gpio */
-	mxc_register_gpio("imx31-gpio", 0, MX25_GPIO1_BASE_ADDR, SZ_16K, MX25_INT_GPIO1, 0);
-	mxc_register_gpio("imx31-gpio", 1, MX25_GPIO2_BASE_ADDR, SZ_16K, MX25_INT_GPIO2, 0);
-	mxc_register_gpio("imx31-gpio", 2, MX25_GPIO3_BASE_ADDR, SZ_16K, MX25_INT_GPIO3, 0);
-	mxc_register_gpio("imx31-gpio", 3, MX25_GPIO4_BASE_ADDR, SZ_16K, MX25_INT_GPIO4, 0);
+	/* i.mx25 has the i.mx35 type gpio */
+	mxc_register_gpio("imx35-gpio", 0, MX25_GPIO1_BASE_ADDR, SZ_16K, MX25_INT_GPIO1, 0);
+	mxc_register_gpio("imx35-gpio", 1, MX25_GPIO2_BASE_ADDR, SZ_16K, MX25_INT_GPIO2, 0);
+	mxc_register_gpio("imx35-gpio", 2, MX25_GPIO3_BASE_ADDR, SZ_16K, MX25_INT_GPIO3, 0);
+	mxc_register_gpio("imx35-gpio", 3, MX25_GPIO4_BASE_ADDR, SZ_16K, MX25_INT_GPIO4, 0);
 
 	pinctrl_provide_dummies();
 	/* i.mx25 has the i.mx35 type sdma */
diff --git linux-next-HEAD-072e7c8.orig/arch/arm/mach-imx/mm-imx3.c linux-next-HEAD-072e7c8/arch/arm/mach-imx/mm-imx3.c
index a8983b9..8e51e77 100644
--- linux-next-HEAD-072e7c8.orig/arch/arm/mach-imx/mm-imx3.c
+++ linux-next-HEAD-072e7c8/arch/arm/mach-imx/mm-imx3.c
@@ -273,10 +273,9 @@ void __init imx35_soc_init(void)
 
 	imx3_init_l2x0();
 
-	/* i.mx35 has the i.mx31 type gpio */
-	mxc_register_gpio("imx31-gpio", 0, MX35_GPIO1_BASE_ADDR, SZ_16K, MX35_INT_GPIO1, 0);
-	mxc_register_gpio("imx31-gpio", 1, MX35_GPIO2_BASE_ADDR, SZ_16K, MX35_INT_GPIO2, 0);
-	mxc_register_gpio("imx31-gpio", 2, MX35_GPIO3_BASE_ADDR, SZ_16K, MX35_INT_GPIO3, 0);
+	mxc_register_gpio("imx35-gpio", 0, MX35_GPIO1_BASE_ADDR, SZ_16K, MX35_INT_GPIO1, 0);
+	mxc_register_gpio("imx35-gpio", 1, MX35_GPIO2_BASE_ADDR, SZ_16K, MX35_INT_GPIO2, 0);
+	mxc_register_gpio("imx35-gpio", 2, MX35_GPIO3_BASE_ADDR, SZ_16K, MX35_INT_GPIO3, 0);
 
 	pinctrl_provide_dummies();
 	if (to_version == 1) {
diff --git linux-next-HEAD-072e7c8.orig/arch/arm/mach-imx/mm-imx5.c linux-next-HEAD-072e7c8/arch/arm/mach-imx/mm-imx5.c
index 1d00305..d70d16c 100644
--- linux-next-HEAD-072e7c8.orig/arch/arm/mach-imx/mm-imx5.c
+++ linux-next-HEAD-072e7c8/arch/arm/mach-imx/mm-imx5.c
@@ -181,13 +181,13 @@ static const struct resource imx53_audmux_res[] __initconst = {
 
 void __init imx50_soc_init(void)
 {
-	/* i.mx50 has the i.mx31 type gpio */
-	mxc_register_gpio("imx31-gpio", 0, MX50_GPIO1_BASE_ADDR, SZ_16K, MX50_INT_GPIO1_LOW, MX50_INT_GPIO1_HIGH);
-	mxc_register_gpio("imx31-gpio", 1, MX50_GPIO2_BASE_ADDR, SZ_16K, MX50_INT_GPIO2_LOW, MX50_INT_GPIO2_HIGH);
-	mxc_register_gpio("imx31-gpio", 2, MX50_GPIO3_BASE_ADDR, SZ_16K, MX50_INT_GPIO3_LOW, MX50_INT_GPIO3_HIGH);
-	mxc_register_gpio("imx31-gpio", 3, MX50_GPIO4_BASE_ADDR, SZ_16K, MX50_INT_GPIO4_LOW, MX50_INT_GPIO4_HIGH);
-	mxc_register_gpio("imx31-gpio", 4, MX50_GPIO5_BASE_ADDR, SZ_16K, MX50_INT_GPIO5_LOW, MX50_INT_GPIO5_HIGH);
-	mxc_register_gpio("imx31-gpio", 5, MX50_GPIO6_BASE_ADDR, SZ_16K, MX50_INT_GPIO6_LOW, MX50_INT_GPIO6_HIGH);
+	/* i.mx50 has the i.mx35 type gpio */
+	mxc_register_gpio("imx35-gpio", 0, MX50_GPIO1_BASE_ADDR, SZ_16K, MX50_INT_GPIO1_LOW, MX50_INT_GPIO1_HIGH);
+	mxc_register_gpio("imx35-gpio", 1, MX50_GPIO2_BASE_ADDR, SZ_16K, MX50_INT_GPIO2_LOW, MX50_INT_GPIO2_HIGH);
+	mxc_register_gpio("imx35-gpio", 2, MX50_GPIO3_BASE_ADDR, SZ_16K, MX50_INT_GPIO3_LOW, MX50_INT_GPIO3_HIGH);
+	mxc_register_gpio("imx35-gpio", 3, MX50_GPIO4_BASE_ADDR, SZ_16K, MX50_INT_GPIO4_LOW, MX50_INT_GPIO4_HIGH);
+	mxc_register_gpio("imx35-gpio", 4, MX50_GPIO5_BASE_ADDR, SZ_16K, MX50_INT_GPIO5_LOW, MX50_INT_GPIO5_HIGH);
+	mxc_register_gpio("imx35-gpio", 5, MX50_GPIO6_BASE_ADDR, SZ_16K, MX50_INT_GPIO6_LOW, MX50_INT_GPIO6_HIGH);
 
 	/* i.mx50 has the i.mx31 type audmux */
 	platform_device_register_simple("imx31-audmux", 0, imx50_audmux_res,
@@ -196,11 +196,11 @@ void __init imx50_soc_init(void)
 
 void __init imx51_soc_init(void)
 {
-	/* i.mx51 has the i.mx31 type gpio */
-	mxc_register_gpio("imx31-gpio", 0, MX51_GPIO1_BASE_ADDR, SZ_16K, MX51_INT_GPIO1_LOW, MX51_INT_GPIO1_HIGH);
-	mxc_register_gpio("imx31-gpio", 1, MX51_GPIO2_BASE_ADDR, SZ_16K, MX51_INT_GPIO2_LOW, MX51_INT_GPIO2_HIGH);
-	mxc_register_gpio("imx31-gpio", 2, MX51_GPIO3_BASE_ADDR, SZ_16K, MX51_INT_GPIO3_LOW, MX51_INT_GPIO3_HIGH);
-	mxc_register_gpio("imx31-gpio", 3, MX51_GPIO4_BASE_ADDR, SZ_16K, MX51_INT_GPIO4_LOW, MX51_INT_GPIO4_HIGH);
+	/* i.mx51 has the i.mx35 type gpio */
+	mxc_register_gpio("imx35-gpio", 0, MX51_GPIO1_BASE_ADDR, SZ_16K, MX51_INT_GPIO1_LOW, MX51_INT_GPIO1_HIGH);
+	mxc_register_gpio("imx35-gpio", 1, MX51_GPIO2_BASE_ADDR, SZ_16K, MX51_INT_GPIO2_LOW, MX51_INT_GPIO2_HIGH);
+	mxc_register_gpio("imx35-gpio", 2, MX51_GPIO3_BASE_ADDR, SZ_16K, MX51_INT_GPIO3_LOW, MX51_INT_GPIO3_HIGH);
+	mxc_register_gpio("imx35-gpio", 3, MX51_GPIO4_BASE_ADDR, SZ_16K, MX51_INT_GPIO4_LOW, MX51_INT_GPIO4_HIGH);
 
 	pinctrl_provide_dummies();
 
@@ -218,14 +218,14 @@ void __init imx51_soc_init(void)
 
 void __init imx53_soc_init(void)
 {
-	/* i.mx53 has the i.mx31 type gpio */
-	mxc_register_gpio("imx31-gpio", 0, MX53_GPIO1_BASE_ADDR, SZ_16K, MX53_INT_GPIO1_LOW, MX53_INT_GPIO1_HIGH);
-	mxc_register_gpio("imx31-gpio", 1, MX53_GPIO2_BASE_ADDR, SZ_16K, MX53_INT_GPIO2_LOW, MX53_INT_GPIO2_HIGH);
-	mxc_register_gpio("imx31-gpio", 2, MX53_GPIO3_BASE_ADDR, SZ_16K, MX53_INT_GPIO3_LOW, MX53_INT_GPIO3_HIGH);
-	mxc_register_gpio("imx31-gpio", 3, MX53_GPIO4_BASE_ADDR, SZ_16K, MX53_INT_GPIO4_LOW, MX53_INT_GPIO4_HIGH);
-	mxc_register_gpio("imx31-gpio", 4, MX53_GPIO5_BASE_ADDR, SZ_16K, MX53_INT_GPIO5_LOW, MX53_INT_GPIO5_HIGH);
-	mxc_register_gpio("imx31-gpio", 5, MX53_GPIO6_BASE_ADDR, SZ_16K, MX53_INT_GPIO6_LOW, MX53_INT_GPIO6_HIGH);
-	mxc_register_gpio("imx31-gpio", 6, MX53_GPIO7_BASE_ADDR, SZ_16K, MX53_INT_GPIO7_LOW, MX53_INT_GPIO7_HIGH);
+	/* i.mx53 has the i.mx35 type gpio */
+	mxc_register_gpio("imx35-gpio", 0, MX53_GPIO1_BASE_ADDR, SZ_16K, MX53_INT_GPIO1_LOW, MX53_INT_GPIO1_HIGH);
+	mxc_register_gpio("imx35-gpio", 1, MX53_GPIO2_BASE_ADDR, SZ_16K, MX53_INT_GPIO2_LOW, MX53_INT_GPIO2_HIGH);
+	mxc_register_gpio("imx35-gpio", 2, MX53_GPIO3_BASE_ADDR, SZ_16K, MX53_INT_GPIO3_LOW, MX53_INT_GPIO3_HIGH);
+	mxc_register_gpio("imx35-gpio", 3, MX53_GPIO4_BASE_ADDR, SZ_16K, MX53_INT_GPIO4_LOW, MX53_INT_GPIO4_HIGH);
+	mxc_register_gpio("imx35-gpio", 4, MX53_GPIO5_BASE_ADDR, SZ_16K, MX53_INT_GPIO5_LOW, MX53_INT_GPIO5_HIGH);
+	mxc_register_gpio("imx35-gpio", 5, MX53_GPIO6_BASE_ADDR, SZ_16K, MX53_INT_GPIO6_LOW, MX53_INT_GPIO6_HIGH);
+	mxc_register_gpio("imx35-gpio", 6, MX53_GPIO7_BASE_ADDR, SZ_16K, MX53_INT_GPIO7_LOW, MX53_INT_GPIO7_HIGH);
 
 	pinctrl_provide_dummies();
 	/* i.mx53 has the i.mx35 type sdma */
diff --git linux-next-HEAD-072e7c8.orig/drivers/gpio/gpio-mxc.c linux-next-HEAD-072e7c8/drivers/gpio/gpio-mxc.c
index c337143..bb985e8 100644
--- linux-next-HEAD-072e7c8.orig/drivers/gpio/gpio-mxc.c
+++ linux-next-HEAD-072e7c8/drivers/gpio/gpio-mxc.c
@@ -38,7 +38,8 @@
 enum mxc_gpio_hwtype {
 	IMX1_GPIO,	/* runs on i.mx1 */
 	IMX21_GPIO,	/* runs on i.mx21 and i.mx27 */
-	IMX31_GPIO,	/* runs on all other i.mx */
+	IMX31_GPIO,	/* runs on i.mx31 */
+	IMX35_GPIO,	/* runs on all other i.mx */
 };
 
 /* device type dependent stuff */
@@ -50,6 +51,7 @@ struct mxc_gpio_hwdata {
 	unsigned icr2_reg;
 	unsigned imr_reg;
 	unsigned isr_reg;
+	int edge_sel_reg;
 	unsigned low_level;
 	unsigned high_level;
 	unsigned rise_edge;
@@ -74,6 +76,7 @@ static struct mxc_gpio_hwdata imx1_imx21_gpio_hwdata = {
 	.icr2_reg	= 0x2c,
 	.imr_reg	= 0x30,
 	.isr_reg	= 0x34,
+	.edge_sel_reg	= -EINVAL,
 	.low_level	= 0x03,
 	.high_level	= 0x02,
 	.rise_edge	= 0x00,
@@ -88,6 +91,22 @@ static struct mxc_gpio_hwdata imx31_gpio_hwdata = {
 	.icr2_reg	= 0x10,
 	.imr_reg	= 0x14,
 	.isr_reg	= 0x18,
+	.edge_sel_reg	= -EINVAL,
+	.low_level	= 0x00,
+	.high_level	= 0x01,
+	.rise_edge	= 0x02,
+	.fall_edge	= 0x03,
+};
+
+static struct mxc_gpio_hwdata imx35_gpio_hwdata = {
+	.dr_reg		= 0x00,
+	.gdir_reg	= 0x04,
+	.psr_reg	= 0x08,
+	.icr1_reg	= 0x0c,
+	.icr2_reg	= 0x10,
+	.imr_reg	= 0x14,
+	.isr_reg	= 0x18,
+	.edge_sel_reg	= 0x1c,
 	.low_level	= 0x00,
 	.high_level	= 0x01,
 	.rise_edge	= 0x02,
@@ -104,12 +123,13 @@ static struct mxc_gpio_hwdata *mxc_gpio_hwdata;
 #define GPIO_ICR2		(mxc_gpio_hwdata->icr2_reg)
 #define GPIO_IMR		(mxc_gpio_hwdata->imr_reg)
 #define GPIO_ISR		(mxc_gpio_hwdata->isr_reg)
+#define GPIO_EDGE_SEL		(mxc_gpio_hwdata->edge_sel_reg)
 
 #define GPIO_INT_LOW_LEV	(mxc_gpio_hwdata->low_level)
 #define GPIO_INT_HIGH_LEV	(mxc_gpio_hwdata->high_level)
 #define GPIO_INT_RISE_EDGE	(mxc_gpio_hwdata->rise_edge)
 #define GPIO_INT_FALL_EDGE	(mxc_gpio_hwdata->fall_edge)
-#define GPIO_INT_NONE		0x4
+#define GPIO_INT_BOTH_EDGES	0x4
 
 static struct platform_device_id mxc_gpio_devtype[] = {
 	{
@@ -122,6 +142,9 @@ static struct platform_device_id mxc_gpio_devtype[] = {
 		.name = "imx31-gpio",
 		.driver_data = IMX31_GPIO,
 	}, {
+		.name = "imx35-gpio",
+		.driver_data = IMX35_GPIO,
+	}, {
 		/* sentinel */
 	}
 };
@@ -130,6 +153,7 @@ static const struct of_device_id mxc_gpio_dt_ids[] = {
 	{ .compatible = "fsl,imx1-gpio", .data = &mxc_gpio_devtype[IMX1_GPIO], },
 	{ .compatible = "fsl,imx21-gpio", .data = &mxc_gpio_devtype[IMX21_GPIO], },
 	{ .compatible = "fsl,imx31-gpio", .data = &mxc_gpio_devtype[IMX31_GPIO], },
+	{ .compatible = "fsl,imx35-gpio", .data = &mxc_gpio_devtype[IMX35_GPIO], },
 	{ /* sentinel */ }
 };
 
@@ -160,15 +184,19 @@ static int gpio_set_irq_type(struct irq_data *d, u32 type)
 		edge = GPIO_INT_FALL_EDGE;
 		break;
 	case IRQ_TYPE_EDGE_BOTH:
-		val = gpio_get_value(gpio);
-		if (val) {
-			edge = GPIO_INT_LOW_LEV;
-			pr_debug("mxc: set GPIO %d to low trigger\n", gpio);
+		if (GPIO_EDGE_SEL >= 0) {
+			edge = GPIO_INT_BOTH_EDGES;
 		} else {
-			edge = GPIO_INT_HIGH_LEV;
-			pr_debug("mxc: set GPIO %d to high trigger\n", gpio);
+			val = gpio_get_value(gpio);
+			if (val) {
+				edge = GPIO_INT_LOW_LEV;
+				pr_debug("mxc: set GPIO %d to low trigger\n", gpio);
+			} else {
+				edge = GPIO_INT_HIGH_LEV;
+				pr_debug("mxc: set GPIO %d to high trigger\n", gpio);
+			}
+			port->both_edges |= 1 << (gpio & 31);
 		}
-		port->both_edges |= 1 << (gpio & 31);
 		break;
 	case IRQ_TYPE_LEVEL_LOW:
 		edge = GPIO_INT_LOW_LEV;
@@ -180,10 +208,23 @@ static int gpio_set_irq_type(struct irq_data *d, u32 type)
 		return -EINVAL;
 	}
 
-	reg += GPIO_ICR1 + ((gpio & 0x10) >> 2); /* lower or upper register */
-	bit = gpio & 0xf;
-	val = readl(reg) & ~(0x3 << (bit << 1));
-	writel(val | (edge << (bit << 1)), reg);
+	if (GPIO_EDGE_SEL >= 0) {
+		val = readl(port->base + GPIO_EDGE_SEL);
+		if (edge == GPIO_INT_BOTH_EDGES)
+			writel(val | (1 << (gpio & 0x1f)),
+				port->base + GPIO_EDGE_SEL);
+		else
+			writel(val & ~(1 << (gpio & 0x1f)),
+				port->base + GPIO_EDGE_SEL);
+	}
+
+	if (edge != GPIO_INT_BOTH_EDGES) {
+		reg += GPIO_ICR1 + ((gpio & 0x10) >> 2); /* lower or upper register */
+		bit = gpio & 0xf;
+		val = readl(reg) & ~(0x3 << (bit << 1));
+		writel(val | (edge << (bit << 1)), reg);
+	}
+
 	writel(1 << (gpio & 0x1f), port->base + GPIO_ISR);
 
 	return 0;
@@ -338,7 +379,9 @@ static void __devinit mxc_gpio_get_hw(struct platform_device *pdev)
 		return;
 	}
 
-	if (hwtype == IMX31_GPIO)
+	if (hwtype == IMX35_GPIO)
+		mxc_gpio_hwdata = &imx35_gpio_hwdata;
+	else if (hwtype == IMX31_GPIO)
 		mxc_gpio_hwdata = &imx31_gpio_hwdata;
 	else
 		mxc_gpio_hwdata = &imx1_imx21_gpio_hwdata;
