From: julia@diku.dk (Julia Lawall)
Date: Sun, 20 Mar 2011 22:04:37 +0100 (CET)
Subject: [PATCH 2/2] ARM: mx5/mx53_evk: Remove unneeded gpio_set_value call
In-Reply-To: <20110320192451.GA19808@pengutronix.de>
References: <1300126869-14587-1-git-send-email-fabio.estevam@freescale.com>
	<1300126869-14587-2-git-send-email-fabio.estevam@freescale.com>
	<20110315090656.GC13316@pengutronix.de>
	<Pine.LNX.4.64.1103151039030.11859@ask.diku.dk>
	<20110315094946.GD13316@pengutronix.de>
	<Pine.LNX.4.64.1103151113420.8560@pc-004.diku.dk>
	<20110316083326.GF13316@pengutronix.de>
	<Pine.LNX.4.64.1103201850250.27008@ask.diku.dk>
	<20110320192451.GA19808@pengutronix.de>
Message-ID: <Pine.LNX.4.64.1103202201060.27008@ask.diku.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In this case, I also ignore the !GPIOLIB issue.  This semantic patch 
considers the case where the direction call has some error handling code.  
In this case, it just deletes that error handling code, so most of these 
cases are likely to need some manual cleanup, eg to get rid of unreachable 
error labels or to change the error message.

The semantic patch is as follows.  It modifies over 150 occurrences, as 
shown below.

@@
expression E1,E2,ret,E;
statement S;
@@

-      gpio_request(E1,E2)
+      gpio_request_one(E1,GPIOF_IN,E2)
       ... when != E1
-      ret = gpio_direction_input(E1);
       ... when != ret = E
-      if (\(ret != 0 \| ret < 0\)) S

@@
expression E1,E2,ret,E;
statement S;
@@

-      gpio_request(E1,E2)
+      gpio_request_one(E1,GPIOF_OUT_INIT_LOW,E2)
       ... when != E1
-      ret = gpio_direction_output(E1,0);
       ... when != ret = E
-      if (\(ret != 0 \| ret < 0\)) S

@@
expression E1,E2,ret,E;
statement S;
@@

-      gpio_request(E1,E2)
+      gpio_request_one(E1,GPIOF_OUT_INIT_HIGH,E2)
       ... when != E1
-      ret = gpio_direction_output(E1,1);
       ... when != ret = E
-      if (\(ret != 0 \| ret < 0\)) S

julia


diff -u -p a/arch/arm/mach-at91/board-gsia18s.c b/arch/arm/mach-at91/board-gsia18s.c
--- a/arch/arm/mach-at91/board-gsia18s.c 2011-01-19 18:51:18.000000000 +0100
+++ b/arch/arm/mach-at91/board-gsia18s.c 2011-03-20 22:00:24.000000000 +0100
@@ -458,18 +458,13 @@ static int pcf8574x_0x20_setup(struct i2
 {
 	int status;
 
-	status = gpio_request(gpio + PCF_GPIO_ETH_DETECT, "eth_det");
+	status = gpio_request_one(gpio + PCF_GPIO_ETH_DETECT, GPIOF_IN,
+				  "eth_det");
 	if (status < 0) {
 		pr_err("error: can't request GPIO%d\n",
 			gpio + PCF_GPIO_ETH_DETECT);
 		return status;
 	}
-	status = gpio_direction_input(gpio + PCF_GPIO_ETH_DETECT);
-	if (status < 0) {
-		pr_err("error: can't setup GPIO%d as input\n",
-			gpio + PCF_GPIO_ETH_DETECT);
-		return status;
-	}
 	status = gpio_export(gpio + PCF_GPIO_ETH_DETECT, false);
 	if (status < 0) {
 		pr_err("error: can't export GPIO%d\n",
diff -u -p a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
--- a/arch/arm/mach-ep93xx/core.c 2011-02-11 10:53:31.000000000 +0100
+++ b/arch/arm/mach-ep93xx/core.c 2011-03-20 22:00:22.000000000 +0100
@@ -598,13 +598,11 @@ int ep93xx_pwm_acquire_gpio(struct platf
 	if (pdev->id == 0) {
 		err = 0;
 	} else if (pdev->id == 1) {
-		err = gpio_request(EP93XX_GPIO_LINE_EGPIO14,
-				   dev_name(&pdev->dev));
+		err = gpio_request_one(EP93XX_GPIO_LINE_EGPIO14,
+				       GPIOF_OUT_INIT_LOW,
+				       dev_name(&pdev->dev));
 		if (err)
 			return err;
-		err = gpio_direction_output(EP93XX_GPIO_LINE_EGPIO14, 0);
-		if (err)
-			goto fail;
 
 		/* PWM 1 output on EGPIO[14] */
 		ep93xx_devcfg_set_bits(EP93XX_SYSCON_DEVCFG_PONG);
diff -u -p a/arch/arm/mach-mx3/mach-armadillo5x0.c b/arch/arm/mach-mx3/mach-armadillo5x0.c
--- a/arch/arm/mach-mx3/mach-armadillo5x0.c 2011-03-14 17:19:13.000000000 +0100
+++ b/arch/arm/mach-mx3/mach-armadillo5x0.c 2011-03-20 22:00:21.000000000 +0100
@@ -160,18 +160,13 @@ static int usbotg_init(struct platform_d
 
 	/* Chip already enabled by hardware */
 	/* OTG phy reset*/
-	err = gpio_request(OTG_RESET, "USB-OTG-RESET");
+	err = gpio_request_one(OTG_RESET, GPIOF_OUT_INIT_HIGH,
+			       "USB-OTG-RESET");
 	if (err) {
 		pr_err("Failed to request the usb otg reset gpio\n");
 		return err;
 	}
 
-	err = gpio_direction_output(OTG_RESET, 1/*HIGH*/);
-	if (err) {
-		pr_err("Failed to reset the usb otg phy\n");
-		goto otg_free_reset;
-	}
-
 	gpio_set_value(OTG_RESET, 0/*LOW*/);
 	mdelay(5);
 	gpio_set_value(OTG_RESET, 1/*HIGH*/);
@@ -206,31 +201,20 @@ static int usbh2_init(struct platform_de
 
 
 	/* Enable the chip */
-	err = gpio_request(USBH2_CS, "USB-H2-CS");
+	err = gpio_request_one(USBH2_CS, GPIOF_OUT_INIT_LOW, "USB-H2-CS");
 	if (err) {
 		pr_err("Failed to request the usb host 2 CS gpio\n");
 		return err;
 	}
 
-	err = gpio_direction_output(USBH2_CS, 0/*Enabled*/);
-	if (err) {
-		pr_err("Failed to drive the usb host 2 CS gpio\n");
-		goto h2_free_cs;
-	}
-
 	/* H2 phy reset*/
-	err = gpio_request(USBH2_RESET, "USB-H2-RESET");
+	err = gpio_request_one(USBH2_RESET, GPIOF_OUT_INIT_HIGH,
+			       "USB-H2-RESET");
 	if (err) {
 		pr_err("Failed to request the usb host 2 reset gpio\n");
 		goto h2_free_cs;
 	}
 
-	err = gpio_direction_output(USBH2_RESET, 1/*HIGH*/);
-	if (err) {
-		pr_err("Failed to reset the usb host 2 phy\n");
-		goto h2_free_reset;
-	}
-
 	gpio_set_value(USBH2_RESET, 0/*LOW*/);
 	mdelay(5);
 	gpio_set_value(USBH2_RESET, 1/*HIGH*/);
diff -u -p a/arch/arm/mach-mx3/mach-mx31_3ds.c b/arch/arm/mach-mx3/mach-mx31_3ds.c
--- a/arch/arm/mach-mx3/mach-mx31_3ds.c 2011-03-14 17:19:13.000000000 +0100
+++ b/arch/arm/mach-mx3/mach-mx31_3ds.c 2011-03-20 22:00:21.000000000 +0100
@@ -574,18 +574,13 @@ static int mx31_3ds_usbotg_init(void)
 	mxc_iomux_set_pad(MX31_PIN_USBOTG_NXT, USB_PAD_CFG);
 	mxc_iomux_set_pad(MX31_PIN_USBOTG_STP, USB_PAD_CFG);
 
-	err = gpio_request(USBOTG_RST_B, "otgusb-reset");
+	err = gpio_request_one(USBOTG_RST_B, GPIOF_OUT_INIT_LOW,
+			       "otgusb-reset");
 	if (err) {
 		pr_err("Failed to request the USB OTG reset gpio\n");
 		return err;
 	}
 
-	err = gpio_direction_output(USBOTG_RST_B, 0);
-	if (err) {
-		pr_err("Failed to drive the USB OTG reset gpio\n");
-		goto usbotg_free_reset;
-	}
-
 	mdelay(1);
 	gpio_set_value(USBOTG_RST_B, 1);
 	return 0;
@@ -617,18 +612,12 @@ static int mx31_3ds_host2_init(struct pl
 	mxc_iomux_set_pad(MX31_PIN_IOIS16, USB_PAD_CFG);
 	mxc_iomux_set_pad(MX31_PIN_PC_RW_B, USB_PAD_CFG);
 
-	err = gpio_request(USBH2_RST_B, "usbh2-reset");
+	err = gpio_request_one(USBH2_RST_B, GPIOF_OUT_INIT_LOW, "usbh2-reset");
 	if (err) {
 		pr_err("Failed to request the USB Host 2 reset gpio\n");
 		return err;
 	}
 
-	err = gpio_direction_output(USBH2_RST_B, 0);
-	if (err) {
-		pr_err("Failed to drive the USB Host 2 reset gpio\n");
-		goto usbotg_free_reset;
-	}
-
 	mdelay(1);
 	gpio_set_value(USBH2_RST_B, 1);
 
diff -u -p a/arch/arm/mach-mx3/mach-mx31moboard.c b/arch/arm/mach-mx3/mach-mx31moboard.c
--- a/arch/arm/mach-mx3/mach-mx31moboard.c 2011-03-14 17:19:13.000000000 +0100
+++ b/arch/arm/mach-mx3/mach-mx31moboard.c 2011-03-20 22:00:22.000000000 +0100
@@ -123,14 +123,11 @@ static struct platform_device mx31moboar
 
 static int moboard_uart0_init(struct platform_device *pdev)
 {
-	int ret = gpio_request(IOMUX_TO_GPIO(MX31_PIN_CTS1), "uart0-cts-hack");
+	int ret = gpio_request_one(IOMUX_TO_GPIO(MX31_PIN_CTS1),
+				   GPIOF_OUT_INIT_LOW, "uart0-cts-hack");
 	if (ret)
 		return ret;
 
-	ret = gpio_direction_output(IOMUX_TO_GPIO(MX31_PIN_CTS1), 0);
-	if (ret)
-		gpio_free(IOMUX_TO_GPIO(MX31_PIN_CTS1));
-
 	return ret;
 }
 
diff -u -p a/arch/arm/mach-mxs/mach-mx28evk.c b/arch/arm/mach-mxs/mach-mx28evk.c
--- a/arch/arm/mach-mxs/mach-mx28evk.c 2011-03-14 17:19:13.000000000 +0100
+++ b/arch/arm/mach-mxs/mach-mx28evk.c 2011-03-20 22:00:22.000000000 +0100
@@ -129,18 +129,13 @@ static void __init mx28evk_fec_reset(voi
 		clk_enable(clk);
 
 	/* Power up fec phy */
-	ret = gpio_request(MX28EVK_FEC_PHY_POWER, "fec-phy-power");
+	ret = gpio_request_one(MX28EVK_FEC_PHY_POWER, GPIOF_OUT_INIT_LOW,
+			       "fec-phy-power");
 	if (ret) {
 		pr_err("Failed to request gpio fec-phy-%s: %d\n", "power", ret);
 		return;
 	}
 
-	ret = gpio_direction_output(MX28EVK_FEC_PHY_POWER, 0);
-	if (ret) {
-		pr_err("Failed to drive gpio fec-phy-%s: %d\n", "power", ret);
-		return;
-	}
-
 	/* Reset fec phy */
 	ret = gpio_request(MX28EVK_FEC_PHY_RESET, "fec-phy-reset");
 	if (ret) {
diff -u -p a/arch/arm/mach-mxs/module-tx28.c b/arch/arm/mach-mxs/module-tx28.c
--- a/arch/arm/mach-mxs/module-tx28.c 2011-03-14 17:19:13.000000000 +0100
+++ b/arch/arm/mach-mxs/module-tx28.c 2011-03-20 22:00:23.000000000 +0100
@@ -72,19 +72,13 @@ int __init tx28_add_fec0(void)
 		unsigned int gpio = MXS_GPIO_NR(PAD_BANK(tx28_fec_gpio_pads[i]),
 			PAD_PIN(tx28_fec_gpio_pads[i]));
 
-		ret = gpio_request(gpio, "FEC");
+		ret = gpio_request_one(gpio, GPIOF_OUT_INIT_LOW, "FEC");
 		if (ret) {
 			pr_err("Failed to request GPIO_%d_%d: %d\n",
 				PAD_BANK(tx28_fec_gpio_pads[i]),
 				PAD_PIN(tx28_fec_gpio_pads[i]), ret);
 			goto free_gpios;
 		}
-		ret = gpio_direction_output(gpio, 0);
-		if (ret) {
-			pr_err("Failed to set direction of GPIO_%d_%d to output: %d\n",
-					gpio / 32 + 1, gpio % 32, ret);
-			goto free_gpios;
-		}
 	}
 
 	/* Power up fec phy */
diff -u -p a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
--- a/arch/arm/mach-omap2/board-4430sdp.c 2011-03-20 18:17:22.000000000 +0100
+++ b/arch/arm/mach-omap2/board-4430sdp.c 2011-03-20 22:00:22.000000000 +0100
@@ -257,44 +257,26 @@ static int omap_ethernet_init(void)
 
 	/* Request of GPIO lines */
 
-	status = gpio_request(ETH_KS8851_POWER_ON, "eth_power");
+	status = gpio_request_one(ETH_KS8851_POWER_ON, GPIOF_OUT_INIT_HIGH,
+				  "eth_power");
 	if (status) {
 		pr_err("Cannot request GPIO %d\n", ETH_KS8851_POWER_ON);
 		return status;
 	}
 
-	status = gpio_request(ETH_KS8851_QUART, "quart");
+	status = gpio_request_one(ETH_KS8851_QUART, GPIOF_OUT_INIT_HIGH,
+				  "quart");
 	if (status) {
 		pr_err("Cannot request GPIO %d\n", ETH_KS8851_QUART);
 		goto error1;
 	}
 
-	status = gpio_request(ETH_KS8851_IRQ, "eth_irq");
+	status = gpio_request_one(ETH_KS8851_IRQ, GPIOF_IN, "eth_irq");
 	if (status) {
 		pr_err("Cannot request GPIO %d\n", ETH_KS8851_IRQ);
 		goto error2;
 	}
 
-	/* Configuration of requested GPIO lines */
-
-	status = gpio_direction_output(ETH_KS8851_POWER_ON, 1);
-	if (status) {
-		pr_err("Cannot set output GPIO %d\n", ETH_KS8851_IRQ);
-		goto error3;
-	}
-
-	status = gpio_direction_output(ETH_KS8851_QUART, 1);
-	if (status) {
-		pr_err("Cannot set output GPIO %d\n", ETH_KS8851_QUART);
-		goto error3;
-	}
-
-	status = gpio_direction_input(ETH_KS8851_IRQ);
-	if (status) {
-		pr_err("Cannot set input GPIO %d\n", ETH_KS8851_IRQ);
-		goto error3;
-	}
-
 	return 0;
 
 error3:
@@ -616,19 +598,13 @@ static void __init omap_sfh7741prox_init
 {
 	int  error;
 
-	error = gpio_request(OMAP4_SFH7741_ENABLE_GPIO, "sfh7741");
+	error = gpio_request_one(OMAP4_SFH7741_ENABLE_GPIO,
+				 GPIOF_OUT_INIT_LOW, "sfh7741");
 	if (error < 0) {
 		pr_err("%s:failed to request GPIO %d, error %d\n",
 			__func__, OMAP4_SFH7741_ENABLE_GPIO, error);
 		return;
 	}
-
-	error = gpio_direction_output(OMAP4_SFH7741_ENABLE_GPIO , 0);
-	if (error < 0) {
-		pr_err("%s: GPIO configuration failed: GPIO %d,error %d\n",
-			 __func__, OMAP4_SFH7741_ENABLE_GPIO, error);
-		gpio_free(OMAP4_SFH7741_ENABLE_GPIO);
-	}
 }
 
 static void sdp4430_hdmi_mux_init(void)
diff -u -p a/arch/arm/mach-omap2/board-am3517crane.c b/arch/arm/mach-omap2/board-am3517crane.c
--- a/arch/arm/mach-omap2/board-am3517crane.c 2011-03-14 17:19:13.000000000 +0100
+++ b/arch/arm/mach-omap2/board-am3517crane.c 2011-03-20 22:00:23.000000000 +0100
@@ -89,19 +89,13 @@ static void __init am3517_crane_init(voi
 		return;
 	}
 
-	ret = gpio_request(GPIO_USB_POWER, "usb_ehci_enable");
+	ret = gpio_request_one(GPIO_USB_POWER, GPIOF_OUT_INIT_HIGH,
+			       "usb_ehci_enable");
 	if (ret < 0) {
 		pr_err("Can not request GPIO %d\n", GPIO_USB_POWER);
 		return;
 	}
 
-	ret = gpio_direction_output(GPIO_USB_POWER, 1);
-	if (ret < 0) {
-		gpio_free(GPIO_USB_POWER);
-		pr_err("Unable to initialize EHCI power\n");
-		return;
-	}
-
 	usbhs_init(&usbhs_bdata);
 }
 
diff -u -p a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
--- a/arch/arm/mach-omap2/board-am3517evm.c 2011-03-14 17:19:13.000000000 +0100
+++ b/arch/arm/mach-omap2/board-am3517evm.c 2011-03-20 22:00:24.000000000 +0100
@@ -174,19 +174,12 @@ static void __init am3517_evm_rtc_init(v
 	int r;
 
 	omap_mux_init_gpio(GPIO_RTCS35390A_IRQ, OMAP_PIN_INPUT_PULLUP);
-	r = gpio_request(GPIO_RTCS35390A_IRQ, "rtcs35390a-irq");
+	r = gpio_request_one(GPIO_RTCS35390A_IRQ, GPIOF_IN, "rtcs35390a-irq");
 	if (r < 0) {
 		printk(KERN_WARNING "failed to request GPIO#%d\n",
 				GPIO_RTCS35390A_IRQ);
 		return;
 	}
-	r = gpio_direction_input(GPIO_RTCS35390A_IRQ);
-	if (r < 0) {
-		printk(KERN_WARNING "GPIO#%d cannot be configured as input\n",
-				GPIO_RTCS35390A_IRQ);
-		gpio_free(GPIO_RTCS35390A_IRQ);
-		return;
-	}
 	am3517evm_i2c1_boardinfo[0].irq = gpio_to_irq(GPIO_RTCS35390A_IRQ);
 }
 
diff -u -p a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
--- a/arch/arm/mach-omap2/board-omap3pandora.c 2011-03-14 17:19:13.000000000 +0100
+++ b/arch/arm/mach-omap2/board-omap3pandora.c 2011-03-20 22:00:23.000000000 +0100
@@ -305,18 +305,12 @@ static int omap3pandora_twl_gpio_setup(s
 
 	/* gpio + 13 drives 32kHz buffer for wifi module */
 	gpio_32khz = gpio + 13;
-	ret = gpio_request(gpio_32khz, "wifi 32kHz");
+	ret = gpio_request_one(gpio_32khz, GPIOF_OUT_INIT_HIGH, "wifi 32kHz");
 	if (ret < 0) {
 		pr_err("Cannot get GPIO line %d, ret=%d\n", gpio_32khz, ret);
 		goto fail;
 	}
 
-	ret = gpio_direction_output(gpio_32khz, 1);
-	if (ret < 0) {
-		pr_err("Cannot set GPIO line %d, ret=%d\n", gpio_32khz, ret);
-		goto fail_direction;
-	}
-
 	return 0;
 
 fail_direction:
@@ -639,14 +633,10 @@ static void __init pandora_wl1251_init(v
 
 	memset(&pandora_wl1251_pdata, 0, sizeof(pandora_wl1251_pdata));
 
-	ret = gpio_request(PANDORA_WIFI_IRQ_GPIO, "wl1251 irq");
+	ret = gpio_request_one(PANDORA_WIFI_IRQ_GPIO, GPIOF_IN, "wl1251 irq");
 	if (ret < 0)
 		goto fail;
 
-	ret = gpio_direction_input(PANDORA_WIFI_IRQ_GPIO);
-	if (ret < 0)
-		goto fail_irq;
-
 	pandora_wl1251_pdata.irq = gpio_to_irq(PANDORA_WIFI_IRQ_GPIO);
 	if (pandora_wl1251_pdata.irq < 0)
 		goto fail_irq;
diff -u -p a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c 2011-03-14 17:19:13.000000000 +0100
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c 2011-03-20 22:00:21.000000000 +0100
@@ -925,22 +925,15 @@ static void __init rx51_init_wl1251(void
 {
 	int irq, ret;
 
-	ret = gpio_request(RX51_WL1251_POWER_GPIO, "wl1251 power");
+	ret = gpio_request_one(RX51_WL1251_POWER_GPIO, GPIOF_OUT_INIT_LOW,
+			       "wl1251 power");
 	if (ret < 0)
 		goto error;
 
-	ret = gpio_direction_output(RX51_WL1251_POWER_GPIO, 0);
+	ret = gpio_request_one(RX51_WL1251_IRQ_GPIO, GPIOF_IN, "wl1251 irq");
 	if (ret < 0)
 		goto err_power;
 
-	ret = gpio_request(RX51_WL1251_IRQ_GPIO, "wl1251 irq");
-	if (ret < 0)
-		goto err_power;
-
-	ret = gpio_direction_input(RX51_WL1251_IRQ_GPIO);
-	if (ret < 0)
-		goto err_irq;
-
 	irq = gpio_to_irq(RX51_WL1251_IRQ_GPIO);
 	if (irq < 0)
 		goto err_irq;
diff -u -p a/arch/arm/mach-pxa/balloon3.c b/arch/arm/mach-pxa/balloon3.c
--- a/arch/arm/mach-pxa/balloon3.c 2011-03-14 17:19:13.000000000 +0100
+++ b/arch/arm/mach-pxa/balloon3.c 2011-03-20 22:00:21.000000000 +0100
@@ -250,18 +250,13 @@ static void __init balloon3_lcd_init(voi
 
 	pxa2xx_mfp_config(ARRAY_AND_SIZE(balloon3_lcd_pin_config));
 
-	ret = gpio_request(BALLOON3_GPIO_RUN_BACKLIGHT, "BKL-ON");
+	ret = gpio_request_one(BALLOON3_GPIO_RUN_BACKLIGHT,
+			       GPIOF_OUT_INIT_HIGH, "BKL-ON");
 	if (ret) {
 		pr_err("Requesting BKL-ON GPIO failed!\n");
 		goto err;
 	}
 
-	ret = gpio_direction_output(BALLOON3_GPIO_RUN_BACKLIGHT, 1);
-	if (ret) {
-		pr_err("Setting BKL-ON GPIO direction failed!\n");
-		goto err2;
-	}
-
 	balloon3_lcd_screen.pxafb_backlight_power = balloon3_backlight_power;
 	set_pxa_fb_info(&balloon3_lcd_screen);
 	return;
@@ -635,14 +630,11 @@ static int balloon3_nand_probe(struct pl
 			"NAND support might be broken in this version!", ver);
 
 	/* Power up the NAND chips */
-	ret = gpio_request(BALLOON3_GPIO_RUN_NAND, "NAND");
+	ret = gpio_request_one(BALLOON3_GPIO_RUN_NAND, GPIOF_OUT_INIT_HIGH,
+			       "NAND");
 	if (ret)
 		goto err1;
 
-	ret = gpio_direction_output(BALLOON3_GPIO_RUN_NAND, 1);
-	if (ret)
-		goto err2;
-
 	gpio_set_value(BALLOON3_GPIO_RUN_NAND, 1);
 
 	/* Deassert all nCE lines and write protect line */
diff -u -p a/arch/arm/mach-pxa/cm-x270.c b/arch/arm/mach-pxa/cm-x270.c
--- a/arch/arm/mach-pxa/cm-x270.c 2010-12-31 15:18:30.000000000 +0100
+++ b/arch/arm/mach-pxa/cm-x270.c 2011-03-20 22:00:23.000000000 +0100
@@ -327,22 +327,18 @@ static unsigned long cm_x270_libertas_pi
 
 static int cm_x270_libertas_setup(struct spi_device *spi)
 {
-	int err = gpio_request(GPIO19_WLAN_STRAP, "WLAN STRAP");
+	int err = gpio_request_one(GPIO19_WLAN_STRAP, GPIOF_OUT_INIT_HIGH,
+				   "WLAN STRAP");
 	if (err)
 		return err;
 
-	err = gpio_request(GPIO102_WLAN_RST, "WLAN RST");
+	err = gpio_request_one(GPIO102_WLAN_RST, GPIOF_OUT_INIT_LOW,
+			       "WLAN RST");
 	if (err)
 		goto err_free_strap;
 
-	err = gpio_direction_output(GPIO102_WLAN_RST, 0);
-	if (err)
-		goto err_free_strap;
 	msleep(100);
 
-	err = gpio_direction_output(GPIO19_WLAN_STRAP, 1);
-	if (err)
-		goto err_free_strap;
 	msleep(100);
 
 	pxa2xx_mfp_config(ARRAY_AND_SIZE(cm_x270_libertas_pin_config));
diff -u -p a/arch/arm/mach-pxa/gumstix.c b/arch/arm/mach-pxa/gumstix.c
--- a/arch/arm/mach-pxa/gumstix.c 2010-12-28 18:26:02.000000000 +0100
+++ b/arch/arm/mach-pxa/gumstix.c 2011-03-20 22:00:24.000000000 +0100
@@ -152,17 +152,13 @@ static void __init gumstix_bluetooth_ini
 
 	gumstix_setup_bt_clock();
 
-	err = gpio_request(GPIO_GUMSTIX_BTRESET, "BTRST");
+	err = gpio_request_one(GPIO_GUMSTIX_BTRESET, GPIOF_OUT_INIT_HIGH,
+			       "BTRST");
 	if (err) {
 		pr_err("gumstix: failed request gpio for bluetooth reset\n");
 		return;
 	}
 
-	err = gpio_direction_output(GPIO_GUMSTIX_BTRESET, 1);
-	if (err) {
-		pr_err("gumstix: can't reset bluetooth\n");
-		return;
-	}
 	gpio_set_value(GPIO_GUMSTIX_BTRESET, 0);
 	udelay(100);
 	gpio_set_value(GPIO_GUMSTIX_BTRESET, 1);
diff -u -p a/arch/arm/mach-pxa/palm27x.c b/arch/arm/mach-pxa/palm27x.c
--- a/arch/arm/mach-pxa/palm27x.c 2011-03-14 17:19:13.000000000 +0100
+++ b/arch/arm/mach-pxa/palm27x.c 2011-03-20 22:00:24.000000000 +0100
@@ -278,20 +278,15 @@ static int palm27x_backlight_init(struct
 {
 	int ret;
 
-	ret = gpio_request(palm_bl_power, "BL POWER");
+	ret = gpio_request_one(palm_bl_power, GPIOF_OUT_INIT_LOW, "BL POWER");
 	if (ret)
 		goto err;
-	ret = gpio_direction_output(palm_bl_power, 0);
-	if (ret)
-		goto err2;
 
 	if (gpio_is_valid(palm_lcd_power)) {
-		ret = gpio_request(palm_lcd_power, "LCD POWER");
+		ret = gpio_request_one(palm_lcd_power, GPIOF_OUT_INIT_LOW,
+				       "LCD POWER");
 		if (ret)
 			goto err2;
-		ret = gpio_direction_output(palm_lcd_power, 0);
-		if (ret)
-			goto err3;
 	}
 
 	return 0;
@@ -355,20 +350,14 @@ static int palm27x_power_supply_init(str
 {
 	int ret;
 
-	ret = gpio_request(palm_ac_state, "AC state");
+	ret = gpio_request_one(palm_ac_state, GPIOF_IN, "AC state");
 	if (ret)
 		goto err1;
-	ret = gpio_direction_input(palm_ac_state);
-	if (ret)
-		goto err2;
 
 	if (gpio_is_valid(palm_usb_state)) {
-		ret = gpio_request(palm_usb_state, "USB state");
+		ret = gpio_request_one(palm_usb_state, GPIOF_IN, "USB state");
 		if (ret)
 			goto err2;
-		ret = gpio_direction_input(palm_usb_state);
-		if (ret)
-			goto err3;
 	}
 
 	return 0;
diff -u -p a/arch/arm/mach-pxa/palmtc.c b/arch/arm/mach-pxa/palmtc.c
--- a/arch/arm/mach-pxa/palmtc.c 2010-12-28 18:26:02.000000000 +0100
+++ b/arch/arm/mach-pxa/palmtc.c 2011-03-20 22:00:23.000000000 +0100
@@ -171,12 +171,10 @@ static int palmtc_backlight_init(struct 
 {
 	int ret;
 
-	ret = gpio_request(GPIO_NR_PALMTC_BL_POWER, "BL POWER");
+	ret = gpio_request_one(GPIO_NR_PALMTC_BL_POWER, GPIOF_OUT_INIT_HIGH,
+			       "BL POWER");
 	if (ret)
 		goto err;
-	ret = gpio_direction_output(GPIO_NR_PALMTC_BL_POWER, 1);
-	if (ret)
-		goto err2;
 
 	return 0;
 
diff -u -p a/arch/arm/mach-pxa/palmte2.c b/arch/arm/mach-pxa/palmte2.c
--- a/arch/arm/mach-pxa/palmte2.c 2010-12-28 18:26:02.000000000 +0100
+++ b/arch/arm/mach-pxa/palmte2.c 2011-03-20 22:00:22.000000000 +0100
@@ -140,18 +140,14 @@ static int palmte2_backlight_init(struct
 {
 	int ret;
 
-	ret = gpio_request(GPIO_NR_PALMTE2_BL_POWER, "BL POWER");
+	ret = gpio_request_one(GPIO_NR_PALMTE2_BL_POWER, GPIOF_OUT_INIT_LOW,
+			       "BL POWER");
 	if (ret)
 		goto err;
-	ret = gpio_direction_output(GPIO_NR_PALMTE2_BL_POWER, 0);
+	ret = gpio_request_one(GPIO_NR_PALMTE2_LCD_POWER, GPIOF_OUT_INIT_LOW,
+			       "LCD POWER");
 	if (ret)
 		goto err2;
-	ret = gpio_request(GPIO_NR_PALMTE2_LCD_POWER, "LCD POWER");
-	if (ret)
-		goto err2;
-	ret = gpio_direction_output(GPIO_NR_PALMTE2_LCD_POWER, 0);
-	if (ret)
-		goto err3;
 
 	return 0;
 err3:
@@ -225,12 +221,10 @@ static int power_supply_init(struct devi
 {
 	int ret;
 
-	ret = gpio_request(GPIO_NR_PALMTE2_POWER_DETECT, "CABLE_STATE_AC");
+	ret = gpio_request_one(GPIO_NR_PALMTE2_POWER_DETECT, GPIOF_IN,
+			       "CABLE_STATE_AC");
 	if (ret)
 		goto err1;
-	ret = gpio_direction_input(GPIO_NR_PALMTE2_POWER_DETECT);
-	if (ret)
-		goto err2;
 
 	return 0;
 
diff -u -p a/arch/arm/mach-pxa/tosa-bt.c b/arch/arm/mach-pxa/tosa-bt.c
--- a/arch/arm/mach-pxa/tosa-bt.c 2011-03-14 17:19:13.000000000 +0100
+++ b/arch/arm/mach-pxa/tosa-bt.c 2011-03-20 22:00:23.000000000 +0100
@@ -61,18 +61,14 @@ static int tosa_bt_probe(struct platform
 
 	struct tosa_bt_data *data = dev->dev.platform_data;
 
-	rc = gpio_request(data->gpio_reset, "Bluetooth reset");
+	rc = gpio_request_one(data->gpio_reset, GPIOF_OUT_INIT_LOW,
+			      "Bluetooth reset");
 	if (rc)
 		goto err_reset;
-	rc = gpio_direction_output(data->gpio_reset, 0);
-	if (rc)
-		goto err_reset_dir;
-	rc = gpio_request(data->gpio_pwr, "Bluetooth power");
+	rc = gpio_request_one(data->gpio_pwr, GPIOF_OUT_INIT_LOW,
+			      "Bluetooth power");
 	if (rc)
 		goto err_pwr;
-	rc = gpio_direction_output(data->gpio_pwr, 0);
-	if (rc)
-		goto err_pwr_dir;
 
 	rfk = rfkill_alloc("tosa-bt", &dev->dev, RFKILL_TYPE_BLUETOOTH,
 			   &tosa_bt_rfkill_ops, data);
diff -u -p a/arch/arm/mach-pxa/tosa.c b/arch/arm/mach-pxa/tosa.c
--- a/arch/arm/mach-pxa/tosa.c 2011-03-14 17:19:13.000000000 +0100
+++ b/arch/arm/mach-pxa/tosa.c 2011-03-20 22:00:23.000000000 +0100
@@ -253,14 +253,11 @@ static int tosa_mci_init(struct device *
 {
 	int err;
 
-	err = gpio_request(TOSA_GPIO_nSD_INT, "SD Int");
+	err = gpio_request_one(TOSA_GPIO_nSD_INT, GPIOF_IN, "SD Int");
 	if (err) {
 		printk(KERN_ERR "tosa_mci_init: can't request SD_PWR gpio\n");
 		goto err_gpio_int;
 	}
-	err = gpio_direction_input(TOSA_GPIO_nSD_INT);
-	if (err)
-		goto err_gpio_int_dir;
 
 	return 0;
 
@@ -304,21 +301,16 @@ static int tosa_irda_startup(struct devi
 {
 	int ret;
 
-	ret = gpio_request(TOSA_GPIO_IRDA_TX, "IrDA TX");
+	ret = gpio_request_one(TOSA_GPIO_IRDA_TX, GPIOF_OUT_INIT_LOW,
+			       "IrDA TX");
 	if (ret)
 		goto err_tx;
-	ret = gpio_direction_output(TOSA_GPIO_IRDA_TX, 0);
-	if (ret)
-		goto err_tx_dir;
 
-	ret = gpio_request(TOSA_GPIO_IR_POWERDWN, "IrDA powerdown");
+	ret = gpio_request_one(TOSA_GPIO_IR_POWERDWN, GPIOF_OUT_INIT_LOW,
+			       "IrDA powerdown");
 	if (ret)
 		goto err_pwr;
 
-	ret = gpio_direction_output(TOSA_GPIO_IR_POWERDWN, 0);
-	if (ret)
-		goto err_pwr_dir;
-
 	tosa_irda_transceiver_mode(dev, IR_SIRMODE | IR_OFF);
 
 	return 0;
@@ -352,14 +344,10 @@ static struct pxaficp_platform_data tosa
  */
 static int tosa_power_init(struct device *dev)
 {
-	int ret = gpio_request(TOSA_GPIO_AC_IN, "ac in");
+	int ret = gpio_request_one(TOSA_GPIO_AC_IN, GPIOF_IN, "ac in");
 	if (ret)
 		goto err_gpio_req;
 
-	ret = gpio_direction_input(TOSA_GPIO_AC_IN);
-	if (ret)
-		goto err_gpio_in;
-
 	return 0;
 
 err_gpio_in:
@@ -622,24 +610,18 @@ static int tosa_tc6393xb_enable(struct p
 {
 	int rc;
 
-	rc = gpio_request(TOSA_GPIO_TC6393XB_REST_IN, "tc6393xb #pclr");
+	rc = gpio_request_one(TOSA_GPIO_TC6393XB_REST_IN, GPIOF_OUT_INIT_LOW,
+			      "tc6393xb #pclr");
 	if (rc)
 		goto err_req_pclr;
-	rc = gpio_request(TOSA_GPIO_TC6393XB_SUSPEND, "tc6393xb #suspend");
+	rc = gpio_request_one(TOSA_GPIO_TC6393XB_SUSPEND, GPIOF_OUT_INIT_LOW,
+			      "tc6393xb #suspend");
 	if (rc)
 		goto err_req_suspend;
-	rc = gpio_request(TOSA_GPIO_TC6393XB_L3V_ON, "tc6393xb l3v");
+	rc = gpio_request_one(TOSA_GPIO_TC6393XB_L3V_ON, GPIOF_OUT_INIT_LOW,
+			      "tc6393xb l3v");
 	if (rc)
 		goto err_req_l3v;
-	rc = gpio_direction_output(TOSA_GPIO_TC6393XB_L3V_ON, 0);
-	if (rc)
-		goto err_dir_l3v;
-	rc = gpio_direction_output(TOSA_GPIO_TC6393XB_SUSPEND, 0);
-	if (rc)
-		goto err_dir_suspend;
-	rc = gpio_direction_output(TOSA_GPIO_TC6393XB_REST_IN, 0);
-	if (rc)
-		goto err_dir_pclr;
 
 	mdelay(1);
 
@@ -726,14 +708,11 @@ static int tosa_tc6393xb_setup(struct pl
 {
 	int rc;
 
-	rc = gpio_request(TOSA_GPIO_CARD_VCC_ON, "CARD_VCC_ON");
+	rc = gpio_request_one(TOSA_GPIO_CARD_VCC_ON, GPIOF_OUT_INIT_HIGH,
+			      "CARD_VCC_ON");
 	if (rc)
 		goto err_req;
 
-	rc = gpio_direction_output(TOSA_GPIO_CARD_VCC_ON, 1);
-	if (rc)
-		goto err_dir;
-
 	return rc;
 
 err_dir:
diff -u -p a/arch/arm/mach-pxa/viper.c b/arch/arm/mach-pxa/viper.c
--- a/arch/arm/mach-pxa/viper.c 2011-03-14 17:19:13.000000000 +0100
+++ b/arch/arm/mach-pxa/viper.c 2011-03-20 22:00:22.000000000 +0100
@@ -353,22 +353,15 @@ static int viper_backlight_init(struct d
 	int ret;
 
 	/* GPIO9 and 10 control FB backlight. Initialise to off */
-	ret = gpio_request(VIPER_BCKLIGHT_EN_GPIO, "Backlight");
+	ret = gpio_request_one(VIPER_BCKLIGHT_EN_GPIO, GPIOF_OUT_INIT_LOW,
+			       "Backlight");
 	if (ret)
 		goto err_request_bckl;
 
-	ret = gpio_request(VIPER_LCD_EN_GPIO, "LCD");
+	ret = gpio_request_one(VIPER_LCD_EN_GPIO, GPIOF_OUT_INIT_LOW, "LCD");
 	if (ret)
 		goto err_request_lcd;
 
-	ret = gpio_direction_output(VIPER_BCKLIGHT_EN_GPIO, 0);
-	if (ret)
-		goto err_dir;
-
-	ret = gpio_direction_output(VIPER_LCD_EN_GPIO, 0);
-	if (ret)
-		goto err_dir;
-
 	return 0;
 
 err_dir:
diff -u -p a/arch/arm/mach-pxa/vpac270.c b/arch/arm/mach-pxa/vpac270.c
--- a/arch/arm/mach-pxa/vpac270.c 2011-03-14 17:19:13.000000000 +0100
+++ b/arch/arm/mach-pxa/vpac270.c 2011-03-20 22:00:23.000000000 +0100
@@ -559,18 +559,13 @@ static void __init vpac270_lcd_init(void
 {
 	int ret;
 
-	ret = gpio_request(GPIO81_VPAC270_BKL_ON, "BKL-ON");
+	ret = gpio_request_one(GPIO81_VPAC270_BKL_ON, GPIOF_OUT_INIT_HIGH,
+			       "BKL-ON");
 	if (ret) {
 		pr_err("Requesting BKL-ON GPIO failed!\n");
 		goto err;
 	}
 
-	ret = gpio_direction_output(GPIO81_VPAC270_BKL_ON, 1);
-	if (ret) {
-		pr_err("Setting BKL-ON GPIO direction failed!\n");
-		goto err2;
-	}
-
 	vpac270_lcd_screen.pxafb_lcd_power = vpac270_lcd_power;
 	set_pxa_fb_info(&vpac270_lcd_screen);
 	return;
diff -u -p a/arch/arm/mach-pxa/z2.c b/arch/arm/mach-pxa/z2.c
--- a/arch/arm/mach-pxa/z2.c 2011-03-14 17:19:13.000000000 +0100
+++ b/arch/arm/mach-pxa/z2.c 2011-03-20 22:00:22.000000000 +0100
@@ -497,22 +497,16 @@ static int z2_lbs_spi_setup(struct spi_d
 {
 	int ret = 0;
 
-	ret = gpio_request(GPIO15_ZIPITZ2_WIFI_POWER, "WiFi Power");
+	ret = gpio_request_one(GPIO15_ZIPITZ2_WIFI_POWER,
+			       GPIOF_OUT_INIT_HIGH, "WiFi Power");
 	if (ret)
 		goto err;
 
-	ret = gpio_direction_output(GPIO15_ZIPITZ2_WIFI_POWER, 1);
+	ret = gpio_request_one(GPIO14_ZIPITZ2_WIFI_RESET, GPIOF_OUT_INIT_LOW,
+			       "WiFi Reset");
 	if (ret)
 		goto err2;
 
-	ret = gpio_request(GPIO14_ZIPITZ2_WIFI_RESET, "WiFi Reset");
-	if (ret)
-		goto err2;
-
-	ret = gpio_direction_output(GPIO14_ZIPITZ2_WIFI_RESET, 0);
-	if (ret)
-		goto err3;
-
 	/* Reset the card */
 	mdelay(180);
 	gpio_set_value(GPIO14_ZIPITZ2_WIFI_RESET, 1);
diff -u -p a/arch/arm/mach-pxa/zeus.c b/arch/arm/mach-pxa/zeus.c
--- a/arch/arm/mach-pxa/zeus.c 2011-03-14 17:19:13.000000000 +0100
+++ b/arch/arm/mach-pxa/zeus.c 2011-03-20 22:00:23.000000000 +0100
@@ -393,16 +393,11 @@ static int zeus_mcp2515_setup(struct spi
 {
 	int err;
 
-	err = gpio_request(ZEUS_CAN_SHDN_GPIO, "CAN shutdown");
+	err = gpio_request_one(ZEUS_CAN_SHDN_GPIO, GPIOF_OUT_INIT_HIGH,
+			       "CAN shutdown");
 	if (err)
 		return err;
 
-	err = gpio_direction_output(ZEUS_CAN_SHDN_GPIO, 1);
-	if (err) {
-		gpio_free(ZEUS_CAN_SHDN_GPIO);
-		return err;
-	}
-
 	return 0;
 }
 
diff -u -p a/arch/arm/mach-sa1100/collie.c b/arch/arm/mach-sa1100/collie.c
--- a/arch/arm/mach-sa1100/collie.c 2011-02-19 08:28:51.000000000 +0100
+++ b/arch/arm/mach-sa1100/collie.c 2011-03-20 22:00:24.000000000 +0100
@@ -95,14 +95,10 @@ static struct mcp_plat_data collie_mcp_d
  */
 static int collie_power_init(struct device *dev)
 {
-	int ret = gpio_request(COLLIE_GPIO_AC_IN, "ac in");
+	int ret = gpio_request_one(COLLIE_GPIO_AC_IN, GPIOF_IN, "ac in");
 	if (ret)
 		goto err_gpio_req;
 
-	ret = gpio_direction_input(COLLIE_GPIO_AC_IN);
-	if (ret)
-		goto err_gpio_in;
-
 	return 0;
 
 err_gpio_in:
@@ -273,14 +269,11 @@ static struct mtd_partition collie_parti
 
 static int collie_flash_init(void)
 {
-	int rc = gpio_request(COLLIE_GPIO_VPEN, "flash Vpp enable");
+	int rc = gpio_request_one(COLLIE_GPIO_VPEN, GPIOF_OUT_INIT_HIGH,
+				  "flash Vpp enable");
 	if (rc)
 		return rc;
 
-	rc = gpio_direction_output(COLLIE_GPIO_VPEN, 1);
-	if (rc)
-		gpio_free(COLLIE_GPIO_VPEN);
-
 	return rc;
 }
 
diff -u -p a/arch/arm/mach-sa1100/h3600.c b/arch/arm/mach-sa1100/h3600.c
--- a/arch/arm/mach-sa1100/h3600.c 2010-10-23 19:40:31.000000000 +0200
+++ b/arch/arm/mach-sa1100/h3600.c 2011-03-20 22:00:24.000000000 +0100
@@ -79,18 +79,14 @@ static void h3600_irda_set_speed(struct 
 
 static int h3600_irda_startup(struct device *dev)
 {
-	int err = gpio_request(H3600_EGPIO_IR_ON, "IrDA power");
+	int err = gpio_request_one(H3600_EGPIO_IR_ON, GPIOF_OUT_INIT_LOW,
+				   "IrDA power");
 	if (err)
 		goto err1;
-	err = gpio_direction_output(H3600_EGPIO_IR_ON, 0);
+	err = gpio_request_one(H3600_EGPIO_IR_FSEL, GPIOF_OUT_INIT_LOW,
+			       "IrDA fsel");
 	if (err)
 		goto err2;
-	err = gpio_request(H3600_EGPIO_IR_FSEL, "IrDA fsel");
-	if (err)
-		goto err2;
-	err = gpio_direction_output(H3600_EGPIO_IR_FSEL, 0);
-	if (err)
-		goto err3;
 	return 0;
 
 err3:	gpio_free(H3600_EGPIO_IR_FSEL);
diff -u -p a/arch/arm/mach-sa1100/h3xxx.c b/arch/arm/mach-sa1100/h3xxx.c
--- a/arch/arm/mach-sa1100/h3xxx.c 2009-12-03 14:09:46.000000000 +0100
+++ b/arch/arm/mach-sa1100/h3xxx.c 2011-03-20 22:00:24.000000000 +0100
@@ -82,16 +82,13 @@ static void h3xxx_set_vpp(int vpp)
 
 static int h3xxx_flash_init(void)
 {
-	int err = gpio_request(H3XXX_EGPIO_VPP_ON, "Flash Vpp");
+	int err = gpio_request_one(H3XXX_EGPIO_VPP_ON, GPIOF_OUT_INIT_LOW,
+				   "Flash Vpp");
 	if (err) {
 		pr_err("%s: can't request H3XXX_EGPIO_VPP_ON\n", __func__);
 		return err;
 	}
 
-	err = gpio_direction_output(H3XXX_EGPIO_VPP_ON, 0);
-	if (err)
-		gpio_free(H3XXX_EGPIO_VPP_ON);
-
 	return err;
 }
 
diff -u -p a/arch/arm/mach-ux500/board-mop500-stuib.c b/arch/arm/mach-ux500/board-mop500-stuib.c
--- a/arch/arm/mach-ux500/board-mop500-stuib.c 2011-02-19 08:28:51.000000000 +0100
+++ b/arch/arm/mach-ux500/board-mop500-stuib.c 2011-03-20 22:00:22.000000000 +0100
@@ -100,17 +100,12 @@ static int bu21013_gpio_board_init(int r
 
 	bu21013_devices++;
 	if (bu21013_devices == 1) {
-		retval = gpio_request(reset_pin, "touchp_reset");
+		retval = gpio_request_one(reset_pin, GPIOF_OUT_INIT_HIGH,
+					  "touchp_reset");
 		if (retval) {
 			printk(KERN_ERR "Unable to request gpio reset_pin");
 			return retval;
 		}
-		retval = gpio_direction_output(reset_pin, 1);
-		if (retval < 0) {
-			printk(KERN_ERR "%s: gpio direction failed\n",
-					__func__);
-			return retval;
-		}
 	}
 
 	return retval;
diff -u -p a/arch/m68knommu/platform/520x/config.c b/arch/m68knommu/platform/520x/config.c
--- a/arch/m68knommu/platform/520x/config.c 2011-03-14 17:19:13.000000000 +0100
+++ b/arch/m68knommu/platform/520x/config.c 2011-03-20 22:00:24.000000000 +0100
@@ -99,38 +99,26 @@ static int m520x_cs_setup(struct mcfqspi
 {
 	int status;
 
-	status = gpio_request(MCFQSPI_CS0, "MCFQSPI_CS0");
+	status = gpio_request_one(MCFQSPI_CS0, GPIOF_OUT_INIT_HIGH,
+				  "MCFQSPI_CS0");
 	if (status) {
 		pr_debug("gpio_request for MCFQSPI_CS0 failed\n");
 		goto fail0;
 	}
-	status = gpio_direction_output(MCFQSPI_CS0, 1);
-	if (status) {
-		pr_debug("gpio_direction_output for MCFQSPI_CS0 failed\n");
-		goto fail1;
-	}
 
-	status = gpio_request(MCFQSPI_CS1, "MCFQSPI_CS1");
+	status = gpio_request_one(MCFQSPI_CS1, GPIOF_OUT_INIT_HIGH,
+				  "MCFQSPI_CS1");
 	if (status) {
 		pr_debug("gpio_request for MCFQSPI_CS1 failed\n");
 		goto fail1;
 	}
-	status = gpio_direction_output(MCFQSPI_CS1, 1);
-	if (status) {
-		pr_debug("gpio_direction_output for MCFQSPI_CS1 failed\n");
-		goto fail2;
-	}
 
-	status = gpio_request(MCFQSPI_CS2, "MCFQSPI_CS2");
+	status = gpio_request_one(MCFQSPI_CS2, GPIOF_OUT_INIT_HIGH,
+				  "MCFQSPI_CS2");
 	if (status) {
 		pr_debug("gpio_request for MCFQSPI_CS2 failed\n");
 		goto fail2;
 	}
-	status = gpio_direction_output(MCFQSPI_CS2, 1);
-	if (status) {
-		pr_debug("gpio_direction_output for MCFQSPI_CS2 failed\n");
-		goto fail3;
-	}
 
 	return 0;
 
diff -u -p a/arch/m68knommu/platform/523x/config.c b/arch/m68knommu/platform/523x/config.c
--- a/arch/m68knommu/platform/523x/config.c 2011-03-14 17:19:13.000000000 +0100
+++ b/arch/m68knommu/platform/523x/config.c 2011-03-20 22:00:24.000000000 +0100
@@ -101,49 +101,33 @@ static int m523x_cs_setup(struct mcfqspi
 {
 	int status;
 
-	status = gpio_request(MCFQSPI_CS0, "MCFQSPI_CS0");
+	status = gpio_request_one(MCFQSPI_CS0, GPIOF_OUT_INIT_HIGH,
+				  "MCFQSPI_CS0");
 	if (status) {
 		pr_debug("gpio_request for MCFQSPI_CS0 failed\n");
 		goto fail0;
 	}
-	status = gpio_direction_output(MCFQSPI_CS0, 1);
-	if (status) {
-		pr_debug("gpio_direction_output for MCFQSPI_CS0 failed\n");
-		goto fail1;
-	}
 
-	status = gpio_request(MCFQSPI_CS1, "MCFQSPI_CS1");
+	status = gpio_request_one(MCFQSPI_CS1, GPIOF_OUT_INIT_HIGH,
+				  "MCFQSPI_CS1");
 	if (status) {
 		pr_debug("gpio_request for MCFQSPI_CS1 failed\n");
 		goto fail1;
 	}
-	status = gpio_direction_output(MCFQSPI_CS1, 1);
-	if (status) {
-		pr_debug("gpio_direction_output for MCFQSPI_CS1 failed\n");
-		goto fail2;
-	}
 
-	status = gpio_request(MCFQSPI_CS2, "MCFQSPI_CS2");
+	status = gpio_request_one(MCFQSPI_CS2, GPIOF_OUT_INIT_HIGH,
+				  "MCFQSPI_CS2");
 	if (status) {
 		pr_debug("gpio_request for MCFQSPI_CS2 failed\n");
 		goto fail2;
 	}
-	status = gpio_direction_output(MCFQSPI_CS2, 1);
-	if (status) {
-		pr_debug("gpio_direction_output for MCFQSPI_CS2 failed\n");
-		goto fail3;
-	}
 
-	status = gpio_request(MCFQSPI_CS3, "MCFQSPI_CS3");
+	status = gpio_request_one(MCFQSPI_CS3, GPIOF_OUT_INIT_HIGH,
+				  "MCFQSPI_CS3");
 	if (status) {
 		pr_debug("gpio_request for MCFQSPI_CS3 failed\n");
 		goto fail3;
 	}
-	status = gpio_direction_output(MCFQSPI_CS3, 1);
-	if (status) {
-		pr_debug("gpio_direction_output for MCFQSPI_CS3 failed\n");
-		goto fail4;
-	}
 
 	return 0;
 
diff -u -p a/arch/m68knommu/platform/5249/config.c b/arch/m68knommu/platform/5249/config.c
--- a/arch/m68knommu/platform/5249/config.c 2010-05-27 15:47:03.000000000 +0200
+++ b/arch/m68knommu/platform/5249/config.c 2011-03-20 22:00:21.000000000 +0100
@@ -87,49 +87,33 @@ static int m5249_cs_setup(struct mcfqspi
 {
 	int status;
 
-	status = gpio_request(MCFQSPI_CS0, "MCFQSPI_CS0");
+	status = gpio_request_one(MCFQSPI_CS0, GPIOF_OUT_INIT_HIGH,
+				  "MCFQSPI_CS0");
 	if (status) {
 		pr_debug("gpio_request for MCFQSPI_CS0 failed\n");
 		goto fail0;
 	}
-	status = gpio_direction_output(MCFQSPI_CS0, 1);
-	if (status) {
-		pr_debug("gpio_direction_output for MCFQSPI_CS0 failed\n");
-		goto fail1;
-	}
 
-	status = gpio_request(MCFQSPI_CS1, "MCFQSPI_CS1");
+	status = gpio_request_one(MCFQSPI_CS1, GPIOF_OUT_INIT_HIGH,
+				  "MCFQSPI_CS1");
 	if (status) {
 		pr_debug("gpio_request for MCFQSPI_CS1 failed\n");
 		goto fail1;
 	}
-	status = gpio_direction_output(MCFQSPI_CS1, 1);
-	if (status) {
-		pr_debug("gpio_direction_output for MCFQSPI_CS1 failed\n");
-		goto fail2;
-	}
 
-	status = gpio_request(MCFQSPI_CS2, "MCFQSPI_CS2");
+	status = gpio_request_one(MCFQSPI_CS2, GPIOF_OUT_INIT_HIGH,
+				  "MCFQSPI_CS2");
 	if (status) {
 		pr_debug("gpio_request for MCFQSPI_CS2 failed\n");
 		goto fail2;
 	}
-	status = gpio_direction_output(MCFQSPI_CS2, 1);
-	if (status) {
-		pr_debug("gpio_direction_output for MCFQSPI_CS2 failed\n");
-		goto fail3;
-	}
 
-	status = gpio_request(MCFQSPI_CS3, "MCFQSPI_CS3");
+	status = gpio_request_one(MCFQSPI_CS3, GPIOF_OUT_INIT_HIGH,
+				  "MCFQSPI_CS3");
 	if (status) {
 		pr_debug("gpio_request for MCFQSPI_CS3 failed\n");
 		goto fail3;
 	}
-	status = gpio_direction_output(MCFQSPI_CS3, 1);
-	if (status) {
-		pr_debug("gpio_direction_output for MCFQSPI_CS3 failed\n");
-		goto fail4;
-	}
 
 	return 0;
 
diff -u -p a/arch/m68knommu/platform/527x/config.c b/arch/m68knommu/platform/527x/config.c
--- a/arch/m68knommu/platform/527x/config.c 2011-03-14 17:19:13.000000000 +0100
+++ b/arch/m68knommu/platform/527x/config.c 2011-03-20 22:00:21.000000000 +0100
@@ -139,49 +139,33 @@ static int m527x_cs_setup(struct mcfqspi
 {
 	int status;
 
-	status = gpio_request(MCFQSPI_CS0, "MCFQSPI_CS0");
+	status = gpio_request_one(MCFQSPI_CS0, GPIOF_OUT_INIT_HIGH,
+				  "MCFQSPI_CS0");
 	if (status) {
 		pr_debug("gpio_request for MCFQSPI_CS0 failed\n");
 		goto fail0;
 	}
-	status = gpio_direction_output(MCFQSPI_CS0, 1);
-	if (status) {
-		pr_debug("gpio_direction_output for MCFQSPI_CS0 failed\n");
-		goto fail1;
-	}
 
-	status = gpio_request(MCFQSPI_CS1, "MCFQSPI_CS1");
+	status = gpio_request_one(MCFQSPI_CS1, GPIOF_OUT_INIT_HIGH,
+				  "MCFQSPI_CS1");
 	if (status) {
 		pr_debug("gpio_request for MCFQSPI_CS1 failed\n");
 		goto fail1;
 	}
-	status = gpio_direction_output(MCFQSPI_CS1, 1);
-	if (status) {
-		pr_debug("gpio_direction_output for MCFQSPI_CS1 failed\n");
-		goto fail2;
-	}
 
-	status = gpio_request(MCFQSPI_CS2, "MCFQSPI_CS2");
+	status = gpio_request_one(MCFQSPI_CS2, GPIOF_OUT_INIT_HIGH,
+				  "MCFQSPI_CS2");
 	if (status) {
 		pr_debug("gpio_request for MCFQSPI_CS2 failed\n");
 		goto fail2;
 	}
-	status = gpio_direction_output(MCFQSPI_CS2, 1);
-	if (status) {
-		pr_debug("gpio_direction_output for MCFQSPI_CS2 failed\n");
-		goto fail3;
-	}
 
-	status = gpio_request(MCFQSPI_CS3, "MCFQSPI_CS3");
+	status = gpio_request_one(MCFQSPI_CS3, GPIOF_OUT_INIT_HIGH,
+				  "MCFQSPI_CS3");
 	if (status) {
 		pr_debug("gpio_request for MCFQSPI_CS3 failed\n");
 		goto fail3;
 	}
-	status = gpio_direction_output(MCFQSPI_CS3, 1);
-	if (status) {
-		pr_debug("gpio_direction_output for MCFQSPI_CS3 failed\n");
-		goto fail4;
-	}
 
 	return 0;
 
diff -u -p a/arch/m68knommu/platform/528x/config.c b/arch/m68knommu/platform/528x/config.c
--- a/arch/m68knommu/platform/528x/config.c 2011-03-14 17:19:13.000000000 +0100
+++ b/arch/m68knommu/platform/528x/config.c 2011-03-20 22:00:24.000000000 +0100
@@ -102,49 +102,33 @@ static int m528x_cs_setup(struct mcfqspi
 {
 	int status;
 
-	status = gpio_request(MCFQSPI_CS0, "MCFQSPI_CS0");
+	status = gpio_request_one(MCFQSPI_CS0, GPIOF_OUT_INIT_HIGH,
+				  "MCFQSPI_CS0");
 	if (status) {
 		pr_debug("gpio_request for MCFQSPI_CS0 failed\n");
 		goto fail0;
 	}
-	status = gpio_direction_output(MCFQSPI_CS0, 1);
-	if (status) {
-		pr_debug("gpio_direction_output for MCFQSPI_CS0 failed\n");
-		goto fail1;
-	}
 
-	status = gpio_request(MCFQSPI_CS1, "MCFQSPI_CS1");
+	status = gpio_request_one(MCFQSPI_CS1, GPIOF_OUT_INIT_HIGH,
+				  "MCFQSPI_CS1");
 	if (status) {
 		pr_debug("gpio_request for MCFQSPI_CS1 failed\n");
 		goto fail1;
 	}
-	status = gpio_direction_output(MCFQSPI_CS1, 1);
-	if (status) {
-		pr_debug("gpio_direction_output for MCFQSPI_CS1 failed\n");
-		goto fail2;
-	}
 
-	status = gpio_request(MCFQSPI_CS2, "MCFQSPI_CS2");
+	status = gpio_request_one(MCFQSPI_CS2, GPIOF_OUT_INIT_HIGH,
+				  "MCFQSPI_CS2");
 	if (status) {
 		pr_debug("gpio_request for MCFQSPI_CS2 failed\n");
 		goto fail2;
 	}
-	status = gpio_direction_output(MCFQSPI_CS2, 1);
-	if (status) {
-		pr_debug("gpio_direction_output for MCFQSPI_CS2 failed\n");
-		goto fail3;
-	}
 
-	status = gpio_request(MCFQSPI_CS3, "MCFQSPI_CS3");
+	status = gpio_request_one(MCFQSPI_CS3, GPIOF_OUT_INIT_HIGH,
+				  "MCFQSPI_CS3");
 	if (status) {
 		pr_debug("gpio_request for MCFQSPI_CS3 failed\n");
 		goto fail3;
 	}
-	status = gpio_direction_output(MCFQSPI_CS3, 1);
-	if (status) {
-		pr_debug("gpio_direction_output for MCFQSPI_CS3 failed\n");
-		goto fail4;
-	}
 
 	return 0;
 
diff -u -p a/arch/m68knommu/platform/532x/config.c b/arch/m68knommu/platform/532x/config.c
--- a/arch/m68knommu/platform/532x/config.c 2010-01-29 18:29:07.000000000 +0100
+++ b/arch/m68knommu/platform/532x/config.c 2011-03-20 22:00:24.000000000 +0100
@@ -107,38 +107,26 @@ static int m532x_cs_setup(struct mcfqspi
 {
 	int status;
 
-	status = gpio_request(MCFQSPI_CS0, "MCFQSPI_CS0");
+	status = gpio_request_one(MCFQSPI_CS0, GPIOF_OUT_INIT_HIGH,
+				  "MCFQSPI_CS0");
 	if (status) {
 		pr_debug("gpio_request for MCFQSPI_CS0 failed\n");
 		goto fail0;
 	}
-	status = gpio_direction_output(MCFQSPI_CS0, 1);
-	if (status) {
-		pr_debug("gpio_direction_output for MCFQSPI_CS0 failed\n");
-		goto fail1;
-	}
 
-	status = gpio_request(MCFQSPI_CS1, "MCFQSPI_CS1");
+	status = gpio_request_one(MCFQSPI_CS1, GPIOF_OUT_INIT_HIGH,
+				  "MCFQSPI_CS1");
 	if (status) {
 		pr_debug("gpio_request for MCFQSPI_CS1 failed\n");
 		goto fail1;
 	}
-	status = gpio_direction_output(MCFQSPI_CS1, 1);
-	if (status) {
-		pr_debug("gpio_direction_output for MCFQSPI_CS1 failed\n");
-		goto fail2;
-	}
 
-	status = gpio_request(MCFQSPI_CS2, "MCFQSPI_CS2");
+	status = gpio_request_one(MCFQSPI_CS2, GPIOF_OUT_INIT_HIGH,
+				  "MCFQSPI_CS2");
 	if (status) {
 		pr_debug("gpio_request for MCFQSPI_CS2 failed\n");
 		goto fail2;
 	}
-	status = gpio_direction_output(MCFQSPI_CS2, 1);
-	if (status) {
-		pr_debug("gpio_direction_output for MCFQSPI_CS2 failed\n");
-		goto fail3;
-	}
 
 	return 0;
 
diff -u -p a/drivers/ata/pata_palmld.c b/drivers/ata/pata_palmld.c
--- a/drivers/ata/pata_palmld.c 2011-02-19 08:28:51.000000000 +0100
+++ b/drivers/ata/pata_palmld.c 2011-03-20 22:00:21.000000000 +0100
@@ -61,19 +61,15 @@ static __devinit int palmld_pata_probe(s
 		return -ENOMEM;
 
 	/* request and activate power GPIO, IRQ GPIO */
-	ret = gpio_request(GPIO_NR_PALMLD_IDE_PWEN, "HDD PWR");
+	ret = gpio_request_one(GPIO_NR_PALMLD_IDE_PWEN, GPIOF_OUT_INIT_HIGH,
+			       "HDD PWR");
 	if (ret)
 		goto err1;
-	ret = gpio_direction_output(GPIO_NR_PALMLD_IDE_PWEN, 1);
-	if (ret)
-		goto err2;
 
-	ret = gpio_request(GPIO_NR_PALMLD_IDE_RESET, "HDD RST");
+	ret = gpio_request_one(GPIO_NR_PALMLD_IDE_RESET, GPIOF_OUT_INIT_LOW,
+			       "HDD RST");
 	if (ret)
 		goto err2;
-	ret = gpio_direction_output(GPIO_NR_PALMLD_IDE_RESET, 0);
-	if (ret)
-		goto err3;
 
 	/* reset the drive */
 	gpio_set_value(GPIO_NR_PALMLD_IDE_RESET, 0);
diff -u -p a/drivers/hwmon/gpio-fan.c b/drivers/hwmon/gpio-fan.c
--- a/drivers/hwmon/gpio-fan.c 2010-11-13 10:26:37.000000000 +0100
+++ b/drivers/hwmon/gpio-fan.c 2011-03-20 22:00:23.000000000 +0100
@@ -95,14 +95,10 @@ static int fan_alarm_init(struct gpio_fa
 
 	fan_data->alarm = alarm;
 
-	err = gpio_request(alarm->gpio, "GPIO fan alarm");
+	err = gpio_request_one(alarm->gpio, GPIOF_IN, "GPIO fan alarm");
 	if (err)
 		return err;
 
-	err = gpio_direction_input(alarm->gpio);
-	if (err)
-		goto err_free_gpio;
-
 	err = device_create_file(&pdev->dev, &dev_attr_fan1_alarm);
 	if (err)
 		goto err_free_gpio;
diff -u -p a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
--- a/drivers/input/keyboard/gpio_keys.c 2011-02-02 17:27:38.000000000 +0100
+++ b/drivers/input/keyboard/gpio_keys.c 2011-03-20 22:00:23.000000000 +0100
@@ -371,21 +371,13 @@ static int __devinit gpio_keys_setup_key
 	setup_timer(&bdata->timer, gpio_keys_timer, (unsigned long)bdata);
 	INIT_WORK(&bdata->work, gpio_keys_work_func);
 
-	error = gpio_request(button->gpio, desc);
+	error = gpio_request_one(button->gpio, GPIOF_IN, desc);
 	if (error < 0) {
 		dev_err(dev, "failed to request GPIO %d, error %d\n",
 			button->gpio, error);
 		goto fail2;
 	}
 
-	error = gpio_direction_input(button->gpio);
-	if (error < 0) {
-		dev_err(dev, "failed to configure"
-			" direction for GPIO %d, error %d\n",
-			button->gpio, error);
-		goto fail3;
-	}
-
 	if (button->debounce_interval) {
 		error = gpio_set_debounce(button->gpio,
 					  button->debounce_interval * 1000);
diff -u -p a/drivers/input/keyboard/gpio_keys_polled.c b/drivers/input/keyboard/gpio_keys_polled.c
--- a/drivers/input/keyboard/gpio_keys_polled.c 2010-12-26 10:19:06.000000000 +0100
+++ b/drivers/input/keyboard/gpio_keys_polled.c 2011-03-20 22:00:22.000000000 +0100
@@ -158,22 +158,14 @@ static int __devinit gpio_keys_polled_pr
 			goto err_free_gpio;
 		}
 
-		error = gpio_request(gpio,
-				     button->desc ? button->desc : DRV_NAME);
+		error = gpio_request_one(gpio, GPIOF_IN,
+					 button->desc ? button->desc : DRV_NAME);
 		if (error) {
 			dev_err(dev, "unable to claim gpio %u, err=%d\n",
 				gpio, error);
 			goto err_free_gpio;
 		}
 
-		error = gpio_direction_input(gpio);
-		if (error) {
-			dev_err(dev,
-				"unable to set direction on gpio %u, err=%d\n",
-				gpio, error);
-			goto err_free_gpio;
-		}
-
 		bdata->can_sleep = gpio_cansleep(gpio);
 		bdata->last_state = -1;
 		bdata->threshold = DIV_ROUND_UP(button->debounce_interval,
diff -u -p a/drivers/input/misc/rotary_encoder.c b/drivers/input/misc/rotary_encoder.c
--- a/drivers/input/misc/rotary_encoder.c 2011-02-11 10:53:32.000000000 +0100
+++ b/drivers/input/misc/rotary_encoder.c 2011-03-20 22:00:22.000000000 +0100
@@ -146,34 +146,20 @@ static int __devinit rotary_encoder_prob
 	}
 
 	/* request the GPIOs */
-	err = gpio_request(pdata->gpio_a, DRV_NAME);
+	err = gpio_request_one(pdata->gpio_a, GPIOF_IN, DRV_NAME);
 	if (err) {
 		dev_err(&pdev->dev, "unable to request GPIO %d\n",
 			pdata->gpio_a);
 		goto exit_unregister_input;
 	}
 
-	err = gpio_direction_input(pdata->gpio_a);
-	if (err) {
-		dev_err(&pdev->dev, "unable to set GPIO %d for input\n",
-			pdata->gpio_a);
-		goto exit_unregister_input;
-	}
-
-	err = gpio_request(pdata->gpio_b, DRV_NAME);
+	err = gpio_request_one(pdata->gpio_b, GPIOF_IN, DRV_NAME);
 	if (err) {
 		dev_err(&pdev->dev, "unable to request GPIO %d\n",
 			pdata->gpio_b);
 		goto exit_free_gpio_a;
 	}
 
-	err = gpio_direction_input(pdata->gpio_b);
-	if (err) {
-		dev_err(&pdev->dev, "unable to set GPIO %d for input\n",
-			pdata->gpio_b);
-		goto exit_free_gpio_a;
-	}
-
 	/* request the IRQs */
 	err = request_irq(encoder->irq_a, &rotary_encoder_irq,
 			  IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
diff -u -p a/drivers/input/touchscreen/cy8ctmg110_ts.c b/drivers/input/touchscreen/cy8ctmg110_ts.c
--- a/drivers/input/touchscreen/cy8ctmg110_ts.c 2011-01-19 18:51:19.000000000 +0100
+++ b/drivers/input/touchscreen/cy8ctmg110_ts.c 2011-03-20 22:00:22.000000000 +0100
@@ -223,7 +223,7 @@ static int __devinit cy8ctmg110_probe(st
 	cy8ctmg110_power(ts, true);
 	cy8ctmg110_set_sleepmode(ts, false);
 
-	err = gpio_request(ts->irq_pin, "touch_irq_key");
+	err = gpio_request_one(ts->irq_pin, GPIOF_IN, "touch_irq_key");
 	if (err < 0) {
 		dev_err(&client->dev,
 			"Failed to request GPIO %d, error %d\n",
@@ -231,14 +231,6 @@ static int __devinit cy8ctmg110_probe(st
 		goto err_shutoff_device;
 	}
 
-	err = gpio_direction_input(ts->irq_pin);
-	if (err < 0) {
-		dev_err(&client->dev,
-			"Failed to configure input direction for GPIO %d, error %d\n",
-			ts->irq_pin, err);
-		goto err_free_irq_gpio;
-	}
-
 	client->irq = gpio_to_irq(ts->irq_pin);
 	if (client->irq < 0) {
 		err = client->irq;
diff -u -p a/drivers/input/touchscreen/mainstone-wm97xx.c b/drivers/input/touchscreen/mainstone-wm97xx.c
--- a/drivers/input/touchscreen/mainstone-wm97xx.c 2010-02-03 15:05:01.000000000 +0100
+++ b/drivers/input/touchscreen/mainstone-wm97xx.c 2011-03-20 22:00:22.000000000 +0100
@@ -208,16 +208,10 @@ static int wm97xx_acc_startup(struct wm9
 		irq = 4;
 
 	if (irq) {
-		ret = gpio_request(irq, "Touchscreen IRQ");
+		ret = gpio_request_one(irq, GPIOF_IN, "Touchscreen IRQ");
 		if (ret)
 			goto out;
 
-		ret = gpio_direction_input(irq);
-		if (ret) {
-			gpio_free(irq);
-			goto out;
-		}
-
 		wm->pen_irq = gpio_to_irq(irq);
 		set_irq_type(wm->pen_irq, IRQ_TYPE_EDGE_BOTH);
 	} else /* pen irq not supported */
diff -u -p a/drivers/leds/leds-netxbig.c b/drivers/leds/leds-netxbig.c
--- a/drivers/leds/leds-netxbig.c 2010-10-14 18:30:04.000000000 +0200
+++ b/drivers/leds/leds-netxbig.c 2011-03-20 22:00:21.000000000 +0100
@@ -81,35 +81,23 @@ static int __devinit gpio_ext_init(struc
 
 	/* Configure address GPIOs. */
 	for (i = 0; i < gpio_ext->num_addr; i++) {
-		err = gpio_request(gpio_ext->addr[i], "GPIO extension addr");
+		err = gpio_request_one(gpio_ext->addr[i], GPIOF_OUT_INIT_LOW,
+				       "GPIO extension addr");
 		if (err)
 			goto err_free_addr;
-		err = gpio_direction_output(gpio_ext->addr[i], 0);
-		if (err) {
-			gpio_free(gpio_ext->addr[i]);
-			goto err_free_addr;
-		}
 	}
 	/* Configure data GPIOs. */
 	for (i = 0; i < gpio_ext->num_data; i++) {
-		err = gpio_request(gpio_ext->data[i], "GPIO extension data");
+		err = gpio_request_one(gpio_ext->data[i], GPIOF_OUT_INIT_LOW,
+				       "GPIO extension data");
 		if (err)
 			goto err_free_data;
-		err = gpio_direction_output(gpio_ext->data[i], 0);
-		if (err) {
-			gpio_free(gpio_ext->data[i]);
-			goto err_free_data;
-		}
 	}
 	/* Configure "enable select" GPIO. */
-	err = gpio_request(gpio_ext->enable, "GPIO extension enable");
+	err = gpio_request_one(gpio_ext->enable, GPIOF_OUT_INIT_LOW,
+			       "GPIO extension enable");
 	if (err)
 		goto err_free_data;
-	err = gpio_direction_output(gpio_ext->enable, 0);
-	if (err) {
-		gpio_free(gpio_ext->enable);
-		goto err_free_data;
-	}
 
 	return 0;
 
diff -u -p a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
--- a/drivers/mmc/host/omap_hsmmc.c 2011-03-14 17:19:15.000000000 +0100
+++ b/drivers/mmc/host/omap_hsmmc.c 2011-03-20 22:00:24.000000000 +0100
@@ -506,23 +506,19 @@ static int omap_hsmmc_gpio_init(struct o
 			pdata->slots[0].card_detect = omap_hsmmc_card_detect;
 		pdata->slots[0].card_detect_irq =
 				gpio_to_irq(pdata->slots[0].switch_pin);
-		ret = gpio_request(pdata->slots[0].switch_pin, "mmc_cd");
+		ret = gpio_request_one(pdata->slots[0].switch_pin, GPIOF_IN,
+				       "mmc_cd");
 		if (ret)
 			return ret;
-		ret = gpio_direction_input(pdata->slots[0].switch_pin);
-		if (ret)
-			goto err_free_sp;
 	} else
 		pdata->slots[0].switch_pin = -EINVAL;
 
 	if (gpio_is_valid(pdata->slots[0].gpio_wp)) {
 		pdata->slots[0].get_ro = omap_hsmmc_get_wp;
-		ret = gpio_request(pdata->slots[0].gpio_wp, "mmc_wp");
+		ret = gpio_request_one(pdata->slots[0].gpio_wp, GPIOF_IN,
+				       "mmc_wp");
 		if (ret)
 			goto err_free_cd;
-		ret = gpio_direction_input(pdata->slots[0].gpio_wp);
-		if (ret)
-			goto err_free_wp;
 	} else
 		pdata->slots[0].gpio_wp = -EINVAL;
 
diff -u -p a/drivers/mmc/host/sdhci-spear.c b/drivers/mmc/host/sdhci-spear.c
--- a/drivers/mmc/host/sdhci-spear.c 2010-05-29 09:25:20.000000000 +0200
+++ b/drivers/mmc/host/sdhci-spear.c 2011-03-20 22:00:23.000000000 +0100
@@ -182,19 +182,14 @@ static int __devinit sdhci_probe(struct 
 	}
 
 	if (sdhci->data->card_int_gpio >= 0) {
-		ret = gpio_request(sdhci->data->card_int_gpio, "sdhci");
+		ret = gpio_request_one(sdhci->data->card_int_gpio, GPIOF_IN,
+				       "sdhci");
 		if (ret < 0) {
 			dev_dbg(&pdev->dev, "gpio request fail: %d\n",
 					sdhci->data->card_int_gpio);
 			goto err_igpio_request;
 		}
 
-		ret = gpio_direction_input(sdhci->data->card_int_gpio);
-		if (ret) {
-			dev_dbg(&pdev->dev, "gpio set direction fail: %d\n",
-					sdhci->data->card_int_gpio);
-			goto err_igpio_direction;
-		}
 		ret = request_irq(gpio_to_irq(sdhci->data->card_int_gpio),
 				sdhci_gpio_irq, IRQF_TRIGGER_LOW,
 				mmc_hostname(host->mmc), pdev);
diff -u -p a/drivers/pcmcia/pxa2xx_colibri.c b/drivers/pcmcia/pxa2xx_colibri.c
--- a/drivers/pcmcia/pxa2xx_colibri.c 2011-03-14 17:19:16.000000000 +0100
+++ b/drivers/pcmcia/pxa2xx_colibri.c 2011-03-20 22:00:21.000000000 +0100
@@ -54,47 +54,35 @@ static int colibri_pcmcia_hw_init(struct
 {
 	int ret;
 
-	ret = gpio_request(colibri_pcmcia_gpio.detect_gpio, "DETECT");
+	ret = gpio_request_one(colibri_pcmcia_gpio.detect_gpio, GPIOF_IN,
+			       "DETECT");
 	if (ret)
 		goto err1;
-	ret = gpio_direction_input(colibri_pcmcia_gpio.detect_gpio);
-	if (ret)
-		goto err2;
 
-	ret = gpio_request(colibri_pcmcia_gpio.ready_gpio, "READY");
+	ret = gpio_request_one(colibri_pcmcia_gpio.ready_gpio, GPIOF_IN,
+			       "READY");
 	if (ret)
 		goto err2;
-	ret = gpio_direction_input(colibri_pcmcia_gpio.ready_gpio);
-	if (ret)
-		goto err3;
 
-	ret = gpio_request(colibri_pcmcia_gpio.bvd1_gpio, "BVD1");
+	ret = gpio_request_one(colibri_pcmcia_gpio.bvd1_gpio, GPIOF_IN,
+			       "BVD1");
 	if (ret)
 		goto err3;
-	ret = gpio_direction_input(colibri_pcmcia_gpio.bvd1_gpio);
-	if (ret)
-		goto err4;
 
-	ret = gpio_request(colibri_pcmcia_gpio.bvd2_gpio, "BVD2");
+	ret = gpio_request_one(colibri_pcmcia_gpio.bvd2_gpio, GPIOF_IN,
+			       "BVD2");
 	if (ret)
 		goto err4;
-	ret = gpio_direction_input(colibri_pcmcia_gpio.bvd2_gpio);
-	if (ret)
-		goto err5;
 
-	ret = gpio_request(colibri_pcmcia_gpio.ppen_gpio, "PPEN");
+	ret = gpio_request_one(colibri_pcmcia_gpio.ppen_gpio,
+			       GPIOF_OUT_INIT_LOW, "PPEN");
 	if (ret)
 		goto err5;
-	ret = gpio_direction_output(colibri_pcmcia_gpio.ppen_gpio, 0);
-	if (ret)
-		goto err6;
 
-	ret = gpio_request(colibri_pcmcia_gpio.reset_gpio, "RESET");
+	ret = gpio_request_one(colibri_pcmcia_gpio.reset_gpio,
+			       GPIOF_OUT_INIT_HIGH, "RESET");
 	if (ret)
 		goto err6;
-	ret = gpio_direction_output(colibri_pcmcia_gpio.reset_gpio, 1);
-	if (ret)
-		goto err7;
 
 	colibri_irqs[0].irq = gpio_to_irq(colibri_pcmcia_gpio.detect_gpio);
 	skt->socket.pci_irq = gpio_to_irq(colibri_pcmcia_gpio.ready_gpio);
diff -u -p a/drivers/pcmcia/pxa2xx_palmld.c b/drivers/pcmcia/pxa2xx_palmld.c
--- a/drivers/pcmcia/pxa2xx_palmld.c 2009-11-08 21:45:05.000000000 +0100
+++ b/drivers/pcmcia/pxa2xx_palmld.c 2011-03-20 22:00:25.000000000 +0100
@@ -24,26 +24,20 @@ static int palmld_pcmcia_hw_init(struct 
 {
 	int ret;
 
-	ret = gpio_request(GPIO_NR_PALMLD_PCMCIA_POWER, "PCMCIA PWR");
+	ret = gpio_request_one(GPIO_NR_PALMLD_PCMCIA_POWER,
+			       GPIOF_OUT_INIT_LOW, "PCMCIA PWR");
 	if (ret)
 		goto err1;
-	ret = gpio_direction_output(GPIO_NR_PALMLD_PCMCIA_POWER, 0);
-	if (ret)
-		goto err2;
 
-	ret = gpio_request(GPIO_NR_PALMLD_PCMCIA_RESET, "PCMCIA RST");
+	ret = gpio_request_one(GPIO_NR_PALMLD_PCMCIA_RESET,
+			       GPIOF_OUT_INIT_HIGH, "PCMCIA RST");
 	if (ret)
 		goto err2;
-	ret = gpio_direction_output(GPIO_NR_PALMLD_PCMCIA_RESET, 1);
-	if (ret)
-		goto err3;
 
-	ret = gpio_request(GPIO_NR_PALMLD_PCMCIA_READY, "PCMCIA RDY");
+	ret = gpio_request_one(GPIO_NR_PALMLD_PCMCIA_READY, GPIOF_IN,
+			       "PCMCIA RDY");
 	if (ret)
 		goto err3;
-	ret = gpio_direction_input(GPIO_NR_PALMLD_PCMCIA_READY);
-	if (ret)
-		goto err4;
 
 	skt->socket.pci_irq = IRQ_GPIO(GPIO_NR_PALMLD_PCMCIA_READY);
 	return 0;
diff -u -p a/drivers/pcmcia/pxa2xx_palmtc.c b/drivers/pcmcia/pxa2xx_palmtc.c
--- a/drivers/pcmcia/pxa2xx_palmtc.c 2009-12-17 08:30:14.000000000 +0100
+++ b/drivers/pcmcia/pxa2xx_palmtc.c 2011-03-20 22:00:21.000000000 +0100
@@ -25,47 +25,35 @@ static int palmtc_pcmcia_hw_init(struct 
 {
 	int ret;
 
-	ret = gpio_request(GPIO_NR_PALMTC_PCMCIA_POWER1, "PCMCIA PWR1");
+	ret = gpio_request_one(GPIO_NR_PALMTC_PCMCIA_POWER1,
+			       GPIOF_OUT_INIT_LOW, "PCMCIA PWR1");
 	if (ret)
 		goto err1;
-	ret = gpio_direction_output(GPIO_NR_PALMTC_PCMCIA_POWER1, 0);
-	if (ret)
-		goto err2;
 
-	ret = gpio_request(GPIO_NR_PALMTC_PCMCIA_POWER2, "PCMCIA PWR2");
+	ret = gpio_request_one(GPIO_NR_PALMTC_PCMCIA_POWER2,
+			       GPIOF_OUT_INIT_LOW, "PCMCIA PWR2");
 	if (ret)
 		goto err2;
-	ret = gpio_direction_output(GPIO_NR_PALMTC_PCMCIA_POWER2, 0);
-	if (ret)
-		goto err3;
 
-	ret = gpio_request(GPIO_NR_PALMTC_PCMCIA_POWER3, "PCMCIA PWR3");
+	ret = gpio_request_one(GPIO_NR_PALMTC_PCMCIA_POWER3,
+			       GPIOF_OUT_INIT_LOW, "PCMCIA PWR3");
 	if (ret)
 		goto err3;
-	ret = gpio_direction_output(GPIO_NR_PALMTC_PCMCIA_POWER3, 0);
-	if (ret)
-		goto err4;
 
-	ret = gpio_request(GPIO_NR_PALMTC_PCMCIA_RESET, "PCMCIA RST");
+	ret = gpio_request_one(GPIO_NR_PALMTC_PCMCIA_RESET,
+			       GPIOF_OUT_INIT_HIGH, "PCMCIA RST");
 	if (ret)
 		goto err4;
-	ret = gpio_direction_output(GPIO_NR_PALMTC_PCMCIA_RESET, 1);
-	if (ret)
-		goto err5;
 
-	ret = gpio_request(GPIO_NR_PALMTC_PCMCIA_READY, "PCMCIA RDY");
+	ret = gpio_request_one(GPIO_NR_PALMTC_PCMCIA_READY, GPIOF_IN,
+			       "PCMCIA RDY");
 	if (ret)
 		goto err5;
-	ret = gpio_direction_input(GPIO_NR_PALMTC_PCMCIA_READY);
-	if (ret)
-		goto err6;
 
-	ret = gpio_request(GPIO_NR_PALMTC_PCMCIA_PWRREADY, "PCMCIA PWRRDY");
+	ret = gpio_request_one(GPIO_NR_PALMTC_PCMCIA_PWRREADY, GPIOF_IN,
+			       "PCMCIA PWRRDY");
 	if (ret)
 		goto err6;
-	ret = gpio_direction_input(GPIO_NR_PALMTC_PCMCIA_PWRREADY);
-	if (ret)
-		goto err7;
 
 	skt->socket.pci_irq = IRQ_GPIO(GPIO_NR_PALMTC_PCMCIA_READY);
 	return 0;
diff -u -p a/drivers/pcmcia/pxa2xx_palmtx.c b/drivers/pcmcia/pxa2xx_palmtx.c
--- a/drivers/pcmcia/pxa2xx_palmtx.c 2009-11-08 21:45:05.000000000 +0100
+++ b/drivers/pcmcia/pxa2xx_palmtx.c 2011-03-20 22:00:25.000000000 +0100
@@ -25,33 +25,25 @@ static int palmtx_pcmcia_hw_init(struct 
 {
 	int ret;
 
-	ret = gpio_request(GPIO_NR_PALMTX_PCMCIA_POWER1, "PCMCIA PWR1");
+	ret = gpio_request_one(GPIO_NR_PALMTX_PCMCIA_POWER1,
+			       GPIOF_OUT_INIT_LOW, "PCMCIA PWR1");
 	if (ret)
 		goto err1;
-	ret = gpio_direction_output(GPIO_NR_PALMTX_PCMCIA_POWER1, 0);
-	if (ret)
-		goto err2;
 
-	ret = gpio_request(GPIO_NR_PALMTX_PCMCIA_POWER2, "PCMCIA PWR2");
+	ret = gpio_request_one(GPIO_NR_PALMTX_PCMCIA_POWER2,
+			       GPIOF_OUT_INIT_LOW, "PCMCIA PWR2");
 	if (ret)
 		goto err2;
-	ret = gpio_direction_output(GPIO_NR_PALMTX_PCMCIA_POWER2, 0);
-	if (ret)
-		goto err3;
 
-	ret = gpio_request(GPIO_NR_PALMTX_PCMCIA_RESET, "PCMCIA RST");
+	ret = gpio_request_one(GPIO_NR_PALMTX_PCMCIA_RESET,
+			       GPIOF_OUT_INIT_HIGH, "PCMCIA RST");
 	if (ret)
 		goto err3;
-	ret = gpio_direction_output(GPIO_NR_PALMTX_PCMCIA_RESET, 1);
-	if (ret)
-		goto err4;
 
-	ret = gpio_request(GPIO_NR_PALMTX_PCMCIA_READY, "PCMCIA RDY");
+	ret = gpio_request_one(GPIO_NR_PALMTX_PCMCIA_READY, GPIOF_IN,
+			       "PCMCIA RDY");
 	if (ret)
 		goto err4;
-	ret = gpio_direction_input(GPIO_NR_PALMTX_PCMCIA_READY);
-	if (ret)
-		goto err5;
 
 	skt->socket.pci_irq = gpio_to_irq(GPIO_NR_PALMTX_PCMCIA_READY);
 	return 0;
diff -u -p a/drivers/pcmcia/pxa2xx_vpac270.c b/drivers/pcmcia/pxa2xx_vpac270.c
--- a/drivers/pcmcia/pxa2xx_vpac270.c 2010-05-19 22:36:14.000000000 +0200
+++ b/drivers/pcmcia/pxa2xx_vpac270.c 2011-03-20 22:00:25.000000000 +0100
@@ -40,33 +40,25 @@ static int vpac270_pcmcia_hw_init(struct
 	int ret;
 
 	if (skt->nr == 0) {
-		ret = gpio_request(GPIO84_VPAC270_PCMCIA_CD, "PCMCIA CD");
+		ret = gpio_request_one(GPIO84_VPAC270_PCMCIA_CD, GPIOF_IN,
+				       "PCMCIA CD");
 		if (ret)
 			goto err1;
-		ret = gpio_direction_input(GPIO84_VPAC270_PCMCIA_CD);
-		if (ret)
-			goto err2;
 
-		ret = gpio_request(GPIO35_VPAC270_PCMCIA_RDY, "PCMCIA RDY");
+		ret = gpio_request_one(GPIO35_VPAC270_PCMCIA_RDY, GPIOF_IN,
+				       "PCMCIA RDY");
 		if (ret)
 			goto err2;
-		ret = gpio_direction_input(GPIO35_VPAC270_PCMCIA_RDY);
-		if (ret)
-			goto err3;
 
-		ret = gpio_request(GPIO107_VPAC270_PCMCIA_PPEN, "PCMCIA PPEN");
+		ret = gpio_request_one(GPIO107_VPAC270_PCMCIA_PPEN,
+				       GPIOF_OUT_INIT_LOW, "PCMCIA PPEN");
 		if (ret)
 			goto err3;
-		ret = gpio_direction_output(GPIO107_VPAC270_PCMCIA_PPEN, 0);
-		if (ret)
-			goto err4;
 
-		ret = gpio_request(GPIO11_VPAC270_PCMCIA_RESET, "PCMCIA RESET");
+		ret = gpio_request_one(GPIO11_VPAC270_PCMCIA_RESET,
+				       GPIOF_OUT_INIT_LOW, "PCMCIA RESET");
 		if (ret)
 			goto err4;
-		ret = gpio_direction_output(GPIO11_VPAC270_PCMCIA_RESET, 0);
-		if (ret)
-			goto err5;
 
 		skt->socket.pci_irq = gpio_to_irq(GPIO35_VPAC270_PCMCIA_RDY);
 
@@ -84,26 +76,20 @@ err1:
 		return ret;
 
 	} else {
-		ret = gpio_request(GPIO17_VPAC270_CF_CD, "CF CD");
+		ret = gpio_request_one(GPIO17_VPAC270_CF_CD, GPIOF_IN,
+				       "CF CD");
 		if (ret)
 			goto err6;
-		ret = gpio_direction_input(GPIO17_VPAC270_CF_CD);
-		if (ret)
-			goto err7;
 
-		ret = gpio_request(GPIO12_VPAC270_CF_RDY, "CF RDY");
+		ret = gpio_request_one(GPIO12_VPAC270_CF_RDY, GPIOF_IN,
+				       "CF RDY");
 		if (ret)
 			goto err7;
-		ret = gpio_direction_input(GPIO12_VPAC270_CF_RDY);
-		if (ret)
-			goto err8;
 
-		ret = gpio_request(GPIO16_VPAC270_CF_RESET, "CF RESET");
+		ret = gpio_request_one(GPIO16_VPAC270_CF_RESET,
+				       GPIOF_OUT_INIT_LOW, "CF RESET");
 		if (ret)
 			goto err8;
-		ret = gpio_direction_output(GPIO16_VPAC270_CF_RESET, 0);
-		if (ret)
-			goto err9;
 
 		skt->socket.pci_irq = gpio_to_irq(GPIO12_VPAC270_CF_RDY);
 
diff -u -p a/drivers/pcmcia/sa1100_h3600.c b/drivers/pcmcia/sa1100_h3600.c
--- a/drivers/pcmcia/sa1100_h3600.c 2010-11-13 10:26:38.000000000 +0100
+++ b/drivers/pcmcia/sa1100_h3600.c 2011-03-20 22:00:25.000000000 +0100
@@ -30,65 +30,50 @@ static int h3600_pcmcia_hw_init(struct s
 
 	switch (skt->nr) {
 	case 0:
-		err = gpio_request(H3XXX_GPIO_PCMCIA_IRQ0, "PCMCIA IRQ0");
+		err = gpio_request_one(H3XXX_GPIO_PCMCIA_IRQ0, GPIOF_IN,
+				       "PCMCIA IRQ0");
 		if (err)
 			goto err00;
-		err = gpio_direction_input(H3XXX_GPIO_PCMCIA_IRQ0);
-		if (err)
-			goto err01;
 		skt->socket.pci_irq = gpio_to_irq(H3XXX_GPIO_PCMCIA_IRQ0);
 
-		err = gpio_request(H3XXX_GPIO_PCMCIA_CD0, "PCMCIA CD0");
+		err = gpio_request_one(H3XXX_GPIO_PCMCIA_CD0, GPIOF_IN,
+				       "PCMCIA CD0");
 		if (err)
 			goto err01;
-		err = gpio_direction_input(H3XXX_GPIO_PCMCIA_CD0);
-		if (err)
-			goto err02;
 		irqs[0].irq = gpio_to_irq(H3XXX_GPIO_PCMCIA_CD0);
 
-		err = gpio_request(H3XXX_EGPIO_OPT_NVRAM_ON, "OPT NVRAM ON");
+		err = gpio_request_one(H3XXX_EGPIO_OPT_NVRAM_ON,
+				       GPIOF_OUT_INIT_LOW, "OPT NVRAM ON");
 		if (err)
 			goto err02;
-		err = gpio_direction_output(H3XXX_EGPIO_OPT_NVRAM_ON, 0);
+		err = gpio_request_one(H3XXX_EGPIO_OPT_ON,
+				       GPIOF_OUT_INIT_LOW, "OPT ON");
 		if (err)
 			goto err03;
-		err = gpio_request(H3XXX_EGPIO_OPT_ON, "OPT ON");
-		if (err)
-			goto err03;
-		err = gpio_direction_output(H3XXX_EGPIO_OPT_ON, 0);
-		if (err)
-			goto err04;
-		err = gpio_request(H3XXX_EGPIO_OPT_RESET, "OPT RESET");
+		err = gpio_request_one(H3XXX_EGPIO_OPT_RESET,
+				       GPIOF_OUT_INIT_LOW, "OPT RESET");
 		if (err)
 			goto err04;
-		err = gpio_direction_output(H3XXX_EGPIO_OPT_RESET, 0);
+		err = gpio_request_one(H3XXX_EGPIO_CARD_RESET,
+				       GPIOF_OUT_INIT_LOW,
+				       "PCMCIA CARD RESET");
 		if (err)
 			goto err05;
-		err = gpio_request(H3XXX_EGPIO_CARD_RESET, "PCMCIA CARD RESET");
-		if (err)
-			goto err05;
-		err = gpio_direction_output(H3XXX_EGPIO_CARD_RESET, 0);
-		if (err)
-			goto err06;
 		err = soc_pcmcia_request_irqs(skt, irqs, ARRAY_SIZE(irqs));
 		if (err)
 			goto err06;
 		break;
 	case 1:
-		err = gpio_request(H3XXX_GPIO_PCMCIA_IRQ1, "PCMCIA IRQ1");
+		err = gpio_request_one(H3XXX_GPIO_PCMCIA_IRQ1, GPIOF_IN,
+				       "PCMCIA IRQ1");
 		if (err)
 			goto err10;
-		err = gpio_direction_input(H3XXX_GPIO_PCMCIA_IRQ1);
-		if (err)
-			goto err11;
 		skt->socket.pci_irq = gpio_to_irq(H3XXX_GPIO_PCMCIA_IRQ1);
 
-		err = gpio_request(H3XXX_GPIO_PCMCIA_CD1, "PCMCIA CD1");
+		err = gpio_request_one(H3XXX_GPIO_PCMCIA_CD1, GPIOF_IN,
+				       "PCMCIA CD1");
 		if (err)
 			goto err11;
-		err = gpio_direction_input(H3XXX_GPIO_PCMCIA_CD1);
-		if (err)
-			goto err12;
 		irqs[1].irq = gpio_to_irq(H3XXX_GPIO_PCMCIA_CD1);
 
 		err = soc_pcmcia_request_irqs(skt, irqs, ARRAY_SIZE(irqs));
diff -u -p a/drivers/power/bq20z75.c b/drivers/power/bq20z75.c
--- a/drivers/power/bq20z75.c 2011-03-20 18:17:23.000000000 +0100
+++ b/drivers/power/bq20z75.c 2011-03-20 22:00:24.000000000 +0100
@@ -578,21 +578,14 @@ static int __devinit bq20z75_probe(struc
 	if (!bq20z75_device->gpio_detect)
 		goto skip_gpio;
 
-	rc = gpio_request(pdata->battery_detect, dev_name(&client->dev));
+	rc = gpio_request_one(pdata->battery_detect, GPIOF_IN,
+			      dev_name(&client->dev));
 	if (rc) {
 		dev_warn(&client->dev, "Failed to request gpio: %d\n", rc);
 		bq20z75_device->gpio_detect = false;
 		goto skip_gpio;
 	}
 
-	rc = gpio_direction_input(pdata->battery_detect);
-	if (rc) {
-		dev_warn(&client->dev, "Failed to get gpio as input: %d\n", rc);
-		gpio_free(pdata->battery_detect);
-		bq20z75_device->gpio_detect = false;
-		goto skip_gpio;
-	}
-
 	irq = gpio_to_irq(pdata->battery_detect);
 	if (irq <= 0) {
 		dev_warn(&client->dev, "Failed to get gpio as irq: %d\n", irq);
diff -u -p a/drivers/power/gpio-charger.c b/drivers/power/gpio-charger.c
--- a/drivers/power/gpio-charger.c 2010-12-28 18:26:04.000000000 +0100
+++ b/drivers/power/gpio-charger.c 2011-03-20 22:00:24.000000000 +0100
@@ -102,16 +102,11 @@ static int __devinit gpio_charger_probe(
 	charger->supplied_to = pdata->supplied_to;
 	charger->num_supplicants = pdata->num_supplicants;
 
-	ret = gpio_request(pdata->gpio, dev_name(&pdev->dev));
+	ret = gpio_request_one(pdata->gpio, GPIOF_IN, dev_name(&pdev->dev));
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to request gpio pin: %d\n", ret);
 		goto err_free;
 	}
-	ret = gpio_direction_input(pdata->gpio);
-	if (ret) {
-		dev_err(&pdev->dev, "Failed to set gpio to input: %d\n", ret);
-		goto err_gpio_free;
-	}
 
 	gpio_charger->pdata = pdata;
 
diff -u -p a/drivers/power/jz4740-battery.c b/drivers/power/jz4740-battery.c
--- a/drivers/power/jz4740-battery.c 2011-03-14 17:19:16.000000000 +0100
+++ b/drivers/power/jz4740-battery.c 2011-03-20 22:00:24.000000000 +0100
@@ -316,16 +316,12 @@ static int __devinit jz_battery_probe(st
 	disable_irq(jz_battery->irq);
 
 	if (gpio_is_valid(pdata->gpio_charge)) {
-		ret = gpio_request(pdata->gpio_charge, dev_name(&pdev->dev));
+		ret = gpio_request_one(pdata->gpio_charge, GPIOF_IN,
+				       dev_name(&pdev->dev));
 		if (ret) {
 			dev_err(&pdev->dev, "charger state gpio request failed.\n");
 			goto err_free_irq;
 		}
-		ret = gpio_direction_input(pdata->gpio_charge);
-		if (ret) {
-			dev_err(&pdev->dev, "charger state gpio set direction failed.\n");
-			goto err_free_gpio;
-		}
 
 		jz_battery->charge_irq = gpio_to_irq(pdata->gpio_charge);
 
diff -u -p a/drivers/power/wm97xx_battery.c b/drivers/power/wm97xx_battery.c
--- a/drivers/power/wm97xx_battery.c 2010-12-28 18:26:04.000000000 +0100
+++ b/drivers/power/wm97xx_battery.c 2011-03-20 22:00:25.000000000 +0100
@@ -189,12 +189,10 @@ static int __devinit wm97xx_bat_probe(st
 	}
 
 	if (gpio_is_valid(pdata->charge_gpio)) {
-		ret = gpio_request(pdata->charge_gpio, "BATT CHRG");
+		ret = gpio_request_one(pdata->charge_gpio, GPIOF_IN,
+				       "BATT CHRG");
 		if (ret)
 			goto err;
-		ret = gpio_direction_input(pdata->charge_gpio);
-		if (ret)
-			goto err2;
 		ret = request_irq(gpio_to_irq(pdata->charge_gpio),
 				wm97xx_chrg_irq, IRQF_DISABLED,
 				"AC Detect", dev);
diff -u -p a/drivers/power/z2_battery.c b/drivers/power/z2_battery.c
--- a/drivers/power/z2_battery.c 2011-03-20 18:17:23.000000000 +0100
+++ b/drivers/power/z2_battery.c 2011-03-20 22:00:24.000000000 +0100
@@ -207,14 +207,11 @@ static int __devinit z2_batt_probe(struc
 	mutex_init(&charger->work_lock);
 
 	if (info->charge_gpio >= 0 && gpio_is_valid(info->charge_gpio)) {
-		ret = gpio_request(info->charge_gpio, "BATT CHRG");
+		ret = gpio_request_one(info->charge_gpio, GPIOF_IN,
+				       "BATT CHRG");
 		if (ret)
 			goto err;
 
-		ret = gpio_direction_input(info->charge_gpio);
-		if (ret)
-			goto err2;
-
 		set_irq_type(gpio_to_irq(info->charge_gpio),
 				IRQ_TYPE_EDGE_BOTH);
 		ret = request_irq(gpio_to_irq(info->charge_gpio),
diff -u -p a/drivers/staging/cptm1217/clearpad_tm1217.c b/drivers/staging/cptm1217/clearpad_tm1217.c
--- a/drivers/staging/cptm1217/clearpad_tm1217.c 2010-11-24 07:55:12.000000000 +0100
+++ b/drivers/staging/cptm1217/clearpad_tm1217.c 2011-03-20 22:00:24.000000000 +0100
@@ -378,22 +378,13 @@ static int cp_tm1217_setup_gpio_irq(stru
 	int retval;
 
 	/* Hook up the irq handler */
-	retval = gpio_request(ts->gpio, "cp_tm1217_touch");
+	retval = gpio_request_one(ts->gpio, GPIOF_IN, "cp_tm1217_touch");
 	if (retval < 0) {
 		dev_err(ts->dev, "cp_tm1217: GPIO request failed error %d\n",
 								retval);
 		return retval;
 	}
 
-	retval = gpio_direction_input(ts->gpio);
-	if (retval < 0) {
-		dev_err(ts->dev,
-		"cp_tm1217: GPIO direction configuration failed, error %d\n",
-								retval);
-		gpio_free(ts->gpio);
-		return retval;
-	}
-
 	retval = gpio_to_irq(ts->gpio);
 	if (retval < 0) {
 		dev_err(ts->dev, "cp_tm1217: GPIO to IRQ failedi,"
diff -u -p a/drivers/staging/iio/magnetometer/ak8975.c b/drivers/staging/iio/magnetometer/ak8975.c
--- a/drivers/staging/iio/magnetometer/ak8975.c 2010-09-18 08:59:06.000000000 +0200
+++ b/drivers/staging/iio/magnetometer/ak8975.c 2011-03-20 22:00:24.000000000 +0100
@@ -460,20 +460,13 @@ static int ak8975_probe(struct i2c_clien
 		goto exit_free;
 	}
 
-	err = gpio_request(data->eoc_gpio, "ak_8975");
+	err = gpio_request_one(data->eoc_gpio, GPIOF_IN, "ak_8975");
 	if (err < 0) {
 		dev_err(&client->dev, "failed to request GPIO %d, error %d\n",
 			data->eoc_gpio, err);
 		goto exit_free;
 	}
 
-	err = gpio_direction_input(data->eoc_gpio);
-	if (err < 0) {
-		dev_err(&client->dev, "Failed to configure input direction for"
-			" GPIO %d, error %d\n", data->eoc_gpio, err);
-		goto exit_gpio;
-	}
-
 	/* Perform some basic start-of-day setup of the device. */
 	err = ak8975_setup(client);
 	if (err < 0) {
diff -u -p a/drivers/video/backlight/l4f00242t03.c b/drivers/video/backlight/l4f00242t03.c
--- a/drivers/video/backlight/l4f00242t03.c 2011-01-19 18:51:19.000000000 +0100
+++ b/drivers/video/backlight/l4f00242t03.c 2011-03-20 22:00:21.000000000 +0100
@@ -178,29 +178,22 @@ static int __devinit l4f00242t03_probe(s
 
 	priv->spi = spi;
 
-	ret = gpio_request(pdata->reset_gpio, "lcd l4f00242t03 reset");
+	ret = gpio_request_one(pdata->reset_gpio, GPIOF_OUT_INIT_HIGH,
+			       "lcd l4f00242t03 reset");
 	if (ret) {
 		dev_err(&spi->dev,
 			"Unable to get the lcd l4f00242t03 reset gpio.\n");
 		goto err;
 	}
 
-	ret = gpio_direction_output(pdata->reset_gpio, 1);
-	if (ret)
-		goto err2;
-
-	ret = gpio_request(pdata->data_enable_gpio,
-				"lcd l4f00242t03 data enable");
+	ret = gpio_request_one(pdata->data_enable_gpio, GPIOF_OUT_INIT_LOW,
+			       "lcd l4f00242t03 data enable");
 	if (ret) {
 		dev_err(&spi->dev,
 			"Unable to get the lcd l4f00242t03 data en gpio.\n");
 		goto err2;
 	}
 
-	ret = gpio_direction_output(pdata->data_enable_gpio, 0);
-	if (ret)
-		goto err3;
-
 	if (pdata->io_supply) {
 		priv->io_reg = regulator_get(NULL, pdata->io_supply);
 
diff -u -p a/drivers/video/backlight/tosa_bl.c b/drivers/video/backlight/tosa_bl.c
--- a/drivers/video/backlight/tosa_bl.c 2010-06-04 16:56:16.000000000 +0200
+++ b/drivers/video/backlight/tosa_bl.c 2011-03-20 22:00:21.000000000 +0100
@@ -89,14 +89,12 @@ static int __devinit tosa_bl_probe(struc
 
 	data->comadj = sharpsl_param.comadj == -1 ? COMADJ_DEFAULT : sharpsl_param.comadj;
 
-	ret = gpio_request(TOSA_GPIO_BL_C20MA, "backlight");
+	ret = gpio_request_one(TOSA_GPIO_BL_C20MA, GPIOF_OUT_INIT_LOW,
+			       "backlight");
 	if (ret) {
 		dev_dbg(&data->bl->dev, "Unable to request gpio!\n");
 		goto err_gpio_bl;
 	}
-	ret = gpio_direction_output(TOSA_GPIO_BL_C20MA, 0);
-	if (ret)
-		goto err_gpio_dir;
 
 	i2c_set_clientdata(client, data);
 	data->i2c = client;
diff -u -p a/drivers/video/backlight/tosa_lcd.c b/drivers/video/backlight/tosa_lcd.c
--- a/drivers/video/backlight/tosa_lcd.c 2010-03-29 19:27:58.000000000 +0200
+++ b/drivers/video/backlight/tosa_lcd.c 2011-03-20 22:00:21.000000000 +0100
@@ -192,16 +192,12 @@ static int __devinit tosa_lcd_probe(stru
 	data->spi = spi;
 	dev_set_drvdata(&spi->dev, data);
 
-	ret = gpio_request(TOSA_GPIO_TG_ON, "tg #pwr");
+	ret = gpio_request_one(TOSA_GPIO_TG_ON, GPIOF_OUT_INIT_LOW, "tg #pwr");
 	if (ret < 0)
 		goto err_gpio_tg;
 
 	mdelay(60);
 
-	ret = gpio_direction_output(TOSA_GPIO_TG_ON, 0);
-	if (ret < 0)
-		goto err_gpio_dir;
-
 	mdelay(60);
 	tosa_lcd_tg_init(data);
 
diff -u -p a/drivers/video/msm/mddi_client_nt35399.c b/drivers/video/msm/mddi_client_nt35399.c
--- a/drivers/video/msm/mddi_client_nt35399.c 2010-03-29 19:27:59.000000000 +0200
+++ b/drivers/video/msm/mddi_client_nt35399.c 2011-03-20 22:00:26.000000000 +0100
@@ -155,14 +155,10 @@ static int setup_vsync(struct panel_info
 		ret = 0;
 		goto uninit;
 	}
-	ret = gpio_request(gpio, "vsync");
+	ret = gpio_request_one(gpio, GPIOF_IN, "vsync");
 	if (ret)
 		goto err_request_gpio_failed;
 
-	ret = gpio_direction_input(gpio);
-	if (ret)
-		goto err_gpio_direction_input_failed;
-
 	ret = irq = gpio_to_irq(gpio);
 	if (ret < 0)
 		goto err_get_irq_num_failed;
diff -u -p a/drivers/video/msm/mddi_client_toshiba.c b/drivers/video/msm/mddi_client_toshiba.c
--- a/drivers/video/msm/mddi_client_toshiba.c 2010-03-29 19:27:59.000000000 +0200
+++ b/drivers/video/msm/mddi_client_toshiba.c 2011-03-20 22:00:26.000000000 +0100
@@ -186,14 +186,10 @@ static int setup_vsync(struct panel_info
 		ret = 0;
 		goto uninit;
 	}
-	ret = gpio_request(gpio, "vsync");
+	ret = gpio_request_one(gpio, GPIOF_IN, "vsync");
 	if (ret)
 		goto err_request_gpio_failed;
 
-	ret = gpio_direction_input(gpio);
-	if (ret)
-		goto err_gpio_direction_input_failed;
-
 	ret = irq = gpio_to_irq(gpio);
 	if (ret < 0)
 		goto err_get_irq_num_failed;
diff -u -p a/drivers/video/omap2/displays/panel-tpo-td043mtea1.c b/drivers/video/omap2/displays/panel-tpo-td043mtea1.c
--- a/drivers/video/omap2/displays/panel-tpo-td043mtea1.c 2010-10-23 19:40:32.000000000 +0200
+++ b/drivers/video/omap2/displays/panel-tpo-td043mtea1.c 2011-03-20 22:00:26.000000000 +0100
@@ -406,17 +406,12 @@ static int tpo_td043_probe(struct omap_d
 	}
 
 	if (gpio_is_valid(nreset_gpio)) {
-		ret = gpio_request(nreset_gpio, "lcd reset");
+		ret = gpio_request_one(nreset_gpio, GPIOF_OUT_INIT_LOW,
+				       "lcd reset");
 		if (ret < 0) {
 			dev_err(&dssdev->dev, "couldn't request reset GPIO\n");
 			goto fail_gpio_req;
 		}
-
-		ret = gpio_direction_output(nreset_gpio, 0);
-		if (ret < 0) {
-			dev_err(&dssdev->dev, "couldn't set GPIO direction\n");
-			goto fail_gpio_direction;
-		}
 	}
 
 	ret = sysfs_create_group(&dssdev->dev.kobj, &tpo_td043_attr_group);
diff -u -p a/drivers/watchdog/wm831x_wdt.c b/drivers/watchdog/wm831x_wdt.c
--- a/drivers/watchdog/wm831x_wdt.c 2010-03-05 23:55:32.000000000 +0100
+++ b/drivers/watchdog/wm831x_wdt.c 2011-03-20 22:00:25.000000000 +0100
@@ -350,8 +350,9 @@ static int __devinit wm831x_wdt_probe(st
 		reg |= pdata->software << WM831X_WDOG_RST_SRC_SHIFT;
 
 		if (pdata->update_gpio) {
-			ret = gpio_request(pdata->update_gpio,
-					   "Watchdog update");
+			ret = gpio_request_one(pdata->update_gpio,
+					       GPIOF_OUT_INIT_LOW,
+					       "Watchdog update");
 			if (ret < 0) {
 				dev_err(wm831x->dev,
 					"Failed to request update GPIO: %d\n",
@@ -359,14 +360,6 @@ static int __devinit wm831x_wdt_probe(st
 				goto err;
 			}
 
-			ret = gpio_direction_output(pdata->update_gpio, 0);
-			if (ret != 0) {
-				dev_err(wm831x->dev,
-					"gpio_direction_output returned: %d\n",
-					ret);
-				goto err_gpio;
-			}
-
 			update_gpio = pdata->update_gpio;
 
 			/* Make sure the watchdog takes hardware updates */
diff -u -p a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
--- a/sound/soc/codecs/twl6040.c 2011-02-02 17:27:40.000000000 +0100
+++ b/sound/soc/codecs/twl6040.c 2011-03-20 22:00:23.000000000 +0100
@@ -1641,14 +1641,11 @@ static int twl6040_probe(struct snd_soc_
 	init_completion(&priv->handsfree.ramp_done);
 
 	if (gpio_is_valid(audpwron)) {
-		ret = gpio_request(audpwron, "audpwron");
+		ret = gpio_request_one(audpwron, GPIOF_OUT_INIT_LOW,
+				       "audpwron");
 		if (ret)
 			goto gpio1_err;
 
-		ret = gpio_direction_output(audpwron, 0);
-		if (ret)
-			goto gpio2_err;
-
 		priv->codec_powered = 0;
 
 		/* enable only codec ready interrupt */
diff -u -p a/sound/soc/codecs/uda1380.c b/sound/soc/codecs/uda1380.c
--- a/sound/soc/codecs/uda1380.c 2010-12-31 15:18:31.000000000 +0100
+++ b/sound/soc/codecs/uda1380.c 2011-03-20 22:00:24.000000000 +0100
@@ -732,21 +732,17 @@ static int uda1380_probe(struct snd_soc_
 		return -EINVAL;
 
 	if (gpio_is_valid(pdata->gpio_reset)) {
-		ret = gpio_request(pdata->gpio_reset, "uda1380 reset");
+		ret = gpio_request_one(pdata->gpio_reset, GPIOF_OUT_INIT_LOW,
+				       "uda1380 reset");
 		if (ret)
 			goto err_out;
-		ret = gpio_direction_output(pdata->gpio_reset, 0);
-		if (ret)
-			goto err_gpio_reset_conf;
 	}
 
 	if (gpio_is_valid(pdata->gpio_power)) {
-		ret = gpio_request(pdata->gpio_power, "uda1380 power");
+		ret = gpio_request_one(pdata->gpio_power, GPIOF_OUT_INIT_LOW,
+				       "uda1380 power");
 		if (ret)
 			goto err_gpio;
-		ret = gpio_direction_output(pdata->gpio_power, 0);
-		if (ret)
-			goto err_gpio_power_conf;
 	} else {
 		ret = uda1380_reset(codec);
 		if (ret) {
diff -u -p a/sound/soc/omap/omap3pandora.c b/sound/soc/omap/omap3pandora.c
--- a/sound/soc/omap/omap3pandora.c 2010-12-04 18:54:36.000000000 +0100
+++ b/sound/soc/omap/omap3pandora.c 2011-03-20 22:00:22.000000000 +0100
@@ -263,30 +263,20 @@ static int __init omap3pandora_soc_init(
 
 	pr_info("OMAP3 Pandora SoC init\n");
 
-	ret = gpio_request(OMAP3_PANDORA_DAC_POWER_GPIO, "dac_power");
+	ret = gpio_request_one(OMAP3_PANDORA_DAC_POWER_GPIO,
+			       GPIOF_OUT_INIT_LOW, "dac_power");
 	if (ret) {
 		pr_err(PREFIX "Failed to get DAC power GPIO\n");
 		return ret;
 	}
 
-	ret = gpio_direction_output(OMAP3_PANDORA_DAC_POWER_GPIO, 0);
-	if (ret) {
-		pr_err(PREFIX "Failed to set DAC power GPIO direction\n");
-		goto fail0;
-	}
-
-	ret = gpio_request(OMAP3_PANDORA_AMP_POWER_GPIO, "amp_power");
+	ret = gpio_request_one(OMAP3_PANDORA_AMP_POWER_GPIO,
+			       GPIOF_OUT_INIT_LOW, "amp_power");
 	if (ret) {
 		pr_err(PREFIX "Failed to get amp power GPIO\n");
 		goto fail0;
 	}
 
-	ret = gpio_direction_output(OMAP3_PANDORA_AMP_POWER_GPIO, 0);
-	if (ret) {
-		pr_err(PREFIX "Failed to set amp power GPIO direction\n");
-		goto fail1;
-	}
-
 	omap3pandora_snd_device = platform_device_alloc("soc-audio", -1);
 	if (omap3pandora_snd_device == NULL) {
 		pr_err(PREFIX "Platform device allocation failed\n");
diff -u -p a/sound/soc/pxa/e740_wm9705.c b/sound/soc/pxa/e740_wm9705.c
--- a/sound/soc/pxa/e740_wm9705.c 2011-03-14 17:19:19.000000000 +0100
+++ b/sound/soc/pxa/e740_wm9705.c 2011-03-20 22:00:22.000000000 +0100
@@ -148,29 +148,21 @@ static int __init e740_init(void)
 	if (!machine_is_e740())
 		return -ENODEV;
 
-	ret = gpio_request(GPIO_E740_MIC_ON,  "Mic amp");
+	ret = gpio_request_one(GPIO_E740_MIC_ON, GPIOF_OUT_INIT_LOW,
+			       "Mic amp");
 	if (ret)
 		return ret;
 
-	ret = gpio_request(GPIO_E740_AMP_ON, "Output amp");
+	ret = gpio_request_one(GPIO_E740_AMP_ON, GPIOF_OUT_INIT_LOW,
+			       "Output amp");
 	if (ret)
 		goto free_mic_amp_gpio;
 
-	ret = gpio_request(GPIO_E740_WM9705_nAVDD2, "Audio power");
+	ret = gpio_request_one(GPIO_E740_WM9705_nAVDD2, GPIOF_OUT_INIT_HIGH,
+			       "Audio power");
 	if (ret)
 		goto free_op_amp_gpio;
 
-	/* Disable audio */
-	ret = gpio_direction_output(GPIO_E740_MIC_ON, 0);
-	if (ret)
-		goto free_apwr_gpio;
-	ret = gpio_direction_output(GPIO_E740_AMP_ON, 0);
-	if (ret)
-		goto free_apwr_gpio;
-	ret = gpio_direction_output(GPIO_E740_WM9705_nAVDD2, 1);
-	if (ret)
-		goto free_apwr_gpio;
-
 	e740_snd_device = platform_device_alloc("soc-audio", -1);
 	if (!e740_snd_device) {
 		ret = -ENOMEM;
diff -u -p a/sound/soc/pxa/e750_wm9705.c b/sound/soc/pxa/e750_wm9705.c
--- a/sound/soc/pxa/e750_wm9705.c 2011-03-14 17:19:19.000000000 +0100
+++ b/sound/soc/pxa/e750_wm9705.c 2011-03-20 22:00:22.000000000 +0100
@@ -131,22 +131,16 @@ static int __init e750_init(void)
 	if (!machine_is_e750())
 		return -ENODEV;
 
-	ret = gpio_request(GPIO_E750_HP_AMP_OFF,  "Headphone amp");
+	ret = gpio_request_one(GPIO_E750_HP_AMP_OFF, GPIOF_OUT_INIT_HIGH,
+			       "Headphone amp");
 	if (ret)
 		return ret;
 
-	ret = gpio_request(GPIO_E750_SPK_AMP_OFF, "Speaker amp");
+	ret = gpio_request_one(GPIO_E750_SPK_AMP_OFF, GPIOF_OUT_INIT_HIGH,
+			       "Speaker amp");
 	if (ret)
 		goto free_hp_amp_gpio;
 
-	ret = gpio_direction_output(GPIO_E750_HP_AMP_OFF, 1);
-	if (ret)
-		goto free_spk_amp_gpio;
-
-	ret = gpio_direction_output(GPIO_E750_SPK_AMP_OFF, 1);
-	if (ret)
-		goto free_spk_amp_gpio;
-
 	e750_snd_device = platform_device_alloc("soc-audio", -1);
 	if (!e750_snd_device) {
 		ret = -ENOMEM;
diff -u -p a/sound/soc/pxa/e800_wm9712.c b/sound/soc/pxa/e800_wm9712.c
--- a/sound/soc/pxa/e800_wm9712.c 2011-03-14 17:19:19.000000000 +0100
+++ b/sound/soc/pxa/e800_wm9712.c 2011-03-20 22:00:22.000000000 +0100
@@ -120,22 +120,16 @@ static int __init e800_init(void)
 	if (!machine_is_e800())
 		return -ENODEV;
 
-	ret = gpio_request(GPIO_E800_HP_AMP_OFF,  "Headphone amp");
+	ret = gpio_request_one(GPIO_E800_HP_AMP_OFF, GPIOF_OUT_INIT_HIGH,
+			       "Headphone amp");
 	if (ret)
 		return ret;
 
-	ret = gpio_request(GPIO_E800_SPK_AMP_ON, "Speaker amp");
+	ret = gpio_request_one(GPIO_E800_SPK_AMP_ON, GPIOF_OUT_INIT_HIGH,
+			       "Speaker amp");
 	if (ret)
 		goto free_hp_amp_gpio;
 
-	ret = gpio_direction_output(GPIO_E800_HP_AMP_OFF, 1);
-	if (ret)
-		goto free_spk_amp_gpio;
-
-	ret = gpio_direction_output(GPIO_E800_SPK_AMP_ON, 1);
-	if (ret)
-		goto free_spk_amp_gpio;
-
 	e800_snd_device = platform_device_alloc("soc-audio", -1);
 	if (!e800_snd_device)
 		return -ENOMEM;
diff -u -p a/sound/soc/pxa/tosa.c b/sound/soc/pxa/tosa.c
--- a/sound/soc/pxa/tosa.c 2011-03-14 17:19:19.000000000 +0100
+++ b/sound/soc/pxa/tosa.c 2011-03-20 22:00:22.000000000 +0100
@@ -241,12 +241,10 @@ static int tosa_probe(struct snd_soc_car
 {
 	int ret;
 
-	ret = gpio_request(TOSA_GPIO_L_MUTE, "Headphone Jack");
+	ret = gpio_request_one(TOSA_GPIO_L_MUTE, GPIOF_OUT_INIT_LOW,
+			       "Headphone Jack");
 	if (ret)
 		return ret;
-	ret = gpio_direction_output(TOSA_GPIO_L_MUTE, 0);
-	if (ret)
-		gpio_free(TOSA_GPIO_L_MUTE);
 
 	return ret;
 }
diff -u -p a/sound/soc/samsung/h1940_uda1380.c b/sound/soc/samsung/h1940_uda1380.c
--- a/sound/soc/samsung/h1940_uda1380.c 2011-01-24 08:53:37.000000000 +0100
+++ b/sound/soc/samsung/h1940_uda1380.c 2011-03-20 22:00:24.000000000 +0100
@@ -239,14 +239,11 @@ static int __init h1940_init(void)
 		return -ENODEV;
 
 	/* configure some gpios */
-	ret = gpio_request(H1940_LATCH_AUDIO_POWER, "speaker-power");
+	ret = gpio_request_one(H1940_LATCH_AUDIO_POWER, GPIOF_OUT_INIT_LOW,
+			       "speaker-power");
 	if (ret)
 		goto err_out;
 
-	ret = gpio_direction_output(H1940_LATCH_AUDIO_POWER, 0);
-	if (ret)
-		goto err_gpio;
-
 	s3c24xx_snd_device = platform_device_alloc("soc-audio", -1);
 	if (!s3c24xx_snd_device) {
 		ret = -ENOMEM;
diff -u -p a/sound/soc/samsung/rx1950_uda1380.c b/sound/soc/samsung/rx1950_uda1380.c
--- a/sound/soc/samsung/rx1950_uda1380.c 2011-01-24 08:53:37.000000000 +0100
+++ b/sound/soc/samsung/rx1950_uda1380.c 2011-03-20 22:00:24.000000000 +0100
@@ -259,14 +259,11 @@ static int __init rx1950_init(void)
 		return -ENODEV;
 
 	/* configure some gpios */
-	ret = gpio_request(S3C2410_GPA(1), "speaker-power");
+	ret = gpio_request_one(S3C2410_GPA(1), GPIOF_OUT_INIT_LOW,
+			       "speaker-power");
 	if (ret)
 		goto err_gpio;
 
-	ret = gpio_direction_output(S3C2410_GPA(1), 0);
-	if (ret)
-		goto err_gpio_conf;
-
 	s3c24xx_snd_device = platform_device_alloc("soc-audio", -1);
 	if (!s3c24xx_snd_device) {
 		ret = -ENOMEM;
diff -u -p a/sound/soc/samsung/smartq_wm8987.c b/sound/soc/samsung/smartq_wm8987.c
--- a/sound/soc/samsung/smartq_wm8987.c 2011-01-24 08:53:37.000000000 +0100
+++ b/sound/soc/samsung/smartq_wm8987.c 2011-03-20 22:00:24.000000000 +0100
@@ -243,19 +243,13 @@ static int __init smartq_init(void)
 	}
 
 	/* Initialise GPIOs used by amplifiers */
-	ret = gpio_request(S3C64XX_GPK(12), "amplifiers shutdown");
+	ret = gpio_request_one(S3C64XX_GPK(12), GPIOF_OUT_INIT_HIGH,
+			       "amplifiers shutdown");
 	if (ret) {
 		dev_err(&smartq_snd_device->dev, "Failed to register GPK12\n");
 		goto err_unregister_device;
 	}
 
-	/* Disable amplifiers */
-	ret = gpio_direction_output(S3C64XX_GPK(12), 1);
-	if (ret) {
-		dev_err(&smartq_snd_device->dev, "Failed to configure GPK12\n");
-		goto err_free_gpio_amp_shut;
-	}
-
 	return 0;
 
 err_free_gpio_amp_shut:
diff -u -p a/sound/soc/soc-jack.c b/sound/soc/soc-jack.c
--- a/sound/soc/soc-jack.c 2011-03-14 17:19:19.000000000 +0100
+++ b/sound/soc/soc-jack.c 2011-03-20 22:00:25.000000000 +0100
@@ -310,14 +310,10 @@ int snd_soc_jack_add_gpios(struct snd_so
 			goto undo;
 		}
 
-		ret = gpio_request(gpios[i].gpio, gpios[i].name);
+		ret = gpio_request_one(gpios[i].gpio, GPIOF_IN, gpios[i].name);
 		if (ret)
 			goto undo;
 
-		ret = gpio_direction_input(gpios[i].gpio);
-		if (ret)
-			goto err;
-
 		INIT_DELAYED_WORK(&gpios[i].work, gpio_work);
 		gpios[i].jack = jack;
 
