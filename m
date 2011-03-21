From: julia@diku.dk (Julia Lawall)
Date: Mon, 21 Mar 2011 08:59:52 +0100 (CET)
Subject: [PATCH 2/2] ARM: mx5/mx53_evk: Remove unneeded gpio_set_value call
In-Reply-To: <AANLkTinponAhPonKeZ9rE1boqJEsVqyvBLKfHCt84Shm@mail.gmail.com>
References: <1300126869-14587-1-git-send-email-fabio.estevam@freescale.com>
	<1300126869-14587-2-git-send-email-fabio.estevam@freescale.com>
	<20110315090656.GC13316@pengutronix.de>
	<Pine.LNX.4.64.1103151039030.11859@ask.diku.dk>
	<20110315094946.GD13316@pengutronix.de>
	<Pine.LNX.4.64.1103151113420.8560@pc-004.diku.dk>
	<20110316083326.GF13316@pengutronix.de>
	<Pine.LNX.4.64.1103201850250.27008@ask.diku.dk>
	<20110320192451.GA19808@pengutronix.de>
	<Pine.LNX.4.64.1103202201060.27008@ask.diku.dk>
	<AANLkTinponAhPonKeZ9rE1boqJEsVqyvBLKfHCt84Shm@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.1103210855560.4323@ask.diku.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 21 Mar 2011, Grant Likely wrote:

> On Sun, Mar 20, 2011 at 3:04 PM, Julia Lawall <julia@diku.dk> wrote:
> > In this case, I also ignore the !GPIOLIB issue. ?This semantic patch
> > considers the case where the direction call has some error handling code.
> > In this case, it just deletes that error handling code, so most of these
> > cases are likely to need some manual cleanup, eg to get rid of unreachable
> > error labels or to change the error message.
> >
> [...]
> > diff -u -p a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
> > --- a/arch/arm/mach-omap2/board-4430sdp.c 2011-03-20 18:17:22.000000000 +0100
> > +++ b/arch/arm/mach-omap2/board-4430sdp.c 2011-03-20 22:00:22.000000000 +0100
> > @@ -257,44 +257,26 @@ static int omap_ethernet_init(void)
> >
> > ? ? ? ?/* Request of GPIO lines */
> >
> > - ? ? ? status = gpio_request(ETH_KS8851_POWER_ON, "eth_power");
> > + ? ? ? status = gpio_request_one(ETH_KS8851_POWER_ON, GPIOF_OUT_INIT_HIGH,
> > + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? "eth_power");
> > ? ? ? ?if (status) {
> > ? ? ? ? ? ? ? ?pr_err("Cannot request GPIO %d\n", ETH_KS8851_POWER_ON);
> > ? ? ? ? ? ? ? ?return status;
> > ? ? ? ?}
> >
> > - ? ? ? status = gpio_request(ETH_KS8851_QUART, "quart");
> > + ? ? ? status = gpio_request_one(ETH_KS8851_QUART, GPIOF_OUT_INIT_HIGH,
> > + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? "quart");
> > ? ? ? ?if (status) {
> > ? ? ? ? ? ? ? ?pr_err("Cannot request GPIO %d\n", ETH_KS8851_QUART);
> > ? ? ? ? ? ? ? ?goto error1;
> > ? ? ? ?}
> >
> > - ? ? ? status = gpio_request(ETH_KS8851_IRQ, "eth_irq");
> > + ? ? ? status = gpio_request_one(ETH_KS8851_IRQ, GPIOF_IN, "eth_irq");
> > ? ? ? ?if (status) {
> > ? ? ? ? ? ? ? ?pr_err("Cannot request GPIO %d\n", ETH_KS8851_IRQ);
> > ? ? ? ? ? ? ? ?goto error2;
> > ? ? ? ?}
> >
> > - ? ? ? /* Configuration of requested GPIO lines */
> > -
> > - ? ? ? status = gpio_direction_output(ETH_KS8851_POWER_ON, 1);
> > - ? ? ? if (status) {
> > - ? ? ? ? ? ? ? pr_err("Cannot set output GPIO %d\n", ETH_KS8851_IRQ);
> > - ? ? ? ? ? ? ? goto error3;
> > - ? ? ? }
> > -
> > - ? ? ? status = gpio_direction_output(ETH_KS8851_QUART, 1);
> > - ? ? ? if (status) {
> > - ? ? ? ? ? ? ? pr_err("Cannot set output GPIO %d\n", ETH_KS8851_QUART);
> > - ? ? ? ? ? ? ? goto error3;
> > - ? ? ? }
> > -
> > - ? ? ? status = gpio_direction_input(ETH_KS8851_IRQ);
> > - ? ? ? if (status) {
> > - ? ? ? ? ? ? ? pr_err("Cannot set input GPIO %d\n", ETH_KS8851_IRQ);
> > - ? ? ? ? ? ? ? goto error3;
> > - ? ? ? }
> > -
> > ? ? ? ?return 0;
> 
> This hunk is probably wrong.  If gpio pins are being requested, it is
> important to verify that all gpios have been requested successfully
> before actively changing the state on any of them.  This hunk changes
> the behaviour.

Thanks for the feedback.  I can also check that there is no call to 
gpio_request or either of the direction functions between the call to 
gpio_request and the call to the direction function to transform.  The 
semantic patch and the result for the case where there is no error 
handling on the direction function are below.

On the other hand, the constraint that everything should be requested 
before initialization is not always respected, eg:

arch/arm/mach-mx3/mx31moboard-smartbot.c

Perhaps code like this should be changed to move up the requests?

julia

@@
expression E1,E2;
@@

-      gpio_request(E1,E2)
+      gpio_request_one(E1,GPIOF_IN,E2)
       ... when != E1
           when != gpio_request(...)
           when != gpio_direction_output(...)
           when != gpio_direction_input(...)
-      gpio_direction_input(E1);


@@
expression E1,E2;
@@

-      gpio_request(E1,E2)
+      gpio_request_one(E1,GPIOF_OUT_INIT_LOW,E2)
       ... when != E1
           when != gpio_request(...)
           when != gpio_direction_output(...)
           when != gpio_direction_input(...)
-      gpio_direction_output(E1,0);

@@
expression E1,E2;
@@

-      gpio_request(E1,E2)
+      gpio_request_one(E1,GPIOF_OUT_INIT_HIGH,E2)
       ... when != E1
           when != gpio_request(...)
           when != gpio_direction_output(...)
           when != gpio_direction_input(...)
-      gpio_direction_output(E1,1);

----------------------------------

diff -u -p a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
--- a/arch/arm/mach-davinci/board-da830-evm.c 2011-03-14 17:19:13.000000000 +0100
+++ b/arch/arm/mach-davinci/board-da830-evm.c 2011-03-21 08:55:21.000000000 +0100
@@ -163,21 +163,20 @@ static __init void da830_evm_usb_init(vo
 		return;
 	}
 
-	ret = gpio_request(ON_BD_USB_DRV, "ON_BD_USB_DRV");
+	ret = gpio_request_one(ON_BD_USB_DRV, GPIOF_OUT_INIT_LOW,
+			       "ON_BD_USB_DRV");
 	if (ret) {
 		printk(KERN_ERR "%s: failed to request GPIO for USB 1.1 port "
 		       "power control: %d\n", __func__, ret);
 		return;
 	}
-	gpio_direction_output(ON_BD_USB_DRV, 0);
 
-	ret = gpio_request(ON_BD_USB_OVC, "ON_BD_USB_OVC");
+	ret = gpio_request_one(ON_BD_USB_OVC, GPIOF_IN, "ON_BD_USB_OVC");
 	if (ret) {
 		printk(KERN_ERR "%s: failed to request GPIO for USB 1.1 port "
 		       "over-current indicator: %d\n", __func__, ret);
 		return;
 	}
-	gpio_direction_input(ON_BD_USB_OVC);
 
 	ret = da8xx_register_usb11(&da830_evm_usb11_pdata);
 	if (ret)
@@ -260,21 +259,19 @@ static inline void da830_evm_init_mmc(vo
 		return;
 	}
 
-	ret = gpio_request(DA830_MMCSD_WP_PIN, "MMC WP");
+	ret = gpio_request_one(DA830_MMCSD_WP_PIN, GPIOF_IN, "MMC WP");
 	if (ret) {
 		pr_warning("da830_evm_init: can not open GPIO %d\n",
 			   DA830_MMCSD_WP_PIN);
 		return;
 	}
-	gpio_direction_input(DA830_MMCSD_WP_PIN);
 
-	ret = gpio_request(DA830_MMCSD_CD_PIN, "MMC CD\n");
+	ret = gpio_request_one(DA830_MMCSD_CD_PIN, GPIOF_IN, "MMC CD\n");
 	if (ret) {
 		pr_warning("da830_evm_init: can not open GPIO %d\n",
 			   DA830_MMCSD_CD_PIN);
 		return;
 	}
-	gpio_direction_input(DA830_MMCSD_CD_PIN);
 
 	ret = da8xx_register_mmcsd0(&da830_evm_mmc_config);
 	if (ret) {
@@ -463,10 +460,7 @@ static struct at24_platform_data da830_e
 static int __init da830_evm_ui_expander_setup(struct i2c_client *client,
 		int gpio, unsigned ngpio, void *context)
 {
-	gpio_request(gpio + 6, "UI MUX_MODE");
-
-	/* Drive mux mode low to match the default without UI card */
-	gpio_direction_output(gpio + 6, 0);
+	gpio_request_one(gpio + 6, GPIOF_OUT_INIT_LOW, "UI MUX_MODE");
 
 	da830_evm_init_lcdc(gpio + 6);
 
diff -u -p a/arch/arm/mach-davinci/board-dm355-evm.c b/arch/arm/mach-davinci/board-dm355-evm.c
--- a/arch/arm/mach-davinci/board-dm355-evm.c 2010-10-23 19:40:31.000000000 +0200
+++ b/arch/arm/mach-davinci/board-dm355-evm.c 2011-03-21 08:55:21.000000000 +0100
@@ -142,8 +142,7 @@ static void __init evm_init_i2c(void)
 {
 	davinci_init_i2c(&i2c_pdata);
 
-	gpio_request(5, "dm355evm_msp");
-	gpio_direction_input(5);
+	gpio_request_one(5, GPIOF_IN, "dm355evm_msp");
 	dm355evm_i2c_info[0].irq = gpio_to_irq(5);
 
 	i2c_register_board_info(1, dm355evm_i2c_info,
@@ -315,8 +314,7 @@ static __init void dm355_evm_init(void)
 {
 	struct clk *aemif;
 
-	gpio_request(1, "dm9000");
-	gpio_direction_input(1);
+	gpio_request_one(1, GPIOF_IN, "dm9000");
 	dm355evm_dm9000_rsrc[2].start = gpio_to_irq(1);
 
 	aemif = clk_get(&dm355evm_dm9000.dev, "aemif");
diff -u -p a/arch/arm/mach-davinci/board-dm355-leopard.c b/arch/arm/mach-davinci/board-dm355-leopard.c
--- a/arch/arm/mach-davinci/board-dm355-leopard.c 2010-10-23 19:40:31.000000000 +0200
+++ b/arch/arm/mach-davinci/board-dm355-leopard.c 2011-03-21 08:55:21.000000000 +0100
@@ -134,8 +134,7 @@ static void __init leopard_init_i2c(void
 {
 	davinci_init_i2c(&i2c_pdata);
 
-	gpio_request(5, "dm355leopard_msp");
-	gpio_direction_input(5);
+	gpio_request_one(5, GPIOF_IN, "dm355leopard_msp");
 	dm355leopard_i2c_info[0].irq = gpio_to_irq(5);
 
 	i2c_register_board_info(1, dm355leopard_i2c_info,
@@ -237,8 +236,7 @@ static __init void dm355_leopard_init(vo
 {
 	struct clk *aemif;
 
-	gpio_request(9, "dm9000");
-	gpio_direction_input(9);
+	gpio_request_one(9, GPIOF_IN, "dm9000");
 	dm355leopard_dm9000_rsrc[2].start = gpio_to_irq(9);
 
 	aemif = clk_get(&dm355leopard_dm9000.dev, "aemif");
diff -u -p a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
--- a/arch/arm/mach-davinci/board-dm644x-evm.c 2011-03-20 18:17:22.000000000 +0100
+++ b/arch/arm/mach-davinci/board-dm644x-evm.c 2011-03-21 08:55:27.000000000 +0100
@@ -371,14 +371,11 @@ evm_u18_setup(struct i2c_client *client,
 		sw_gpio = -EINVAL;
 
 	/* audio PLL:  48 kHz (vs 44.1 or 32), single rate (vs double) */
-	gpio_request(gpio + 3, "pll_fs2");
-	gpio_direction_output(gpio + 3, 0);
+	gpio_request_one(gpio + 3, GPIOF_OUT_INIT_LOW, "pll_fs2");
 
-	gpio_request(gpio + 2, "pll_fs1");
-	gpio_direction_output(gpio + 2, 0);
+	gpio_request_one(gpio + 2, GPIOF_OUT_INIT_LOW, "pll_fs1");
 
-	gpio_request(gpio + 1, "pll_sr");
-	gpio_direction_output(gpio + 1, 0);
+	gpio_request_one(gpio + 1, GPIOF_OUT_INIT_LOW, "pll_sr");
 
 	return 0;
 }
@@ -411,34 +408,27 @@ static int
 evm_u35_setup(struct i2c_client *client, int gpio, unsigned ngpio, void *c)
 {
 	/* p0 = nDRV_VBUS (initial:  don't supply it) */
-	gpio_request(gpio + 0, "nDRV_VBUS");
-	gpio_direction_output(gpio + 0, 1);
+	gpio_request_one(gpio + 0, GPIOF_OUT_INIT_HIGH, "nDRV_VBUS");
 
 	/* p1 = VDDIMX_EN */
-	gpio_request(gpio + 1, "VDDIMX_EN");
-	gpio_direction_output(gpio + 1, 1);
+	gpio_request_one(gpio + 1, GPIOF_OUT_INIT_HIGH, "VDDIMX_EN");
 
 	/* p2 = VLYNQ_EN */
-	gpio_request(gpio + 2, "VLYNQ_EN");
-	gpio_direction_output(gpio + 2, 1);
+	gpio_request_one(gpio + 2, GPIOF_OUT_INIT_HIGH, "VLYNQ_EN");
 
 	/* p3 = n3V3_CF_RESET (initial: stay in reset) */
-	gpio_request(gpio + 3, "nCF_RESET");
-	gpio_direction_output(gpio + 3, 0);
+	gpio_request_one(gpio + 3, GPIOF_OUT_INIT_LOW, "nCF_RESET");
 
 	/* (p4 unused) */
 
 	/* p5 = 1V8_WLAN_RESET (initial: stay in reset) */
-	gpio_request(gpio + 5, "WLAN_RESET");
-	gpio_direction_output(gpio + 5, 1);
+	gpio_request_one(gpio + 5, GPIOF_OUT_INIT_HIGH, "WLAN_RESET");
 
 	/* p6 = nATA_SEL (initial: select) */
-	gpio_request(gpio + 6, "nATA_SEL");
-	gpio_direction_output(gpio + 6, 0);
+	gpio_request_one(gpio + 6, GPIOF_OUT_INIT_LOW, "nATA_SEL");
 
 	/* p7 = nCF_SEL (initial: deselect) */
-	gpio_request(gpio + 7, "nCF_SEL");
-	gpio_direction_output(gpio + 7, 1);
+	gpio_request_one(gpio + 7, GPIOF_OUT_INIT_HIGH, "nCF_SEL");
 
 	return 0;
 }
diff -u -p a/arch/arm/mach-davinci/board-tnetv107x-evm.c b/arch/arm/mach-davinci/board-tnetv107x-evm.c
--- a/arch/arm/mach-davinci/board-tnetv107x-evm.c 2011-03-20 18:17:22.000000000 +0100
+++ b/arch/arm/mach-davinci/board-tnetv107x-evm.c 2011-03-21 08:55:21.000000000 +0100
@@ -44,12 +44,11 @@ static int initialize_gpio(int gpio, cha
 {
 	int ret;
 
-	ret = gpio_request(gpio, desc);
+	ret = gpio_request_one(gpio, GPIOF_IN, desc);
 	if (ret < 0) {
 		pr_err_ratelimited("cannot open %s gpio\n", desc);
 		return -ENOSYS;
 	}
-	gpio_direction_input(gpio);
 	return gpio;
 }
 
diff -u -p a/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c b/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
--- a/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c 2011-02-11 10:53:31.000000000 +0100
+++ b/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c 2011-03-21 08:55:22.000000000 +0100
@@ -251,11 +251,10 @@ static const struct imxuart_platform_dat
 
 static void __maybe_unused ads7846_dev_init(void)
 {
-	if (gpio_request(ADS7846_PENDOWN, "ADS7846 pendown") < 0) {
+	if (gpio_request_one(ADS7846_PENDOWN, GPIOF_IN, "ADS7846 pendown") < 0) {
 		printk(KERN_ERR "can't get ads746 pen down GPIO\n");
 		return;
 	}
-	gpio_direction_input(ADS7846_PENDOWN);
 }
 
 static int ads7846_get_pendown_state(void)
diff -u -p a/arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c b/arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c
--- a/arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c 2010-12-04 18:54:35.000000000 +0100
+++ b/arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c 2011-03-21 08:55:21.000000000 +0100
@@ -277,16 +277,13 @@ void __init eukrea_mbimxsd25_baseboard_i
 	imx25_add_flexcan1(NULL);
 	imx25_add_sdhci_esdhc_imx(0, NULL);
 
-	gpio_request(GPIO_LED1, "LED1");
-	gpio_direction_output(GPIO_LED1, 1);
+	gpio_request_one(GPIO_LED1, GPIOF_OUT_INIT_HIGH, "LED1");
 	gpio_free(GPIO_LED1);
 
-	gpio_request(GPIO_SWITCH1, "SWITCH1");
-	gpio_direction_input(GPIO_SWITCH1);
+	gpio_request_one(GPIO_SWITCH1, GPIOF_IN, "SWITCH1");
 	gpio_free(GPIO_SWITCH1);
 
-	gpio_request(GPIO_LCDPWR, "LCDPWR");
-	gpio_direction_output(GPIO_LCDPWR, 1);
+	gpio_request_one(GPIO_LCDPWR, GPIOF_OUT_INIT_HIGH, "LCDPWR");
 	gpio_free(GPIO_SWITCH1);
 
 	i2c_register_board_info(0, eukrea_mbimxsd_i2c_devices,
diff -u -p a/arch/arm/mach-imx/pcm970-baseboard.c b/arch/arm/mach-imx/pcm970-baseboard.c
--- a/arch/arm/mach-imx/pcm970-baseboard.c 2010-12-04 18:54:35.000000000 +0100
+++ b/arch/arm/mach-imx/pcm970-baseboard.c 2011-03-21 08:55:22.000000000 +0100
@@ -100,14 +100,12 @@ static int pcm970_sdhc2_init(struct devi
 	if (ret)
 		return ret;
 
-	ret = gpio_request(GPIO_PORTC + 28, "imx-mmc-ro");
+	ret = gpio_request_one(GPIO_PORTC + 28, GPIOF_IN, "imx-mmc-ro");
 	if (ret) {
 		free_irq(IRQ_GPIOC(29), data);
 		return ret;
 	}
 
-	gpio_direction_input(GPIO_PORTC + 28);
-
 	return 0;
 }
 
diff -u -p a/arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c b/arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c
--- a/arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c 2011-02-26 13:17:46.000000000 +0100
+++ b/arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c 2011-03-21 08:55:26.000000000 +0100
@@ -291,16 +291,13 @@ void __init eukrea_mbimxsd35_baseboard_i
 	imx35_add_flexcan1(NULL);
 	imx35_add_sdhci_esdhc_imx(0, NULL);
 
-	gpio_request(GPIO_LED1, "LED1");
-	gpio_direction_output(GPIO_LED1, 1);
+	gpio_request_one(GPIO_LED1, GPIOF_OUT_INIT_HIGH, "LED1");
 	gpio_free(GPIO_LED1);
 
-	gpio_request(GPIO_SWITCH1, "SWITCH1");
-	gpio_direction_input(GPIO_SWITCH1);
+	gpio_request_one(GPIO_SWITCH1, GPIOF_IN, "SWITCH1");
 	gpio_free(GPIO_SWITCH1);
 
-	gpio_request(GPIO_LCDPWR, "LCDPWR");
-	gpio_direction_output(GPIO_LCDPWR, 1);
+	gpio_request_one(GPIO_LCDPWR, GPIOF_OUT_INIT_HIGH, "LCDPWR");
 	gpio_free(GPIO_LCDPWR);
 
 	i2c_register_board_info(0, eukrea_mbimxsd_i2c_devices,
diff -u -p a/arch/arm/mach-mx3/mach-armadillo5x0.c b/arch/arm/mach-mx3/mach-armadillo5x0.c
--- a/arch/arm/mach-mx3/mach-armadillo5x0.c 2011-03-14 17:19:13.000000000 +0100
+++ b/arch/arm/mach-mx3/mach-armadillo5x0.c 2011-03-21 08:55:21.000000000 +0100
@@ -412,18 +412,14 @@ static int armadillo5x0_sdhc1_init(struc
 	gpio_det = IOMUX_TO_GPIO(MX31_PIN_ATA_DMACK);
 	gpio_wp = IOMUX_TO_GPIO(MX31_PIN_ATA_RESET_B);
 
-	ret = gpio_request(gpio_det, "sdhc-card-detect");
+	ret = gpio_request_one(gpio_det, GPIOF_IN, "sdhc-card-detect");
 	if (ret)
 		return ret;
 
-	gpio_direction_input(gpio_det);
-
-	ret = gpio_request(gpio_wp, "sdhc-write-protect");
+	ret = gpio_request_one(gpio_wp, GPIOF_IN, "sdhc-write-protect");
 	if (ret)
 		goto err_gpio_free;
 
-	gpio_direction_input(gpio_wp);
-
 	/* When supported the trigger type have to be BOTH */
 	ret = request_irq(IOMUX_TO_IRQ(MX31_PIN_ATA_DMACK), detect_irq,
 			  IRQF_DISABLED | IRQF_TRIGGER_FALLING,
diff -u -p a/arch/arm/mach-mx3/mach-kzm_arm11_01.c b/arch/arm/mach-mx3/mach-kzm_arm11_01.c
--- a/arch/arm/mach-mx3/mach-kzm_arm11_01.c 2011-02-19 08:28:51.000000000 +0100
+++ b/arch/arm/mach-mx3/mach-kzm_arm11_01.c 2011-03-21 08:55:22.000000000 +0100
@@ -113,8 +113,8 @@ static int __init kzm_init_ext_uart(void
 	 * GPIO 1-1: external UART interrupt line
 	 */
 	mxc_iomux_mode(IOMUX_MODE(MX31_PIN_GPIO1_1, IOMUX_CONFIG_GPIO));
-	gpio_request(IOMUX_TO_GPIO(MX31_PIN_GPIO1_1), "ext-uart-int");
-	gpio_direction_input(IOMUX_TO_GPIO(MX31_PIN_GPIO1_1));
+	gpio_request_one(IOMUX_TO_GPIO(MX31_PIN_GPIO1_1), GPIOF_IN,
+			 "ext-uart-int");
 
 	/*
 	 * Unmask UART interrupt
@@ -172,8 +172,8 @@ static int __init kzm_init_smsc9118(void
 	 * GPIO 1-2: SMSC9118 interrupt line
 	 */
 	mxc_iomux_mode(IOMUX_MODE(MX31_PIN_GPIO1_2, IOMUX_CONFIG_GPIO));
-	gpio_request(IOMUX_TO_GPIO(MX31_PIN_GPIO1_2), "smsc9118-int");
-	gpio_direction_input(IOMUX_TO_GPIO(MX31_PIN_GPIO1_2));
+	gpio_request_one(IOMUX_TO_GPIO(MX31_PIN_GPIO1_2), GPIOF_IN,
+			 "smsc9118-int");
 
 	return platform_device_register(&kzm_smsc9118_device);
 }
diff -u -p a/arch/arm/mach-mx3/mach-mx31lilly.c b/arch/arm/mach-mx3/mach-mx31lilly.c
--- a/arch/arm/mach-mx3/mach-mx31lilly.c 2011-03-14 17:19:13.000000000 +0100
+++ b/arch/arm/mach-mx3/mach-mx31lilly.c 2011-03-21 08:55:21.000000000 +0100
@@ -175,8 +175,8 @@ static int usbh2_init(struct platform_de
 	/* chip select */
 	mxc_iomux_alloc_pin(IOMUX_MODE(MX31_PIN_DTR_DCE1, IOMUX_CONFIG_GPIO),
 				"USBH2_CS");
-	gpio_request(IOMUX_TO_GPIO(MX31_PIN_DTR_DCE1), "USBH2 CS");
-	gpio_direction_output(IOMUX_TO_GPIO(MX31_PIN_DTR_DCE1), 0);
+	gpio_request_one(IOMUX_TO_GPIO(MX31_PIN_DTR_DCE1),
+			 GPIOF_OUT_INIT_LOW, "USBH2 CS");
 
 	mdelay(10);
 
diff -u -p a/arch/arm/mach-mx3/mach-mx31lite.c b/arch/arm/mach-mx3/mach-mx31lite.c
--- a/arch/arm/mach-mx3/mach-mx31lite.c 2011-03-14 17:19:13.000000000 +0100
+++ b/arch/arm/mach-mx3/mach-mx31lite.c 2011-03-21 08:55:21.000000000 +0100
@@ -164,8 +164,8 @@ static int usbh2_init(struct platform_de
 	/* chip select */
 	mxc_iomux_alloc_pin(IOMUX_MODE(MX31_PIN_DTR_DCE1, IOMUX_CONFIG_GPIO),
 				"USBH2_CS");
-	gpio_request(IOMUX_TO_GPIO(MX31_PIN_DTR_DCE1), "USBH2 CS");
-	gpio_direction_output(IOMUX_TO_GPIO(MX31_PIN_DTR_DCE1), 0);
+	gpio_request_one(IOMUX_TO_GPIO(MX31_PIN_DTR_DCE1),
+			 GPIOF_OUT_INIT_LOW, "USBH2 CS");
 
 	mdelay(10);
 
diff -u -p a/arch/arm/mach-mx3/mach-mx31moboard.c b/arch/arm/mach-mx3/mach-mx31moboard.c
--- a/arch/arm/mach-mx3/mach-mx31moboard.c 2011-03-14 17:19:13.000000000 +0100
+++ b/arch/arm/mach-mx3/mach-mx31moboard.c 2011-03-21 08:55:22.000000000 +0100
@@ -311,16 +311,13 @@ static int moboard_sdhc1_init(struct dev
 {
 	int ret;
 
-	ret = gpio_request(SDHC1_CD, "sdhc-detect");
+	ret = gpio_request_one(SDHC1_CD, GPIOF_IN, "sdhc-detect");
 	if (ret)
 		return ret;
 
-	gpio_direction_input(SDHC1_CD);
-
-	ret = gpio_request(SDHC1_WP, "sdhc-wp");
+	ret = gpio_request_one(SDHC1_WP, GPIOF_IN, "sdhc-wp");
 	if (ret)
 		goto err_gpio_free;
-	gpio_direction_input(SDHC1_WP);
 
 	ret = request_irq(gpio_to_irq(SDHC1_CD), detect_irq,
 		IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
@@ -390,13 +387,11 @@ static void usb_xcvr_reset(void)
 	mxc_iomux_set_pad(MX31_PIN_SRXD3, USB_PAD_CFG | PAD_CTL_100K_PD);
 	mxc_iomux_set_pad(MX31_PIN_STXD3, USB_PAD_CFG | PAD_CTL_100K_PD);
 
-	gpio_request(OTG_EN_B, "usb-udc-en");
-	gpio_direction_output(OTG_EN_B, 0);
-	gpio_request(USBH2_EN_B, "usbh2-en");
-	gpio_direction_output(USBH2_EN_B, 0);
+	gpio_request_one(OTG_EN_B, GPIOF_OUT_INIT_LOW, "usb-udc-en");
+	
+	gpio_request_one(USBH2_EN_B, GPIOF_OUT_INIT_LOW, "usbh2-en");
 
-	gpio_request(USB_RESET_B, "usb-reset");
-	gpio_direction_output(USB_RESET_B, 0);
+	gpio_request_one(USB_RESET_B, GPIOF_OUT_INIT_LOW, "usb-reset");
 	mdelay(1);
 	gpio_set_value(USB_RESET_B, 1);
 	mdelay(1);
@@ -522,8 +517,8 @@ static void __init mx31moboard_init(void
 	imx31_add_spi_imx1(&moboard_spi1_pdata);
 	imx31_add_spi_imx2(&moboard_spi2_pdata);
 
-	gpio_request(IOMUX_TO_GPIO(MX31_PIN_GPIO1_3), "pmic-irq");
-	gpio_direction_input(IOMUX_TO_GPIO(MX31_PIN_GPIO1_3));
+	gpio_request_one(IOMUX_TO_GPIO(MX31_PIN_GPIO1_3), GPIOF_IN,
+			 "pmic-irq");
 	spi_register_board_info(moboard_spi_board_info,
 		ARRAY_SIZE(moboard_spi_board_info));
 
diff -u -p a/arch/arm/mach-mx3/mach-pcm037.c b/arch/arm/mach-mx3/mach-pcm037.c
--- a/arch/arm/mach-mx3/mach-pcm037.c 2011-03-14 17:19:13.000000000 +0100
+++ b/arch/arm/mach-mx3/mach-pcm037.c 2011-03-21 08:55:21.000000000 +0100
@@ -358,17 +358,14 @@ static int pcm970_sdhc1_init(struct devi
 {
 	int ret;
 
-	ret = gpio_request(SDHC1_GPIO_DET, "sdhc-detect");
+	ret = gpio_request_one(SDHC1_GPIO_DET, GPIOF_IN, "sdhc-detect");
 	if (ret)
 		return ret;
 
-	gpio_direction_input(SDHC1_GPIO_DET);
-
 #ifdef PCM970_SDHC_RW_SWITCH
-	ret = gpio_request(SDHC1_GPIO_WP, "sdhc-wp");
+	ret = gpio_request_one(SDHC1_GPIO_WP, GPIOF_IN, "sdhc-wp");
 	if (ret)
 		goto err_gpio_free;
-	gpio_direction_input(SDHC1_GPIO_WP);
 #endif
 
 	ret = request_irq(IOMUX_TO_IRQ(MX31_PIN_SCK6), detect_irq,
diff -u -p a/arch/arm/mach-mx3/mach-pcm043.c b/arch/arm/mach-mx3/mach-pcm043.c
--- a/arch/arm/mach-mx3/mach-pcm043.c 2011-03-14 17:19:13.000000000 +0100
+++ b/arch/arm/mach-mx3/mach-pcm043.c 2011-03-21 08:55:21.000000000 +0100
@@ -229,7 +229,7 @@ static void pcm043_ac97_warm_reset(struc
 	iomux_v3_cfg_t txfs = MX35_PAD_STXFS4__AUDMUX_AUD4_TXFS;
 	int ret;
 
-	ret = gpio_request(AC97_GPIO_TXFS, "SSI");
+	ret = gpio_request_one(AC97_GPIO_TXFS, GPIOF_OUT_INIT_HIGH, "SSI");
 	if (ret) {
 		printk("failed to get GPIO_TXFS: %d\n", ret);
 		return;
@@ -238,7 +238,6 @@ static void pcm043_ac97_warm_reset(struc
 	mxc_iomux_v3_setup_pad(txfs_gpio);
 
 	/* warm reset */
-	gpio_direction_output(AC97_GPIO_TXFS, 1);
 	udelay(2);
 	gpio_set_value(AC97_GPIO_TXFS, 0);
 
diff -u -p a/arch/arm/mach-mx3/mx31lilly-db.c b/arch/arm/mach-mx3/mx31lilly-db.c
--- a/arch/arm/mach-mx3/mx31lilly-db.c 2010-12-04 18:54:35.000000000 +0100
+++ b/arch/arm/mach-mx3/mx31lilly-db.c 2011-03-21 08:55:26.000000000 +0100
@@ -197,14 +197,14 @@ static struct mx3fb_platform_data fb_pda
 
 static void __init mx31lilly_init_fb(void)
 {
-	if (gpio_request(LCD_VCC_EN_GPIO, "LCD enable") != 0) {
+	if (gpio_request_one(LCD_VCC_EN_GPIO, GPIOF_OUT_INIT_HIGH,
+			     "LCD enable") != 0) {
 		printk(KERN_WARNING "unable to request LCD_VCC_EN pin.\n");
 		return;
 	}
 
 	mxc_register_device(&mx3_ipu, &ipu_data);
 	mxc_register_device(&mx3_fb, &fb_pdata);
-	gpio_direction_output(LCD_VCC_EN_GPIO, 1);
 }
 
 void __init mx31lilly_db_init(void)
diff -u -p a/arch/arm/mach-mx3/mx31moboard-devboard.c b/arch/arm/mach-mx3/mx31moboard-devboard.c
--- a/arch/arm/mach-mx3/mx31moboard-devboard.c 2011-02-19 08:28:51.000000000 +0100
+++ b/arch/arm/mach-mx3/mx31moboard-devboard.c 2011-03-21 08:55:21.000000000 +0100
@@ -67,16 +67,13 @@ static int devboard_sdhc2_init(struct de
 {
 	int ret;
 
-	ret = gpio_request(SDHC2_CD, "sdhc-detect");
+	ret = gpio_request_one(SDHC2_CD, GPIOF_IN, "sdhc-detect");
 	if (ret)
 		return ret;
 
-	gpio_direction_input(SDHC2_CD);
-
-	ret = gpio_request(SDHC2_WP, "sdhc-wp");
+	ret = gpio_request_one(SDHC2_WP, GPIOF_IN, "sdhc-wp");
 	if (ret)
 		goto err_gpio_free;
-	gpio_direction_input(SDHC2_WP);
 
 	ret = request_irq(gpio_to_irq(SDHC2_CD), detect_irq,
 		IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
@@ -161,18 +158,17 @@ static int devboard_usbh1_hw_init(struct
 
 static int devboard_isp1105_init(struct otg_transceiver *otg)
 {
-	int ret = gpio_request(USBH1_MODE, "usbh1-mode");
+	int ret = gpio_request_one(USBH1_MODE, GPIOF_OUT_INIT_LOW,
+				   "usbh1-mode");
 	if (ret)
 		return ret;
-	/* single ended */
-	gpio_direction_output(USBH1_MODE, 0);
 
-	ret = gpio_request(USBH1_VBUSEN_B, "usbh1-vbusen");
+	ret = gpio_request_one(USBH1_VBUSEN_B, GPIOF_OUT_INIT_HIGH,
+			       "usbh1-vbusen");
 	if (ret) {
 		gpio_free(USBH1_MODE);
 		return ret;
 	}
-	gpio_direction_output(USBH1_VBUSEN_B, 1);
 
 	return 0;
 }
diff -u -p a/arch/arm/mach-mx3/mx31moboard-marxbot.c b/arch/arm/mach-mx3/mx31moboard-marxbot.c
--- a/arch/arm/mach-mx3/mx31moboard-marxbot.c 2011-02-19 08:28:51.000000000 +0100
+++ b/arch/arm/mach-mx3/mx31moboard-marxbot.c 2011-03-21 08:55:22.000000000 +0100
@@ -80,16 +80,13 @@ static int marxbot_sdhc2_init(struct dev
 {
 	int ret;
 
-	ret = gpio_request(SDHC2_CD, "sdhc-detect");
+	ret = gpio_request_one(SDHC2_CD, GPIOF_IN, "sdhc-detect");
 	if (ret)
 		return ret;
 
-	gpio_direction_input(SDHC2_CD);
-
-	ret = gpio_request(SDHC2_WP, "sdhc-wp");
+	ret = gpio_request_one(SDHC2_WP, GPIOF_IN, "sdhc-wp");
 	if (ret)
 		goto err_gpio_free;
-	gpio_direction_input(SDHC2_WP);
 
 	ret = request_irq(gpio_to_irq(SDHC2_CD), detect_irq,
 		IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
@@ -195,28 +192,28 @@ static struct platform_device *marxbot_c
 
 static int __init marxbot_cam_init(void)
 {
-	int ret = gpio_request(CAM_CHOICE, "cam-choice");
+	int ret = gpio_request_one(CAM_CHOICE, GPIOF_OUT_INIT_LOW,
+				   "cam-choice");
 	if (ret)
 		return ret;
-	gpio_direction_output(CAM_CHOICE, 0);
 
-	ret = gpio_request(BASECAM_RST_B, "basecam-reset");
+	ret = gpio_request_one(BASECAM_RST_B, GPIOF_OUT_INIT_HIGH,
+			       "basecam-reset");
 	if (ret)
 		return ret;
-	gpio_direction_output(BASECAM_RST_B, 1);
-	ret = gpio_request(BASECAM_POWER, "basecam-standby");
+	ret = gpio_request_one(BASECAM_POWER, GPIOF_OUT_INIT_LOW,
+			       "basecam-standby");
 	if (ret)
 		return ret;
-	gpio_direction_output(BASECAM_POWER, 0);
 
-	ret = gpio_request(TURRETCAM_RST_B, "turretcam-reset");
+	ret = gpio_request_one(TURRETCAM_RST_B, GPIOF_OUT_INIT_HIGH,
+			       "turretcam-reset");
 	if (ret)
 		return ret;
-	gpio_direction_output(TURRETCAM_RST_B, 1);
-	ret = gpio_request(TURRETCAM_POWER, "turretcam-standby");
+	ret = gpio_request_one(TURRETCAM_POWER, GPIOF_OUT_INIT_LOW,
+			       "turretcam-standby");
 	if (ret)
 		return ret;
-	gpio_direction_output(TURRETCAM_POWER, 0);
 
 	return 0;
 }
@@ -276,18 +273,17 @@ static int marxbot_usbh1_hw_init(struct 
 
 static int marxbot_isp1105_init(struct otg_transceiver *otg)
 {
-	int ret = gpio_request(USBH1_MODE, "usbh1-mode");
+	int ret = gpio_request_one(USBH1_MODE, GPIOF_OUT_INIT_LOW,
+				   "usbh1-mode");
 	if (ret)
 		return ret;
-	/* single ended */
-	gpio_direction_output(USBH1_MODE, 0);
 
-	ret = gpio_request(USBH1_VBUSEN_B, "usbh1-vbusen");
+	ret = gpio_request_one(USBH1_VBUSEN_B, GPIOF_OUT_INIT_HIGH,
+			       "usbh1-vbusen");
 	if (ret) {
 		gpio_free(USBH1_MODE);
 		return ret;
 	}
-	gpio_direction_output(USBH1_VBUSEN_B, 1);
 
 	return 0;
 }
@@ -358,8 +354,8 @@ void __init mx31moboard_marxbot_init(voi
 	platform_add_devices(marxbot_cameras, ARRAY_SIZE(marxbot_cameras));
 
 	/* battery present pin */
-	gpio_request(IOMUX_TO_GPIO(MX31_PIN_LCS0), "bat-present");
-	gpio_direction_input(IOMUX_TO_GPIO(MX31_PIN_LCS0));
+	gpio_request_one(IOMUX_TO_GPIO(MX31_PIN_LCS0), GPIOF_IN,
+			 "bat-present");
 	gpio_export(IOMUX_TO_GPIO(MX31_PIN_LCS0), false);
 
 	imx31_add_fsl_usb2_udc(&usb_pdata);
diff -u -p a/arch/arm/mach-mx3/mx31moboard-smartbot.c b/arch/arm/mach-mx3/mx31moboard-smartbot.c
--- a/arch/arm/mach-mx3/mx31moboard-smartbot.c 2011-03-14 17:19:13.000000000 +0100
+++ b/arch/arm/mach-mx3/mx31moboard-smartbot.c 2011-03-21 08:55:22.000000000 +0100
@@ -104,14 +104,13 @@ static struct platform_device *smartbot_
 
 static int __init smartbot_cam_init(void)
 {
-	int ret = gpio_request(CAM_RST_B, "cam-reset");
+	int ret = gpio_request_one(CAM_RST_B, GPIOF_OUT_INIT_HIGH,
+				   "cam-reset");
 	if (ret)
 		return ret;
-	gpio_direction_output(CAM_RST_B, 1);
-	ret = gpio_request(CAM_POWER, "cam-standby");
+	ret = gpio_request_one(CAM_POWER, GPIOF_OUT_INIT_LOW, "cam-standby");
 	if (ret)
 		return ret;
-	gpio_direction_output(CAM_POWER, 0);
 
 	return 0;
 }
diff -u -p a/arch/arm/mach-mx5/board-cpuimx51.c b/arch/arm/mach-mx5/board-cpuimx51.c
--- a/arch/arm/mach-mx5/board-cpuimx51.c 2011-02-19 08:28:51.000000000 +0100
+++ b/arch/arm/mach-mx5/board-cpuimx51.c 2011-03-21 08:55:24.000000000 +0100
@@ -253,17 +253,13 @@ static void __init eukrea_cpuimx51_init(
 	imx51_add_imx_uart(0, &uart_pdata);
 	imx51_add_mxc_nand(&eukrea_cpuimx51_nand_board_info);
 
-	gpio_request(CPUIMX51_QUARTA_GPIO, "quarta_irq");
-	gpio_direction_input(CPUIMX51_QUARTA_GPIO);
+	gpio_request_one(CPUIMX51_QUARTA_GPIO, GPIOF_IN, "quarta_irq");
 	gpio_free(CPUIMX51_QUARTA_GPIO);
-	gpio_request(CPUIMX51_QUARTB_GPIO, "quartb_irq");
-	gpio_direction_input(CPUIMX51_QUARTB_GPIO);
+	gpio_request_one(CPUIMX51_QUARTB_GPIO, GPIOF_IN, "quartb_irq");
 	gpio_free(CPUIMX51_QUARTB_GPIO);
-	gpio_request(CPUIMX51_QUARTC_GPIO, "quartc_irq");
-	gpio_direction_input(CPUIMX51_QUARTC_GPIO);
+	gpio_request_one(CPUIMX51_QUARTC_GPIO, GPIOF_IN, "quartc_irq");
 	gpio_free(CPUIMX51_QUARTC_GPIO);
-	gpio_request(CPUIMX51_QUARTD_GPIO, "quartd_irq");
-	gpio_direction_input(CPUIMX51_QUARTD_GPIO);
+	gpio_request_one(CPUIMX51_QUARTD_GPIO, GPIOF_IN, "quartd_irq");
 	gpio_free(CPUIMX51_QUARTD_GPIO);
 
 	imx51_add_fec(NULL);
diff -u -p a/arch/arm/mach-mx5/board-cpuimx51sd.c b/arch/arm/mach-mx5/board-cpuimx51sd.c
--- a/arch/arm/mach-mx5/board-cpuimx51sd.c 2011-03-14 17:19:13.000000000 +0100
+++ b/arch/arm/mach-mx5/board-cpuimx51sd.c 2011-03-21 08:55:24.000000000 +0100
@@ -280,22 +280,18 @@ static void __init eukrea_cpuimx51sd_ini
 	gpio_set_value(ETH_RST, 1);
 	imx51_add_fec(NULL);
 
-	gpio_request(CAN_IRQGPIO, "can_irq");
-	gpio_direction_input(CAN_IRQGPIO);
+	gpio_request_one(CAN_IRQGPIO, GPIOF_IN, "can_irq");
 	gpio_free(CAN_IRQGPIO);
-	gpio_request(CAN_NCS, "can_ncs");
-	gpio_direction_output(CAN_NCS, 1);
+	gpio_request_one(CAN_NCS, GPIOF_OUT_INIT_HIGH, "can_ncs");
 	gpio_free(CAN_NCS);
-	gpio_request(CAN_RST, "can_rst");
-	gpio_direction_output(CAN_RST, 0);
+	gpio_request_one(CAN_RST, GPIOF_OUT_INIT_LOW, "can_rst");
 	msleep(20);
 	gpio_set_value(CAN_RST, 1);
 	imx51_add_ecspi(0, &cpuimx51sd_ecspi1_pdata);
 	spi_register_board_info(cpuimx51sd_spi_device,
 				ARRAY_SIZE(cpuimx51sd_spi_device));
 
-	gpio_request(TSC2007_IRQGPIO, "tsc2007_irq");
-	gpio_direction_input(TSC2007_IRQGPIO);
+	gpio_request_one(TSC2007_IRQGPIO, GPIOF_IN, "tsc2007_irq");
 	gpio_free(TSC2007_IRQGPIO);
 
 	i2c_register_board_info(0, eukrea_cpuimx51sd_i2c_devices,
@@ -309,8 +305,7 @@ static void __init eukrea_cpuimx51sd_ini
 		mxc_register_device(&mxc_usbdr_udc_device, &usb_pdata);
 	}
 
-	gpio_request(USBH1_RST, "usb_rst");
-	gpio_direction_output(USBH1_RST, 0);
+	gpio_request_one(USBH1_RST, GPIOF_OUT_INIT_LOW, "usb_rst");
 	msleep(20);
 	gpio_set_value(USBH1_RST, 1);
 	mxc_register_device(&mxc_usbh1_device, &usbh1_config);
diff -u -p a/arch/arm/mach-mx5/board-mx50_rdp.c b/arch/arm/mach-mx5/board-mx50_rdp.c
--- a/arch/arm/mach-mx5/board-mx50_rdp.c 2011-02-11 10:53:31.000000000 +0100
+++ b/arch/arm/mach-mx5/board-mx50_rdp.c 2011-03-21 08:55:21.000000000 +0100
@@ -176,10 +176,9 @@ static const struct fec_platform_data fe
 
 static inline void mx50_rdp_fec_reset(void)
 {
-	gpio_request(FEC_EN, "fec-en");
-	gpio_direction_output(FEC_EN, 0);
-	gpio_request(FEC_RESET_B, "fec-reset_b");
-	gpio_direction_output(FEC_RESET_B, 0);
+	gpio_request_one(FEC_EN, GPIOF_OUT_INIT_LOW, "fec-en");
+	
+	gpio_request_one(FEC_RESET_B, GPIOF_OUT_INIT_LOW, "fec-reset_b");
 	msleep(1);
 	gpio_set_value(FEC_RESET_B, 1);
 }
diff -u -p a/arch/arm/mach-mx5/board-mx51_babbage.c b/arch/arm/mach-mx5/board-mx51_babbage.c
--- a/arch/arm/mach-mx5/board-mx51_babbage.c 2011-02-19 08:28:51.000000000 +0100
+++ b/arch/arm/mach-mx5/board-mx51_babbage.c 2011-03-21 08:55:21.000000000 +0100
@@ -181,26 +181,26 @@ static int gpio_usbh1_active(void)
 
 	/* Set USBH1_STP to GPIO and toggle it */
 	mxc_iomux_v3_setup_pad(usbh1stp_gpio);
-	ret = gpio_request(BABBAGE_USBH1_STP, "usbh1_stp");
+	ret = gpio_request_one(BABBAGE_USBH1_STP, GPIOF_OUT_INIT_LOW,
+			       "usbh1_stp");
 
 	if (ret) {
 		pr_debug("failed to get MX51_PAD_USBH1_STP__GPIO_1_27: %d\n", ret);
 		return ret;
 	}
-	gpio_direction_output(BABBAGE_USBH1_STP, 0);
 	gpio_set_value(BABBAGE_USBH1_STP, 1);
 	msleep(100);
 	gpio_free(BABBAGE_USBH1_STP);
 
 	/* De-assert USB PHY RESETB */
 	mxc_iomux_v3_setup_pad(phyreset_gpio);
-	ret = gpio_request(BABBAGE_PHY_RESET, "phy_reset");
+	ret = gpio_request_one(BABBAGE_PHY_RESET, GPIOF_OUT_INIT_HIGH,
+			       "phy_reset");
 
 	if (ret) {
 		pr_debug("failed to get MX51_PAD_EIM_D21__GPIO_2_5: %d\n", ret);
 		return ret;
 	}
-	gpio_direction_output(BABBAGE_PHY_RESET, 1);
 	return 0;
 }
 
@@ -209,12 +209,12 @@ static inline void babbage_usbhub_reset(
 	int ret;
 
 	/* Bring USB hub out of reset */
-	ret = gpio_request(BABBAGE_USB_HUB_RESET, "GPIO1_7");
+	ret = gpio_request_one(BABBAGE_USB_HUB_RESET, GPIOF_OUT_INIT_LOW,
+			       "GPIO1_7");
 	if (ret) {
 		printk(KERN_ERR"failed to get GPIO_USB_HUB_RESET: %d\n", ret);
 		return;
 	}
-	gpio_direction_output(BABBAGE_USB_HUB_RESET, 0);
 
 	/* USB HUB RESET - De-assert USB HUB RESET_N */
 	msleep(1);
@@ -228,12 +228,12 @@ static inline void babbage_fec_reset(voi
 	int ret;
 
 	/* reset FEC PHY */
-	ret = gpio_request(BABBAGE_FEC_PHY_RESET, "fec-phy-reset");
+	ret = gpio_request_one(BABBAGE_FEC_PHY_RESET, GPIOF_OUT_INIT_LOW,
+			       "fec-phy-reset");
 	if (ret) {
 		printk(KERN_ERR"failed to get GPIO_FEC_PHY_RESET: %d\n", ret);
 		return;
 	}
-	gpio_direction_output(BABBAGE_FEC_PHY_RESET, 0);
 	gpio_set_value(BABBAGE_FEC_PHY_RESET, 0);
 	msleep(1);
 	gpio_set_value(BABBAGE_FEC_PHY_RESET, 1);
diff -u -p a/arch/arm/mach-mx5/board-mx51_efikamx.c b/arch/arm/mach-mx5/board-mx51_efikamx.c
--- a/arch/arm/mach-mx5/board-mx51_efikamx.c 2011-02-26 13:17:46.000000000 +0100
+++ b/arch/arm/mach-mx5/board-mx51_efikamx.c 2011-03-21 08:55:25.000000000 +0100
@@ -104,12 +104,11 @@ static void __init mx51_efikamx_board_id
 	/* things are taking time to settle */
 	msleep(150);
 
-	gpio_request(EFIKAMX_PCBID0, "pcbid0");
-	gpio_direction_input(EFIKAMX_PCBID0);
-	gpio_request(EFIKAMX_PCBID1, "pcbid1");
-	gpio_direction_input(EFIKAMX_PCBID1);
-	gpio_request(EFIKAMX_PCBID2, "pcbid2");
-	gpio_direction_input(EFIKAMX_PCBID2);
+	gpio_request_one(EFIKAMX_PCBID0, GPIOF_IN, "pcbid0");
+	
+	gpio_request_one(EFIKAMX_PCBID1, GPIOF_IN, "pcbid1");
+	
+	gpio_request_one(EFIKAMX_PCBID2, GPIOF_IN, "pcbid2");
 
 	id = gpio_get_value(EFIKAMX_PCBID0);
 	id |= gpio_get_value(EFIKAMX_PCBID1) << 1;
@@ -255,11 +254,10 @@ static void __init mx51_efikamx_init(voi
 	imx51_add_gpio_keys(&mx51_efikamx_powerkey_data);
 
 	if (system_rev == 0x11) {
-		gpio_request(EFIKAMX_RESET1_1, "reset");
-		gpio_direction_output(EFIKAMX_RESET1_1, 1);
+		gpio_request_one(EFIKAMX_RESET1_1, GPIOF_OUT_INIT_HIGH,
+				 "reset");
 	} else {
-		gpio_request(EFIKAMX_RESET, "reset");
-		gpio_direction_output(EFIKAMX_RESET, 1);
+		gpio_request_one(EFIKAMX_RESET, GPIOF_OUT_INIT_HIGH, "reset");
 	}
 
 	/*
@@ -267,12 +265,10 @@ static void __init mx51_efikamx_init(voi
 	 * sb and mx have same wlan pin but the value to enable it are
 	 * different :/
 	 */
-	gpio_request(EFIKA_WLAN_EN, "wlan_en");
-	gpio_direction_output(EFIKA_WLAN_EN, 0);
+	gpio_request_one(EFIKA_WLAN_EN, GPIOF_OUT_INIT_LOW, "wlan_en");
 	msleep(10);
 
-	gpio_request(EFIKA_WLAN_RESET, "wlan_rst");
-	gpio_direction_output(EFIKA_WLAN_RESET, 0);
+	gpio_request_one(EFIKA_WLAN_RESET, GPIOF_OUT_INIT_LOW, "wlan_rst");
 	msleep(10);
 	gpio_set_value(EFIKA_WLAN_RESET, 1);
 }
diff -u -p a/arch/arm/mach-mx5/board-mx51_efikasb.c b/arch/arm/mach-mx5/board-mx51_efikasb.c
--- a/arch/arm/mach-mx5/board-mx51_efikasb.c 2011-03-14 17:19:13.000000000 +0100
+++ b/arch/arm/mach-mx5/board-mx51_efikasb.c 2011-03-21 08:55:25.000000000 +0100
@@ -108,8 +108,7 @@ static int initialize_usbh2_port(struct 
 	iomux_v3_cfg_t usbh2gpio = MX51_PAD_EIM_A26__GPIO2_20;
 
 	mxc_iomux_v3_setup_pad(usbh2gpio);
-	gpio_request(EFIKASB_USBH2_STP, "usbh2_stp");
-	gpio_direction_output(EFIKASB_USBH2_STP, 0);
+	gpio_request_one(EFIKASB_USBH2_STP, GPIOF_OUT_INIT_LOW, "usbh2_stp");
 	msleep(1);
 	gpio_set_value(EFIKASB_USBH2_STP, 1);
 	msleep(1);
@@ -229,10 +228,9 @@ static void __init mx51_efikasb_board_id
 {
 	int id;
 
-	gpio_request(EFIKASB_PCBID0, "pcb id0");
-	gpio_direction_input(EFIKASB_PCBID0);
-	gpio_request(EFIKASB_PCBID1, "pcb id1");
-	gpio_direction_input(EFIKASB_PCBID1);
+	gpio_request_one(EFIKASB_PCBID0, GPIOF_IN, "pcb id0");
+	
+	gpio_request_one(EFIKASB_PCBID1, GPIOF_IN, "pcb id1");
 
 	id = gpio_get_value(EFIKASB_PCBID0);
 	id |= gpio_get_value(EFIKASB_PCBID1) << 1;
diff -u -p a/arch/arm/mach-mx5/board-mx53_evk.c b/arch/arm/mach-mx5/board-mx53_evk.c
--- a/arch/arm/mach-mx5/board-mx53_evk.c 2011-03-14 17:19:13.000000000 +0100
+++ b/arch/arm/mach-mx5/board-mx53_evk.c 2011-03-21 08:55:21.000000000 +0100
@@ -82,12 +82,12 @@ static inline void mx53_evk_fec_reset(vo
 	int ret;
 
 	/* reset FEC PHY */
-	ret = gpio_request(SMD_FEC_PHY_RST, "fec-phy-reset");
+	ret = gpio_request_one(SMD_FEC_PHY_RST, GPIOF_OUT_INIT_LOW,
+			       "fec-phy-reset");
 	if (ret) {
 		printk(KERN_ERR"failed to get GPIO_FEC_PHY_RESET: %d\n", ret);
 		return;
 	}
-	gpio_direction_output(SMD_FEC_PHY_RST, 0);
 	gpio_set_value(SMD_FEC_PHY_RST, 0);
 	msleep(1);
 	gpio_set_value(SMD_FEC_PHY_RST, 1);
diff -u -p a/arch/arm/mach-mx5/board-mx53_loco.c b/arch/arm/mach-mx5/board-mx53_loco.c
--- a/arch/arm/mach-mx5/board-mx53_loco.c 2011-03-14 17:19:13.000000000 +0100
+++ b/arch/arm/mach-mx5/board-mx53_loco.c 2011-03-21 08:55:21.000000000 +0100
@@ -185,12 +185,12 @@ static inline void mx53_loco_fec_reset(v
 	int ret;
 
 	/* reset FEC PHY */
-	ret = gpio_request(LOCO_FEC_PHY_RST, "fec-phy-reset");
+	ret = gpio_request_one(LOCO_FEC_PHY_RST, GPIOF_OUT_INIT_LOW,
+			       "fec-phy-reset");
 	if (ret) {
 		printk(KERN_ERR"failed to get GPIO_FEC_PHY_RESET: %d\n", ret);
 		return;
 	}
-	gpio_direction_output(LOCO_FEC_PHY_RST, 0);
 	msleep(1);
 	gpio_set_value(LOCO_FEC_PHY_RST, 1);
 }
diff -u -p a/arch/arm/mach-mx5/board-mx53_smd.c b/arch/arm/mach-mx5/board-mx53_smd.c
--- a/arch/arm/mach-mx5/board-mx53_smd.c 2011-03-14 17:19:13.000000000 +0100
+++ b/arch/arm/mach-mx5/board-mx53_smd.c 2011-03-21 08:55:25.000000000 +0100
@@ -70,12 +70,12 @@ static inline void mx53_smd_fec_reset(vo
 	int ret;
 
 	/* reset FEC PHY */
-	ret = gpio_request(SMD_FEC_PHY_RST, "fec-phy-reset");
+	ret = gpio_request_one(SMD_FEC_PHY_RST, GPIOF_OUT_INIT_LOW,
+			       "fec-phy-reset");
 	if (ret) {
 		printk(KERN_ERR"failed to get GPIO_FEC_PHY_RESET: %d\n", ret);
 		return;
 	}
-	gpio_direction_output(SMD_FEC_PHY_RST, 0);
 	msleep(1);
 	gpio_set_value(SMD_FEC_PHY_RST, 1);
 }
diff -u -p a/arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c b/arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c
--- a/arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c 2011-01-19 18:51:18.000000000 +0100
+++ b/arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c 2011-03-21 08:55:21.000000000 +0100
@@ -193,25 +193,20 @@ void __init eukrea_mbimx51_baseboard_ini
 	imx51_add_imx_uart(1, NULL);
 	imx51_add_imx_uart(2, &uart_pdata);
 
-	gpio_request(MBIMX51_LED0, "LED0");
-	gpio_direction_output(MBIMX51_LED0, 1);
+	gpio_request_one(MBIMX51_LED0, GPIOF_OUT_INIT_HIGH, "LED0");
 	gpio_free(MBIMX51_LED0);
-	gpio_request(MBIMX51_LED1, "LED1");
-	gpio_direction_output(MBIMX51_LED1, 1);
+	gpio_request_one(MBIMX51_LED1, GPIOF_OUT_INIT_HIGH, "LED1");
 	gpio_free(MBIMX51_LED1);
-	gpio_request(MBIMX51_LED2, "LED2");
-	gpio_direction_output(MBIMX51_LED2, 1);
+	gpio_request_one(MBIMX51_LED2, GPIOF_OUT_INIT_HIGH, "LED2");
 	gpio_free(MBIMX51_LED2);
-	gpio_request(MBIMX51_LED3, "LED3");
-	gpio_direction_output(MBIMX51_LED3, 1);
+	gpio_request_one(MBIMX51_LED3, GPIOF_OUT_INIT_HIGH, "LED3");
 	gpio_free(MBIMX51_LED3);
 
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 
 	imx51_add_imx_keypad(&mbimx51_map_data);
 
-	gpio_request(MBIMX51_TSC2007_GPIO, "tsc2007_irq");
-	gpio_direction_input(MBIMX51_TSC2007_GPIO);
+	gpio_request_one(MBIMX51_TSC2007_GPIO, GPIOF_IN, "tsc2007_irq");
 	set_irq_type(MBIMX51_TSC2007_IRQ, IRQF_TRIGGER_FALLING);
 	i2c_register_board_info(1, mbimx51_i2c_devices,
 				ARRAY_SIZE(mbimx51_i2c_devices));
diff -u -p a/arch/arm/mach-mx5/eukrea_mbimxsd-baseboard.c b/arch/arm/mach-mx5/eukrea_mbimxsd-baseboard.c
--- a/arch/arm/mach-mx5/eukrea_mbimxsd-baseboard.c 2011-01-09 09:32:57.000000000 +0100
+++ b/arch/arm/mach-mx5/eukrea_mbimxsd-baseboard.c 2011-03-21 08:55:24.000000000 +0100
@@ -150,12 +150,10 @@ void __init eukrea_mbimxsd51_baseboard_i
 
 	imx51_add_sdhci_esdhc_imx(0, NULL);
 
-	gpio_request(GPIO_LED1, "LED1");
-	gpio_direction_output(GPIO_LED1, 1);
+	gpio_request_one(GPIO_LED1, GPIOF_OUT_INIT_HIGH, "LED1");
 	gpio_free(GPIO_LED1);
 
-	gpio_request(GPIO_SWITCH1, "SWITCH1");
-	gpio_direction_input(GPIO_SWITCH1);
+	gpio_request_one(GPIO_SWITCH1, GPIOF_IN, "SWITCH1");
 	gpio_free(GPIO_SWITCH1);
 
 	i2c_register_board_info(0, eukrea_mbimxsd_i2c_devices,
diff -u -p a/arch/arm/mach-mx5/mx51_efika.c b/arch/arm/mach-mx5/mx51_efika.c
--- a/arch/arm/mach-mx5/mx51_efika.c 2011-03-14 17:19:13.000000000 +0100
+++ b/arch/arm/mach-mx5/mx51_efika.c 2011-03-21 08:55:25.000000000 +0100
@@ -168,8 +168,7 @@ static int initialize_usbh1_port(struct 
 	void __iomem *socregs_base;
 
 	mxc_iomux_v3_setup_pad(usbh1gpio);
-	gpio_request(EFIKAMX_USBH1_STP, "usbh1_stp");
-	gpio_direction_output(EFIKAMX_USBH1_STP, 0);
+	gpio_request_one(EFIKAMX_USBH1_STP, GPIOF_OUT_INIT_LOW, "usbh1_stp");
 	msleep(1);
 	gpio_set_value(EFIKAMX_USBH1_STP, 1);
 	msleep(1);
@@ -200,8 +199,8 @@ static struct mxc_usbh_platform_data usb
 
 static void mx51_efika_hubreset(void)
 {
-	gpio_request(EFIKAMX_USB_HUB_RESET, "usb_hub_rst");
-	gpio_direction_output(EFIKAMX_USB_HUB_RESET, 1);
+	gpio_request_one(EFIKAMX_USB_HUB_RESET, GPIOF_OUT_INIT_HIGH,
+			 "usb_hub_rst");
 	msleep(1);
 	gpio_set_value(EFIKAMX_USB_HUB_RESET, 0);
 	msleep(1);
@@ -213,8 +212,8 @@ static void __init mx51_efika_usb(void)
 	mx51_efika_hubreset();
 
 	/* pulling it low, means no USB at all... */
-	gpio_request(EFIKA_USB_PHY_RESET, "usb_phy_reset");
-	gpio_direction_output(EFIKA_USB_PHY_RESET, 0);
+	gpio_request_one(EFIKA_USB_PHY_RESET, GPIOF_OUT_INIT_LOW,
+			 "usb_phy_reset");
 	msleep(1);
 	gpio_set_value(EFIKA_USB_PHY_RESET, 1);
 
@@ -623,8 +622,7 @@ void __init efika_board_common_init(void
 	if (machine_is_mx51_efikasb())
 		vgen1_init.constraints.max_uV = 1200000;
 
-	gpio_request(EFIKAMX_PMIC, "pmic irq");
-	gpio_direction_input(EFIKAMX_PMIC);
+	gpio_request_one(EFIKAMX_PMIC, GPIOF_IN, "pmic irq");
 	spi_register_board_info(mx51_efika_spi_board_info,
 		ARRAY_SIZE(mx51_efika_spi_board_info));
 	imx51_add_ecspi(0, &mx51_efika_spi_pdata);
diff -u -p a/arch/arm/mach-mxs/mach-mx28evk.c b/arch/arm/mach-mxs/mach-mx28evk.c
--- a/arch/arm/mach-mxs/mach-mx28evk.c 2011-03-14 17:19:13.000000000 +0100
+++ b/arch/arm/mach-mxs/mach-mx28evk.c 2011-03-21 08:55:24.000000000 +0100
@@ -142,13 +142,13 @@ static void __init mx28evk_fec_reset(voi
 	}
 
 	/* Reset fec phy */
-	ret = gpio_request(MX28EVK_FEC_PHY_RESET, "fec-phy-reset");
+	ret = gpio_request_one(MX28EVK_FEC_PHY_RESET, GPIOF_OUT_INIT_LOW,
+			       "fec-phy-reset");
 	if (ret) {
 		pr_err("Failed to request gpio fec-phy-%s: %d\n", "reset", ret);
 		return;
 	}
 
-	gpio_direction_output(MX28EVK_FEC_PHY_RESET, 0);
 	if (ret) {
 		pr_err("Failed to drive gpio fec-phy-%s: %d\n", "reset", ret);
 		return;
diff -u -p a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
--- a/arch/arm/mach-omap1/board-ams-delta.c 2011-02-11 10:53:31.000000000 +0100
+++ b/arch/arm/mach-omap1/board-ams-delta.c 2011-03-21 08:55:22.000000000 +0100
@@ -364,12 +364,12 @@ static int __init ams_delta_modem_init(v
 	ams_delta_modem_ports[0].irq =
 			gpio_to_irq(AMS_DELTA_GPIO_PIN_MODEM_IRQ);
 
-	err = gpio_request(AMS_DELTA_GPIO_PIN_MODEM_IRQ, "modem");
+	err = gpio_request_one(AMS_DELTA_GPIO_PIN_MODEM_IRQ, GPIOF_IN,
+			       "modem");
 	if (err) {
 		pr_err("Couldn't request gpio pin for modem\n");
 		return err;
 	}
-	gpio_direction_input(AMS_DELTA_GPIO_PIN_MODEM_IRQ);
 
 	ams_delta_latch2_write(
 		AMS_DELTA_LATCH2_MODEM_NRESET | AMS_DELTA_LATCH2_MODEM_CODEC,
diff -u -p a/arch/arm/mach-omap1/board-fsample.c b/arch/arm/mach-omap1/board-fsample.c
--- a/arch/arm/mach-omap1/board-fsample.c 2011-02-11 10:53:31.000000000 +0100
+++ b/arch/arm/mach-omap1/board-fsample.c 2011-03-21 08:55:23.000000000 +0100
@@ -299,9 +299,8 @@ static void __init omap_fsample_init(voi
 {
 	fsample_init_smc91x();
 
-	if (gpio_request(FSAMPLE_NAND_RB_GPIO_PIN, "NAND ready") < 0)
+	if (gpio_request_one(FSAMPLE_NAND_RB_GPIO_PIN, GPIOF_IN, "NAND ready") < 0)
 		BUG();
-	gpio_direction_input(FSAMPLE_NAND_RB_GPIO_PIN);
 
 	omap_cfg_reg(L3_1610_FLASH_CS2B_OE);
 	omap_cfg_reg(M8_1610_FLASH_CS2B_WE);
diff -u -p a/arch/arm/mach-omap1/board-h2-mmc.c b/arch/arm/mach-omap1/board-h2-mmc.c
--- a/arch/arm/mach-omap1/board-h2-mmc.c 2010-10-04 07:26:41.000000000 +0200
+++ b/arch/arm/mach-omap1/board-h2-mmc.c 2011-03-21 08:55:24.000000000 +0100
@@ -32,12 +32,11 @@ static int mmc_set_power(struct device *
 
 static int mmc_late_init(struct device *dev)
 {
-	int ret = gpio_request(H2_TPS_GPIO_MMC_PWR_EN, "MMC power");
+	int ret = gpio_request_one(H2_TPS_GPIO_MMC_PWR_EN,
+				   GPIOF_OUT_INIT_LOW, "MMC power");
 	if (ret < 0)
 		return ret;
 
-	gpio_direction_output(H2_TPS_GPIO_MMC_PWR_EN, 0);
-
 	return ret;
 }
 
diff -u -p a/arch/arm/mach-omap1/board-h2.c b/arch/arm/mach-omap1/board-h2.c
--- a/arch/arm/mach-omap1/board-h2.c 2011-02-11 10:53:31.000000000 +0100
+++ b/arch/arm/mach-omap1/board-h2.c 2011-03-21 08:55:24.000000000 +0100
@@ -420,9 +420,8 @@ static void __init h2_init(void)
 
 	h2_nand_resource.end = h2_nand_resource.start = OMAP_CS2B_PHYS;
 	h2_nand_resource.end += SZ_4K - 1;
-	if (gpio_request(H2_NAND_RB_GPIO_PIN, "NAND ready") < 0)
+	if (gpio_request_one(H2_NAND_RB_GPIO_PIN, GPIOF_IN, "NAND ready") < 0)
 		BUG();
-	gpio_direction_input(H2_NAND_RB_GPIO_PIN);
 
 	omap_cfg_reg(L3_1610_FLASH_CS2B_OE);
 	omap_cfg_reg(M8_1610_FLASH_CS2B_WE);
diff -u -p a/arch/arm/mach-omap1/board-h3-mmc.c b/arch/arm/mach-omap1/board-h3-mmc.c
--- a/arch/arm/mach-omap1/board-h3-mmc.c 2010-10-04 07:26:41.000000000 +0200
+++ b/arch/arm/mach-omap1/board-h3-mmc.c 2011-03-21 08:55:24.000000000 +0100
@@ -51,10 +51,10 @@ void __init h3_mmc_init(void)
 {
 	int ret;
 
-	ret = gpio_request(H3_TPS_GPIO_MMC_PWR_EN, "MMC power");
+	ret = gpio_request_one(H3_TPS_GPIO_MMC_PWR_EN, GPIOF_OUT_INIT_LOW,
+			       "MMC power");
 	if (ret < 0)
 		return;
-	gpio_direction_output(H3_TPS_GPIO_MMC_PWR_EN, 0);
 
 	mmc_data[0] = &mmc1_data;
 	omap1_init_mmc(mmc_data, OMAP16XX_NR_MMC);
diff -u -p a/arch/arm/mach-omap1/board-h3.c b/arch/arm/mach-omap1/board-h3.c
--- a/arch/arm/mach-omap1/board-h3.c 2011-02-11 10:53:31.000000000 +0100
+++ b/arch/arm/mach-omap1/board-h3.c 2011-03-21 08:55:24.000000000 +0100
@@ -403,9 +403,8 @@ static void __init h3_init(void)
 
 	nand_resource.end = nand_resource.start = OMAP_CS2B_PHYS;
 	nand_resource.end += SZ_4K - 1;
-	if (gpio_request(H3_NAND_RB_GPIO_PIN, "NAND ready") < 0)
+	if (gpio_request_one(H3_NAND_RB_GPIO_PIN, GPIOF_IN, "NAND ready") < 0)
 		BUG();
-	gpio_direction_input(H3_NAND_RB_GPIO_PIN);
 
 	/* GPIO10 Func_MUX_CTRL reg bit 29:27, Configure V2 to mode1 as GPIO */
 	/* GPIO10 pullup/down register, Enable pullup on GPIO10 */
diff -u -p a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/board-nokia770.c
--- a/arch/arm/mach-omap1/board-nokia770.c 2011-02-11 10:53:31.000000000 +0100
+++ b/arch/arm/mach-omap1/board-nokia770.c 2011-03-21 08:55:24.000000000 +0100
@@ -221,17 +221,17 @@ static void __init nokia770_mmc_init(voi
 {
 	int ret;
 
-	ret = gpio_request(NOKIA770_GPIO_MMC_POWER, "MMC power");
+	ret = gpio_request_one(NOKIA770_GPIO_MMC_POWER, GPIOF_OUT_INIT_LOW,
+			       "MMC power");
 	if (ret < 0)
 		return;
-	gpio_direction_output(NOKIA770_GPIO_MMC_POWER, 0);
 
-	ret = gpio_request(NOKIA770_GPIO_MMC_SWITCH, "MMC cover");
+	ret = gpio_request_one(NOKIA770_GPIO_MMC_SWITCH, GPIOF_IN,
+			       "MMC cover");
 	if (ret < 0) {
 		gpio_free(NOKIA770_GPIO_MMC_POWER);
 		return;
 	}
-	gpio_direction_input(NOKIA770_GPIO_MMC_SWITCH);
 
 	/* Only the second MMC controller is used */
 	nokia770_mmc_data[1] = &nokia770_mmc2_data;
diff -u -p a/arch/arm/mach-omap1/board-osk.c b/arch/arm/mach-omap1/board-osk.c
--- a/arch/arm/mach-omap1/board-osk.c 2010-12-28 18:26:02.000000000 +0100
+++ b/arch/arm/mach-omap1/board-osk.c 2011-03-21 08:55:23.000000000 +0100
@@ -197,19 +197,19 @@ static int osk_tps_setup(struct i2c_clie
 	/* Set GPIO 1 HIGH to disable VBUS power supply;
 	 * OHCI driver powers it up/down as needed.
 	 */
-	gpio_request(OSK_TPS_GPIO_USB_PWR_EN, "n_vbus_en");
-	gpio_direction_output(OSK_TPS_GPIO_USB_PWR_EN, 1);
+	gpio_request_one(OSK_TPS_GPIO_USB_PWR_EN, GPIOF_OUT_INIT_HIGH,
+			 "n_vbus_en");
 
 	/* Set GPIO 2 high so LED D3 is off by default */
 	tps65010_set_gpio_out_value(GPIO2, HIGH);
 
 	/* Set GPIO 3 low to take ethernet out of reset */
-	gpio_request(OSK_TPS_GPIO_LAN_RESET, "smc_reset");
-	gpio_direction_output(OSK_TPS_GPIO_LAN_RESET, 0);
+	gpio_request_one(OSK_TPS_GPIO_LAN_RESET, GPIOF_OUT_INIT_LOW,
+			 "smc_reset");
 
 	/* GPIO4 is VDD_DSP */
-	gpio_request(OSK_TPS_GPIO_DSP_PWR_EN, "dsp_power");
-	gpio_direction_output(OSK_TPS_GPIO_DSP_PWR_EN, 1);
+	gpio_request_one(OSK_TPS_GPIO_DSP_PWR_EN, GPIOF_OUT_INIT_HIGH,
+			 "dsp_power");
 	/* REVISIT if DSP support isn't configured, power it off ... */
 
 	/* Let LED1 (D9) blink; leds-gpio may override it */
@@ -476,12 +476,10 @@ static void __init osk_mistral_init(void
 
 
 	/* omap_cfg_reg(P19_1610_GPIO6); */	/* BUSY */
-	gpio_request(6, "ts_busy");
-	gpio_direction_input(6);
+	gpio_request_one(6, GPIOF_IN, "ts_busy");
 
 	omap_cfg_reg(P20_1610_GPIO4);	/* PENIRQ */
-	gpio_request(4, "ts_int");
-	gpio_direction_input(4);
+	gpio_request_one(4, GPIOF_IN, "ts_int");
 	set_irq_type(gpio_to_irq(4), IRQ_TYPE_EDGE_FALLING);
 
 	spi_register_board_info(mistral_boardinfo,
diff -u -p a/arch/arm/mach-omap1/board-palmte.c b/arch/arm/mach-omap1/board-palmte.c
--- a/arch/arm/mach-omap1/board-palmte.c 2011-02-11 10:53:31.000000000 +0100
+++ b/arch/arm/mach-omap1/board-palmte.c 2011-03-21 08:55:23.000000000 +0100
@@ -233,18 +233,16 @@ static struct spi_board_info palmte_spi_
 static void __init palmte_misc_gpio_setup(void)
 {
 	/* Set TSC2102 PINTDAV pin as input (used by TSC2102 driver) */
-	if (gpio_request(PALMTE_PINTDAV_GPIO, "TSC2102 PINTDAV") < 0) {
+	if (gpio_request_one(PALMTE_PINTDAV_GPIO, GPIOF_IN, "TSC2102 PINTDAV") < 0) {
 		printk(KERN_ERR "Could not reserve PINTDAV GPIO!\n");
 		return;
 	}
-	gpio_direction_input(PALMTE_PINTDAV_GPIO);
 
 	/* Set USB-or-DC-IN pin as input (unused) */
-	if (gpio_request(PALMTE_USB_OR_DC_GPIO, "USB/DC-IN") < 0) {
+	if (gpio_request_one(PALMTE_USB_OR_DC_GPIO, GPIOF_IN, "USB/DC-IN") < 0) {
 		printk(KERN_ERR "Could not reserve cable signal GPIO!\n");
 		return;
 	}
-	gpio_direction_input(PALMTE_USB_OR_DC_GPIO);
 }
 
 static void __init omap_palmte_init(void)
diff -u -p a/arch/arm/mach-omap1/board-palmz71.c b/arch/arm/mach-omap1/board-palmz71.c
--- a/arch/arm/mach-omap1/board-palmz71.c 2010-12-28 18:26:02.000000000 +0100
+++ b/arch/arm/mach-omap1/board-palmz71.c 2011-03-21 08:55:23.000000000 +0100
@@ -285,19 +285,18 @@ palmz71_gpio_setup(int early)
 		gpio_direction_output(1, 1);
 	} else {
 		/* Set MMC/SD host WP pin as input */
-		if (gpio_request(PALMZ71_MMC_WP_GPIO, "MMC WP") < 0) {
+		if (gpio_request_one(PALMZ71_MMC_WP_GPIO, GPIOF_IN, "MMC WP") < 0) {
 			printk(KERN_ERR "Could not reserve WP GPIO!\n");
 			return;
 		}
-		gpio_direction_input(PALMZ71_MMC_WP_GPIO);
 
 		/* Monitor the Power-cable-connected signal */
-		if (gpio_request(PALMZ71_USBDETECT_GPIO, "USB detect") < 0) {
+		if (gpio_request_one(PALMZ71_USBDETECT_GPIO, GPIOF_IN,
+				     "USB detect") < 0) {
 			printk(KERN_ERR
 				"Could not reserve cable signal GPIO!\n");
 			return;
 		}
-		gpio_direction_input(PALMZ71_USBDETECT_GPIO);
 		if (request_irq(gpio_to_irq(PALMZ71_USBDETECT_GPIO),
 				palmz71_powercable, IRQF_SAMPLE_RANDOM,
 				"palmz71-cable", 0))
diff -u -p a/arch/arm/mach-omap1/board-perseus2.c b/arch/arm/mach-omap1/board-perseus2.c
--- a/arch/arm/mach-omap1/board-perseus2.c 2010-12-28 18:26:02.000000000 +0100
+++ b/arch/arm/mach-omap1/board-perseus2.c 2011-03-21 08:55:22.000000000 +0100
@@ -267,9 +267,8 @@ static void __init omap_perseus2_init(vo
 {
 	perseus2_init_smc91x();
 
-	if (gpio_request(P2_NAND_RB_GPIO_PIN, "NAND ready") < 0)
+	if (gpio_request_one(P2_NAND_RB_GPIO_PIN, GPIOF_IN, "NAND ready") < 0)
 		BUG();
-	gpio_direction_input(P2_NAND_RB_GPIO_PIN);
 
 	omap_cfg_reg(L3_1610_FLASH_CS2B_OE);
 	omap_cfg_reg(M8_1610_FLASH_CS2B_WE);
diff -u -p a/arch/arm/mach-omap1/board-voiceblue.c b/arch/arm/mach-omap1/board-voiceblue.c
--- a/arch/arm/mach-omap1/board-voiceblue.c 2011-02-11 10:53:31.000000000 +0100
+++ b/arch/arm/mach-omap1/board-voiceblue.c 2011-03-21 08:55:24.000000000 +0100
@@ -264,16 +264,14 @@ static void __init voiceblue_init(void)
 	/* Watchdog */
 	gpio_request(0, "Watchdog");
 	/* smc91x reset */
-	gpio_request(7, "SMC91x reset");
-	gpio_direction_output(7, 1);
+	gpio_request_one(7, GPIOF_OUT_INIT_HIGH, "SMC91x reset");
 	udelay(2);	/* wait@least 100ns */
 	gpio_set_value(7, 0);
 	mdelay(50);	/* 50ms until PHY ready */
 	/* smc91x interrupt pin */
 	gpio_request(8, "SMC91x irq");
 	/* 16C554 reset*/
-	gpio_request(6, "16C554 reset");
-	gpio_direction_output(6, 0);
+	gpio_request_one(6, GPIOF_OUT_INIT_LOW, "16C554 reset");
 	/* 16C554 interrupt pins */
 	gpio_request(12, "16C554 irq");
 	gpio_request(13, "16C554 irq");
diff -u -p a/arch/arm/mach-omap1/fpga.c b/arch/arm/mach-omap1/fpga.c
--- a/arch/arm/mach-omap1/fpga.c 2011-01-19 18:51:18.000000000 +0100
+++ b/arch/arm/mach-omap1/fpga.c 2011-03-21 08:55:24.000000000 +0100
@@ -177,12 +177,11 @@ void omap1510_fpga_init_irq(void)
 	 * NOTE: For general GPIO/MPUIO access and interrupts, please see
 	 * gpio.[ch]
 	 */
-	res = gpio_request(13, "FPGA irq");
+	res = gpio_request_one(13, GPIOF_IN, "FPGA irq");
 	if (res) {
 		pr_err("%s failed to get gpio\n", __func__);
 		return;
 	}
-	gpio_direction_input(13);
 	set_irq_type(gpio_to_irq(13), IRQ_TYPE_EDGE_RISING);
 	set_irq_chained_handler(OMAP1510_INT_FPGA, innovator_fpga_IRQ_demux);
 }
diff -u -p a/arch/arm/mach-omap1/serial.c b/arch/arm/mach-omap1/serial.c
--- a/arch/arm/mach-omap1/serial.c 2010-12-26 10:19:06.000000000 +0100
+++ b/arch/arm/mach-omap1/serial.c 2011-03-21 08:55:23.000000000 +0100
@@ -220,13 +220,12 @@ static void __init omap_serial_set_port_
 {
 	int ret;
 
-	ret = gpio_request(gpio_nr, "UART wake");
+	ret = gpio_request_one(gpio_nr, GPIOF_IN, "UART wake");
 	if (ret < 0) {
 		printk(KERN_ERR "Could not request UART wake GPIO: %i\n",
 		       gpio_nr);
 		return;
 	}
-	gpio_direction_input(gpio_nr);
 	ret = request_irq(gpio_to_irq(gpio_nr), &omap_serial_wake_interrupt,
 			  IRQF_TRIGGER_RISING, "serial wakeup", NULL);
 	if (ret) {
diff -u -p a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
--- a/arch/arm/mach-omap2/board-3430sdp.c 2011-03-14 17:19:13.000000000 +0100
+++ b/arch/arm/mach-omap2/board-3430sdp.c 2011-03-21 08:55:23.000000000 +0100
@@ -132,12 +132,11 @@ static int ts_gpio;	/* Needed for ads784
  */
 static void ads7846_dev_init(void)
 {
-	if (gpio_request(ts_gpio, "ADS7846 pendown") < 0) {
+	if (gpio_request_one(ts_gpio, GPIOF_IN, "ADS7846 pendown") < 0) {
 		printk(KERN_ERR "can't get ads746 pen down GPIO\n");
 		return;
 	}
 
-	gpio_direction_input(ts_gpio);
 	gpio_set_debounce(ts_gpio, 310);
 }
 
@@ -360,12 +359,10 @@ static int sdp3430_twl_gpio_setup(struct
 	omap2_hsmmc_init(mmc);
 
 	/* gpio + 7 is "sub_lcd_en_bkl" (output/PWM1) */
-	gpio_request(gpio + 7, "sub_lcd_en_bkl");
-	gpio_direction_output(gpio + 7, 0);
+	gpio_request_one(gpio + 7, GPIOF_OUT_INIT_LOW, "sub_lcd_en_bkl");
 
 	/* gpio + 15 is "sub_lcd_nRST" (output) */
-	gpio_request(gpio + 15, "sub_lcd_nRST");
-	gpio_direction_output(gpio + 15, 0);
+	gpio_request_one(gpio + 15, GPIOF_OUT_INIT_LOW, "sub_lcd_nRST");
 
 	return 0;
 }
diff -u -p a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
--- a/arch/arm/mach-omap2/board-am3517evm.c 2011-03-14 17:19:13.000000000 +0100
+++ b/arch/arm/mach-omap2/board-am3517evm.c 2011-03-21 08:55:25.000000000 +0100
@@ -252,30 +252,29 @@ static void __init am3517_evm_display_in
 	/*
 	 * Enable GPIO 182 = LCD Backlight Power
 	 */
-	r = gpio_request(LCD_PANEL_BKLIGHT_PWR, "lcd_backlight_pwr");
+	r = gpio_request_one(LCD_PANEL_BKLIGHT_PWR, GPIOF_OUT_INIT_HIGH,
+			     "lcd_backlight_pwr");
 	if (r) {
 		printk(KERN_ERR "failed to get lcd_backlight_pwr\n");
 		return;
 	}
-	gpio_direction_output(LCD_PANEL_BKLIGHT_PWR, 1);
 	/*
 	 * Enable GPIO 181 = LCD Panel PWM
 	 */
-	r = gpio_request(LCD_PANEL_PWM, "lcd_pwm");
+	r = gpio_request_one(LCD_PANEL_PWM, GPIOF_OUT_INIT_HIGH, "lcd_pwm");
 	if (r) {
 		printk(KERN_ERR "failed to get lcd_pwm\n");
 		goto err_1;
 	}
-	gpio_direction_output(LCD_PANEL_PWM, 1);
 	/*
 	 * Enable GPIO 176 = LCD Panel Power enable pin
 	 */
-	r = gpio_request(LCD_PANEL_PWR, "lcd_panel_pwr");
+	r = gpio_request_one(LCD_PANEL_PWR, GPIOF_OUT_INIT_HIGH,
+			     "lcd_panel_pwr");
 	if (r) {
 		printk(KERN_ERR "failed to get lcd_panel_pwr\n");
 		goto err_2;
 	}
-	gpio_direction_output(LCD_PANEL_PWR, 1);
 
 	printk(KERN_INFO "Display initialized successfully\n");
 	return;
diff -u -p a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-omap2/board-apollon.c
--- a/arch/arm/mach-omap2/board-apollon.c 2011-03-14 17:19:13.000000000 +0100
+++ b/arch/arm/mach-omap2/board-apollon.c 2011-03-21 08:55:24.000000000 +0100
@@ -246,13 +246,12 @@ static inline void __init apollon_init_s
 	udelay(100);
 
 	omap_mux_init_gpio(74, 0);
-	if (gpio_request(APOLLON_ETHR_GPIO_IRQ, "SMC91x irq") < 0) {
+	if (gpio_request_one(APOLLON_ETHR_GPIO_IRQ, GPIOF_IN, "SMC91x irq") < 0) {
 		printk(KERN_ERR "Failed to request GPIO%d for smc91x IRQ\n",
 			APOLLON_ETHR_GPIO_IRQ);
 		gpmc_cs_free(APOLLON_ETH_CS);
 		goto out;
 	}
-	gpio_direction_input(APOLLON_ETHR_GPIO_IRQ);
 
 out:
 	clk_disable(gpmc_fck);
@@ -284,16 +283,13 @@ static void __init apollon_led_init(void
 {
 	/* LED0 - AA10 */
 	omap_mux_init_signal("vlynq_clk.gpio_13", 0);
-	gpio_request(LED0_GPIO13, "LED0");
-	gpio_direction_output(LED0_GPIO13, 0);
+	gpio_request_one(LED0_GPIO13, GPIOF_OUT_INIT_LOW, "LED0");
 	/* LED1  - AA6 */
 	omap_mux_init_signal("vlynq_rx1.gpio_14", 0);
-	gpio_request(LED1_GPIO14, "LED1");
-	gpio_direction_output(LED1_GPIO14, 0);
+	gpio_request_one(LED1_GPIO14, GPIOF_OUT_INIT_LOW, "LED1");
 	/* LED2  - AA4 */
 	omap_mux_init_signal("vlynq_rx0.gpio_15", 0);
-	gpio_request(LED2_GPIO15, "LED2");
-	gpio_direction_output(LED2_GPIO15, 0);
+	gpio_request_one(LED2_GPIO15, GPIOF_OUT_INIT_LOW, "LED2");
 }
 
 static void __init apollon_usb_init(void)
@@ -301,8 +297,7 @@ static void __init apollon_usb_init(void
 	/* USB device */
 	/* DEVICE_SUSPEND */
 	omap_mux_init_signal("mcbsp2_clkx.gpio_12", 0);
-	gpio_request(12, "USB suspend");
-	gpio_direction_output(12, 0);
+	gpio_request_one(12, GPIOF_OUT_INIT_LOW, "USB suspend");
 	omap2_usbfs_init(&apollon_usb_config);
 }
 
diff -u -p a/arch/arm/mach-omap2/board-cm-t3517.c b/arch/arm/mach-omap2/board-cm-t3517.c
--- a/arch/arm/mach-omap2/board-cm-t3517.c 2011-03-14 17:19:13.000000000 +0100
+++ b/arch/arm/mach-omap2/board-cm-t3517.c 2011-03-21 08:55:25.000000000 +0100
@@ -148,14 +148,13 @@ static void __init cm_t3517_init_rtc(voi
 {
 	int err;
 
-	err = gpio_request(RTC_CS_EN_GPIO, "rtc cs en");
+	err = gpio_request_one(RTC_CS_EN_GPIO, GPIOF_OUT_INIT_HIGH,
+			       "rtc cs en");
 	if (err) {
 		pr_err("CM-T3517: rtc cs en gpio request failed: %d\n", err);
 		return;
 	}
 
-	gpio_direction_output(RTC_CS_EN_GPIO, 1);
-
 	platform_device_register(&cm_t3517_rtc_device);
 }
 #else
diff -u -p a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
--- a/arch/arm/mach-omap2/board-devkit8000.c 2011-03-14 17:19:13.000000000 +0100
+++ b/arch/arm/mach-omap2/board-devkit8000.c 2011-03-21 08:55:26.000000000 +0100
@@ -468,14 +468,12 @@ static void __init devkit8000_ads7846_in
 	int gpio = OMAP3_DEVKIT_TS_GPIO;
 	int ret;
 
-	ret = gpio_request(gpio, "ads7846_pen_down");
+	ret = gpio_request_one(gpio, GPIOF_IN, "ads7846_pen_down");
 	if (ret < 0) {
 		printk(KERN_ERR "Failed to request GPIO %d for "
 				"ads7846 pen down IRQ\n", gpio);
 		return;
 	}
-
-	gpio_direction_input(gpio);
 }
 
 static int ads7846_get_pendown_state(void)
@@ -551,14 +549,12 @@ static void __init omap_dm9000_init(void
 	unsigned char *eth_addr = omap_dm9000_platdata.dev_addr;
 	struct omap_die_id odi;
 
-	if (gpio_request(OMAP_DM9000_GPIO_IRQ, "dm9000 irq") < 0) {
+	if (gpio_request_one(OMAP_DM9000_GPIO_IRQ, GPIOF_IN, "dm9000 irq") < 0) {
 		printk(KERN_ERR "Failed to request GPIO%d for dm9000 IRQ\n",
 			OMAP_DM9000_GPIO_IRQ);
 		return;
 		}
 
-	gpio_direction_input(OMAP_DM9000_GPIO_IRQ);
-
 	/* init the mac address using DIE id */
 	omap_get_die_id(&odi);
 
diff -u -p a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
--- a/arch/arm/mach-omap2/board-ldp.c 2011-03-14 17:19:13.000000000 +0100
+++ b/arch/arm/mach-omap2/board-ldp.c 2011-03-21 08:55:25.000000000 +0100
@@ -206,12 +206,11 @@ static int ts_gpio;
  */
 static void ads7846_dev_init(void)
 {
-	if (gpio_request(ts_gpio, "ads7846 irq") < 0) {
+	if (gpio_request_one(ts_gpio, GPIOF_IN, "ads7846 irq") < 0) {
 		printk(KERN_ERR "can't get ads746 pen down GPIO\n");
 		return;
 	}
 
-	gpio_direction_input(ts_gpio);
 	gpio_set_debounce(ts_gpio, 310);
 }
 
@@ -267,12 +266,11 @@ static inline void __init ldp_init_smsc9
 
 	ldp_smsc911x_resources[1].start = OMAP_GPIO_IRQ(eth_gpio);
 
-	if (gpio_request(eth_gpio, "smsc911x irq") < 0) {
+	if (gpio_request_one(eth_gpio, GPIOF_IN, "smsc911x irq") < 0) {
 		printk(KERN_ERR "Failed to request GPIO%d for smsc911x IRQ\n",
 				eth_gpio);
 		return;
 	}
-	gpio_direction_input(eth_gpio);
 }
 
 static struct platform_device ldp_lcd_device = {
diff -u -p a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
--- a/arch/arm/mach-omap2/board-n8x0.c 2011-03-14 17:19:13.000000000 +0100
+++ b/arch/arm/mach-omap2/board-n8x0.c 2011-03-21 08:55:24.000000000 +0100
@@ -106,13 +106,13 @@ static void __init n8x0_usb_init(void)
 	static char	announce[] __initdata = KERN_INFO "TUSB 6010\n";
 
 	/* PM companion chip power control pin */
-	ret = gpio_request(TUSB6010_GPIO_ENABLE, "TUSB6010 enable");
+	ret = gpio_request_one(TUSB6010_GPIO_ENABLE, GPIOF_OUT_INIT_LOW,
+			       "TUSB6010 enable");
 	if (ret != 0) {
 		printk(KERN_ERR "Could not get TUSB power GPIO%i\n",
 		       TUSB6010_GPIO_ENABLE);
 		return;
 	}
-	gpio_direction_output(TUSB6010_GPIO_ENABLE, 0);
 
 	tusb_set_power(0);
 
@@ -512,27 +512,26 @@ static void __init n8x0_mmc_init(void)
 		mmc1_data.slots[1].ban_openended = 1;
 	}
 
-	err = gpio_request(N8X0_SLOT_SWITCH_GPIO, "MMC slot switch");
+	err = gpio_request_one(N8X0_SLOT_SWITCH_GPIO, GPIOF_OUT_INIT_LOW,
+			       "MMC slot switch");
 	if (err)
 		return;
 
-	gpio_direction_output(N8X0_SLOT_SWITCH_GPIO, 0);
-
 	if (machine_is_nokia_n810()) {
-		err = gpio_request(N810_EMMC_VSD_GPIO, "MMC slot 2 Vddf");
+		err = gpio_request_one(N810_EMMC_VSD_GPIO,
+				       GPIOF_OUT_INIT_LOW, "MMC slot 2 Vddf");
 		if (err) {
 			gpio_free(N8X0_SLOT_SWITCH_GPIO);
 			return;
 		}
-		gpio_direction_output(N810_EMMC_VSD_GPIO, 0);
 
-		err = gpio_request(N810_EMMC_VIO_GPIO, "MMC slot 2 Vdd");
+		err = gpio_request_one(N810_EMMC_VIO_GPIO,
+				       GPIOF_OUT_INIT_LOW, "MMC slot 2 Vdd");
 		if (err) {
 			gpio_free(N8X0_SLOT_SWITCH_GPIO);
 			gpio_free(N810_EMMC_VSD_GPIO);
 			return;
 		}
-		gpio_direction_output(N810_EMMC_VIO_GPIO, 0);
 	}
 
 	mmc_data[0] = &mmc1_data;
diff -u -p a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
--- a/arch/arm/mach-omap2/board-omap3beagle.c 2011-03-14 17:19:13.000000000 +0100
+++ b/arch/arm/mach-omap2/board-omap3beagle.c 2011-03-21 08:55:25.000000000 +0100
@@ -243,13 +243,12 @@ static void __init beagle_display_init(v
 {
 	int r;
 
-	r = gpio_request(beagle_dvi_device.reset_gpio, "DVI reset");
+	r = gpio_request_one(beagle_dvi_device.reset_gpio,
+			     GPIOF_OUT_INIT_LOW, "DVI reset");
 	if (r < 0) {
 		printk(KERN_ERR "Unable to get DVI reset GPIO\n");
 		return;
 	}
-
-	gpio_direction_output(beagle_dvi_device.reset_gpio, 0);
 }
 
 #include "sdram-micron-mt46h32m32lf-6.h"
diff -u -p a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
--- a/arch/arm/mach-omap2/board-omap3evm.c 2011-03-14 17:19:13.000000000 +0100
+++ b/arch/arm/mach-omap2/board-omap3evm.c 2011-03-21 08:55:23.000000000 +0100
@@ -171,13 +171,12 @@ static inline void __init omap3evm_init_
 		usleep_range(1, 2);
 	}
 
-	if (gpio_request(OMAP3EVM_ETHR_GPIO_IRQ, "SMSC911x irq") < 0) {
+	if (gpio_request_one(OMAP3EVM_ETHR_GPIO_IRQ, GPIOF_IN, "SMSC911x irq") < 0) {
 		printk(KERN_ERR "Failed to request GPIO%d for smsc911x IRQ\n",
 			OMAP3EVM_ETHR_GPIO_IRQ);
 		return;
 	}
 
-	gpio_direction_input(OMAP3EVM_ETHR_GPIO_IRQ);
 	platform_device_register(&omap3evm_smsc911x_device);
 }
 
@@ -204,47 +203,47 @@ static void __init omap3_evm_display_ini
 {
 	int r;
 
-	r = gpio_request(OMAP3EVM_LCD_PANEL_RESB, "lcd_panel_resb");
+	r = gpio_request_one(OMAP3EVM_LCD_PANEL_RESB, GPIOF_OUT_INIT_HIGH,
+			     "lcd_panel_resb");
 	if (r) {
 		printk(KERN_ERR "failed to get lcd_panel_resb\n");
 		return;
 	}
-	gpio_direction_output(OMAP3EVM_LCD_PANEL_RESB, 1);
 
-	r = gpio_request(OMAP3EVM_LCD_PANEL_INI, "lcd_panel_ini");
+	r = gpio_request_one(OMAP3EVM_LCD_PANEL_INI, GPIOF_OUT_INIT_HIGH,
+			     "lcd_panel_ini");
 	if (r) {
 		printk(KERN_ERR "failed to get lcd_panel_ini\n");
 		goto err_1;
 	}
-	gpio_direction_output(OMAP3EVM_LCD_PANEL_INI, 1);
 
-	r = gpio_request(OMAP3EVM_LCD_PANEL_QVGA, "lcd_panel_qvga");
+	r = gpio_request_one(OMAP3EVM_LCD_PANEL_QVGA, GPIOF_OUT_INIT_LOW,
+			     "lcd_panel_qvga");
 	if (r) {
 		printk(KERN_ERR "failed to get lcd_panel_qvga\n");
 		goto err_2;
 	}
-	gpio_direction_output(OMAP3EVM_LCD_PANEL_QVGA, 0);
 
-	r = gpio_request(OMAP3EVM_LCD_PANEL_LR, "lcd_panel_lr");
+	r = gpio_request_one(OMAP3EVM_LCD_PANEL_LR, GPIOF_OUT_INIT_HIGH,
+			     "lcd_panel_lr");
 	if (r) {
 		printk(KERN_ERR "failed to get lcd_panel_lr\n");
 		goto err_3;
 	}
-	gpio_direction_output(OMAP3EVM_LCD_PANEL_LR, 1);
 
-	r = gpio_request(OMAP3EVM_LCD_PANEL_UD, "lcd_panel_ud");
+	r = gpio_request_one(OMAP3EVM_LCD_PANEL_UD, GPIOF_OUT_INIT_HIGH,
+			     "lcd_panel_ud");
 	if (r) {
 		printk(KERN_ERR "failed to get lcd_panel_ud\n");
 		goto err_4;
 	}
-	gpio_direction_output(OMAP3EVM_LCD_PANEL_UD, 1);
 
-	r = gpio_request(OMAP3EVM_LCD_PANEL_ENVDD, "lcd_panel_envdd");
+	r = gpio_request_one(OMAP3EVM_LCD_PANEL_ENVDD, GPIOF_OUT_INIT_LOW,
+			     "lcd_panel_envdd");
 	if (r) {
 		printk(KERN_ERR "failed to get lcd_panel_envdd\n");
 		goto err_5;
 	}
-	gpio_direction_output(OMAP3EVM_LCD_PANEL_ENVDD, 0);
 
 	return;
 
@@ -473,8 +472,7 @@ static int omap3evm_twl_gpio_setup(struc
 		printk(KERN_ERR "failed to get/set lcd_bkl gpio\n");
 
 	/* gpio + 7 == DVI Enable */
-	gpio_request(gpio + 7, "EN_DVI");
-	gpio_direction_output(gpio + 7, 0);
+	gpio_request_one(gpio + 7, GPIOF_OUT_INIT_LOW, "EN_DVI");
 
 	/* TWL4030_GPIO_MAX + 1 == ledB (out, active low LED) */
 	gpio_leds[2].gpio = gpio + TWL4030_GPIO_MAX + 1;
@@ -681,10 +679,9 @@ static int __init omap3_evm_i2c_init(voi
 
 static void ads7846_dev_init(void)
 {
-	if (gpio_request(OMAP3_EVM_TS_GPIO, "ADS7846 pendown") < 0)
+	if (gpio_request_one(OMAP3_EVM_TS_GPIO, GPIOF_IN, "ADS7846 pendown") < 0)
 		printk(KERN_ERR "can't get ads7846 pen down GPIO\n");
 
-	gpio_direction_input(OMAP3_EVM_TS_GPIO);
 	gpio_set_debounce(OMAP3_EVM_TS_GPIO, 310);
 }
 
@@ -852,14 +849,14 @@ static void __init omap3_evm_init(void)
 	if (get_omap3_evm_rev() >= OMAP3EVM_BOARD_GEN_2) {
 		/* enable EHCI VBUS using GPIO22 */
 		omap_mux_init_gpio(22, OMAP_PIN_INPUT_PULLUP);
-		gpio_request(OMAP3_EVM_EHCI_VBUS, "enable EHCI VBUS");
-		gpio_direction_output(OMAP3_EVM_EHCI_VBUS, 0);
+		gpio_request_one(OMAP3_EVM_EHCI_VBUS, GPIOF_OUT_INIT_LOW,
+				 "enable EHCI VBUS");
 		gpio_set_value(OMAP3_EVM_EHCI_VBUS, 1);
 
 		/* Select EHCI port on main board */
 		omap_mux_init_gpio(61, OMAP_PIN_INPUT_PULLUP);
-		gpio_request(OMAP3_EVM_EHCI_SELECT, "select EHCI port");
-		gpio_direction_output(OMAP3_EVM_EHCI_SELECT, 0);
+		gpio_request_one(OMAP3_EVM_EHCI_SELECT, GPIOF_OUT_INIT_LOW,
+				 "select EHCI port");
 		gpio_set_value(OMAP3_EVM_EHCI_SELECT, 0);
 
 		/* setup EHCI phy reset config */
diff -u -p a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
--- a/arch/arm/mach-omap2/board-omap3pandora.c 2011-03-14 17:19:13.000000000 +0100
+++ b/arch/arm/mach-omap2/board-omap3pandora.c 2011-03-21 08:55:25.000000000 +0100
@@ -575,14 +575,12 @@ static void __init omap3pandora_ads7846_
 	int gpio = OMAP3_PANDORA_TS_GPIO;
 	int ret;
 
-	ret = gpio_request(gpio, "ads7846_pen_down");
+	ret = gpio_request_one(gpio, GPIOF_IN, "ads7846_pen_down");
 	if (ret < 0) {
 		printk(KERN_ERR "Failed to request GPIO %d for "
 				"ads7846 pen down IRQ\n", gpio);
 		return;
 	}
-
-	gpio_direction_input(gpio);
 }
 
 static int ads7846_get_pendown_state(void)
diff -u -p a/arch/arm/mach-omap2/board-omap3stalker.c b/arch/arm/mach-omap2/board-omap3stalker.c
--- a/arch/arm/mach-omap2/board-omap3stalker.c 2011-03-14 17:19:13.000000000 +0100
+++ b/arch/arm/mach-omap2/board-omap3stalker.c 2011-03-21 08:55:24.000000000 +0100
@@ -107,15 +107,14 @@ static inline void __init omap3stalker_i
 		rate = clk_get_rate(l3ck);
 
 	omap_mux_init_gpio(19, OMAP_PIN_INPUT_PULLUP);
-	if (gpio_request(OMAP3STALKER_ETHR_GPIO_IRQ, "SMC911x irq") < 0) {
+	if (gpio_request_one(OMAP3STALKER_ETHR_GPIO_IRQ, GPIOF_IN,
+			     "SMC911x irq") < 0) {
 		printk(KERN_ERR
 		       "Failed to request GPIO%d for smc911x IRQ\n",
 		       OMAP3STALKER_ETHR_GPIO_IRQ);
 		return;
 	}
 
-	gpio_direction_input(OMAP3STALKER_ETHR_GPIO_IRQ);
-
 	platform_device_register(&omap3stalker_smsc911x_device);
 }
 
@@ -365,12 +364,11 @@ omap3stalker_twl_gpio_setup(struct devic
 	 */
 
 	/* TWL4030_GPIO_MAX + 0 == ledA, LCD Backlight control */
-	gpio_request(gpio + TWL4030_GPIO_MAX, "EN_LCD_BKL");
-	gpio_direction_output(gpio + TWL4030_GPIO_MAX, 0);
+	gpio_request_one(gpio + TWL4030_GPIO_MAX, GPIOF_OUT_INIT_LOW,
+			 "EN_LCD_BKL");
 
 	/* gpio + 7 == DVI Enable */
-	gpio_request(gpio + 7, "EN_DVI");
-	gpio_direction_output(gpio + 7, 0);
+	gpio_request_one(gpio + 7, GPIOF_OUT_INIT_LOW, "EN_DVI");
 
 	/* TWL4030_GPIO_MAX + 1 == ledB (out, mmc0) */
 	gpio_leds[2].gpio = gpio + TWL4030_GPIO_MAX + 1;
@@ -534,10 +532,10 @@ static int __init omap3_stalker_i2c_init
 #define OMAP3_STALKER_TS_GPIO	175
 static void ads7846_dev_init(void)
 {
-	if (gpio_request(OMAP3_STALKER_TS_GPIO, "ADS7846 pendown") < 0)
+	if (gpio_request_one(OMAP3_STALKER_TS_GPIO, GPIOF_IN,
+			     "ADS7846 pendown") < 0)
 		printk(KERN_ERR "can't get ads7846 pen down GPIO\n");
 
-	gpio_direction_input(OMAP3_STALKER_TS_GPIO);
 	gpio_set_debounce(OMAP3_STALKER_TS_GPIO, 310);
 }
 
diff -u -p a/arch/arm/mach-omap2/board-omap3touchbook.c b/arch/arm/mach-omap2/board-omap3touchbook.c
--- a/arch/arm/mach-omap2/board-omap3touchbook.c 2011-03-14 17:19:13.000000000 +0100
+++ b/arch/arm/mach-omap2/board-omap3touchbook.c 2011-03-21 08:55:22.000000000 +0100
@@ -155,12 +155,11 @@ static int touchbook_twl_gpio_setup(stru
 	 * power switch and overcurrent detect
 	 */
 
-	gpio_request(gpio + 1, "EHCI_nOC");
-	gpio_direction_input(gpio + 1);
+	gpio_request_one(gpio + 1, GPIOF_IN, "EHCI_nOC");
 
 	/* TWL4030_GPIO_MAX + 0 == ledA, EHCI nEN_USB_PWR (out, active low) */
-	gpio_request(gpio + TWL4030_GPIO_MAX, "nEN_USB_PWR");
-	gpio_direction_output(gpio + TWL4030_GPIO_MAX, 0);
+	gpio_request_one(gpio + TWL4030_GPIO_MAX, GPIOF_OUT_INIT_LOW,
+			 "nEN_USB_PWR");
 
 	/* TWL4030_GPIO_MAX + 1 == ledB, PMU_STAT (out, active low LED) */
 	gpio_leds[2].gpio = gpio + TWL4030_GPIO_MAX + 1;
@@ -303,13 +302,12 @@ static int __init omap3_touchbook_i2c_in
 
 static void __init omap3_ads7846_init(void)
 {
-	if (gpio_request(OMAP3_TS_GPIO, "ads7846_pen_down")) {
+	if (gpio_request_one(OMAP3_TS_GPIO, GPIOF_IN, "ads7846_pen_down")) {
 		printk(KERN_ERR "Failed to request GPIO %d for "
 				"ads7846 pen down IRQ\n", OMAP3_TS_GPIO);
 		return;
 	}
 
-	gpio_direction_input(OMAP3_TS_GPIO);
 	gpio_set_debounce(OMAP3_TS_GPIO, 310);
 }
 
@@ -483,13 +481,12 @@ static void omap3_touchbook_poweroff(voi
 {
 	int r;
 
-	r = gpio_request(TB_KILL_POWER_GPIO, "DVI reset");
+	r = gpio_request_one(TB_KILL_POWER_GPIO, GPIOF_OUT_INIT_LOW,
+			     "DVI reset");
 	if (r < 0) {
 		printk(KERN_ERR "Unable to get kill power GPIO\n");
 		return;
 	}
-
-	gpio_direction_output(TB_KILL_POWER_GPIO, 0);
 }
 
 static int __init early_touchbook_revision(char *p)
diff -u -p a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c 2011-03-14 17:19:13.000000000 +0100
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c 2011-03-21 08:55:22.000000000 +0100
@@ -557,10 +557,8 @@ static __init void rx51_init_si4713(void
 static int rx51_twlgpio_setup(struct device *dev, unsigned gpio, unsigned n)
 {
 	/* FIXME this gpio setup is just a placeholder for now */
-	gpio_request(gpio + 6, "backlight_pwm");
-	gpio_direction_output(gpio + 6, 0);
-	gpio_request(gpio + 7, "speaker_en");
-	gpio_direction_output(gpio + 7, 1);
+	gpio_request_one(gpio + 6, GPIOF_OUT_INIT_LOW, "backlight_pwm");
+	gpio_request_one(gpio + 7, GPIOF_OUT_INIT_HIGH, "speaker_en");
 
 	return 0;
 }
diff -u -p a/arch/arm/mach-omap2/board-rx51-video.c b/arch/arm/mach-omap2/board-rx51-video.c
--- a/arch/arm/mach-omap2/board-rx51-video.c 2011-02-19 08:28:51.000000000 +0100
+++ b/arch/arm/mach-omap2/board-rx51-video.c 2011-03-21 08:55:24.000000000 +0100
@@ -76,13 +76,12 @@ static int __init rx51_video_init(void)
 		return 0;
 	}
 
-	if (gpio_request(RX51_LCD_RESET_GPIO, "LCD ACX565AKM reset")) {
+	if (gpio_request_one(RX51_LCD_RESET_GPIO, GPIOF_OUT_INIT_HIGH,
+			     "LCD ACX565AKM reset")) {
 		pr_err("%s failed to get LCD Reset GPIO\n", __func__);
 		return 0;
 	}
 
-	gpio_direction_output(RX51_LCD_RESET_GPIO, 1);
-
 	omap_display_init(&rx51_dss_board_info);
 	return 0;
 }
diff -u -p a/arch/arm/mach-omap2/board-zoom-debugboard.c b/arch/arm/mach-omap2/board-zoom-debugboard.c
--- a/arch/arm/mach-omap2/board-zoom-debugboard.c 2010-10-14 18:30:03.000000000 +0200
+++ b/arch/arm/mach-omap2/board-zoom-debugboard.c 2011-03-21 08:55:23.000000000 +0100
@@ -74,12 +74,11 @@ static inline void __init zoom_init_smsc
 
 	zoom_smsc911x_resources[1].start = OMAP_GPIO_IRQ(eth_gpio);
 
-	if (gpio_request(eth_gpio, "smsc911x irq") < 0) {
+	if (gpio_request_one(eth_gpio, GPIOF_IN, "smsc911x irq") < 0) {
 		printk(KERN_ERR "Failed to request GPIO%d for smsc911x IRQ\n",
 				eth_gpio);
 		return;
 	}
-	gpio_direction_input(eth_gpio);
 }
 
 static struct plat_serial8250_port serial_platform_data[] = {
@@ -120,12 +119,11 @@ static inline void __init zoom_init_quad
 
 	quart_gpio = ZOOM_QUADUART_GPIO;
 
-	if (gpio_request(quart_gpio, "TL16CP754C GPIO") < 0) {
+	if (gpio_request_one(quart_gpio, GPIOF_IN, "TL16CP754C GPIO") < 0) {
 		printk(KERN_ERR "Failed to request GPIO%d for TL16CP754C\n",
 								quart_gpio);
 		return;
 	}
-	gpio_direction_input(quart_gpio);
 }
 
 static inline int omap_zoom_debugboard_detect(void)
@@ -135,12 +133,12 @@ static inline int omap_zoom_debugboard_d
 
 	debug_board_detect = ZOOM_SMSC911X_GPIO;
 
-	if (gpio_request(debug_board_detect, "Zoom debug board detect") < 0) {
+	if (gpio_request_one(debug_board_detect, GPIOF_IN,
+			     "Zoom debug board detect") < 0) {
 		printk(KERN_ERR "Failed to request GPIO%d for Zoom debug"
 		"board detect\n", debug_board_detect);
 		return 0;
 	}
-	gpio_direction_input(debug_board_detect);
 
 	if (!gpio_get_value(debug_board_detect)) {
 		ret = 0;
diff -u -p a/arch/arm/mach-omap2/board-zoom-display.c b/arch/arm/mach-omap2/board-zoom-display.c
--- a/arch/arm/mach-omap2/board-zoom-display.c 2011-02-19 08:28:51.000000000 +0100
+++ b/arch/arm/mach-omap2/board-zoom-display.c 2011-03-21 08:55:25.000000000 +0100
@@ -30,21 +30,21 @@ static void zoom_lcd_panel_init(void)
 			LCD_PANEL_RESET_GPIO_PROD :
 			LCD_PANEL_RESET_GPIO_PILOT;
 
-	ret = gpio_request(lcd_panel_reset_gpio, "lcd reset");
+	ret = gpio_request_one(lcd_panel_reset_gpio, GPIOF_OUT_INIT_HIGH,
+			       "lcd reset");
 	if (ret) {
 		pr_err("Failed to get LCD reset GPIO (gpio%d).\n",
 			lcd_panel_reset_gpio);
 		return;
 	}
-	gpio_direction_output(lcd_panel_reset_gpio, 1);
 
-	ret = gpio_request(LCD_PANEL_QVGA_GPIO, "lcd qvga");
+	ret = gpio_request_one(LCD_PANEL_QVGA_GPIO, GPIOF_OUT_INIT_HIGH,
+			       "lcd qvga");
 	if (ret) {
 		pr_err("Failed to get LCD_PANEL_QVGA_GPIO (gpio%d).\n",
 			LCD_PANEL_QVGA_GPIO);
 		goto err0;
 	}
-	gpio_direction_output(LCD_PANEL_QVGA_GPIO, 1);
 
 	return;
 err0:
diff -u -p a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-omap2/board-zoom-peripherals.c
--- a/arch/arm/mach-omap2/board-zoom-peripherals.c 2011-03-14 17:19:13.000000000 +0100
+++ b/arch/arm/mach-omap2/board-zoom-peripherals.c 2011-03-21 08:55:26.000000000 +0100
@@ -276,13 +276,13 @@ static int zoom_twl_gpio_setup(struct de
 	zoom_vsim_supply.dev = mmc[0].dev;
 	zoom_vmmc2_supply.dev = mmc[1].dev;
 
-	ret = gpio_request(LCD_PANEL_ENABLE_GPIO, "lcd enable");
+	ret = gpio_request_one(LCD_PANEL_ENABLE_GPIO, GPIOF_OUT_INIT_LOW,
+			       "lcd enable");
 	if (ret) {
 		pr_err("Failed to get LCD_PANEL_ENABLE_GPIO (gpio%d).\n",
 				LCD_PANEL_ENABLE_GPIO);
 		return ret;
 	}
-	gpio_direction_output(LCD_PANEL_ENABLE_GPIO, 0);
 
 	return ret;
 }
diff -u -p a/arch/arm/mach-omap2/gpmc-smc91x.c b/arch/arm/mach-omap2/gpmc-smc91x.c
--- a/arch/arm/mach-omap2/gpmc-smc91x.c 2009-12-12 00:23:19.000000000 +0100
+++ b/arch/arm/mach-omap2/gpmc-smc91x.c 2011-03-21 08:55:23.000000000 +0100
@@ -147,25 +147,24 @@ void __init gpmc_smc91x_init(struct omap
 			goto free1;
 	}
 
-	if (gpio_request(gpmc_cfg->gpio_irq, "SMC91X irq") < 0)
+	if (gpio_request_one(gpmc_cfg->gpio_irq, GPIOF_IN, "SMC91X irq") < 0)
 		goto free1;
 
-	gpio_direction_input(gpmc_cfg->gpio_irq);
 	gpmc_smc91x_resources[1].start = gpio_to_irq(gpmc_cfg->gpio_irq);
 
 	if (gpmc_cfg->gpio_pwrdwn) {
-		ret = gpio_request(gpmc_cfg->gpio_pwrdwn, "SMC91X powerdown");
+		ret = gpio_request_one(gpmc_cfg->gpio_pwrdwn,
+				       GPIOF_OUT_INIT_LOW, "SMC91X powerdown");
 		if (ret)
 			goto free2;
-		gpio_direction_output(gpmc_cfg->gpio_pwrdwn, 0);
 	}
 
 	if (gpmc_cfg->gpio_reset) {
-		ret = gpio_request(gpmc_cfg->gpio_reset, "SMC91X reset");
+		ret = gpio_request_one(gpmc_cfg->gpio_reset,
+				       GPIOF_OUT_INIT_LOW, "SMC91X reset");
 		if (ret)
 			goto free3;
 
-		gpio_direction_output(gpmc_cfg->gpio_reset, 0);
 		gpio_set_value(gpmc_cfg->gpio_reset, 1);
 		msleep(100);
 		gpio_set_value(gpmc_cfg->gpio_reset, 0);
diff -u -p a/arch/arm/mach-omap2/gpmc-smsc911x.c b/arch/arm/mach-omap2/gpmc-smsc911x.c
--- a/arch/arm/mach-omap2/gpmc-smsc911x.c 2010-09-30 17:54:14.000000000 +0200
+++ b/arch/arm/mach-omap2/gpmc-smsc911x.c 2011-03-21 08:55:25.000000000 +0100
@@ -71,26 +71,25 @@ void __init gpmc_smsc911x_init(struct om
 	gpmc_smsc911x_resources[0].start = cs_mem_base + 0x0;
 	gpmc_smsc911x_resources[0].end = cs_mem_base + 0xff;
 
-	if (gpio_request(gpmc_cfg->gpio_irq, "smsc911x irq") < 0) {
+	if (gpio_request_one(gpmc_cfg->gpio_irq, GPIOF_IN, "smsc911x irq") < 0) {
 		printk(KERN_ERR "Failed to request GPIO%d for smsc911x IRQ\n",
 				gpmc_cfg->gpio_irq);
 		goto free1;
 	}
 
-	gpio_direction_input(gpmc_cfg->gpio_irq);
 	gpmc_smsc911x_resources[1].start = gpio_to_irq(gpmc_cfg->gpio_irq);
 	gpmc_smsc911x_resources[1].flags |=
 					(gpmc_cfg->flags & IRQF_TRIGGER_MASK);
 
 	if (gpio_is_valid(gpmc_cfg->gpio_reset)) {
-		ret = gpio_request(gpmc_cfg->gpio_reset, "smsc911x reset");
+		ret = gpio_request_one(gpmc_cfg->gpio_reset,
+				       GPIOF_OUT_INIT_HIGH, "smsc911x reset");
 		if (ret) {
 			printk(KERN_ERR "Failed to request GPIO%d for smsc911x reset\n",
 					gpmc_cfg->gpio_reset);
 			goto free2;
 		}
 
-		gpio_direction_output(gpmc_cfg->gpio_reset, 1);
 		gpio_set_value(gpmc_cfg->gpio_reset, 0);
 		msleep(100);
 		gpio_set_value(gpmc_cfg->gpio_reset, 1);
diff -u -p a/arch/arm/mach-omap2/usb-tusb6010.c b/arch/arm/mach-omap2/usb-tusb6010.c
--- a/arch/arm/mach-omap2/usb-tusb6010.c 2010-12-28 18:26:02.000000000 +0100
+++ b/arch/arm/mach-omap2/usb-tusb6010.c 2011-03-21 08:55:25.000000000 +0100
@@ -293,12 +293,11 @@ tusb6010_setup_interface(struct musb_hdr
 			);
 
 	/* IRQ */
-	status = gpio_request(irq, "TUSB6010 irq");
+	status = gpio_request_one(irq, GPIOF_IN, "TUSB6010 irq");
 	if (status < 0) {
 		printk(error, 3, status);
 		return status;
 	}
-	gpio_direction_input(irq);
 	tusb_resources[2].start = irq + IH_GPIO_BASE;
 
 	/* set up memory timings ... can speed them up later */
diff -u -p a/arch/arm/mach-orion5x/dns323-setup.c b/arch/arm/mach-orion5x/dns323-setup.c
--- a/arch/arm/mach-orion5x/dns323-setup.c 2011-03-14 17:19:13.000000000 +0100
+++ b/arch/arm/mach-orion5x/dns323-setup.c 2011-03-21 08:55:23.000000000 +0100
@@ -642,8 +642,8 @@ static void __init dns323_init(void)
 		 * DNS323_GPIO_LED_POWER1 to also be low.
 		 */
 		 dns323ab_leds[0].active_low = 1;
-		 gpio_request(DNS323_GPIO_LED_POWER1, "Power Led Enable");
-		 gpio_direction_output(DNS323_GPIO_LED_POWER1, 0);
+		 gpio_request_one(DNS323_GPIO_LED_POWER1, GPIOF_OUT_INIT_LOW,
+				  "Power Led Enable");
 		/* Fall through */
 	case DNS323_REV_B1:
 		i2c_register_board_info(0, dns323ab_i2c_devices,
diff -u -p a/arch/arm/mach-pxa/cm-x270.c b/arch/arm/mach-pxa/cm-x270.c
--- a/arch/arm/mach-pxa/cm-x270.c 2010-12-31 15:18:30.000000000 +0100
+++ b/arch/arm/mach-pxa/cm-x270.c 2011-03-21 08:55:24.000000000 +0100
@@ -208,10 +208,9 @@ static int cmx270_marathon_probe(struct 
 	int gpio, err;
 
 	for (gpio = 58; gpio <= 77; gpio++) {
-		err = gpio_request(gpio, "LCD");
+		err = gpio_request_one(gpio, GPIOF_IN, "LCD");
 		if (err)
 			return err;
-		gpio_direction_input(gpio);
 	}
 
 	pxa2xx_mfp_config(ARRAY_AND_SIZE(cmx270_marathon_on));
diff -u -p a/arch/arm/mach-pxa/cm-x300.c b/arch/arm/mach-pxa/cm-x300.c
--- a/arch/arm/mach-pxa/cm-x300.c 2011-03-14 17:19:13.000000000 +0100
+++ b/arch/arm/mach-pxa/cm-x300.c 2011-03-21 08:55:22.000000000 +0100
@@ -484,14 +484,14 @@ static int cm_x300_ulpi_phy_reset(void)
 	int err;
 
 	/* reset the PHY */
-	err = gpio_request(GPIO_ULPI_PHY_RST, "ulpi reset");
+	err = gpio_request_one(GPIO_ULPI_PHY_RST, GPIOF_OUT_INIT_LOW,
+			       "ulpi reset");
 	if (err) {
 		pr_err("%s: failed to request ULPI reset GPIO: %d\n",
 		       __func__, err);
 		return err;
 	}
 
-	gpio_direction_output(GPIO_ULPI_PHY_RST, 0);
 	msleep(10);
 	gpio_set_value(GPIO_ULPI_PHY_RST, 1);
 	msleep(10);
diff -u -p a/arch/arm/mach-pxa/colibri-pxa3xx.c b/arch/arm/mach-pxa/colibri-pxa3xx.c
--- a/arch/arm/mach-pxa/colibri-pxa3xx.c 2010-12-28 18:26:02.000000000 +0100
+++ b/arch/arm/mach-pxa/colibri-pxa3xx.c 2011-03-21 08:55:22.000000000 +0100
@@ -103,8 +103,7 @@ static struct pxafb_mach_info sharp_lq43
 void __init colibri_pxa3xx_init_lcd(int bl_pin)
 {
 	lcd_bl_pin = bl_pin;
-	gpio_request(bl_pin, "lcd backlight");
-	gpio_direction_output(bl_pin, 0);
+	gpio_request_one(bl_pin, GPIOF_OUT_INIT_LOW, "lcd backlight");
 	set_pxa_fb_info(&sharp_lq43_info);
 }
 #endif
diff -u -p a/arch/arm/mach-pxa/em-x270.c b/arch/arm/mach-pxa/em-x270.c
--- a/arch/arm/mach-pxa/em-x270.c 2011-03-14 17:19:13.000000000 +0100
+++ b/arch/arm/mach-pxa/em-x270.c 2011-03-21 08:55:25.000000000 +0100
@@ -379,23 +379,19 @@ static void __init em_x270_init_nand(voi
 {
 	int err;
 
-	err = gpio_request(GPIO11_NAND_CS, "NAND CS");
+	err = gpio_request_one(GPIO11_NAND_CS, GPIOF_OUT_INIT_HIGH, "NAND CS");
 	if (err) {
 		pr_warning("EM-X270: failed to request NAND CS gpio\n");
 		return;
 	}
 
-	gpio_direction_output(GPIO11_NAND_CS, 1);
-
-	err = gpio_request(nand_rb, "NAND R/B");
+	err = gpio_request_one(nand_rb, GPIOF_IN, "NAND R/B");
 	if (err) {
 		pr_warning("EM-X270: failed to request NAND R/B gpio\n");
 		gpio_free(GPIO11_NAND_CS);
 		return;
 	}
 
-	gpio_direction_input(nand_rb);
-
 	platform_device_register(&em_x270_nand);
 }
 #else
@@ -473,12 +469,11 @@ static int em_x270_usb_hub_init(void)
 	if (err)
 		goto err_free_usb_ldo;
 
-	err = gpio_request(usb_hub_reset, "hub rst");
+	err = gpio_request_one(usb_hub_reset, GPIOF_OUT_INIT_HIGH, "hub rst");
 	if (err)
 		goto err_free_vbus_gpio;
 
 	/* USB Hub power-on and reset */
-	gpio_direction_output(usb_hub_reset, 1);
 	gpio_direction_output(GPIO9_USB_VBUS_EN, 0);
 	regulator_enable(em_x270_usb_ldo);
 	gpio_set_value(usb_hub_reset, 0);
@@ -568,21 +563,20 @@ static int em_x270_mci_init(struct devic
 	}
 
 	if (machine_is_em_x270()) {
-		err = gpio_request(GPIO95_MMC_WP, "MMC WP");
+		err = gpio_request_one(GPIO95_MMC_WP, GPIOF_IN, "MMC WP");
 		if (err) {
 			dev_err(dev, "can't request MMC write protect: %d\n",
 				err);
 			goto err_gpio_wp;
 		}
-		gpio_direction_input(GPIO95_MMC_WP);
 	} else {
-		err = gpio_request(GPIO38_SD_PWEN, "sdio power");
+		err = gpio_request_one(GPIO38_SD_PWEN, GPIOF_OUT_INIT_HIGH,
+				       "sdio power");
 		if (err) {
 			dev_err(dev, "can't request MMC power control : %d\n",
 				err);
 			goto err_gpio_wp;
 		}
-		gpio_direction_output(GPIO38_SD_PWEN, 1);
 	}
 
 	return 0;
@@ -741,11 +735,11 @@ static int em_x270_libertas_setup(struct
 		goto err_free_pwen;
 
 	if (machine_is_exeda()) {
-		err = gpio_request(GPIO37_WLAN_RST, "WLAN RST");
+		err = gpio_request_one(GPIO37_WLAN_RST, GPIOF_OUT_INIT_HIGH,
+				       "WLAN RST");
 		if (err)
 			goto err_free_strap;
 
-		gpio_direction_output(GPIO37_WLAN_RST, 1);
 		msleep(100);
 	}
 
@@ -951,12 +945,10 @@ static int em_x270_sensor_init(void)
 {
 	int ret;
 
-	ret = gpio_request(cam_reset, "camera reset");
+	ret = gpio_request_one(cam_reset, GPIOF_OUT_INIT_LOW, "camera reset");
 	if (ret)
 		return ret;
 
-	gpio_direction_output(cam_reset, 0);
-
 	em_x270_camera_ldo = regulator_get(NULL, "vcc cam");
 	if (em_x270_camera_ldo == NULL) {
 		gpio_free(cam_reset);
diff -u -p a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
--- a/arch/arm/mach-pxa/magician.c 2011-03-14 17:19:13.000000000 +0100
+++ b/arch/arm/mach-pxa/magician.c 2011-03-21 08:55:23.000000000 +0100
@@ -748,8 +748,8 @@ static void __init magician_init(void)
 		lcd_select = board_id & 0x8;
 		pr_info("LCD type: %s\n", lcd_select ? "Samsung" : "Toppoly");
 		if (lcd_select && (system_rev < 3)) {
-			gpio_request(GPIO75_MAGICIAN_SAMSUNG_POWER, "SAMSUNG_POWER");
-			gpio_direction_output(GPIO75_MAGICIAN_SAMSUNG_POWER, 0);
+			gpio_request_one(GPIO75_MAGICIAN_SAMSUNG_POWER,
+					 GPIOF_OUT_INIT_LOW, "SAMSUNG_POWER");
 		}
 		gpio_request(GPIO104_MAGICIAN_LCD_POWER_1, "LCD_POWER_1");
 		gpio_request(GPIO105_MAGICIAN_LCD_POWER_2, "LCD_POWER_2");
diff -u -p a/arch/arm/mach-pxa/saar.c b/arch/arm/mach-pxa/saar.c
--- a/arch/arm/mach-pxa/saar.c 2011-03-14 17:19:13.000000000 +0100
+++ b/arch/arm/mach-pxa/saar.c 2011-03-21 08:55:22.000000000 +0100
@@ -413,13 +413,13 @@ static void ltm022a97a_lcd_power(int on,
 	int err;
 
 	if (!pin_requested) {
-		err = gpio_request(GPIO_LCD_RESET, "lcd reset");
+		err = gpio_request_one(GPIO_LCD_RESET, GPIOF_OUT_INIT_LOW,
+				       "lcd reset");
 		if (err) {
 			pr_err("failed to request gpio for LCD reset\n");
 			return;
 		}
 
-		gpio_direction_output(GPIO_LCD_RESET, 0);
 		pin_requested = 1;
 	}
 
diff -u -p a/arch/arm/mach-pxa/sharpsl_pm.c b/arch/arm/mach-pxa/sharpsl_pm.c
--- a/arch/arm/mach-pxa/sharpsl_pm.c 2010-12-28 18:26:03.000000000 +0100
+++ b/arch/arm/mach-pxa/sharpsl_pm.c 2011-03-21 08:55:21.000000000 +0100
@@ -899,12 +899,13 @@ static int __devinit sharpsl_pm_probe(st
 
 	sharpsl_pm.machinfo->init();
 
-	gpio_request(sharpsl_pm.machinfo->gpio_acin, "AC IN");
-	gpio_direction_input(sharpsl_pm.machinfo->gpio_acin);
-	gpio_request(sharpsl_pm.machinfo->gpio_batfull, "Battery Full");
-	gpio_direction_input(sharpsl_pm.machinfo->gpio_batfull);
-	gpio_request(sharpsl_pm.machinfo->gpio_batlock, "Battery Lock");
-	gpio_direction_input(sharpsl_pm.machinfo->gpio_batlock);
+	gpio_request_one(sharpsl_pm.machinfo->gpio_acin, GPIOF_IN, "AC IN");
+	
+	gpio_request_one(sharpsl_pm.machinfo->gpio_batfull, GPIOF_IN,
+			 "Battery Full");
+	
+	gpio_request_one(sharpsl_pm.machinfo->gpio_batlock, GPIOF_IN,
+			 "Battery Lock");
 
 	/* Register interrupt handlers */
 	if (request_irq(IRQ_GPIO(sharpsl_pm.machinfo->gpio_acin), sharpsl_ac_isr, IRQF_DISABLED | IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING, "AC Input Detect", sharpsl_ac_isr)) {
diff -u -p a/arch/arm/mach-pxa/stargate2.c b/arch/arm/mach-pxa/stargate2.c
--- a/arch/arm/mach-pxa/stargate2.c 2011-03-14 17:19:13.000000000 +0100
+++ b/arch/arm/mach-pxa/stargate2.c 2011-03-21 08:55:24.000000000 +0100
@@ -693,19 +693,18 @@ static int stargate2_mci_init(struct dev
 {
 	int err;
 
-	err = gpio_request(SG2_SD_POWER_ENABLE, "SG2_sd_power_enable");
+	err = gpio_request_one(SG2_SD_POWER_ENABLE, GPIOF_OUT_INIT_LOW,
+			       "SG2_sd_power_enable");
 	if (err) {
 		printk(KERN_ERR "Can't get the gpio for SD power control");
 		goto return_err;
 	}
-	gpio_direction_output(SG2_SD_POWER_ENABLE, 0);
 
-	err = gpio_request(SG2_GPIO_nSD_DETECT, "SG2_sd_detect");
+	err = gpio_request_one(SG2_GPIO_nSD_DETECT, GPIOF_IN, "SG2_sd_detect");
 	if (err) {
 		printk(KERN_ERR "Can't get the sd detect gpio");
 		goto free_power_en;
 	}
-	gpio_direction_input(SG2_GPIO_nSD_DETECT);
 
 	err = request_irq(IRQ_GPIO(SG2_GPIO_nSD_DETECT),
 			  stargate2_detect_int,
@@ -799,12 +798,12 @@ static struct at24_platform_data pca9500
 static int stargate2_reset_bluetooth(void)
 {
 	int err;
-	err = gpio_request(SG2_BT_RESET, "SG2_BT_RESET");
+	err = gpio_request_one(SG2_BT_RESET, GPIOF_OUT_INIT_HIGH,
+			       "SG2_BT_RESET");
 	if (err) {
 		printk(KERN_ERR "Could not get gpio for bluetooth reset\n");
 		return err;
 	}
-	gpio_direction_output(SG2_BT_RESET, 1);
 	mdelay(5);
 	/* now reset it - 5 msec minimum */
 	gpio_set_value(SG2_BT_RESET, 0);
diff -u -p a/arch/arm/mach-pxa/zylonite_pxa300.c b/arch/arm/mach-pxa/zylonite_pxa300.c
--- a/arch/arm/mach-pxa/zylonite_pxa300.c 2011-03-14 17:19:13.000000000 +0100
+++ b/arch/arm/mach-pxa/zylonite_pxa300.c 2011-03-21 08:55:22.000000000 +0100
@@ -197,8 +197,7 @@ static void __init zylonite_detect_lcd_p
 	for (i = 0; i < NUM_LCD_DETECT_PINS; i++) {
 		id = id << 1;
 		gpio = mfp_to_gpio(lcd_detect_pins[i]);
-		gpio_request(gpio, "LCD_ID_PINS");
-		gpio_direction_input(gpio);
+		gpio_request_one(gpio, GPIOF_IN, "LCD_ID_PINS");
 
 		if (gpio_get_value(gpio))
 			id = id | 0x1;
diff -u -p a/arch/arm/mach-pxa/zylonite_pxa320.c b/arch/arm/mach-pxa/zylonite_pxa320.c
--- a/arch/arm/mach-pxa/zylonite_pxa320.c 2010-01-12 18:05:01.000000000 +0100
+++ b/arch/arm/mach-pxa/zylonite_pxa320.c 2011-03-21 08:55:21.000000000 +0100
@@ -176,8 +176,7 @@ static void __init zylonite_detect_lcd_p
 	for (i = 0; i < NUM_LCD_DETECT_PINS; i++) {
 		id = id << 1;
 		gpio = mfp_to_gpio(lcd_detect_pins[i]);
-		gpio_request(gpio, "LCD_ID_PINS");
-		gpio_direction_input(gpio);
+		gpio_request_one(gpio, GPIOF_IN, "LCD_ID_PINS");
 
 		if (gpio_get_value(gpio))
 			id = id | 0x1;
diff -u -p a/arch/arm/mach-s3c2410/mach-h1940.c b/arch/arm/mach-s3c2410/mach-h1940.c
--- a/arch/arm/mach-s3c2410/mach-h1940.c 2011-03-14 17:19:13.000000000 +0100
+++ b/arch/arm/mach-s3c2410/mach-h1940.c 2011-03-21 08:55:24.000000000 +0100
@@ -305,10 +305,10 @@ int h1940_bat_init(void)
 {
 	int ret;
 
-	ret = gpio_request(H1940_LATCH_SM803_ENABLE, "h1940-charger-enable");
+	ret = gpio_request_one(H1940_LATCH_SM803_ENABLE, GPIOF_OUT_INIT_LOW,
+			       "h1940-charger-enable");
 	if (ret)
 		return ret;
-	gpio_direction_output(H1940_LATCH_SM803_ENABLE, 0);
 
 	return 0;
 
@@ -473,9 +473,8 @@ static struct s3c24xx_mci_pdata h1940_mm
 
 static int h1940_backlight_init(struct device *dev)
 {
-	gpio_request(S3C2410_GPB(0), "Backlight");
+	gpio_request_one(S3C2410_GPB(0), GPIOF_OUT_INIT_LOW, "Backlight");
 
-	gpio_direction_output(S3C2410_GPB(0), 0);
 	s3c_gpio_setpull(S3C2410_GPB(0), S3C_GPIO_PULL_NONE);
 	s3c_gpio_cfgpin(S3C2410_GPB(0), S3C2410_GPB0_TOUT0);
 	gpio_set_value(H1940_LATCH_MAX1698_nSHUTDOWN, 1);
@@ -723,8 +722,7 @@ static void __init h1940_init(void)
 	gpio_direction_output(H1940_LATCH_LCD_P4, 0);
 	gpio_direction_output(H1940_LATCH_MAX1698_nSHUTDOWN, 0);
 
-	gpio_request(H1940_LATCH_SD_POWER, "SD power");
-	gpio_direction_output(H1940_LATCH_SD_POWER, 0);
+	gpio_request_one(H1940_LATCH_SD_POWER, GPIOF_OUT_INIT_LOW, "SD power");
 
 	platform_add_devices(h1940_devices, ARRAY_SIZE(h1940_devices));
 
diff -u -p a/arch/arm/mach-s3c2410/mach-qt2410.c b/arch/arm/mach-s3c2410/mach-qt2410.c
--- a/arch/arm/mach-s3c2410/mach-qt2410.c 2010-10-23 19:40:31.000000000 +0200
+++ b/arch/arm/mach-s3c2410/mach-qt2410.c 2011-03-21 08:55:23.000000000 +0100
@@ -354,8 +354,8 @@ static void __init qt2410_machine_init(v
 	s3c24xx_udc_set_platdata(&qt2410_udc_cfg);
 	s3c_i2c0_set_platdata(NULL);
 
-	WARN_ON(gpio_request(S3C2410_GPB(5), "spi cs"));
-	gpio_direction_output(S3C2410_GPB(5), 1);
+	WARN_ON(gpio_request_one(S3C2410_GPB(5), GPIOF_OUT_INIT_HIGH,
+				 "spi cs"));
 
 	platform_add_devices(qt2410_devices, ARRAY_SIZE(qt2410_devices));
 	s3c_pm_init();
diff -u -p a/arch/arm/mach-s3c2412/mach-jive.c b/arch/arm/mach-s3c2412/mach-jive.c
--- a/arch/arm/mach-s3c2412/mach-jive.c 2010-10-23 19:40:31.000000000 +0200
+++ b/arch/arm/mach-s3c2412/mach-jive.c 2011-03-21 08:55:23.000000000 +0100
@@ -636,11 +636,9 @@ static void __init jive_machine_init(voi
 
 	/* initialise the spi */
 
-	gpio_request(S3C2410_GPG(13), "lcm reset");
-	gpio_direction_output(S3C2410_GPG(13), 0);
+	gpio_request_one(S3C2410_GPG(13), GPIOF_OUT_INIT_LOW, "lcm reset");
 
-	gpio_request(S3C2410_GPB(7), "jive spi");
-	gpio_direction_output(S3C2410_GPB(7), 1);
+	gpio_request_one(S3C2410_GPB(7), GPIOF_OUT_INIT_HIGH, "jive spi");
 
 	s3c2410_gpio_setpin(S3C2410_GPB(6), 0);
 	s3c_gpio_cfgpin(S3C2410_GPB(6), S3C2410_GPIO_OUTPUT);
@@ -650,8 +648,8 @@ static void __init jive_machine_init(voi
 
 	/* initialise the WM8750 spi */
 
-	gpio_request(S3C2410_GPH(10), "jive wm8750 spi");
-	gpio_direction_output(S3C2410_GPH(10), 1);
+	gpio_request_one(S3C2410_GPH(10), GPIOF_OUT_INIT_HIGH,
+			 "jive wm8750 spi");
 
 	/* Turn off suspend on both USB ports, and switch the
 	 * selectable USB port to USB device mode. */
diff -u -p a/arch/arm/mach-s3c2416/mach-smdk2416.c b/arch/arm/mach-s3c2416/mach-smdk2416.c
--- a/arch/arm/mach-s3c2416/mach-smdk2416.c 2011-01-09 09:32:57.000000000 +0100
+++ b/arch/arm/mach-s3c2416/mach-smdk2416.c 2011-03-21 08:55:25.000000000 +0100
@@ -203,14 +203,11 @@ static void __init smdk2416_machine_init
 	s3c_sdhci0_set_platdata(&smdk2416_hsmmc0_pdata);
 	s3c_sdhci1_set_platdata(&smdk2416_hsmmc1_pdata);
 
-	gpio_request(S3C2410_GPB(4), "USBHost Power");
-	gpio_direction_output(S3C2410_GPB(4), 1);
+	gpio_request_one(S3C2410_GPB(4), GPIOF_OUT_INIT_HIGH, "USBHost Power");
 
-	gpio_request(S3C2410_GPB(3), "Display Power");
-	gpio_direction_output(S3C2410_GPB(3), 1);
+	gpio_request_one(S3C2410_GPB(3), GPIOF_OUT_INIT_HIGH, "Display Power");
 
-	gpio_request(S3C2410_GPB(1), "Display Reset");
-	gpio_direction_output(S3C2410_GPB(1), 1);
+	gpio_request_one(S3C2410_GPB(1), GPIOF_OUT_INIT_HIGH, "Display Reset");
 
 	platform_add_devices(smdk2416_devices, ARRAY_SIZE(smdk2416_devices));
 	smdk_machine_init();
diff -u -p a/arch/arm/mach-s3c2440/mach-mini2440.c b/arch/arm/mach-s3c2440/mach-mini2440.c
--- a/arch/arm/mach-s3c2440/mach-mini2440.c 2011-03-14 17:19:13.000000000 +0100
+++ b/arch/arm/mach-s3c2440/mach-mini2440.c 2011-03-21 08:55:21.000000000 +0100
@@ -618,8 +618,8 @@ static void __init mini2440_init(void)
 	s3c_gpio_cfgpin(S3C2410_GPC(0), S3C2410_GPC0_LEND);
 
 	/* Turn the backlight early on */
-	WARN_ON(gpio_request(S3C2410_GPG(4), "backlight"));
-	gpio_direction_output(S3C2410_GPG(4), 1);
+	WARN_ON(gpio_request_one(S3C2410_GPG(4), GPIOF_OUT_INIT_HIGH,
+				 "backlight"));
 
 	/* remove pullup on optional PWM backlight -- unused on 3.5 and 7"s */
 	s3c_gpio_setpull(S3C2410_GPB(1), S3C_GPIO_PULL_UP);
diff -u -p a/arch/arm/mach-s3c2440/mach-osiris-dvs.c b/arch/arm/mach-s3c2440/mach-osiris-dvs.c
--- a/arch/arm/mach-s3c2440/mach-osiris-dvs.c 2009-12-08 20:58:27.000000000 +0100
+++ b/arch/arm/mach-s3c2440/mach-osiris-dvs.c 2011-03-21 08:55:22.000000000 +0100
@@ -99,15 +99,13 @@ static int __devinit osiris_dvs_probe(st
 
 	dev_info(&pdev->dev, "initialising\n");
 
-	ret = gpio_request(OSIRIS_GPIO_DVS, "osiris-dvs");
+	ret = gpio_request_one(OSIRIS_GPIO_DVS, GPIOF_OUT_INIT_HIGH,
+			       "osiris-dvs");
 	if (ret) {
 		dev_err(&pdev->dev, "cannot claim gpio\n");
 		goto err_nogpio;
 	}
 
-	/* start with dvs disabled */
-	gpio_direction_output(OSIRIS_GPIO_DVS, 1);
-
 	ret = cpufreq_register_notifier(&osiris_dvs_nb,
 					CPUFREQ_TRANSITION_NOTIFIER);
 	if (ret) {
diff -u -p a/arch/arm/mach-s3c2440/mach-rx1950.c b/arch/arm/mach-s3c2440/mach-rx1950.c
--- a/arch/arm/mach-s3c2440/mach-rx1950.c 2011-03-14 17:19:13.000000000 +0100
+++ b/arch/arm/mach-s3c2440/mach-rx1950.c 2011-03-21 08:55:21.000000000 +0100
@@ -785,8 +785,8 @@ static void __init rx1950_init_machine(v
 						S3C2410_MISCCR_USBSUSPND1, 0x0);
 
 	/* mmc power is disabled by default */
-	WARN_ON(gpio_request(S3C2410_GPJ(1), "MMC power"));
-	gpio_direction_output(S3C2410_GPJ(1), 0);
+	WARN_ON(gpio_request_one(S3C2410_GPJ(1), GPIOF_OUT_INIT_LOW,
+				 "MMC power"));
 
 	for (i = 0; i < 8; i++)
 		WARN_ON(gpio_request(S3C2410_GPC(i), "LCD power"));
diff -u -p a/arch/arm/mach-s3c64xx/mach-hmt.c b/arch/arm/mach-s3c64xx/mach-hmt.c
--- a/arch/arm/mach-s3c64xx/mach-hmt.c 2010-10-23 19:40:31.000000000 +0200
+++ b/arch/arm/mach-s3c64xx/mach-hmt.c 2011-03-21 08:55:22.000000000 +0100
@@ -251,14 +251,12 @@ static void __init hmt_machine_init(void
 	s3c_fb_set_platdata(&hmt_lcd_pdata);
 	s3c_nand_set_platdata(&hmt_nand_info);
 
-	gpio_request(S3C64XX_GPC(7), "usb power");
-	gpio_direction_output(S3C64XX_GPC(7), 0);
-	gpio_request(S3C64XX_GPM(0), "usb power");
-	gpio_direction_output(S3C64XX_GPM(0), 1);
-	gpio_request(S3C64XX_GPK(7), "usb power");
-	gpio_direction_output(S3C64XX_GPK(7), 1);
-	gpio_request(S3C64XX_GPF(13), "usb power");
-	gpio_direction_output(S3C64XX_GPF(13), 1);
+	gpio_request_one(S3C64XX_GPC(7), GPIOF_OUT_INIT_LOW, "usb power");
+	gpio_request_one(S3C64XX_GPM(0), GPIOF_OUT_INIT_HIGH, "usb power");
+	
+	gpio_request_one(S3C64XX_GPK(7), GPIOF_OUT_INIT_HIGH, "usb power");
+	
+	gpio_request_one(S3C64XX_GPF(13), GPIOF_OUT_INIT_HIGH, "usb power");
 
 	platform_add_devices(hmt_devices, ARRAY_SIZE(hmt_devices));
 }
diff -u -p a/arch/arm/mach-s3c64xx/mach-smartq.c b/arch/arm/mach-s3c64xx/mach-smartq.c
--- a/arch/arm/mach-s3c64xx/mach-smartq.c 2010-09-04 09:22:04.000000000 +0200
+++ b/arch/arm/mach-s3c64xx/mach-smartq.c 2011-03-21 08:55:22.000000000 +0100
@@ -189,13 +189,11 @@ static int __init smartq_lcd_setup_gpio(
 {
 	int ret;
 
-	ret = gpio_request(S3C64XX_GPM(3), "LCD power");
+	ret = gpio_request_one(S3C64XX_GPM(3), GPIOF_OUT_INIT_LOW,
+			       "LCD power");
 	if (ret < 0)
 		return ret;
 
-	/* turn power off */
-	gpio_direction_output(S3C64XX_GPM(3), 0);
-
 	return 0;
 }
 
@@ -276,15 +274,13 @@ static int __init smartq_power_off_init(
 {
 	int ret;
 
-	ret = gpio_request(S3C64XX_GPK(15), "Power control");
+	ret = gpio_request_one(S3C64XX_GPK(15), GPIOF_OUT_INIT_LOW,
+			       "Power control");
 	if (ret < 0) {
 		pr_err("%s: failed to get GPK15\n", __func__);
 		return ret;
 	}
 
-	/* leave power on */
-	gpio_direction_output(S3C64XX_GPK(15), 0);
-
 	pm_power_off = smartq_power_off;
 
 	return ret;
diff -u -p a/arch/arm/mach-s5pv210/mach-aquila.c b/arch/arm/mach-s5pv210/mach-aquila.c
--- a/arch/arm/mach-s5pv210/mach-aquila.c 2011-03-14 17:19:13.000000000 +0100
+++ b/arch/arm/mach-s5pv210/mach-aquila.c 2011-03-21 08:55:25.000000000 +0100
@@ -595,8 +595,7 @@ static struct s3c_sdhci_platdata aquila_
 
 static void aquila_setup_sdhci(void)
 {
-	gpio_request(AQUILA_EXT_FLASH_EN, "FLASH_EN");
-	gpio_direction_output(AQUILA_EXT_FLASH_EN, 1);
+	gpio_request_one(AQUILA_EXT_FLASH_EN, GPIOF_OUT_INIT_HIGH, "FLASH_EN");
 
 	s3c_sdhci0_set_platdata(&aquila_hsmmc0_data);
 	s3c_sdhci1_set_platdata(&aquila_hsmmc1_data);
diff -u -p a/arch/arm/mach-s5pv210/mach-smdkv210.c b/arch/arm/mach-s5pv210/mach-smdkv210.c
--- a/arch/arm/mach-s5pv210/mach-smdkv210.c 2011-03-14 17:19:13.000000000 +0100
+++ b/arch/arm/mach-s5pv210/mach-smdkv210.c 2011-03-21 08:55:25.000000000 +0100
@@ -153,15 +153,12 @@ static void smdkv210_lte480wv_set_power(
 {
 	if (power) {
 #if !defined(CONFIG_BACKLIGHT_PWM)
-		gpio_request(S5PV210_GPD0(3), "GPD0");
-		gpio_direction_output(S5PV210_GPD0(3), 1);
+		gpio_request_one(S5PV210_GPD0(3), GPIOF_OUT_INIT_HIGH, "GPD0");
 		gpio_free(S5PV210_GPD0(3));
 #endif
 
 		/* fire nRESET on power up */
-		gpio_request(S5PV210_GPH0(6), "GPH0");
-
-		gpio_direction_output(S5PV210_GPH0(6), 1);
+		gpio_request_one(S5PV210_GPH0(6), GPIOF_OUT_INIT_HIGH, "GPH0");
 
 		gpio_set_value(S5PV210_GPH0(6), 0);
 		mdelay(10);
@@ -172,8 +169,7 @@ static void smdkv210_lte480wv_set_power(
 		gpio_free(S5PV210_GPH0(6));
 	} else {
 #if !defined(CONFIG_BACKLIGHT_PWM)
-		gpio_request(S5PV210_GPD0(3), "GPD0");
-		gpio_direction_output(S5PV210_GPD0(3), 0);
+		gpio_request_one(S5PV210_GPD0(3), GPIOF_OUT_INIT_LOW, "GPD0");
 		gpio_free(S5PV210_GPD0(3));
 #endif
 	}
diff -u -p a/arch/arm/mach-shmobile/board-ag5evm.c b/arch/arm/mach-shmobile/board-ag5evm.c
--- a/arch/arm/mach-shmobile/board-ag5evm.c 2011-02-02 17:27:36.000000000 +0100
+++ b/arch/arm/mach-shmobile/board-ag5evm.c 2011-03-21 08:55:25.000000000 +0100
@@ -418,14 +418,11 @@ static void __init ag5evm_init(void)
 	gpio_request(GPIO_FN_MMCD0_5, NULL);
 	gpio_request(GPIO_FN_MMCD0_6, NULL);
 	gpio_request(GPIO_FN_MMCD0_7, NULL);
-	gpio_request(GPIO_PORT208, NULL); /* Reset */
-	gpio_direction_output(GPIO_PORT208, 1);
+	gpio_request_one(GPIO_PORT208, GPIOF_OUT_INIT_HIGH, NULL);
 
 	/* enable SMSC911X */
-	gpio_request(GPIO_PORT144, NULL); /* PINTA2 */
-	gpio_direction_input(GPIO_PORT144);
-	gpio_request(GPIO_PORT145, NULL); /* RESET */
-	gpio_direction_output(GPIO_PORT145, 1);
+	gpio_request_one(GPIO_PORT144, GPIOF_IN, NULL); /* PINTA2 */
+	gpio_request_one(GPIO_PORT145, GPIOF_OUT_INIT_HIGH, NULL);
 
 	/* FSI A */
 	gpio_request(GPIO_FN_FSIACK, NULL);
@@ -440,15 +437,13 @@ static void __init ag5evm_init(void)
 	gpio_request(GPIO_FN_PORT243_IRDA_FIRSEL, NULL);
 
 	/* LCD panel */
-	gpio_request(GPIO_PORT217, NULL); /* RESET */
-	gpio_direction_output(GPIO_PORT217, 0);
+	gpio_request_one(GPIO_PORT217, GPIOF_OUT_INIT_LOW, NULL); /* RESET */
 	mdelay(1);
 	gpio_set_value(GPIO_PORT217, 1);
 	mdelay(100);
 
 	/* LCD backlight controller */
-	gpio_request(GPIO_PORT235, NULL); /* RESET */
-	gpio_direction_output(GPIO_PORT235, 0);
+	gpio_request_one(GPIO_PORT235, GPIOF_OUT_INIT_LOW, NULL); /* RESET */
 	lcd_backlight_reset();
 
 	/* MIPI-DSI clock setup */
diff -u -p a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
--- a/arch/arm/mach-shmobile/board-ap4evb.c 2011-03-14 17:19:13.000000000 +0100
+++ b/arch/arm/mach-shmobile/board-ap4evb.c 2011-03-21 08:55:26.000000000 +0100
@@ -1054,9 +1054,7 @@ static int ts_get_pendown_state(void)
 
 	gpio_free(GPIO_TSC_IRQ);
 
-	gpio_request(GPIO_TSC_PORT, NULL);
-
-	gpio_direction_input(GPIO_TSC_PORT);
+	gpio_request_one(GPIO_TSC_PORT, GPIOF_IN, NULL);
 
 	val = gpio_get_value(GPIO_TSC_PORT);
 
@@ -1198,8 +1196,7 @@ static void __init ap4evb_init(void)
 	gpio_request(GPIO_FN_FSIAILR,	NULL);
 	gpio_request(GPIO_FN_FSIAISLD,	NULL);
 	gpio_request(GPIO_FN_FSIAOSLD,	NULL);
-	gpio_request(GPIO_PORT161,	NULL);
-	gpio_direction_output(GPIO_PORT161, 0); /* slave */
+	gpio_request_one(GPIO_PORT161, GPIOF_OUT_INIT_LOW, NULL);/* slave */
 
 	gpio_request(GPIO_PORT9, NULL);
 	gpio_request(GPIO_PORT10, NULL);
@@ -1207,8 +1204,7 @@ static void __init ap4evb_init(void)
 	gpio_no_direction(GPIO_PORT10CR); /* FSIAOLR needs no direction */
 
 	/* card detect pin for MMC slot (CN7) */
-	gpio_request(GPIO_PORT41, NULL);
-	gpio_direction_input(GPIO_PORT41);
+	gpio_request_one(GPIO_PORT41, GPIOF_IN, NULL);
 
 	/* setup FSI2 port B (HDMI) */
 	gpio_request(GPIO_FN_FSIBCK, NULL);
@@ -1296,11 +1292,9 @@ static void __init ap4evb_init(void)
 	gpio_request(GPIO_FN_LCDDISP,  NULL);
 	gpio_request(GPIO_FN_LCDDCK,   NULL);
 
-	gpio_request(GPIO_PORT189, NULL); /* backlight */
-	gpio_direction_output(GPIO_PORT189, 1);
+	gpio_request_one(GPIO_PORT189, GPIOF_OUT_INIT_HIGH, NULL);
 
-	gpio_request(GPIO_PORT151, NULL); /* LCDDON */
-	gpio_direction_output(GPIO_PORT151, 1);
+	gpio_request_one(GPIO_PORT151, GPIOF_OUT_INIT_HIGH, NULL);
 
 	lcdc_info.clock_source			= LCDC_CLK_BUS;
 	lcdc_info.ch[0].interface_type		= RGB18;
diff -u -p a/arch/arm/mach-shmobile/board-g3evm.c b/arch/arm/mach-shmobile/board-g3evm.c
--- a/arch/arm/mach-shmobile/board-g3evm.c 2011-01-19 18:51:18.000000000 +0100
+++ b/arch/arm/mach-shmobile/board-g3evm.c 2011-03-21 08:55:26.000000000 +0100
@@ -271,18 +271,15 @@ static void __init g3evm_init(void)
 	sh7367_pinmux_init();
 
 	/* Lit DS4 LED */
-	gpio_request(GPIO_PORT22, NULL);
-	gpio_direction_output(GPIO_PORT22, 1);
+	gpio_request_one(GPIO_PORT22, GPIOF_OUT_INIT_HIGH, NULL);
 	gpio_export(GPIO_PORT22, 0);
 
 	/* Lit DS8 LED */
-	gpio_request(GPIO_PORT23, NULL);
-	gpio_direction_output(GPIO_PORT23, 1);
+	gpio_request_one(GPIO_PORT23, GPIOF_OUT_INIT_HIGH, NULL);
 	gpio_export(GPIO_PORT23, 0);
 
 	/* Lit DS3 LED */
-	gpio_request(GPIO_PORT24, NULL);
-	gpio_direction_output(GPIO_PORT24, 1);
+	gpio_request_one(GPIO_PORT24, GPIOF_OUT_INIT_HIGH, NULL);
 	gpio_export(GPIO_PORT24, 0);
 
 	/* SCIFA1 */
diff -u -p a/arch/arm/mach-shmobile/board-g4evm.c b/arch/arm/mach-shmobile/board-g4evm.c
--- a/arch/arm/mach-shmobile/board-g4evm.c 2011-01-19 18:51:18.000000000 +0100
+++ b/arch/arm/mach-shmobile/board-g4evm.c 2011-03-21 08:55:25.000000000 +0100
@@ -315,23 +315,19 @@ static void __init g4evm_init(void)
 	sh7377_pinmux_init();
 
 	/* Lit DS14 LED */
-	gpio_request(GPIO_PORT109, NULL);
-	gpio_direction_output(GPIO_PORT109, 1);
+	gpio_request_one(GPIO_PORT109, GPIOF_OUT_INIT_HIGH, NULL);
 	gpio_export(GPIO_PORT109, 1);
 
 	/* Lit DS15 LED */
-	gpio_request(GPIO_PORT110, NULL);
-	gpio_direction_output(GPIO_PORT110, 1);
+	gpio_request_one(GPIO_PORT110, GPIOF_OUT_INIT_HIGH, NULL);
 	gpio_export(GPIO_PORT110, 1);
 
 	/* Lit DS16 LED */
-	gpio_request(GPIO_PORT112, NULL);
-	gpio_direction_output(GPIO_PORT112, 1);
+	gpio_request_one(GPIO_PORT112, GPIOF_OUT_INIT_HIGH, NULL);
 	gpio_export(GPIO_PORT112, 1);
 
 	/* Lit DS17 LED */
-	gpio_request(GPIO_PORT113, NULL);
-	gpio_direction_output(GPIO_PORT113, 1);
+	gpio_request_one(GPIO_PORT113, GPIOF_OUT_INIT_HIGH, NULL);
 	gpio_export(GPIO_PORT113, 1);
 
 	/* USBHS */
diff -u -p a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
--- a/arch/arm/mach-shmobile/board-mackerel.c 2011-03-14 17:19:13.000000000 +0100
+++ b/arch/arm/mach-shmobile/board-mackerel.c 2011-03-21 08:55:27.000000000 +0100
@@ -1058,11 +1058,9 @@ static void __init mackerel_init(void)
 	gpio_request(GPIO_FN_LCDDISP,  NULL);
 	gpio_request(GPIO_FN_LCDDCK,   NULL);
 
-	gpio_request(GPIO_PORT31, NULL); /* backlight */
-	gpio_direction_output(GPIO_PORT31, 1);
+	gpio_request_one(GPIO_PORT31, GPIOF_OUT_INIT_HIGH, NULL);
 
-	gpio_request(GPIO_PORT151, NULL); /* LCDDON */
-	gpio_direction_output(GPIO_PORT151, 1);
+	gpio_request_one(GPIO_PORT151, GPIOF_OUT_INIT_HIGH, NULL);
 
 	/* USB enable */
 	gpio_request(GPIO_FN_VBUS0_1,    NULL);
@@ -1080,8 +1078,7 @@ static void __init mackerel_init(void)
 	gpio_request(GPIO_FN_FSIAILR,	NULL);
 	gpio_request(GPIO_FN_FSIAISLD,	NULL);
 	gpio_request(GPIO_FN_FSIAOSLD,	NULL);
-	gpio_request(GPIO_PORT161,	NULL);
-	gpio_direction_output(GPIO_PORT161, 0); /* slave */
+	gpio_request_one(GPIO_PORT161, GPIOF_OUT_INIT_LOW, NULL);/* slave */
 
 	gpio_request(GPIO_PORT9,  NULL);
 	gpio_request(GPIO_PORT10, NULL);
@@ -1133,8 +1130,7 @@ static void __init mackerel_init(void)
 	gpio_request(GPIO_FN_SDHID1_0, NULL);
 #endif
 	/* card detect pin for MMC slot (CN7) */
-	gpio_request(GPIO_PORT41, NULL);
-	gpio_direction_input(GPIO_PORT41);
+	gpio_request_one(GPIO_PORT41, GPIOF_IN, NULL);
 
 	/* enable SDHI2 */
 	gpio_request(GPIO_FN_SDHICMD2, NULL);
@@ -1145,8 +1141,7 @@ static void __init mackerel_init(void)
 	gpio_request(GPIO_FN_SDHID2_0, NULL);
 
 	/* card detect pin for microSD slot (CN23) */
-	gpio_request(GPIO_PORT162, NULL);
-	gpio_direction_input(GPIO_PORT162);
+	gpio_request_one(GPIO_PORT162, GPIOF_IN, NULL);
 
 	/* MMCIF */
 	gpio_request(GPIO_FN_MMCD0_0, NULL);
diff -u -p a/arch/arm/mach-stmp378x/stmp378x_devb.c b/arch/arm/mach-stmp378x/stmp378x_devb.c
--- a/arch/arm/mach-stmp378x/stmp378x_devb.c 2010-10-23 19:40:31.000000000 +0200
+++ b/arch/arm/mach-stmp378x/stmp378x_devb.c 2011-03-21 08:55:24.000000000 +0100
@@ -133,18 +133,15 @@ static int stmp3xxxmmc_hw_init_ssp1(void
 		goto out;
 
 	/* Configure write protect GPIO pin */
-	ret = gpio_request(PINID_PWM4, "mmc wp");
+	ret = gpio_request_one(PINID_PWM4, GPIOF_IN, "mmc wp");
 	if (ret)
 		goto out_wp;
 
-	gpio_direction_input(PINID_PWM4);
-
 	/* Configure POWER pin as gpio to drive power to MMC slot */
-	ret = gpio_request(PINID_PWM3, "mmc power");
+	ret = gpio_request_one(PINID_PWM3, GPIOF_OUT_INIT_LOW, "mmc power");
 	if (ret)
 		goto out_power;
 
-	gpio_direction_output(PINID_PWM3, 0);
 	mdelay(100);
 
 	return 0;
diff -u -p a/arch/arm/mach-tegra/board-harmony-pcie.c b/arch/arm/mach-tegra/board-harmony-pcie.c
--- a/arch/arm/mach-tegra/board-harmony-pcie.c 2011-03-20 18:17:23.000000000 +0100
+++ b/arch/arm/mach-tegra/board-harmony-pcie.c 2011-03-21 08:55:24.000000000 +0100
@@ -38,12 +38,11 @@ static int __init harmony_pcie_init(void
 	if (!machine_is_harmony())
 		return 0;
 
-	err = gpio_request(EN_VDD_1V05_GPIO, "EN_VDD_1V05");
+	err = gpio_request_one(EN_VDD_1V05_GPIO, GPIOF_OUT_INIT_HIGH,
+			       "EN_VDD_1V05");
 	if (err)
 		return err;
 
-	gpio_direction_output(EN_VDD_1V05_GPIO, 1);
-
 	regulator = regulator_get(NULL, "pex_clk");
 	if (IS_ERR_OR_NULL(regulator))
 		goto err_reg;
diff -u -p a/arch/arm/mach-tegra/board-seaboard.c b/arch/arm/mach-tegra/board-seaboard.c
--- a/arch/arm/mach-tegra/board-seaboard.c 2011-03-20 18:17:23.000000000 +0100
+++ b/arch/arm/mach-tegra/board-seaboard.c 2011-03-21 08:55:24.000000000 +0100
@@ -154,8 +154,7 @@ static struct i2c_board_info __initdata 
 
 static void __init seaboard_i2c_init(void)
 {
-	gpio_request(TEGRA_GPIO_ISL29018_IRQ, "isl29018");
-	gpio_direction_input(TEGRA_GPIO_ISL29018_IRQ);
+	gpio_request_one(TEGRA_GPIO_ISL29018_IRQ, GPIOF_IN, "isl29018");
 
 	i2c_register_board_info(0, &isl29018_device, 1);
 
diff -u -p a/arch/arm/mach-tegra/usb_phy.c b/arch/arm/mach-tegra/usb_phy.c
--- a/arch/arm/mach-tegra/usb_phy.c 2011-03-14 17:19:13.000000000 +0100
+++ b/arch/arm/mach-tegra/usb_phy.c 2011-03-21 08:55:24.000000000 +0100
@@ -710,8 +710,8 @@ struct tegra_usb_phy *tegra_usb_phy_open
 			goto err1;
 		}
 		tegra_gpio_enable(ulpi_config->reset_gpio);
-		gpio_request(ulpi_config->reset_gpio, "ulpi_phy_reset_b");
-		gpio_direction_output(ulpi_config->reset_gpio, 0);
+		gpio_request_one(ulpi_config->reset_gpio, GPIOF_OUT_INIT_LOW,
+				 "ulpi_phy_reset_b");
 		phy->ulpi = otg_ulpi_create(&ulpi_viewport_access_ops, 0);
 		phy->ulpi->io_priv = regs + ULPI_VIEWPORT;
 	} else {
diff -u -p a/arch/arm/plat-mxc/3ds_debugboard.c b/arch/arm/plat-mxc/3ds_debugboard.c
--- a/arch/arm/plat-mxc/3ds_debugboard.c 2011-01-19 18:51:18.000000000 +0100
+++ b/arch/arm/plat-mxc/3ds_debugboard.c 2011-03-21 08:55:25.000000000 +0100
@@ -176,8 +176,7 @@ int __init mxc_expio_init(u32 base, u32 
 	/*
 	 * Configure INT line as GPIO input
 	 */
-	gpio_request(MXC_IRQ_TO_GPIO(p_irq), "expio_pirq");
-	gpio_direction_input(MXC_IRQ_TO_GPIO(p_irq));
+	gpio_request_one(MXC_IRQ_TO_GPIO(p_irq), GPIOF_IN, "expio_pirq");
 
 	/* disable the interrupt and clear the status */
 	__raw_writew(0, brd_io + INTR_MASK_REG);
diff -u -p a/arch/arm/plat-omap/debug-devices.c b/arch/arm/plat-omap/debug-devices.c
--- a/arch/arm/plat-omap/debug-devices.c 2009-12-12 00:23:19.000000000 +0100
+++ b/arch/arm/plat-omap/debug-devices.c 2011-03-21 08:55:21.000000000 +0100
@@ -82,12 +82,11 @@ int __init debug_card_init(u32 addr, uns
 	smc91x_resources[1].start = gpio_to_irq(gpio);
 	smc91x_resources[1].end   = gpio_to_irq(gpio);
 
-	status = gpio_request(gpio, "SMC91x irq");
+	status = gpio_request_one(gpio, GPIOF_IN, "SMC91x irq");
 	if (status < 0) {
 		printk(KERN_ERR "GPIO%d unavailable for smc91x IRQ\n", gpio);
 		return status;
 	}
-	gpio_direction_input(gpio);
 
 	led_resources[0].start = addr;
 	led_resources[0].end   = addr + SZ_4K - 1;
diff -u -p a/arch/avr32/boards/atngw100/mrmt.c b/arch/avr32/boards/atngw100/mrmt.c
--- a/arch/avr32/boards/atngw100/mrmt.c 2009-09-21 18:11:44.000000000 +0200
+++ b/arch/avr32/boards/atngw100/mrmt.c 2011-03-21 08:55:21.000000000 +0100
@@ -314,13 +314,11 @@ static int __init mrmt1_init(void)
 #endif
 
 	at32_select_gpio( PIN_LCD_DISP, AT32_GPIOF_OUTPUT );
-	gpio_request( PIN_LCD_DISP, "LCD_DISP" );
-	gpio_direction_output( PIN_LCD_DISP, 0 );	/* LCD DISP */
+	gpio_request_one(PIN_LCD_DISP, GPIOF_OUT_INIT_LOW, "LCD_DISP");/* LCD DISP */
 #ifdef CONFIG_BOARD_MRMT_LCD_DISABLE
 	/* Keep Backlight and DISP off */
 	at32_select_gpio( PIN_LCD_BL, AT32_GPIOF_OUTPUT );
-	gpio_request( PIN_LCD_BL, "LCD_BL" );
-	gpio_direction_output( PIN_LCD_BL, 0 );		/* Backlight */
+	gpio_request_one(PIN_LCD_BL, GPIOF_OUT_INIT_LOW, "LCD_BL");/* Backlight */
 #else
 	gpio_set_value( PIN_LCD_DISP, 1 );	/* DISP asserted first */
 #ifdef CONFIG_BOARD_MRMT_BL_PWM
@@ -331,20 +329,17 @@ static int __init mrmt1_init(void)
 	/* Backlight always on */
 	udelay( 1 );
 	at32_select_gpio( PIN_LCD_BL, AT32_GPIOF_OUTPUT );
-	gpio_request( PIN_LCD_BL, "LCD_BL" );
-	gpio_direction_output( PIN_LCD_BL, 1 );
+	gpio_request_one(PIN_LCD_BL, GPIOF_OUT_INIT_HIGH, "LCD_BL");
 #endif
 #endif
 
 	/* Make sure BT and Zigbee modules in reset */
 	at32_select_gpio( PIN_BT_RST, AT32_GPIOF_OUTPUT );
-	gpio_request( PIN_BT_RST, "BT_RST" );
-	gpio_direction_output( PIN_BT_RST, 1 );
+	gpio_request_one(PIN_BT_RST, GPIOF_OUT_INIT_HIGH, "BT_RST");
 	/* BT Module in Reset */
 
 	at32_select_gpio( PIN_ZB_RST_N, AT32_GPIOF_OUTPUT );
-	gpio_request( PIN_ZB_RST_N, "ZB_RST_N" );
-	gpio_direction_output( PIN_ZB_RST_N, 0 );
+	gpio_request_one(PIN_ZB_RST_N, GPIOF_OUT_INIT_LOW, "ZB_RST_N");
 	/* XBee Module in Reset */
 
 #ifdef CONFIG_BOARD_MRMT_WIRELESS_ZB
@@ -366,8 +361,7 @@ static int __init mrmt1_early_init(void)
 {
 	/* To maintain power-on signal in case boot loader did not already */
 	at32_select_gpio( PIN_PWR_ON, AT32_GPIOF_OUTPUT );
-	gpio_request( PIN_PWR_ON, "PIN_PWR_ON" );
-	gpio_direction_output( PIN_PWR_ON, 1 );
+	gpio_request_one(PIN_PWR_ON, GPIOF_OUT_INIT_HIGH, "PIN_PWR_ON");
 
 	return 0;
 }
diff -u -p a/arch/avr32/boards/atngw100/setup.c b/arch/avr32/boards/atngw100/setup.c
--- a/arch/avr32/boards/atngw100/setup.c 2011-01-19 18:51:18.000000000 +0100
+++ b/arch/avr32/boards/atngw100/setup.c 2011-03-21 08:55:21.000000000 +0100
@@ -309,13 +309,11 @@ static int __init atngw100_arch_init(voi
 	 */
 #ifdef CONFIG_BOARD_ATNGW100_MKII
 	at32_select_gpio(GPIO_PIN_PE(30), 0);
-	gpio_request(GPIO_PIN_PE(30), "j15");
-	gpio_direction_input(GPIO_PIN_PE(30));
+	gpio_request_one(GPIO_PIN_PE(30), GPIOF_IN, "j15");
 	gpio_export(GPIO_PIN_PE(30), false);
 #else
 	at32_select_gpio(GPIO_PIN_PB(30), 0);
-	gpio_request(GPIO_PIN_PB(30), "j15");
-	gpio_direction_input(GPIO_PIN_PB(30));
+	gpio_request_one(GPIO_PIN_PB(30), GPIOF_IN, "j15");
 	gpio_export(GPIO_PIN_PB(30), false);
 #endif
 
diff -u -p a/arch/blackfin/mach-bf533/boards/stamp.c b/arch/blackfin/mach-bf533/boards/stamp.c
--- a/arch/blackfin/mach-bf533/boards/stamp.c 2011-01-19 18:51:18.000000000 +0100
+++ b/arch/blackfin/mach-bf533/boards/stamp.c 2011-03-21 08:55:22.000000000 +0100
@@ -718,6 +718,5 @@ void __init native_machine_early_platfor
 void native_machine_restart(char *cmd)
 {
 	/* workaround pull up on cpld / flash pin not being strong enough */
-	gpio_request(GPIO_PF0, "flash_cpld");
-	gpio_direction_output(GPIO_PF0, 0);
+	gpio_request_one(GPIO_PF0, GPIOF_OUT_INIT_LOW, "flash_cpld");
 }
diff -u -p a/arch/mips/alchemy/devboards/db1200/platform.c b/arch/mips/alchemy/devboards/db1200/platform.c
--- a/arch/mips/alchemy/devboards/db1200/platform.c 2010-09-04 09:22:04.000000000 +0200
+++ b/arch/mips/alchemy/devboards/db1200/platform.c 2011-03-21 08:55:24.000000000 +0100
@@ -468,8 +468,7 @@ static int __init db1200_dev_init(void)
 	pfc = __raw_readl((void __iomem *)SYS_PINFUNC) & ~SYS_PINFUNC_P0A;
 
 	/* switch off OTG VBUS supply */
-	gpio_request(215, "otg-vbus");
-	gpio_direction_output(215, 1);
+	gpio_request_one(215, GPIOF_OUT_INIT_HIGH, "otg-vbus");
 
 	printk(KERN_INFO "DB1200 device configuration:\n");
 
diff -u -p a/arch/mips/alchemy/mtx-1/platform.c b/arch/mips/alchemy/mtx-1/platform.c
--- a/arch/mips/alchemy/mtx-1/platform.c 2011-03-20 18:17:23.000000000 +0100
+++ b/arch/mips/alchemy/mtx-1/platform.c 2011-03-21 08:55:24.000000000 +0100
@@ -153,14 +153,13 @@ static int __init mtx1_register_devices(
 
 	au1xxx_override_eth_cfg(0, &mtx1_au1000_eth0_pdata);
 
-	rc = gpio_request(mtx1_gpio_button[0].gpio,
-					mtx1_gpio_button[0].desc);
+	rc = gpio_request_one(mtx1_gpio_button[0].gpio, GPIOF_IN,
+			      mtx1_gpio_button[0].desc);
 	if (rc < 0) {
 		printk(KERN_INFO "mtx1: failed to request %d\n",
 					mtx1_gpio_button[0].gpio);
 		goto out;
 	}
-	gpio_direction_input(mtx1_gpio_button[0].gpio);
 out:
 	return platform_add_devices(mtx1_devs, ARRAY_SIZE(mtx1_devs));
 }
diff -u -p a/arch/mips/txx9/rbtx4927/setup.c b/arch/mips/txx9/rbtx4927/setup.c
--- a/arch/mips/txx9/rbtx4927/setup.c 2010-02-11 23:53:22.000000000 +0100
+++ b/arch/mips/txx9/rbtx4927/setup.c 2011-03-21 08:55:24.000000000 +0100
@@ -207,8 +207,7 @@ static void __init rbtx4927_mem_setup(vo
 #endif
 
 	/* TX4927-SIO DTR on (PIO[15]) */
-	gpio_request(15, "sio-dtr");
-	gpio_direction_output(15, 1);
+	gpio_request_one(15, GPIOF_OUT_INIT_HIGH, "sio-dtr");
 
 	tx4927_sio_init(0, 0);
 }
diff -u -p a/arch/mips/txx9/rbtx4938/setup.c b/arch/mips/txx9/rbtx4938/setup.c
--- a/arch/mips/txx9/rbtx4938/setup.c 2010-02-11 23:53:22.000000000 +0100
+++ b/arch/mips/txx9/rbtx4938/setup.c 2011-03-21 08:55:24.000000000 +0100
@@ -285,14 +285,12 @@ static int __init rbtx4938_spi_init(void
 	spi_eeprom_register(SPI_BUSNO, SEEPROM1_CS, 128);
 	spi_eeprom_register(SPI_BUSNO, 16 + SEEPROM2_CS, 128);
 	spi_eeprom_register(SPI_BUSNO, 16 + SEEPROM3_CS, 128);
-	gpio_request(16 + SRTC_CS, "rtc-rs5c348");
-	gpio_direction_output(16 + SRTC_CS, 0);
-	gpio_request(SEEPROM1_CS, "seeprom1");
-	gpio_direction_output(SEEPROM1_CS, 1);
-	gpio_request(16 + SEEPROM2_CS, "seeprom2");
-	gpio_direction_output(16 + SEEPROM2_CS, 1);
-	gpio_request(16 + SEEPROM3_CS, "seeprom3");
-	gpio_direction_output(16 + SEEPROM3_CS, 1);
+	gpio_request_one(16 + SRTC_CS, GPIOF_OUT_INIT_LOW, "rtc-rs5c348");
+	gpio_request_one(SEEPROM1_CS, GPIOF_OUT_INIT_HIGH, "seeprom1");
+	
+	gpio_request_one(16 + SEEPROM2_CS, GPIOF_OUT_INIT_HIGH, "seeprom2");
+	
+	gpio_request_one(16 + SEEPROM3_CS, GPIOF_OUT_INIT_HIGH, "seeprom3");
 	tx4938_spi_init(SPI_BUSNO);
 	return 0;
 }
diff -u -p a/arch/sh/boards/board-sh7757lcr.c b/arch/sh/boards/board-sh7757lcr.c
--- a/arch/sh/boards/board-sh7757lcr.c 2011-03-20 18:17:23.000000000 +0100
+++ b/arch/sh/boards/board-sh7757lcr.c 2011-03-21 08:55:21.000000000 +0100
@@ -492,26 +492,22 @@ static int __init sh7757lcr_devices_setu
 	gpio_request(GPIO_FN_EVENT0, NULL);
 
 	/* LED for heartbeat */
-	gpio_request(GPIO_PTU3, NULL);
-	gpio_direction_output(GPIO_PTU3, 1);
-	gpio_request(GPIO_PTU2, NULL);
-	gpio_direction_output(GPIO_PTU2, 1);
-	gpio_request(GPIO_PTU1, NULL);
-	gpio_direction_output(GPIO_PTU1, 1);
-	gpio_request(GPIO_PTU0, NULL);
-	gpio_direction_output(GPIO_PTU0, 1);
+	gpio_request_one(GPIO_PTU3, GPIOF_OUT_INIT_HIGH, NULL);
+	
+	gpio_request_one(GPIO_PTU2, GPIOF_OUT_INIT_HIGH, NULL);
+	
+	gpio_request_one(GPIO_PTU1, GPIOF_OUT_INIT_HIGH, NULL);
+	
+	gpio_request_one(GPIO_PTU0, GPIOF_OUT_INIT_HIGH, NULL);
 
 	/* control for MDIO of Gigabit Ethernet */
-	gpio_request(GPIO_PTT4, NULL);
-	gpio_direction_output(GPIO_PTT4, 1);
+	gpio_request_one(GPIO_PTT4, GPIOF_OUT_INIT_HIGH, NULL);
 
 	/* control for eMMC */
-	gpio_request(GPIO_PTT7, NULL);		/* eMMC_RST# */
-	gpio_direction_output(GPIO_PTT7, 0);
-	gpio_request(GPIO_PTT6, NULL);		/* eMMC_INDEX# */
-	gpio_direction_output(GPIO_PTT6, 0);
-	gpio_request(GPIO_PTT5, NULL);		/* eMMC_PRST# */
-	gpio_direction_output(GPIO_PTT5, 1);
+	gpio_request_one(GPIO_PTT7, GPIOF_OUT_INIT_LOW, NULL);		/* eMMC_RST# */
+	
+	gpio_request_one(GPIO_PTT6, GPIOF_OUT_INIT_LOW, NULL);		/* eMMC_INDEX# */
+	gpio_request_one(GPIO_PTT5, GPIOF_OUT_INIT_HIGH, NULL);
 
 	/* register SPI device information */
 	spi_register_board_info(spi_board_info,
diff -u -p a/arch/sh/boards/mach-ap325rxa/setup.c b/arch/sh/boards/mach-ap325rxa/setup.c
--- a/arch/sh/boards/mach-ap325rxa/setup.c 2011-01-19 18:51:18.000000000 +0100
+++ b/arch/sh/boards/mach-ap325rxa/setup.c 2011-03-21 08:55:22.000000000 +0100
@@ -548,17 +548,14 @@ static int __init ap325rxa_devices_setup
 					&ap325rxa_sdram_leave_end);
 
 	/* LD3 and LD4 LEDs */
-	gpio_request(GPIO_PTX5, NULL); /* RUN */
-	gpio_direction_output(GPIO_PTX5, 1);
+	gpio_request_one(GPIO_PTX5, GPIOF_OUT_INIT_HIGH, NULL); /* RUN */
 	gpio_export(GPIO_PTX5, 0);
 
-	gpio_request(GPIO_PTX4, NULL); /* INDICATOR */
-	gpio_direction_output(GPIO_PTX4, 0);
+	gpio_request_one(GPIO_PTX4, GPIOF_OUT_INIT_LOW, NULL); /* INDICATOR */
 	gpio_export(GPIO_PTX4, 0);
 
 	/* SW1 input */
-	gpio_request(GPIO_PTF7, NULL); /* MODE */
-	gpio_direction_input(GPIO_PTF7);
+	gpio_request_one(GPIO_PTF7, GPIOF_IN, NULL); /* MODE */
 	gpio_export(GPIO_PTF7, 0);
 
 	/* LCDC */
@@ -588,8 +585,7 @@ static int __init ap325rxa_devices_setup
 	gpio_request(GPIO_FN_LCDDON, NULL);
 
 	/* LCD backlight */
-	gpio_request(GPIO_PTS3, NULL);
-	gpio_direction_output(GPIO_PTS3, 1);
+	gpio_request_one(GPIO_PTS3, GPIOF_OUT_INIT_HIGH, NULL);
 
 	/* CEU */
 	gpio_request(GPIO_FN_VIO_CLK2, NULL);
@@ -606,14 +602,13 @@ static int __init ap325rxa_devices_setup
 	gpio_request(GPIO_FN_VIO_D9, NULL);
 	gpio_request(GPIO_FN_VIO_D8, NULL);
 
-	gpio_request(GPIO_PTZ7, NULL);
-	gpio_direction_output(GPIO_PTZ7, 0); /* OE_CAM */
-	gpio_request(GPIO_PTZ6, NULL);
-	gpio_direction_output(GPIO_PTZ6, 0); /* STBY_CAM */
-	gpio_request(GPIO_PTZ5, NULL);
-	gpio_direction_output(GPIO_PTZ5, 0); /* RST_CAM */
-	gpio_request(GPIO_PTZ4, NULL);
-	gpio_direction_output(GPIO_PTZ4, 0); /* SADDR */
+	gpio_request_one(GPIO_PTZ7, GPIOF_OUT_INIT_LOW, NULL);
+	 /* OE_CAM */
+	gpio_request_one(GPIO_PTZ6, GPIOF_OUT_INIT_LOW, NULL);
+	 /* STBY_CAM */
+	gpio_request_one(GPIO_PTZ5, GPIOF_OUT_INIT_LOW, NULL);
+	 /* RST_CAM */
+	gpio_request_one(GPIO_PTZ4, GPIOF_OUT_INIT_LOW, NULL);/* SADDR */
 
 	__raw_writew(__raw_readw(PORT_MSELCRB) & ~0x0001, PORT_MSELCRB);
 
diff -u -p a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
--- a/arch/sh/boards/mach-ecovec24/setup.c 2011-03-20 18:17:23.000000000 +0100
+++ b/arch/sh/boards/mach-ecovec24/setup.c 2011-03-21 08:55:23.000000000 +0100
@@ -433,8 +433,7 @@ static int ts_get_pendown_state(void)
 {
 	int val = 0;
 	gpio_free(GPIO_FN_INTC_IRQ0);
-	gpio_request(GPIO_PTZ0, NULL);
-	gpio_direction_input(GPIO_PTZ0);
+	gpio_request_one(GPIO_PTZ0, GPIOF_IN, NULL);
 
 	val = gpio_get_value(GPIO_PTZ0);
 
@@ -992,8 +991,7 @@ static int __init arch_setup(void)
 	__raw_writew((__raw_readw(PORT_HIZA) & ~(0x1 << 1)) , PORT_HIZA);
 
 	/* enable SH-Eth */
-	gpio_request(GPIO_PTA1, NULL);
-	gpio_direction_output(GPIO_PTA1, 1);
+	gpio_request_one(GPIO_PTA1, GPIOF_OUT_INIT_HIGH, NULL);
 	mdelay(20);
 
 	gpio_request(GPIO_FN_RMII_RXD0,    NULL);
@@ -1097,8 +1095,7 @@ static int __init arch_setup(void)
 		 * but current sh_mobile_lcdc driver doesn't control it.
 		 * It is temporary correspondence
 		 */
-		gpio_request(GPIO_PTF4, NULL);
-		gpio_direction_output(GPIO_PTF4, 1);
+		gpio_request_one(GPIO_PTF4, GPIOF_OUT_INIT_HIGH, NULL);
 
 		/* enable TouchScreen */
 		i2c_register_board_info(0, &ts_i2c_clients, 1);
@@ -1172,8 +1169,7 @@ static int __init arch_setup(void)
 	gpio_request(GPIO_FN_SDHI0D2,  NULL);
 	gpio_request(GPIO_FN_SDHI0D1,  NULL);
 	gpio_request(GPIO_FN_SDHI0D0,  NULL);
-	gpio_request(GPIO_PTB6, NULL);
-	gpio_direction_output(GPIO_PTB6, 0);
+	gpio_request_one(GPIO_PTB6, GPIOF_OUT_INIT_LOW, NULL);
 
 #if !defined(CONFIG_MMC_SH_MMCIF)
 	/* enable SDHI1 on CN12 (needs DS2.6,7 set to ON,OFF) */
@@ -1185,8 +1181,7 @@ static int __init arch_setup(void)
 	gpio_request(GPIO_FN_SDHI1D2,  NULL);
 	gpio_request(GPIO_FN_SDHI1D1,  NULL);
 	gpio_request(GPIO_FN_SDHI1D0,  NULL);
-	gpio_request(GPIO_PTB7, NULL);
-	gpio_direction_output(GPIO_PTB7, 0);
+	gpio_request_one(GPIO_PTB7, GPIOF_OUT_INIT_LOW, NULL);
 
 	/* I/O buffer drive ability is high for SDHI1 */
 	__raw_writew((__raw_readw(IODRIVEA) & ~0x3000) | 0x2000 , IODRIVEA);
@@ -1196,21 +1191,17 @@ static int __init arch_setup(void)
 	gpio_request(GPIO_FN_MSIOF0_TXD, NULL);
 	gpio_request(GPIO_FN_MSIOF0_RXD, NULL);
 	gpio_request(GPIO_FN_MSIOF0_TSCK, NULL);
-	gpio_request(GPIO_PTM4, NULL); /* software CS control of TSYNC pin */
-	gpio_direction_output(GPIO_PTM4, 1); /* active low CS */
-	gpio_request(GPIO_PTB6, NULL); /* 3.3V power control */
-	gpio_direction_output(GPIO_PTB6, 0); /* disable power by default */
-	gpio_request(GPIO_PTY6, NULL); /* write protect */
-	gpio_direction_input(GPIO_PTY6);
-	gpio_request(GPIO_PTY7, NULL); /* card detect */
-	gpio_direction_input(GPIO_PTY7);
+	gpio_request_one(GPIO_PTM4, GPIOF_OUT_INIT_HIGH, NULL); /* software CS control of TSYNC pin *//* active low CS */
+	gpio_request_one(GPIO_PTB6, GPIOF_OUT_INIT_LOW, NULL); /* 3.3V power control *//* disable power by default */
+	gpio_request_one(GPIO_PTY6, GPIOF_IN, NULL); /* write protect */
+	
+	gpio_request_one(GPIO_PTY7, GPIOF_IN, NULL);
 
 	spi_register_board_info(spi_bus, ARRAY_SIZE(spi_bus));
 #endif
 
 	/* enable Video */
-	gpio_request(GPIO_PTU2, NULL);
-	gpio_direction_output(GPIO_PTU2, 1);
+	gpio_request_one(GPIO_PTU2, GPIOF_OUT_INIT_HIGH, NULL);
 
 	/* enable Camera */
 	gpio_request(GPIO_PTA3, NULL);
@@ -1245,13 +1236,11 @@ static int __init arch_setup(void)
 		clk_put(clk);
 	}
 
-	gpio_request(GPIO_PTU0, NULL);
-	gpio_direction_output(GPIO_PTU0, 0);
+	gpio_request_one(GPIO_PTU0, GPIOF_OUT_INIT_LOW, NULL);
 	mdelay(20);
 
 	/* enable motion sensor */
-	gpio_request(GPIO_FN_INTC_IRQ1, NULL);
-	gpio_direction_input(GPIO_FN_INTC_IRQ1);
+	gpio_request_one(GPIO_FN_INTC_IRQ1, GPIOF_IN, NULL);
 
 	/* set VPU clock to 166 MHz */
 	clk = clk_get(NULL, "vpu_clk");
@@ -1263,8 +1252,7 @@ static int __init arch_setup(void)
 	/* enable IrDA */
 	gpio_request(GPIO_FN_IRDA_OUT, NULL);
 	gpio_request(GPIO_FN_IRDA_IN,  NULL);
-	gpio_request(GPIO_PTU5, NULL);
-	gpio_direction_output(GPIO_PTU5, 0);
+	gpio_request_one(GPIO_PTU5, GPIOF_OUT_INIT_LOW, NULL);
 
 #if defined(CONFIG_MMC_SH_MMCIF)
 	/* enable MMCIF (needs DS2.6,7 set to OFF,ON) */
@@ -1278,8 +1266,7 @@ static int __init arch_setup(void)
 	gpio_request(GPIO_FN_MMC_D0, NULL);
 	gpio_request(GPIO_FN_MMC_CLK, NULL);
 	gpio_request(GPIO_FN_MMC_CMD, NULL);
-	gpio_request(GPIO_PTB7, NULL);
-	gpio_direction_output(GPIO_PTB7, 0);
+	gpio_request_one(GPIO_PTB7, GPIOF_OUT_INIT_LOW, NULL);
 
 	/* I/O buffer drive ability is high for MMCIF */
 	__raw_writew((__raw_readw(IODRIVEA) & ~0x3000) | 0x2000 , IODRIVEA);
diff -u -p a/arch/sh/boards/mach-kfr2r09/setup.c b/arch/sh/boards/mach-kfr2r09/setup.c
--- a/arch/sh/boards/mach-kfr2r09/setup.c 2011-01-19 18:51:18.000000000 +0100
+++ b/arch/sh/boards/mach-kfr2r09/setup.c 2011-03-21 08:55:24.000000000 +0100
@@ -500,8 +500,7 @@ static int kfr2r09_usb0_gadget_setup(voi
 {
 	int plugged_in;
 
-	gpio_request(GPIO_PTN4, NULL); /* USB_DET */
-	gpio_direction_input(GPIO_PTN4);
+	gpio_request_one(GPIO_PTN4, GPIOF_IN, NULL); /* USB_DET */
 	plugged_in = gpio_get_value(GPIO_PTN4);
 	if (!plugged_in)
 		return -ENODEV; /* no cable plugged in */
@@ -511,8 +510,7 @@ static int kfr2r09_usb0_gadget_setup(voi
 
 	__raw_writew((__raw_readw(PORT_MSELCRB) & ~0xc000) | 0x8000, PORT_MSELCRB);
 	gpio_request(GPIO_FN_PDSTATUS, NULL); /* R-standby disables USB clock */
-	gpio_request(GPIO_PTV6, NULL); /* USBCLK_ON */
-	gpio_direction_output(GPIO_PTV6, 1); /* USBCLK_ON = H */
+	gpio_request_one(GPIO_PTV6, GPIOF_OUT_INIT_HIGH, NULL); /* USBCLK_ON *//* USBCLK_ON = H */
 	msleep(20); /* wait 20ms to let the clock settle */
 	clk_enable(clk_get(NULL, "usb0"));
 	__raw_writew(0x0600, 0xa40501d4);
@@ -539,8 +537,7 @@ static int __init kfr2r09_devices_setup(
 	gpio_request(GPIO_FN_SCIF1_RXD, NULL);
 	gpio_request(GPIO_FN_SCIF1_TXD, NULL);
 	kfr2r09_serial_i2c_setup(); /* ECONTMSK(bit6=L10ONEN) set 1 */
-	gpio_request(GPIO_PTG3, NULL); /* HPON_ON */
-	gpio_direction_output(GPIO_PTG3, 1); /* HPON_ON = H */
+	gpio_request_one(GPIO_PTG3, GPIOF_OUT_INIT_HIGH, NULL); /* HPON_ON *//* HPON_ON = H */
 
 	/* setup NOR flash@CS0 */
 	__raw_writel(0x36db0400, BSC_CS0BCR);
@@ -587,12 +584,11 @@ static int __init kfr2r09_devices_setup(
 	gpio_request(GPIO_FN_LCDRD, NULL); /* LCD_RD/ */
 	gpio_request(GPIO_FN_LCDWR, NULL); /* LCD_WR/ */
 	gpio_request(GPIO_FN_LCDVSYN, NULL); /* LCD_VSYNC */
-	gpio_request(GPIO_PTE4, NULL); /* LCD_RST/ */
-	gpio_direction_output(GPIO_PTE4, 1);
-	gpio_request(GPIO_PTF4, NULL); /* PROTECT/ */
-	gpio_direction_output(GPIO_PTF4, 1);
-	gpio_request(GPIO_PTU0, NULL); /* LEDSTDBY/ */
-	gpio_direction_output(GPIO_PTU0, 1);
+	gpio_request_one(GPIO_PTE4, GPIOF_OUT_INIT_HIGH, NULL); /* LCD_RST/ */
+	
+	gpio_request_one(GPIO_PTF4, GPIOF_OUT_INIT_HIGH, NULL); /* PROTECT/ */
+	
+	gpio_request_one(GPIO_PTU0, GPIOF_OUT_INIT_HIGH, NULL);
 
 	/* setup USB function */
 	if (kfr2r09_usb0_gadget_setup() == 0)
diff -u -p a/arch/sh/boards/mach-migor/setup.c b/arch/sh/boards/mach-migor/setup.c
--- a/arch/sh/boards/mach-migor/setup.c 2011-01-19 18:51:18.000000000 +0100
+++ b/arch/sh/boards/mach-migor/setup.c 2011-03-21 08:55:22.000000000 +0100
@@ -538,8 +538,7 @@ static int __init migor_devices_setup(vo
 	/* NAND Flash */
 	gpio_request(GPIO_FN_CS6A_CE2B, NULL);
 	__raw_writel((__raw_readl(BSC_CS6ABCR) & ~0x0600) | 0x0200, BSC_CS6ABCR);
-	gpio_request(GPIO_PTA1, NULL);
-	gpio_direction_input(GPIO_PTA1);
+	gpio_request_one(GPIO_PTA1, GPIOF_IN, NULL);
 
 	/* SDHI */
 	gpio_request(GPIO_FN_SDHICD, NULL);
@@ -576,8 +575,7 @@ static int __init migor_devices_setup(vo
 	gpio_request(GPIO_FN_LCDCS, NULL);
 	gpio_request(GPIO_FN_LCDRD, NULL);
 	gpio_request(GPIO_FN_LCDWR, NULL);
-	gpio_request(GPIO_PTH2, NULL); /* LCD_DON */
-	gpio_direction_output(GPIO_PTH2, 1);
+	gpio_request_one(GPIO_PTH2, GPIOF_OUT_INIT_HIGH, NULL); /* LCD_DON */
 #endif
 #ifdef CONFIG_SH_MIGOR_RTA_WVGA /* LCDC - WVGA - Enable RGB Interface signals */
 	gpio_request(GPIO_FN_LCDD15, NULL);
@@ -621,13 +619,10 @@ static int __init migor_devices_setup(vo
 	gpio_request(GPIO_FN_VIO_D9, NULL);
 	gpio_request(GPIO_FN_VIO_D8, NULL);
 
-	gpio_request(GPIO_PTT3, NULL); /* VIO_RST */
-	gpio_direction_output(GPIO_PTT3, 0);
-	gpio_request(GPIO_PTT2, NULL); /* TV_IN_EN */
-	gpio_direction_output(GPIO_PTT2, 1);
-	gpio_request(GPIO_PTT0, NULL); /* CAM_EN */
+	gpio_request_one(GPIO_PTT3, GPIOF_OUT_INIT_LOW, NULL); /* VIO_RST */
+	gpio_request_one(GPIO_PTT2, GPIOF_OUT_INIT_HIGH, NULL); /* TV_IN_EN */
+	gpio_request_one(GPIO_PTT0, GPIOF_OUT_INIT_LOW, NULL); /* CAM_EN */
 #ifdef CONFIG_SH_MIGOR_RTA_WVGA
-	gpio_direction_output(GPIO_PTT0, 0);
 #else
 	gpio_direction_output(GPIO_PTT0, 1);
 #endif
diff -u -p a/arch/sh/boards/mach-se/7724/setup.c b/arch/sh/boards/mach-se/7724/setup.c
--- a/arch/sh/boards/mach-se/7724/setup.c 2011-02-02 17:27:37.000000000 +0100
+++ b/arch/sh/boards/mach-se/7724/setup.c 2011-03-21 08:55:21.000000000 +0100
@@ -899,8 +899,7 @@ static int __init devices_setup(void)
 	gpio_request(GPIO_FN_RMII_CRS_DV,  NULL);
 	gpio_request(GPIO_FN_MDIO,         NULL);
 	gpio_request(GPIO_FN_MDC,          NULL);
-	gpio_request(GPIO_PTX5, NULL);
-	gpio_direction_input(GPIO_PTX5);
+	gpio_request_one(GPIO_PTX5, GPIOF_IN, NULL);
 	sh_eth_init();
 
 	if (sw & SW41_B) {
diff -u -p a/drivers/block/mg_disk.c b/drivers/block/mg_disk.c
--- a/drivers/block/mg_disk.c 2010-08-25 09:45:50.000000000 +0200
+++ b/drivers/block/mg_disk.c 2011-03-21 08:55:24.000000000 +0100
@@ -882,10 +882,9 @@ static int mg_probe(struct platform_devi
 	host->rst = rsc->start;
 
 	/* init rst pin */
-	err = gpio_request(host->rst, MG_RST_PIN);
+	err = gpio_request_one(host->rst, GPIOF_OUT_INIT_HIGH, MG_RST_PIN);
 	if (err)
 		goto probe_err_3;
-	gpio_direction_output(host->rst, 1);
 
 	/* reset out pin */
 	if (!(prv_data->dev_attr & MG_DEV_MASK))
@@ -901,10 +900,9 @@ static int mg_probe(struct platform_devi
 			goto probe_err_3a;
 		}
 		host->rstout = rsc->start;
-		err = gpio_request(host->rstout, MG_RSTOUT_PIN);
+		err = gpio_request_one(host->rstout, GPIOF_IN, MG_RSTOUT_PIN);
 		if (err)
 			goto probe_err_3a;
-		gpio_direction_input(host->rstout);
 	}
 
 	/* disk reset */
diff -u -p a/drivers/hwmon/sht15.c b/drivers/hwmon/sht15.c
--- a/drivers/hwmon/sht15.c 2011-03-20 18:17:23.000000000 +0100
+++ b/drivers/hwmon/sht15.c 2011-03-21 08:55:24.000000000 +0100
@@ -555,12 +555,12 @@ static int __devinit sht15_probe(struct 
 		ret = regulator_register_notifier(data->reg, &data->nb);
 	}
 /* Try requesting the GPIOs */
-	ret = gpio_request(data->pdata->gpio_sck, "SHT15 sck");
+	ret = gpio_request_one(data->pdata->gpio_sck, GPIOF_OUT_INIT_LOW,
+			       "SHT15 sck");
 	if (ret) {
 		dev_err(&pdev->dev, "gpio request failed");
 		goto err_free_data;
 	}
-	gpio_direction_output(data->pdata->gpio_sck, 0);
 	ret = gpio_request(data->pdata->gpio_data, "SHT15 data");
 	if (ret) {
 		dev_err(&pdev->dev, "gpio request failed");
diff -u -p a/drivers/input/keyboard/matrix_keypad.c b/drivers/input/keyboard/matrix_keypad.c
--- a/drivers/input/keyboard/matrix_keypad.c 2010-07-03 18:06:34.000000000 +0200
+++ b/drivers/input/keyboard/matrix_keypad.c 2011-03-21 08:55:22.000000000 +0100
@@ -318,15 +318,14 @@ static int __devinit init_matrix_gpio(st
 	}
 
 	for (i = 0; i < pdata->num_row_gpios; i++) {
-		err = gpio_request(pdata->row_gpios[i], "matrix_kbd_row");
+		err = gpio_request_one(pdata->row_gpios[i], GPIOF_IN,
+				       "matrix_kbd_row");
 		if (err) {
 			dev_err(&pdev->dev,
 				"failed to request GPIO%d for ROW%d\n",
 				pdata->row_gpios[i], i);
 			goto err_free_rows;
 		}
-
-		gpio_direction_input(pdata->row_gpios[i]);
 	}
 
 	if (pdata->clustered_irq > 0) {
diff -u -p a/drivers/input/keyboard/omap-keypad.c b/drivers/input/keyboard/omap-keypad.c
--- a/drivers/input/keyboard/omap-keypad.c 2010-12-28 18:26:03.000000000 +0100
+++ b/drivers/input/keyboard/omap-keypad.c 2011-03-21 08:55:22.000000000 +0100
@@ -336,23 +336,24 @@ static int __devinit omap_kp_probe(struc
 	if (cpu_is_omap24xx()) {
 		/* Cols: outputs */
 		for (col_idx = 0; col_idx < omap_kp->cols; col_idx++) {
-			if (gpio_request(col_gpios[col_idx], "omap_kp_col") < 0) {
+			if (gpio_request_one(col_gpios[col_idx],
+					     GPIOF_OUT_INIT_LOW,
+					     "omap_kp_col") < 0) {
 				printk(KERN_ERR "Failed to request"
 				       "GPIO%d for keypad\n",
 				       col_gpios[col_idx]);
 				goto err1;
 			}
-			gpio_direction_output(col_gpios[col_idx], 0);
 		}
 		/* Rows: inputs */
 		for (row_idx = 0; row_idx < omap_kp->rows; row_idx++) {
-			if (gpio_request(row_gpios[row_idx], "omap_kp_row") < 0) {
+			if (gpio_request_one(row_gpios[row_idx], GPIOF_IN,
+					     "omap_kp_row") < 0) {
 				printk(KERN_ERR "Failed to request"
 				       "GPIO%d for keypad\n",
 				       row_gpios[row_idx]);
 				goto err2;
 			}
-			gpio_direction_input(row_gpios[row_idx]);
 		}
 	} else {
 		col_idx = 0;
diff -u -p a/drivers/input/mouse/gpio_mouse.c b/drivers/input/mouse/gpio_mouse.c
--- a/drivers/input/mouse/gpio_mouse.c 2009-07-12 20:48:31.000000000 +0200
+++ b/drivers/input/mouse/gpio_mouse.c 2011-03-21 08:55:22.000000000 +0100
@@ -83,14 +83,12 @@ static int __devinit gpio_mouse_probe(st
 				dev_dbg(&pdev->dev, "no left button defined\n");
 
 		} else {
-			error = gpio_request(pin, "gpio_mouse");
+			error = gpio_request_one(pin, GPIOF_IN, "gpio_mouse");
 			if (error) {
 				dev_err(&pdev->dev, "fail %d pin (%d idx)\n",
 					pin, i);
 				goto out_free_gpios;
 			}
-
-			gpio_direction_input(pin);
 		}
 	}
 
diff -u -p a/drivers/input/serio/ams_delta_serio.c b/drivers/input/serio/ams_delta_serio.c
--- a/drivers/input/serio/ams_delta_serio.c 2010-11-24 07:55:11.000000000 +0100
+++ b/drivers/input/serio/ams_delta_serio.c 2011-03-21 08:55:21.000000000 +0100
@@ -122,19 +122,19 @@ static int __init ams_delta_serio_init(v
 	strlcpy(ams_delta_serio->phys, "GPIO/serio0",
 			sizeof(ams_delta_serio->phys));
 
-	err = gpio_request(AMS_DELTA_GPIO_PIN_KEYBRD_DATA, "serio-data");
+	err = gpio_request_one(AMS_DELTA_GPIO_PIN_KEYBRD_DATA, GPIOF_IN,
+			       "serio-data");
 	if (err) {
 		pr_err("ams_delta_serio: Couldn't request gpio pin for data\n");
 		goto serio;
 	}
-	gpio_direction_input(AMS_DELTA_GPIO_PIN_KEYBRD_DATA);
 
-	err = gpio_request(AMS_DELTA_GPIO_PIN_KEYBRD_CLK, "serio-clock");
+	err = gpio_request_one(AMS_DELTA_GPIO_PIN_KEYBRD_CLK, GPIOF_IN,
+			       "serio-clock");
 	if (err) {
 		pr_err("ams_delta_serio: couldn't request gpio pin for clock\n");
 		goto gpio_data;
 	}
-	gpio_direction_input(AMS_DELTA_GPIO_PIN_KEYBRD_CLK);
 
 	err = request_irq(gpio_to_irq(AMS_DELTA_GPIO_PIN_KEYBRD_CLK),
 			ams_delta_serio_interrupt, IRQ_TYPE_EDGE_RISING,
diff -u -p a/drivers/leds/leds-bd2802.c b/drivers/leds/leds-bd2802.c
--- a/drivers/leds/leds-bd2802.c 2010-08-06 00:40:23.000000000 +0200
+++ b/drivers/leds/leds-bd2802.c 2011-03-21 08:55:21.000000000 +0100
@@ -697,8 +697,7 @@ static int __devinit bd2802_probe(struct
 	i2c_set_clientdata(client, led);
 
 	/* Configure RESET GPIO (L: RESET, H: RESET cancel) */
-	gpio_request(pdata->reset_gpio, "RGB_RESETB");
-	gpio_direction_output(pdata->reset_gpio, 1);
+	gpio_request_one(pdata->reset_gpio, GPIOF_OUT_INIT_HIGH, "RGB_RESETB");
 
 	/* Tacss = min 0.1ms */
 	udelay(100);
diff -u -p a/drivers/mfd/dm355evm_msp.c b/drivers/mfd/dm355evm_msp.c
--- a/drivers/mfd/dm355evm_msp.c 2009-09-19 08:25:19.000000000 +0200
+++ b/drivers/mfd/dm355evm_msp.c 2011-03-21 08:55:23.000000000 +0100
@@ -307,8 +307,7 @@ static int add_children(struct i2c_clien
 	for (i = 0; i < ARRAY_SIZE(config_inputs); i++) {
 		int gpio = dm355evm_msp_gpio.base + config_inputs[i].offset;
 
-		gpio_request(gpio, config_inputs[i].label);
-		gpio_direction_input(gpio);
+		gpio_request_one(gpio, GPIOF_IN, config_inputs[i].label);
 
 		/* make it easy for userspace to see these */
 		gpio_export(gpio, false);
diff -u -p a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
--- a/drivers/mfd/omap-usb-host.c 2011-03-14 17:19:15.000000000 +0100
+++ b/drivers/mfd/omap-usb-host.c 2011-03-21 08:55:23.000000000 +0100
@@ -716,17 +716,15 @@ static int usbhs_enable(struct device *d
 
 	if (pdata->ehci_data->phy_reset) {
 		if (gpio_is_valid(pdata->ehci_data->reset_gpio_port[0])) {
-			gpio_request(pdata->ehci_data->reset_gpio_port[0],
-						"USB1 PHY reset");
-			gpio_direction_output
-				(pdata->ehci_data->reset_gpio_port[0], 1);
+			gpio_request_one(pdata->ehci_data->reset_gpio_port[0],
+					 GPIOF_OUT_INIT_HIGH,
+					 "USB1 PHY reset");
 		}
 
 		if (gpio_is_valid(pdata->ehci_data->reset_gpio_port[1])) {
-			gpio_request(pdata->ehci_data->reset_gpio_port[1],
-						"USB2 PHY reset");
-			gpio_direction_output
-				(pdata->ehci_data->reset_gpio_port[1], 1);
+			gpio_request_one(pdata->ehci_data->reset_gpio_port[1],
+					 GPIOF_OUT_INIT_HIGH,
+					 "USB2 PHY reset");
 		}
 
 		/* Hold the PHY in RESET for enough time till DIR is high */
diff -u -p a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
--- a/drivers/mmc/host/pxamci.c 2010-09-30 17:54:15.000000000 +0200
+++ b/drivers/mmc/host/pxamci.c 2011-03-21 08:55:23.000000000 +0100
@@ -719,20 +719,19 @@ static int pxamci_probe(struct platform_
 				      host->pdata->gpio_power_invert);
 	}
 	if (gpio_is_valid(gpio_ro)) {
-		ret = gpio_request(gpio_ro, "mmc card read only");
+		ret = gpio_request_one(gpio_ro, GPIOF_IN,
+				       "mmc card read only");
 		if (ret) {
 			dev_err(&pdev->dev, "Failed requesting gpio_ro %d\n", gpio_ro);
 			goto err_gpio_ro;
 		}
-		gpio_direction_input(gpio_ro);
 	}
 	if (gpio_is_valid(gpio_cd)) {
-		ret = gpio_request(gpio_cd, "mmc card detect");
+		ret = gpio_request_one(gpio_cd, GPIOF_IN, "mmc card detect");
 		if (ret) {
 			dev_err(&pdev->dev, "Failed requesting gpio_cd %d\n", gpio_cd);
 			goto err_gpio_cd;
 		}
-		gpio_direction_input(gpio_cd);
 
 		ret = request_irq(gpio_to_irq(gpio_cd), pxamci_detect_irq,
 				  IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
diff -u -p a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
--- a/drivers/mmc/host/s3cmci.c 2010-09-18 08:59:06.000000000 +0200
+++ b/drivers/mmc/host/s3cmci.c 2011-03-21 08:55:25.000000000 +0100
@@ -1676,13 +1676,12 @@ static int __devinit s3cmci_probe(struct
 		host->irq_cd = -1;
 
 	if (!host->pdata->no_wprotect) {
-		ret = gpio_request(host->pdata->gpio_wprotect, "s3cmci wp");
+		ret = gpio_request_one(host->pdata->gpio_wprotect, GPIOF_IN,
+				       "s3cmci wp");
 		if (ret) {
 			dev_err(&pdev->dev, "failed to get writeprotect\n");
 			goto probe_free_irq_cd;
 		}
-
-		gpio_direction_input(host->pdata->gpio_wprotect);
 	}
 
 	/* depending on the dma state, get a dma channel to use. */
diff -u -p a/drivers/mtd/maps/bfin-async-flash.c b/drivers/mtd/maps/bfin-async-flash.c
--- a/drivers/mtd/maps/bfin-async-flash.c 2010-03-29 19:27:56.000000000 +0200
+++ b/drivers/mtd/maps/bfin-async-flash.c 2011-03-21 08:55:25.000000000 +0100
@@ -154,12 +154,12 @@ static int __devinit bfin_flash_probe(st
 	state->flash_ambctl0  = flash_ambctl->start;
 	state->flash_ambctl1  = flash_ambctl->end;
 
-	if (gpio_request(state->enet_flash_pin, DRIVER_NAME)) {
+	if (gpio_request_one(state->enet_flash_pin, GPIOF_OUT_INIT_HIGH,
+			     DRIVER_NAME)) {
 		pr_devinit(KERN_ERR DRIVER_NAME ": Failed to request gpio %d\n", state->enet_flash_pin);
 		kfree(state);
 		return -EBUSY;
 	}
-	gpio_direction_output(state->enet_flash_pin, 1);
 
 	pr_devinit(KERN_NOTICE DRIVER_NAME ": probing %d-bit flash bus\n", state->map.bankwidth * 8);
 	state->mtd = do_map_probe(memory->name, &state->map);
diff -u -p a/drivers/mtd/maps/gpio-addr-flash.c b/drivers/mtd/maps/gpio-addr-flash.c
--- a/drivers/mtd/maps/gpio-addr-flash.c 2010-11-01 20:33:30.000000000 +0100
+++ b/drivers/mtd/maps/gpio-addr-flash.c 2011-03-21 08:55:25.000000000 +0100
@@ -233,7 +233,8 @@ static int __devinit gpio_flash_probe(st
 
 	i = 0;
 	do {
-		if (gpio_request(state->gpio_addrs[i], DRIVER_NAME)) {
+		if (gpio_request_one(state->gpio_addrs[i],
+				     GPIOF_OUT_INIT_LOW, DRIVER_NAME)) {
 			pr_devinit(KERN_ERR PFX "failed to request gpio %d\n",
 				state->gpio_addrs[i]);
 			while (i--)
@@ -241,7 +242,6 @@ static int __devinit gpio_flash_probe(st
 			kfree(state);
 			return -EBUSY;
 		}
-		gpio_direction_output(state->gpio_addrs[i], 0);
 	} while (++i < state->gpio_count);
 
 	pr_devinit(KERN_NOTICE PFX "probing %d-bit flash bus\n",
diff -u -p a/drivers/mtd/nand/cmx270_nand.c b/drivers/mtd/nand/cmx270_nand.c
--- a/drivers/mtd/nand/cmx270_nand.c 2010-03-29 19:27:56.000000000 +0200
+++ b/drivers/mtd/nand/cmx270_nand.c 2011-03-21 08:55:25.000000000 +0100
@@ -159,22 +159,18 @@ static int __init cmx270_init(void)
 	if (!(machine_is_armcore() && cpu_is_pxa27x()))
 		return -ENODEV;
 
-	ret = gpio_request(GPIO_NAND_CS, "NAND CS");
+	ret = gpio_request_one(GPIO_NAND_CS, GPIOF_OUT_INIT_HIGH, "NAND CS");
 	if (ret) {
 		pr_warning("CM-X270: failed to request NAND CS gpio\n");
 		return ret;
 	}
 
-	gpio_direction_output(GPIO_NAND_CS, 1);
-
-	ret = gpio_request(GPIO_NAND_RB, "NAND R/B");
+	ret = gpio_request_one(GPIO_NAND_RB, GPIOF_IN, "NAND R/B");
 	if (ret) {
 		pr_warning("CM-X270: failed to request NAND R/B gpio\n");
 		goto err_gpio_request;
 	}
 
-	gpio_direction_input(GPIO_NAND_RB);
-
 	/* Allocate memory for MTD device structure and private data */
 	cmx270_nand_mtd = kzalloc(sizeof(struct mtd_info) +
 				  sizeof(struct nand_chip),
diff -u -p a/drivers/mtd/nand/fsl_upm.c b/drivers/mtd/nand/fsl_upm.c
--- a/drivers/mtd/nand/fsl_upm.c 2011-03-14 17:19:15.000000000 +0100
+++ b/drivers/mtd/nand/fsl_upm.c 2011-03-21 08:55:25.000000000 +0100
@@ -278,13 +278,13 @@ static int __devinit fun_probe(struct pl
 		fun->rnb_gpio[i] = -1;
 		rnb_gpio = of_get_gpio(ofdev->dev.of_node, i);
 		if (rnb_gpio >= 0) {
-			ret = gpio_request(rnb_gpio, dev_name(&ofdev->dev));
+			ret = gpio_request_one(rnb_gpio, GPIOF_IN,
+					       dev_name(&ofdev->dev));
 			if (ret) {
 				dev_err(&ofdev->dev,
 					"can't request RNB gpio #%d\n", i);
 				goto err2;
 			}
-			gpio_direction_input(rnb_gpio);
 			fun->rnb_gpio[i] = rnb_gpio;
 		} else if (rnb_gpio == -EINVAL) {
 			dev_err(&ofdev->dev, "RNB gpio #%d is invalid\n", i);
diff -u -p a/drivers/mtd/nand/gpio.c b/drivers/mtd/nand/gpio.c
--- a/drivers/mtd/nand/gpio.c 2010-01-03 21:18:12.000000000 +0100
+++ b/drivers/mtd/nand/gpio.c 2011-03-21 08:55:24.000000000 +0100
@@ -259,28 +259,27 @@ static int __devinit gpio_nand_probe(str
 
 	memcpy(&gpiomtd->plat, dev->dev.platform_data, sizeof(gpiomtd->plat));
 
-	ret = gpio_request(gpiomtd->plat.gpio_nce, "NAND NCE");
+	ret = gpio_request_one(gpiomtd->plat.gpio_nce, GPIOF_OUT_INIT_HIGH,
+			       "NAND NCE");
 	if (ret)
 		goto err_nce;
-	gpio_direction_output(gpiomtd->plat.gpio_nce, 1);
 	if (gpio_is_valid(gpiomtd->plat.gpio_nwp)) {
-		ret = gpio_request(gpiomtd->plat.gpio_nwp, "NAND NWP");
+		ret = gpio_request_one(gpiomtd->plat.gpio_nwp,
+				       GPIOF_OUT_INIT_HIGH, "NAND NWP");
 		if (ret)
 			goto err_nwp;
-		gpio_direction_output(gpiomtd->plat.gpio_nwp, 1);
 	}
-	ret = gpio_request(gpiomtd->plat.gpio_ale, "NAND ALE");
+	ret = gpio_request_one(gpiomtd->plat.gpio_ale, GPIOF_OUT_INIT_LOW,
+			       "NAND ALE");
 	if (ret)
 		goto err_ale;
-	gpio_direction_output(gpiomtd->plat.gpio_ale, 0);
-	ret = gpio_request(gpiomtd->plat.gpio_cle, "NAND CLE");
+	ret = gpio_request_one(gpiomtd->plat.gpio_cle, GPIOF_OUT_INIT_LOW,
+			       "NAND CLE");
 	if (ret)
 		goto err_cle;
-	gpio_direction_output(gpiomtd->plat.gpio_cle, 0);
-	ret = gpio_request(gpiomtd->plat.gpio_rdy, "NAND RDY");
+	ret = gpio_request_one(gpiomtd->plat.gpio_rdy, GPIOF_IN, "NAND RDY");
 	if (ret)
 		goto err_rdy;
-	gpio_direction_input(gpiomtd->plat.gpio_rdy);
 
 
 	this->IO_ADDR_W  = this->IO_ADDR_R;
diff -u -p a/drivers/mtd/onenand/omap2.c b/drivers/mtd/onenand/omap2.c
--- a/drivers/mtd/onenand/omap2.c 2011-03-14 17:19:15.000000000 +0100
+++ b/drivers/mtd/onenand/omap2.c 2011-03-21 08:55:25.000000000 +0100
@@ -682,12 +682,12 @@ static int __devinit omap2_onenand_probe
 	}
 
 	if (c->gpio_irq) {
-		if ((r = gpio_request(c->gpio_irq, "OneNAND irq")) < 0) {
+		if ((r = gpio_request_one(c->gpio_irq, GPIOF_IN,
+					  "OneNAND irq")) < 0) {
 			dev_err(&pdev->dev,  "Failed to request GPIO%d for "
 				"OneNAND\n", c->gpio_irq);
 			goto err_iounmap;
 	}
-	gpio_direction_input(c->gpio_irq);
 
 	if ((r = request_irq(gpio_to_irq(c->gpio_irq),
 			     omap2_onenand_interrupt, IRQF_TRIGGER_RISING,
diff -u -p a/drivers/pcmcia/bfin_cf_pcmcia.c b/drivers/pcmcia/bfin_cf_pcmcia.c
--- a/drivers/pcmcia/bfin_cf_pcmcia.c 2010-03-29 19:27:57.000000000 +0200
+++ b/drivers/pcmcia/bfin_cf_pcmcia.c 2011-03-21 08:55:26.000000000 +0100
@@ -211,13 +211,12 @@ static int __devinit bfin_cf_probe(struc
 
 	cd_pfx = platform_get_irq(pdev, 1);	/*Card Detect GPIO PIN */
 
-	if (gpio_request(cd_pfx, "pcmcia: CD")) {
+	if (gpio_request_one(cd_pfx, GPIOF_IN, "pcmcia: CD")) {
 		dev_err(&pdev->dev,
 		       "Failed ro request Card Detect GPIO_%d\n",
 		       cd_pfx);
 		return -EBUSY;
 	}
-	gpio_direction_input(cd_pfx);
 
 	cf = kzalloc(sizeof *cf, GFP_KERNEL);
 	if (!cf) {
diff -u -p a/drivers/pcmcia/pxa2xx_cm_x255.c b/drivers/pcmcia/pxa2xx_cm_x255.c
--- a/drivers/pcmcia/pxa2xx_cm_x255.c 2009-11-08 21:45:05.000000000 +0100
+++ b/drivers/pcmcia/pxa2xx_cm_x255.c 2011-03-21 08:55:26.000000000 +0100
@@ -39,10 +39,10 @@ static struct pcmcia_irqs irqs[] = {
 
 static int cmx255_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
 {
-	int ret = gpio_request(GPIO_PCMCIA_RESET, "PCCard reset");
+	int ret = gpio_request_one(GPIO_PCMCIA_RESET, GPIOF_OUT_INIT_LOW,
+				   "PCCard reset");
 	if (ret)
 		return ret;
-	gpio_direction_output(GPIO_PCMCIA_RESET, 0);
 
 	skt->socket.pci_irq = skt->nr == 0 ? PCMCIA_S0_RDYINT : PCMCIA_S1_RDYINT;
 	ret = soc_pcmcia_request_irqs(skt, irqs, ARRAY_SIZE(irqs));
diff -u -p a/drivers/pcmcia/pxa2xx_cm_x270.c b/drivers/pcmcia/pxa2xx_cm_x270.c
--- a/drivers/pcmcia/pxa2xx_cm_x270.c 2009-11-08 21:45:05.000000000 +0100
+++ b/drivers/pcmcia/pxa2xx_cm_x270.c 2011-03-21 08:55:26.000000000 +0100
@@ -33,10 +33,10 @@ static struct pcmcia_irqs irqs[] = {
 
 static int cmx270_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
 {
-	int ret = gpio_request(GPIO_PCMCIA_RESET, "PCCard reset");
+	int ret = gpio_request_one(GPIO_PCMCIA_RESET, GPIOF_OUT_INIT_LOW,
+				   "PCCard reset");
 	if (ret)
 		return ret;
-	gpio_direction_output(GPIO_PCMCIA_RESET, 0);
 
 	skt->socket.pci_irq = PCMCIA_S0_RDYINT;
 	ret = soc_pcmcia_request_irqs(skt, irqs, ARRAY_SIZE(irqs));
diff -u -p a/drivers/rtc/rtc-v3020.c b/drivers/rtc/rtc-v3020.c
--- a/drivers/rtc/rtc-v3020.c 2010-03-29 19:27:57.000000000 +0200
+++ b/drivers/rtc/rtc-v3020.c 2011-03-21 08:55:23.000000000 +0100
@@ -125,11 +125,11 @@ static int v3020_gpio_map(struct v3020 *
 	v3020_gpio[V3020_IO].gpio = pdata->gpio_io;
 
 	for (i = 0; i < ARRAY_SIZE(v3020_gpio); i++) {
-		err = gpio_request(v3020_gpio[i].gpio, v3020_gpio[i].name);
+		err = gpio_request_one(v3020_gpio[i].gpio,
+				       GPIOF_OUT_INIT_HIGH,
+				       v3020_gpio[i].name);
 		if (err)
 			goto err_request;
-
-		gpio_direction_output(v3020_gpio[i].gpio, 1);
 	}
 
 	chip->gpio = v3020_gpio;
diff -u -p a/drivers/spi/mpc52xx_spi.c b/drivers/spi/mpc52xx_spi.c
--- a/drivers/spi/mpc52xx_spi.c 2011-03-14 17:19:16.000000000 +0100
+++ b/drivers/spi/mpc52xx_spi.c 2011-03-21 08:55:23.000000000 +0100
@@ -468,7 +468,8 @@ static int __devinit mpc52xx_spi_probe(s
 				goto err_gpio;
 			}
 
-			rc = gpio_request(gpio_cs, dev_name(&op->dev));
+			rc = gpio_request_one(gpio_cs, GPIOF_OUT_INIT_HIGH,
+					      dev_name(&op->dev));
 			if (rc) {
 				dev_err(&op->dev,
 					"can't request spi cs gpio #%d "
@@ -476,7 +477,6 @@ static int __devinit mpc52xx_spi_probe(s
 				goto err_gpio;
 			}
 
-			gpio_direction_output(gpio_cs, 1);
 			ms->gpio_cs[i] = gpio_cs;
 		}
 	} else {
diff -u -p a/drivers/spi/spi_bfin5xx.c b/drivers/spi/spi_bfin5xx.c
--- a/drivers/spi/spi_bfin5xx.c 2011-02-19 08:28:52.000000000 +0100
+++ b/drivers/spi/spi_bfin5xx.c 2011-03-21 08:55:21.000000000 +0100
@@ -1150,12 +1150,13 @@ static int bfin_spi_setup(struct spi_dev
 	if (chip->chip_select_num >= MAX_CTRL_CS) {
 		/* Only request on first setup */
 		if (spi_get_ctldata(spi) == NULL) {
-			ret = gpio_request(chip->cs_gpio, spi->modalias);
+			ret = gpio_request_one(chip->cs_gpio,
+					       GPIOF_OUT_INIT_HIGH,
+					       spi->modalias);
 			if (ret) {
 				dev_err(&spi->dev, "gpio_request() error\n");
 				goto pin_error;
 			}
-			gpio_direction_output(chip->cs_gpio, 1);
 		}
 	}
 
diff -u -p a/drivers/spi/spi_oc_tiny.c b/drivers/spi/spi_oc_tiny.c
--- a/drivers/spi/spi_oc_tiny.c 2011-02-26 13:17:47.000000000 +0100
+++ b/drivers/spi/spi_oc_tiny.c 2011-03-21 08:55:22.000000000 +0100
@@ -346,10 +346,10 @@ static int __devinit tiny_spi_probe(stru
 			goto exit;
 	}
 	for (i = 0; i < hw->gpio_cs_count; i++) {
-		err = gpio_request(hw->gpio_cs[i], dev_name(&pdev->dev));
+		err = gpio_request_one(hw->gpio_cs[i], GPIOF_OUT_INIT_HIGH,
+				       dev_name(&pdev->dev));
 		if (err)
 			goto exit_gpio;
-		gpio_direction_output(hw->gpio_cs[i], 1);
 	}
 	hw->bitbang.master->num_chipselect = max(1U, hw->gpio_cs_count);
 
diff -u -p a/drivers/spi/spi_s3c24xx.c b/drivers/spi/spi_s3c24xx.c
--- a/drivers/spi/spi_s3c24xx.c 2010-03-29 19:27:58.000000000 +0200
+++ b/drivers/spi/spi_s3c24xx.c 2011-03-21 08:55:23.000000000 +0100
@@ -614,14 +614,14 @@ static int __init s3c24xx_spi_probe(stru
 			goto err_register;
 		}
 
-		err = gpio_request(pdata->pin_cs, dev_name(&pdev->dev));
+		err = gpio_request_one(pdata->pin_cs, GPIOF_OUT_INIT_HIGH,
+				       dev_name(&pdev->dev));
 		if (err) {
 			dev_err(&pdev->dev, "Failed to get gpio for cs\n");
 			goto err_register;
 		}
 
 		hw->set_cs = s3c24xx_spi_gpiocs;
-		gpio_direction_output(pdata->pin_cs, 1);
 	} else
 		hw->set_cs = pdata->set_cs;
 
diff -u -p a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
--- a/drivers/staging/iio/adc/ad7816.c 2010-11-13 10:26:39.000000000 +0100
+++ b/drivers/staging/iio/adc/ad7816.c 2011-03-21 08:55:24.000000000 +0100
@@ -396,27 +396,24 @@ static int __devinit ad7816_probe(struct
 	chip->convert_pin = pins[1];
 	chip->busy_pin = pins[2];
 
-	ret = gpio_request(chip->rdwr_pin, chip->name);
+	ret = gpio_request_one(chip->rdwr_pin, GPIOF_IN, chip->name);
 	if (ret) {
 		dev_err(&spi_dev->dev, "Fail to request rdwr gpio PIN %d.\n",
 			chip->rdwr_pin);
 		goto error_free_chip;
 	}
-	gpio_direction_input(chip->rdwr_pin);
-	ret = gpio_request(chip->convert_pin, chip->name);
+	ret = gpio_request_one(chip->convert_pin, GPIOF_IN, chip->name);
 	if (ret) {
 		dev_err(&spi_dev->dev, "Fail to request convert gpio PIN %d.\n",
 			chip->convert_pin);
 		goto error_free_gpio_rdwr;
 	}
-	gpio_direction_input(chip->convert_pin);
-	ret = gpio_request(chip->busy_pin, chip->name);
+	ret = gpio_request_one(chip->busy_pin, GPIOF_IN, chip->name);
 	if (ret) {
 		dev_err(&spi_dev->dev, "Fail to request busy gpio PIN %d.\n",
 			chip->busy_pin);
 		goto error_free_gpio_convert;
 	}
-	gpio_direction_input(chip->busy_pin);
 
 	chip->indio_dev = iio_allocate_device();
 	if (chip->indio_dev == NULL) {
diff -u -p a/drivers/staging/iio/resolver/ad2s120x.c b/drivers/staging/iio/resolver/ad2s120x.c
--- a/drivers/staging/iio/resolver/ad2s120x.c 2010-11-13 10:26:39.000000000 +0100
+++ b/drivers/staging/iio/resolver/ad2s120x.c 2011-03-21 08:55:24.000000000 +0100
@@ -220,12 +220,11 @@ static int __devinit ad2s120x_probe(stru
 	unsigned short *pins = spi->dev.platform_data;
 
 	for (pn = 0; pn < AD2S120X_PN; pn++) {
-		if (gpio_request(pins[pn], DRV_NAME)) {
+		if (gpio_request_one(pins[pn], GPIOF_OUT_INIT_HIGH, DRV_NAME)) {
 			pr_err("%s: request gpio pin %d failed\n",
 						DRV_NAME, pins[pn]);
 			goto error_ret;
 		}
-		gpio_direction_output(pins[pn], 1);
 	}
 
 	st = kzalloc(sizeof(*st), GFP_KERNEL);
diff -u -p a/drivers/usb/gadget/at91_udc.c b/drivers/usb/gadget/at91_udc.c
--- a/drivers/usb/gadget/at91_udc.c 2011-02-19 08:28:52.000000000 +0100
+++ b/drivers/usb/gadget/at91_udc.c 2011-03-21 08:55:26.000000000 +0100
@@ -1820,12 +1820,12 @@ static int __init at91udc_probe(struct p
 		goto fail1;
 	}
 	if (udc->board.vbus_pin > 0) {
-		retval = gpio_request(udc->board.vbus_pin, "udc_vbus");
+		retval = gpio_request_one(udc->board.vbus_pin, GPIOF_IN,
+					  "udc_vbus");
 		if (retval < 0) {
 			DBG("request vbus pin failed\n");
 			goto fail2;
 		}
-		gpio_direction_input(udc->board.vbus_pin);
 
 		/*
 		 * Get the initial state of VBUS - we cannot expect
diff -u -p a/drivers/usb/gadget/pxa25x_udc.c b/drivers/usb/gadget/pxa25x_udc.c
--- a/drivers/usb/gadget/pxa25x_udc.c 2010-09-04 09:22:05.000000000 +0200
+++ b/drivers/usb/gadget/pxa25x_udc.c 2011-03-21 08:55:26.000000000 +0100
@@ -2200,27 +2200,27 @@ static int __init pxa25x_udc_probe(struc
 	dev->transceiver = otg_get_transceiver();
 
 	if (gpio_is_valid(dev->mach->gpio_vbus)) {
-		if ((retval = gpio_request(dev->mach->gpio_vbus,
-				"pxa25x_udc GPIO VBUS"))) {
+		if ((retval = gpio_request_one(dev->mach->gpio_vbus,
+					       GPIOF_IN,
+					       "pxa25x_udc GPIO VBUS"))) {
 			dev_dbg(&pdev->dev,
 				"can't get vbus gpio %d, err: %d\n",
 				dev->mach->gpio_vbus, retval);
 			goto err_gpio_vbus;
 		}
-		gpio_direction_input(dev->mach->gpio_vbus);
 		vbus_irq = gpio_to_irq(dev->mach->gpio_vbus);
 	} else
 		vbus_irq = 0;
 
 	if (gpio_is_valid(dev->mach->gpio_pullup)) {
-		if ((retval = gpio_request(dev->mach->gpio_pullup,
-				"pca25x_udc GPIO PULLUP"))) {
+		if ((retval = gpio_request_one(dev->mach->gpio_pullup,
+					       GPIOF_OUT_INIT_LOW,
+					       "pca25x_udc GPIO PULLUP"))) {
 			dev_dbg(&pdev->dev,
 				"can't get pullup gpio %d, err: %d\n",
 				dev->mach->gpio_pullup, retval);
 			goto err_gpio_pullup;
 		}
-		gpio_direction_output(dev->mach->gpio_pullup, 0);
 	}
 
 	init_timer(&dev->timer);
diff -u -p a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
--- a/drivers/usb/host/ohci-at91.c 2010-05-08 13:16:00.000000000 +0200
+++ b/drivers/usb/host/ohci-at91.c 2011-03-21 08:55:25.000000000 +0100
@@ -283,8 +283,8 @@ static int ohci_hcd_at91_drv_probe(struc
 		for (i = 0; i < ARRAY_SIZE(pdata->vbus_pin); i++) {
 			if (pdata->vbus_pin[i] <= 0)
 				continue;
-			gpio_request(pdata->vbus_pin[i], "ohci_vbus");
-			gpio_direction_output(pdata->vbus_pin[i], 0);
+			gpio_request_one(pdata->vbus_pin[i],
+					 GPIOF_OUT_INIT_LOW, "ohci_vbus");
 		}
 	}
 
diff -u -p a/drivers/usb/host/ohci-omap.c b/drivers/usb/host/ohci-omap.c
--- a/drivers/usb/host/ohci-omap.c 2009-10-28 12:03:41.000000000 +0100
+++ b/drivers/usb/host/ohci-omap.c 2011-03-21 08:55:25.000000000 +0100
@@ -254,8 +254,7 @@ static int ohci_omap_init(struct usb_hcd
 
 			/* gpio9 for overcurrent detction */
 			omap_cfg_reg(W8_1610_GPIO9);
-			gpio_request(9, "OHCI overcurrent");
-			gpio_direction_input(9);
+			gpio_request_one(9, GPIOF_IN, "OHCI overcurrent");
 
 			/* for paranoia's sake:  disable USB.PUEN */
 			omap_cfg_reg(W4_USB_HIGHZ);
diff -u -p a/drivers/usb/musb/blackfin.c b/drivers/usb/musb/blackfin.c
--- a/drivers/usb/musb/blackfin.c 2011-02-11 10:53:32.000000000 +0100
+++ b/drivers/usb/musb/blackfin.c 2011-03-21 08:55:25.000000000 +0100
@@ -380,12 +380,12 @@ static int bfin_musb_init(struct musb *m
 	 * here because we are in host mode
 	 */
 
-	if (gpio_request(musb->config->gpio_vrsel, "USB_VRSEL")) {
+	if (gpio_request_one(musb->config->gpio_vrsel, GPIOF_OUT_INIT_LOW,
+			     "USB_VRSEL")) {
 		printk(KERN_ERR "Failed ro request USB_VRSEL GPIO_%d\n",
 			musb->config->gpio_vrsel);
 		return -ENODEV;
 	}
-	gpio_direction_output(musb->config->gpio_vrsel, 0);
 
 	usb_nop_xceiv_register();
 	musb->xceiv = otg_get_transceiver();
diff -u -p a/drivers/usb/otg/gpio_vbus.c b/drivers/usb/otg/gpio_vbus.c
--- a/drivers/usb/otg/gpio_vbus.c 2010-03-29 19:27:58.000000000 +0200
+++ b/drivers/usb/otg/gpio_vbus.c 2011-03-21 08:55:25.000000000 +0100
@@ -240,13 +240,12 @@ static int __init gpio_vbus_probe(struct
 	gpio_vbus->otg.set_power = gpio_vbus_set_power;
 	gpio_vbus->otg.set_suspend = gpio_vbus_set_suspend;
 
-	err = gpio_request(gpio, "vbus_detect");
+	err = gpio_request_one(gpio, GPIOF_IN, "vbus_detect");
 	if (err) {
 		dev_err(&pdev->dev, "can't request vbus gpio %d, err: %d\n",
 			gpio, err);
 		goto err_gpio;
 	}
-	gpio_direction_input(gpio);
 
 	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
 	if (res) {
diff -u -p a/drivers/video/bf537-lq035.c b/drivers/video/bf537-lq035.c
--- a/drivers/video/bf537-lq035.c 2011-02-02 17:27:39.000000000 +0100
+++ b/drivers/video/bf537-lq035.c 2011-03-21 08:55:27.000000000 +0100
@@ -399,7 +399,7 @@ static int __devinit request_ports(void)
 
 #endif
 
-	if (gpio_request(MOD, KBUILD_MODNAME)) {
+	if (gpio_request_one(MOD, GPIOF_OUT_INIT_HIGH, KBUILD_MODNAME)) {
 		pr_err("requesting GPIO %d failed\n", MOD);
 #if (defined(UD) && defined(LBR))
 		gpio_free(LBR);
@@ -408,8 +408,6 @@ static int __devinit request_ports(void)
 		return -EBUSY;
 	}
 
-	gpio_direction_output(MOD, 1);
-
 	SSYNC();
 	return 0;
 }
diff -u -p a/drivers/video/bf54x-lq043fb.c b/drivers/video/bf54x-lq043fb.c
--- a/drivers/video/bf54x-lq043fb.c 2010-08-10 09:17:44.000000000 +0200
+++ b/drivers/video/bf54x-lq043fb.c 2011-03-21 08:55:21.000000000 +0100
@@ -240,7 +240,7 @@ static int request_ports(struct bfin_bf5
 	u16 eppi_req_18[] = EPPI0_18;
 	u16 disp = fbi->mach_info->disp;
 
-	if (gpio_request(disp, DRIVER_NAME)) {
+	if (gpio_request_one(disp, GPIOF_OUT_INIT_HIGH, DRIVER_NAME)) {
 		printk(KERN_ERR "Requesting GPIO %d failed\n", disp);
 		return -EFAULT;
 	}
@@ -263,8 +263,6 @@ static int request_ports(struct bfin_bf5
 		}
 	}
 
-	gpio_direction_output(disp, 1);
-
 	return 0;
 }
 
diff -u -p a/drivers/video/bfin-lq035q1-fb.c b/drivers/video/bfin-lq035q1-fb.c
--- a/drivers/video/bfin-lq035q1-fb.c 2010-05-27 15:47:04.000000000 +0200
+++ b/drivers/video/bfin-lq035q1-fb.c 2011-03-21 08:55:26.000000000 +0100
@@ -363,10 +363,10 @@ static int __devinit bfin_lq035q1_reques
 	 * Drive PPI_FS3 Low
 	 */
 	if (ANOMALY_05000400) {
-		int ret = gpio_request(P_IDENT(P_PPI0_FS3), "PPI_FS3");
+		int ret = gpio_request_one(P_IDENT(P_PPI0_FS3),
+					   GPIOF_OUT_INIT_LOW, "PPI_FS3");
 		if (ret)
 			return ret;
-		gpio_direction_output(P_IDENT(P_PPI0_FS3), 0);
 	}
 
 	if (ppi16)
@@ -714,14 +714,14 @@ static int __devinit bfin_lq035q1_probe(
 	}
 
 	if (info->disp_info->use_bl) {
-		ret = gpio_request(info->disp_info->gpio_bl, "LQ035 Backlight");
+		ret = gpio_request_one(info->disp_info->gpio_bl,
+				       GPIOF_OUT_INIT_LOW, "LQ035 Backlight");
 
 		if (ret) {
 			dev_err(&pdev->dev, "failed to request GPIO %d\n",
 				info->disp_info->gpio_bl);
 			goto out9;
 		}
-		gpio_direction_output(info->disp_info->gpio_bl, 0);
 	}
 
 	ret = register_framebuffer(fbinfo);
diff -u -p a/drivers/video/bfin_adv7393fb.c b/drivers/video/bfin_adv7393fb.c
--- a/drivers/video/bfin_adv7393fb.c 2010-12-04 18:54:36.000000000 +0100
+++ b/drivers/video/bfin_adv7393fb.c 2011-03-21 08:55:26.000000000 +0100
@@ -411,12 +411,12 @@ static int __devinit bfin_adv7393_fb_pro
 
 	/* Workaround "PPI Does Not Start Properly In Specific Mode" */
 	if (ANOMALY_05000400) {
-		if (gpio_request(P_IDENT(P_PPI0_FS3), "PPI0_FS3")) {
+		if (gpio_request_one(P_IDENT(P_PPI0_FS3), GPIOF_OUT_INIT_LOW,
+				     "PPI0_FS3")) {
 			dev_err(&client->dev, "PPI0_FS3 GPIO request failed\n");
 			ret = -EBUSY;
 			goto out_8;
 		}
-		gpio_direction_output(P_IDENT(P_PPI0_FS3), 0);
 	}
 
 	if (peripheral_request_list(ppi_pins, DRIVER_NAME)) {
diff -u -p a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
--- a/drivers/video/omap2/displays/panel-taal.c 2011-03-14 17:19:17.000000000 +0100
+++ b/drivers/video/omap2/displays/panel-taal.c 2011-03-21 08:55:26.000000000 +0100
@@ -753,14 +753,12 @@ static int taal_probe(struct omap_dss_de
 	if (panel_data->use_ext_te) {
 		int gpio = panel_data->ext_te_gpio;
 
-		r = gpio_request(gpio, "taal irq");
+		r = gpio_request_one(gpio, GPIOF_IN, "taal irq");
 		if (r) {
 			dev_err(&dssdev->dev, "GPIO request failed\n");
 			goto err_gpio;
 		}
 
-		gpio_direction_input(gpio);
-
 		r = request_irq(gpio_to_irq(gpio), taal_te_isr,
 				IRQF_DISABLED | IRQF_TRIGGER_RISING,
 				"taal vsync", dssdev);
diff -u -p a/sound/pci/cs5535audio/cs5535audio_olpc.c b/sound/pci/cs5535audio/cs5535audio_olpc.c
--- a/sound/pci/cs5535audio/cs5535audio_olpc.c 2009-12-17 08:30:15.000000000 +0100
+++ b/sound/pci/cs5535audio/cs5535audio_olpc.c 2011-03-21 08:55:25.000000000 +0100
@@ -152,11 +152,10 @@ int __devinit olpc_quirks(struct snd_car
 	if (!machine_is_olpc())
 		return 0;
 
-	if (gpio_request(OLPC_GPIO_MIC_AC, DRV_NAME)) {
+	if (gpio_request_one(OLPC_GPIO_MIC_AC, GPIOF_OUT_INIT_LOW, DRV_NAME)) {
 		printk(KERN_ERR DRV_NAME ": unable to allocate MIC GPIO\n");
 		return -EIO;
 	}
-	gpio_direction_output(OLPC_GPIO_MIC_AC, 0);
 
 	/* drop the original AD1888 HPF control */
 	memset(&elem, 0, sizeof(elem));
diff -u -p a/sound/soc/blackfin/bf5xx-ac97.c b/sound/soc/blackfin/bf5xx-ac97.c
--- a/sound/soc/blackfin/bf5xx-ac97.c 2011-01-19 18:51:20.000000000 +0100
+++ b/sound/soc/blackfin/bf5xx-ac97.c 2011-03-21 08:55:24.000000000 +0100
@@ -215,8 +215,7 @@ static void bf5xx_ac97_warm_reset(struct
 	pr_debug("%s enter\n", __func__);
 
 	peripheral_free(per);
-	gpio_request(gpio, "bf5xx-ac97");
-	gpio_direction_output(gpio, 1);
+	gpio_request_one(gpio, GPIOF_OUT_INIT_HIGH, "bf5xx-ac97");
 	udelay(2);
 	gpio_set_value(gpio, 0);
 	udelay(1);
@@ -321,13 +320,13 @@ static int bf5xx_ac97_probe(struct snd_s
 
 #ifdef CONFIG_SND_BF5XX_HAVE_COLD_RESET
 	/* Request PB3 as reset pin */
-	if (gpio_request(CONFIG_SND_BF5XX_RESET_GPIO_NUM, "SND_AD198x RESET")) {
+	if (gpio_request_one(CONFIG_SND_BF5XX_RESET_GPIO_NUM,
+			     GPIOF_OUT_INIT_HIGH, "SND_AD198x RESET")) {
 		pr_err("Failed to request GPIO_%d for reset\n",
 				CONFIG_SND_BF5XX_RESET_GPIO_NUM);
 		ret =  -1;
 		goto gpio_err;
 	}
-	gpio_direction_output(CONFIG_SND_BF5XX_RESET_GPIO_NUM, 1);
 #endif
 	sport_handle = sport_init(&sport_params[sport_num], 2, \
 			sizeof(struct ac97_frame), NULL);
diff -u -p a/sound/soc/blackfin/bf5xx-ad73311.c b/sound/soc/blackfin/bf5xx-ad73311.c
--- a/sound/soc/blackfin/bf5xx-ad73311.c 2010-11-24 07:55:12.000000000 +0100
+++ b/sound/soc/blackfin/bf5xx-ad73311.c 2011-03-21 08:55:25.000000000 +0100
@@ -131,13 +131,11 @@ static int snd_ad73311_configure(void)
 static int bf5xx_probe(struct platform_device *pdev)
 {
 	int err;
-	if (gpio_request(GPIO_SE, "AD73311_SE")) {
+	if (gpio_request_one(GPIO_SE, GPIOF_OUT_INIT_LOW, "AD73311_SE")) {
 		printk(KERN_ERR "%s: Failed ro request GPIO_%d\n", __func__, GPIO_SE);
 		return -EBUSY;
 	}
 
-	gpio_direction_output(GPIO_SE, 0);
-
 	err = snd_ad73311_configure();
 	if (err < 0)
 		return -EFAULT;
diff -u -p a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
--- a/sound/soc/codecs/tlv320aic3x.c 2010-12-26 10:19:08.000000000 +0100
+++ b/sound/soc/codecs/tlv320aic3x.c 2011-03-21 08:55:24.000000000 +0100
@@ -1379,10 +1379,10 @@ static int aic3x_probe(struct snd_soc_co
 
 	if (gpio_is_valid(aic3x->gpio_reset) &&
 	    !aic3x_is_shared_reset(aic3x)) {
-		ret = gpio_request(aic3x->gpio_reset, "tlv320aic3x reset");
+		ret = gpio_request_one(aic3x->gpio_reset, GPIOF_OUT_INIT_LOW,
+				       "tlv320aic3x reset");
 		if (ret != 0)
 			goto err_gpio;
-		gpio_direction_output(aic3x->gpio_reset, 0);
 	}
 
 	for (i = 0; i < ARRAY_SIZE(aic3x->supplies); i++)
diff -u -p a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
--- a/sound/soc/codecs/tlv320dac33.c 2011-03-14 17:19:19.000000000 +0100
+++ b/sound/soc/codecs/tlv320dac33.c 2011-03-21 08:55:22.000000000 +0100
@@ -1553,14 +1553,14 @@ static int __devinit dac33_i2c_probe(str
 
 	/* Check if the reset GPIO number is valid and request it */
 	if (dac33->power_gpio >= 0) {
-		ret = gpio_request(dac33->power_gpio, "tlv320dac33 reset");
+		ret = gpio_request_one(dac33->power_gpio, GPIOF_OUT_INIT_LOW,
+				       "tlv320dac33 reset");
 		if (ret < 0) {
 			dev_err(&client->dev,
 				"Failed to request reset GPIO (%d)\n",
 				dac33->power_gpio);
 			goto err_gpio;
 		}
-		gpio_direction_output(dac33->power_gpio, 0);
 	}
 
 	for (i = 0; i < ARRAY_SIZE(dac33->supplies); i++)
diff -u -p a/sound/soc/codecs/tpa6130a2.c b/sound/soc/codecs/tpa6130a2.c
--- a/sound/soc/codecs/tpa6130a2.c 2011-01-19 18:51:20.000000000 +0100
+++ b/sound/soc/codecs/tpa6130a2.c 2011-03-21 08:55:22.000000000 +0100
@@ -393,13 +393,13 @@ static int __devinit tpa6130a2_probe(str
 						TPA6130A2_MUTE_L;
 
 	if (data->power_gpio >= 0) {
-		ret = gpio_request(data->power_gpio, "tpa6130a2 enable");
+		ret = gpio_request_one(data->power_gpio, GPIOF_OUT_INIT_LOW,
+				       "tpa6130a2 enable");
 		if (ret < 0) {
 			dev_err(dev, "Failed to request power GPIO (%d)\n",
 				data->power_gpio);
 			goto err_gpio;
 		}
-		gpio_direction_output(data->power_gpio, 0);
 	}
 
 	switch (data->id) {
diff -u -p a/sound/soc/omap/n810.c b/sound/soc/omap/n810.c
--- a/sound/soc/omap/n810.c 2011-01-09 09:32:58.000000000 +0100
+++ b/sound/soc/omap/n810.c 2011-03-21 08:55:22.000000000 +0100
@@ -369,10 +369,10 @@ static int __init n810_soc_init(void)
 	clk_set_parent(sys_clkout2_src, func96m_clk);
 	clk_set_rate(sys_clkout2, 12000000);
 
-	BUG_ON((gpio_request(N810_HEADSET_AMP_GPIO, "hs_amp") < 0) ||
+	BUG_ON((gpio_request_one(N810_HEADSET_AMP_GPIO, GPIOF_OUT_INIT_LOW,
+				 "hs_amp") < 0) ||
 	       (gpio_request(N810_SPEAKER_AMP_GPIO, "spk_amp") < 0));
 
-	gpio_direction_output(N810_HEADSET_AMP_GPIO, 0);
 	gpio_direction_output(N810_SPEAKER_AMP_GPIO, 0);
 
 	return 0;
diff -u -p a/sound/soc/omap/zoom2.c b/sound/soc/omap/zoom2.c
--- a/sound/soc/omap/zoom2.c 2010-11-24 07:55:12.000000000 +0100
+++ b/sound/soc/omap/zoom2.c 2011-03-21 08:55:22.000000000 +0100
@@ -260,11 +260,11 @@ static int __init zoom2_soc_init(void)
 	if (ret)
 		goto err1;
 
-	BUG_ON(gpio_request(ZOOM2_HEADSET_MUX_GPIO, "hs_mux") < 0);
-	gpio_direction_output(ZOOM2_HEADSET_MUX_GPIO, 0);
+	BUG_ON(gpio_request_one(ZOOM2_HEADSET_MUX_GPIO, GPIOF_OUT_INIT_LOW,
+				"hs_mux") < 0);
 
-	BUG_ON(gpio_request(ZOOM2_HEADSET_EXTMUTE_GPIO, "ext_mute") < 0);
-	gpio_direction_output(ZOOM2_HEADSET_EXTMUTE_GPIO, 0);
+	BUG_ON(gpio_request_one(ZOOM2_HEADSET_EXTMUTE_GPIO,
+				GPIOF_OUT_INIT_LOW, "ext_mute") < 0);
 
 	return 0;
 
diff -u -p a/sound/soc/samsung/s3c24xx_uda134x.c b/sound/soc/samsung/s3c24xx_uda134x.c
--- a/sound/soc/samsung/s3c24xx_uda134x.c 2011-02-02 17:27:40.000000000 +0100
+++ b/sound/soc/samsung/s3c24xx_uda134x.c 2011-03-21 08:55:24.000000000 +0100
@@ -266,12 +266,11 @@ static struct uda134x_platform_data s3c2
 
 static int s3c24xx_uda134x_setup_pin(int pin, char *fun)
 {
-	if (gpio_request(pin, "s3c24xx_uda134x") < 0) {
+	if (gpio_request_one(pin, GPIOF_OUT_INIT_LOW, "s3c24xx_uda134x") < 0) {
 		printk(KERN_ERR "S3C24XX_UDA134X SoC Audio: "
 		       "l3 %s pin already in use", fun);
 		return -EBUSY;
 	}
-	gpio_direction_output(pin, 0);
 	return 0;
 }
 
diff -u -p a/sound/soc/tegra/harmony.c b/sound/soc/tegra/harmony.c
--- a/sound/soc/tegra/harmony.c 2011-02-19 08:28:53.000000000 +0100
+++ b/sound/soc/tegra/harmony.c 2011-03-21 08:55:22.000000000 +0100
@@ -201,35 +201,30 @@ static int harmony_asoc_init(struct snd_
 	struct harmony_audio_platform_data *pdata = harmony->pdata;
 	int ret;
 
-	ret = gpio_request(pdata->gpio_spkr_en, "spkr_en");
+	ret = gpio_request_one(pdata->gpio_spkr_en, GPIOF_OUT_INIT_LOW,
+			       "spkr_en");
 	if (ret) {
 		dev_err(card->dev, "cannot get spkr_en gpio\n");
 		return ret;
 	}
 	harmony->gpio_requested |= GPIO_SPKR_EN;
 
-	gpio_direction_output(pdata->gpio_spkr_en, 0);
-
-	ret = gpio_request(pdata->gpio_int_mic_en, "int_mic_en");
+	ret = gpio_request_one(pdata->gpio_int_mic_en, GPIOF_OUT_INIT_LOW,
+			       "int_mic_en");
 	if (ret) {
 		dev_err(card->dev, "cannot get int_mic_en gpio\n");
 		return ret;
 	}
 	harmony->gpio_requested |= GPIO_INT_MIC_EN;
 
-	/* Disable int mic; enable signal is active-high */
-	gpio_direction_output(pdata->gpio_int_mic_en, 0);
-
-	ret = gpio_request(pdata->gpio_ext_mic_en, "ext_mic_en");
+	ret = gpio_request_one(pdata->gpio_ext_mic_en, GPIOF_OUT_INIT_LOW,
+			       "ext_mic_en");
 	if (ret) {
 		dev_err(card->dev, "cannot get ext_mic_en gpio\n");
 		return ret;
 	}
 	harmony->gpio_requested |= GPIO_EXT_MIC_EN;
 
-	/* Enable ext mic; enable signal is active-low */
-	gpio_direction_output(pdata->gpio_ext_mic_en, 0);
-
 	ret = snd_soc_add_controls(codec, harmony_controls,
 				   ARRAY_SIZE(harmony_controls));
 	if (ret < 0)
