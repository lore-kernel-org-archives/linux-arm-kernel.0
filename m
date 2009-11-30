From: derkling@gmail.com (Patrick Bellasi)
Date: Mon, 30 Nov 2009 10:48:04 +0100
Subject: [PATCH 1/3] AT91: update at91_eth_data for ETX2-3 on PA10-11
In-Reply-To: <1259574486-13391-1-git-send-email-derkling@gmail.com>
References: <20091129234917.GB18841@game.jcrosoft.org>
	<1259574486-13391-1-git-send-email-derkling@gmail.com>
Message-ID: <1259574486-13391-2-git-send-email-derkling@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch update the at91_eth_data to handle the usage of PA10 and PA11
for EMAC's EXT2 and EXT3 signals.

The default configuration overlaps with TWI signals, using the new
platform data configuration option "use_twi_pins" it is possible to use
a different pin routing.

Signed-off-by: Patrick Bellasi <derkling@gmail.com
---
 arch/arm/mach-at91/at91sam9260_devices.c |    9 +++++++--
 arch/arm/mach-at91/board-afeb-9260v1.c   |    1 +
 arch/arm/mach-at91/board-cam60.c         |    1 +
 arch/arm/mach-at91/board-csb337.c        |    1 +
 arch/arm/mach-at91/board-csb637.c        |    1 +
 arch/arm/mach-at91/board-ecbat91.c       |    1 +
 arch/arm/mach-at91/board-kafa.c          |    1 +
 arch/arm/mach-at91/board-kb9202.c        |    1 +
 arch/arm/mach-at91/board-sam9-l9260.c    |    1 +
 arch/arm/mach-at91/include/mach/board.h  |    1 +
 10 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-at91/at91sam9260_devices.c b/arch/arm/mach-at91/at91sam9260_devices.c
index 07eb7b0..21dc909 100644
--- a/arch/arm/mach-at91/at91sam9260_devices.c
+++ b/arch/arm/mach-at91/at91sam9260_devices.c
@@ -183,8 +183,13 @@ void __init at91_add_device_eth(struct at91_eth_data *data)
 		at91_set_B_periph(AT91_PIN_PA25, 0);	/* ERX2 */
 		at91_set_B_periph(AT91_PIN_PA26, 0);	/* ERX3 */
 		at91_set_B_periph(AT91_PIN_PA27, 0);	/* ERXCK */
-		at91_set_B_periph(AT91_PIN_PA23, 0);	/* ETX2 */
-		at91_set_B_periph(AT91_PIN_PA24, 0);	/* ETX3 */
+		if (!data->use_twi_pins) {
+			at91_set_B_periph(AT91_PIN_PA10, 0);	/* ETX2 */
+			at91_set_B_periph(AT91_PIN_PA11, 0);	/* ETX3 */
+		} else {
+			at91_set_B_periph(AT91_PIN_PA23, 0);	/* ETX2 */
+			at91_set_B_periph(AT91_PIN_PA24, 0);	/* ETX3 */
+		}
 		at91_set_B_periph(AT91_PIN_PA22, 0);	/* ETXER */
 	}
 
diff --git a/arch/arm/mach-at91/board-afeb-9260v1.c b/arch/arm/mach-at91/board-afeb-9260v1.c
index 50667be..49406e0 100644
--- a/arch/arm/mach-at91/board-afeb-9260v1.c
+++ b/arch/arm/mach-at91/board-afeb-9260v1.c
@@ -112,6 +112,7 @@ static struct spi_board_info afeb9260_spi_devices[] = {
 static struct at91_eth_data __initdata afeb9260_macb_data = {
 	.phy_irq_pin	= AT91_PIN_PA9,
 	.is_rmii	= 0,
+	.use_twi_pins	= 1,
 };
 
 
diff --git a/arch/arm/mach-at91/board-cam60.c b/arch/arm/mach-at91/board-cam60.c
index 02138af..86f447d 100644
--- a/arch/arm/mach-at91/board-cam60.c
+++ b/arch/arm/mach-at91/board-cam60.c
@@ -124,6 +124,7 @@ static struct spi_board_info cam60_spi_devices[] = {
 static struct __initdata at91_eth_data cam60_macb_data = {
 	.phy_irq_pin	= AT91_PIN_PB5,
 	.is_rmii	= 0,
+	.use_twi_pins	= 1,
 };
 
 
diff --git a/arch/arm/mach-at91/board-csb337.c b/arch/arm/mach-at91/board-csb337.c
index fea2529..92d97e9 100644
--- a/arch/arm/mach-at91/board-csb337.c
+++ b/arch/arm/mach-at91/board-csb337.c
@@ -66,6 +66,7 @@ static void __init csb337_init_irq(void)
 static struct at91_eth_data __initdata csb337_eth_data = {
 	.phy_irq_pin	= AT91_PIN_PC2,
 	.is_rmii	= 0,
+	.use_twi_pins	= 1,
 };
 
 static struct at91_usbh_data __initdata csb337_usbh_data = {
diff --git a/arch/arm/mach-at91/board-csb637.c b/arch/arm/mach-at91/board-csb637.c
index cfa3f04..7ae1d0e 100644
--- a/arch/arm/mach-at91/board-csb637.c
+++ b/arch/arm/mach-at91/board-csb637.c
@@ -60,6 +60,7 @@ static void __init csb637_init_irq(void)
 static struct at91_eth_data __initdata csb637_eth_data = {
 	.phy_irq_pin	= AT91_PIN_PC0,
 	.is_rmii	= 0,
+	.use_twi_pins	= 1,
 };
 
 static struct at91_usbh_data __initdata csb637_usbh_data = {
diff --git a/arch/arm/mach-at91/board-ecbat91.c b/arch/arm/mach-at91/board-ecbat91.c
index 1d69908..3a68ee6 100644
--- a/arch/arm/mach-at91/board-ecbat91.c
+++ b/arch/arm/mach-at91/board-ecbat91.c
@@ -68,6 +68,7 @@ static void __init ecb_at91init_irq(void)
 static struct at91_eth_data __initdata ecb_at91eth_data = {
 	.phy_irq_pin	= AT91_PIN_PC4,
 	.is_rmii	= 0,
+	.use_twi_pins	= 1,
 };
 
 static struct at91_usbh_data __initdata ecb_at91usbh_data = {
diff --git a/arch/arm/mach-at91/board-kafa.c b/arch/arm/mach-at91/board-kafa.c
index a87956c..b1df3a9 100644
--- a/arch/arm/mach-at91/board-kafa.c
+++ b/arch/arm/mach-at91/board-kafa.c
@@ -70,6 +70,7 @@ static void __init kafa_init_irq(void)
 static struct at91_eth_data __initdata kafa_eth_data = {
 	.phy_irq_pin	= AT91_PIN_PC4,
 	.is_rmii	= 0,
+	.use_twi_pins	= 1,
 };
 
 static struct at91_usbh_data __initdata kafa_usbh_data = {
diff --git a/arch/arm/mach-at91/board-kb9202.c b/arch/arm/mach-at91/board-kb9202.c
index fe9b991..2fa7a76 100644
--- a/arch/arm/mach-at91/board-kb9202.c
+++ b/arch/arm/mach-at91/board-kb9202.c
@@ -74,6 +74,7 @@ static void __init kb9202_init_irq(void)
 static struct at91_eth_data __initdata kb9202_eth_data = {
 	.phy_irq_pin	= AT91_PIN_PB29,
 	.is_rmii	= 0,
+	.use_twi_pins	= 1,
 };
 
 static struct at91_usbh_data __initdata kb9202_usbh_data = {
diff --git a/arch/arm/mach-at91/board-sam9-l9260.c b/arch/arm/mach-at91/board-sam9-l9260.c
index b483469..9b278eb 100644
--- a/arch/arm/mach-at91/board-sam9-l9260.c
+++ b/arch/arm/mach-at91/board-sam9-l9260.c
@@ -118,6 +118,7 @@ static struct spi_board_info ek_spi_devices[] = {
 static struct at91_eth_data __initdata ek_macb_data = {
 	.phy_irq_pin	= AT91_PIN_PA7,
 	.is_rmii	= 0,
+	.use_twi_pins	= 1,
 };
 
 
diff --git a/arch/arm/mach-at91/include/mach/board.h b/arch/arm/mach-at91/include/mach/board.h
index 2f4fced..f452ae5 100644
--- a/arch/arm/mach-at91/include/mach/board.h
+++ b/arch/arm/mach-at91/include/mach/board.h
@@ -83,6 +83,7 @@ struct at91_eth_data {
 	u32		phy_mask;
 	u8		phy_irq_pin;	/* PHY IRQ */
 	u8		is_rmii;	/* using RMII interface? */
+	u8		use_twi_pins;	/* ETX2-ETX3 on PA23-PA24 */
 };
 extern void __init at91_add_device_eth(struct at91_eth_data *data);
 
-- 
1.6.3.3
