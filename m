From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 9 Aug 2012 08:00:17 +0000
Subject: [PATCH v2 06/10] ARM: davinci: don't use broken ntosd2_init_i2c
In-Reply-To: <1344461278-28245-7-git-send-email-arnd@arndb.de>
References: <1344461278-28245-1-git-send-email-arnd@arndb.de>
 <1344461278-28245-7-git-send-email-arnd@arndb.de>
Message-ID: <201208090800.18321.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On second thought, there is probably no use in keeping the broken function
around, and we can just kill it off. If someone wants to add an i2c
device to the bus, they can always add the init code back as well.

8<-----
Subject: ARM: davinci: don't use broken ntosd2_init_i2c

ntosd2_init_i2c walks the ntosd2_i2c_info array, which it expects to
be populated with at least one member. gcc correctly warns about
the out-of-bounds access here.

Since this can not possibly work, it's better to disable i2c
support entirely on this board.

Without this patch, building davinci_all_defconfig results in:

arch/arm/mach-davinci/board-neuros-osd2.c: In function 'davinci_ntosd2_init':
arch/arm/mach-davinci/board-neuros-osd2.c:187:20: warning: array subscript is above array bounds [-Warray-bounds]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Sekhar Nori <nsekhar@ti.com>
Cc: Andrey Porodko <panda@chelcom.ru>

diff --git a/arch/arm/mach-davinci/board-neuros-osd2.c b/arch/arm/mach-davinci/board-neuros-osd2.c
index 5de69f2..f6b9fc7 100644
--- a/arch/arm/mach-davinci/board-neuros-osd2.c
+++ b/arch/arm/mach-davinci/board-neuros-osd2.c
@@ -162,38 +162,6 @@ static void __init davinci_ntosd2_map_io(void)
 	dm644x_init();
 }
 
-/*
- I2C initialization
-*/
-static struct davinci_i2c_platform_data ntosd2_i2c_pdata = {
-	.bus_freq	= 20 /* kHz */,
-	.bus_delay	= 100 /* usec */,
-};
-
-static struct i2c_board_info __initdata ntosd2_i2c_info[] =  {
-};
-
-static	int ntosd2_init_i2c(void)
-{
-	int	status;
-
-	davinci_init_i2c(&ntosd2_i2c_pdata);
-	status = gpio_request(NTOSD2_MSP430_IRQ, ntosd2_i2c_info[0].type);
-	if (status == 0) {
-		status = gpio_direction_input(NTOSD2_MSP430_IRQ);
-		if (status == 0) {
-			status = gpio_to_irq(NTOSD2_MSP430_IRQ);
-			if (status > 0) {
-				ntosd2_i2c_info[0].irq = status;
-				i2c_register_board_info(1,
-					ntosd2_i2c_info,
-					ARRAY_SIZE(ntosd2_i2c_info));
-			}
-		}
-	}
-	return status;
-}
-
 static struct davinci_mmc_config davinci_ntosd2_mmc_config = {
 	.wires		= 4,
 	.version	= MMC_CTLR_VERSION_1
@@ -218,7 +186,6 @@ static __init void davinci_ntosd2_init(void)
 {
 	struct clk *aemif_clk;
 	struct davinci_soc_info *soc_info = &davinci_soc_info;
-	int	status;
 
 	aemif_clk = clk_get(NULL, "aemif");
 	clk_enable(aemif_clk);
@@ -242,12 +209,6 @@ static __init void davinci_ntosd2_init(void)
 	platform_add_devices(davinci_ntosd2_devices,
 				ARRAY_SIZE(davinci_ntosd2_devices));
 
-	/* Initialize I2C interface specific for this board */
-	status = ntosd2_init_i2c();
-	if (status < 0)
-		pr_warning("davinci_ntosd2_init: msp430 irq setup failed:"
-						"	 %d\n", status);
-
 	davinci_serial_init(&uart_config);
 	dm644x_init_asp(&dm644x_ntosd2_snd_data);
 
