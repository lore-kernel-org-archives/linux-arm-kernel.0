From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 19 Sep 2011 14:51:27 +0200
Subject: [PATCH 03/11] at91/soc: use gpio_is_valid to check the gpio
In-Reply-To: <1316436695-19194-1-git-send-email-plagnioj@jcrosoft.com>
References: <1316436695-19194-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1316436695-19194-3-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/mach-at91/at91cap9_devices.c    |   20 ++++++++++----------
 arch/arm/mach-at91/at91rm9200_devices.c  |   22 +++++++++++-----------
 arch/arm/mach-at91/at91sam9260_devices.c |   26 +++++++++++++-------------
 arch/arm/mach-at91/at91sam9261_devices.c |   14 +++++++-------
 arch/arm/mach-at91/at91sam9263_devices.c |   26 +++++++++++++-------------
 arch/arm/mach-at91/at91sam9g45_devices.c |   20 ++++++++++----------
 arch/arm/mach-at91/at91sam9rl_devices.c  |   16 ++++++++--------
 7 files changed, 72 insertions(+), 72 deletions(-)

diff --git a/arch/arm/mach-at91/at91cap9_devices.c b/arch/arm/mach-at91/at91cap9_devices.c
index dba0d8d..2838f8b 100644
--- a/arch/arm/mach-at91/at91cap9_devices.c
+++ b/arch/arm/mach-at91/at91cap9_devices.c
@@ -76,7 +76,7 @@ void __init at91_add_device_usbh(struct at91_usbh_data *data)
 
 	/* Enable VBus control for UHP ports */
 	for (i = 0; i < data->ports; i++) {
-		if (data->vbus_pin[i])
+		if (gpio_is_valid(data->vbus_pin[i]))
 			at91_set_gpio_output(data->vbus_pin[i], 0);
 	}
 
@@ -173,7 +173,7 @@ void __init at91_add_device_usba(struct usba_platform_data *data)
 	usba_udc_data.pdata.num_ep = ARRAY_SIZE(usba_udc_ep);
 	memcpy(usba_udc_data.ep, usba_udc_ep, sizeof(usba_udc_ep));
 
-	if (data && data->vbus_pin > 0) {
+	if (data && gpio_is_valid(data->vbus_pin)) {
 		at91_set_gpio_input(data->vbus_pin, 0);
 		at91_set_deglitch(data->vbus_pin, 1);
 		usba_udc_data.pdata.vbus_pin = data->vbus_pin;
@@ -226,7 +226,7 @@ void __init at91_add_device_eth(struct at91_eth_data *data)
 	if (!data)
 		return;
 
-	if (data->phy_irq_pin) {
+	if (gpio_is_valid(data->phy_irq_pin)) {
 		at91_set_gpio_input(data->phy_irq_pin, 0);
 		at91_set_deglitch(data->phy_irq_pin, 1);
 	}
@@ -326,13 +326,13 @@ void __init at91_add_device_mmc(short mmc_id, struct at91_mmc_data *data)
 		return;
 
 	/* input/irq */
-	if (data->det_pin) {
+	if (gpio_is_valid(data->det_pin)) {
 		at91_set_gpio_input(data->det_pin, 1);
 		at91_set_deglitch(data->det_pin, 1);
 	}
-	if (data->wp_pin)
+	if (gpio_is_valid(data->wp_pin))
 		at91_set_gpio_input(data->wp_pin, 1);
-	if (data->vcc_pin)
+	if (gpio_is_valid(data->vcc_pin))
 		at91_set_gpio_output(data->vcc_pin, 0);
 
 	if (mmc_id == 0) {		/* MCI0 */
@@ -419,15 +419,15 @@ void __init at91_add_device_nand(struct atmel_nand_data *data)
 	at91_sys_write(AT91_MATRIX_EBICSA, csa | AT91_MATRIX_EBI_CS3A_SMC_SMARTMEDIA);
 
 	/* enable pin */
-	if (data->enable_pin)
+	if (gpio_is_valid(data->enable_pin))
 		at91_set_gpio_output(data->enable_pin, 1);
 
 	/* ready/busy pin */
-	if (data->rdy_pin)
+	if (gpio_is_valid(data->rdy_pin))
 		at91_set_gpio_input(data->rdy_pin, 1);
 
 	/* card detect pin */
-	if (data->det_pin)
+	if (gpio_is_valid(data->det_pin))
 		at91_set_gpio_input(data->det_pin, 1);
 
 	nand_data = *data;
@@ -801,7 +801,7 @@ void __init at91_add_device_ac97(struct ac97c_platform_data *data)
 	at91_set_A_periph(AT91_PIN_PA9, 0);	/* AC97RX */
 
 	/* reset */
-	if (data->reset_pin)
+	if (gpio_is_valid(data->reset_pin))
 		at91_set_gpio_output(data->reset_pin, 0);
 
 	ac97_data = *data;
diff --git a/arch/arm/mach-at91/at91rm9200_devices.c b/arch/arm/mach-at91/at91rm9200_devices.c
index 7227755..ff90b63 100644
--- a/arch/arm/mach-at91/at91rm9200_devices.c
+++ b/arch/arm/mach-at91/at91rm9200_devices.c
@@ -106,11 +106,11 @@ void __init at91_add_device_udc(struct at91_udc_data *data)
 	if (!data)
 		return;
 
-	if (data->vbus_pin) {
+	if (gpio_is_valid(data->vbus_pin)) {
 		at91_set_gpio_input(data->vbus_pin, 0);
 		at91_set_deglitch(data->vbus_pin, 1);
 	}
-	if (data->pullup_pin)
+	if (gpio_is_valid(data->pullup_pin))
 		at91_set_gpio_output(data->pullup_pin, 0);
 
 	udc_data = *data;
@@ -159,7 +159,7 @@ void __init at91_add_device_eth(struct at91_eth_data *data)
 	if (!data)
 		return;
 
-	if (data->phy_irq_pin) {
+	if (gpio_is_valid(data->phy_irq_pin)) {
 		at91_set_gpio_input(data->phy_irq_pin, 0);
 		at91_set_deglitch(data->phy_irq_pin, 1);
 	}
@@ -252,7 +252,7 @@ void __init at91_add_device_cf(struct at91_cf_data *data)
 	);
 
 	/* input/irq */
-	if (data->irq_pin) {
+	if (gpio_is_valid(data->irq_pin)) {
 		at91_set_gpio_input(data->irq_pin, 1);
 		at91_set_deglitch(data->irq_pin, 1);
 	}
@@ -260,7 +260,7 @@ void __init at91_add_device_cf(struct at91_cf_data *data)
 	at91_set_deglitch(data->det_pin, 1);
 
 	/* outputs, initially off */
-	if (data->vcc_pin)
+	if (gpio_is_valid(data->vcc_pin))
 		at91_set_gpio_output(data->vcc_pin, 0);
 	at91_set_gpio_output(data->rst_pin, 0);
 
@@ -320,13 +320,13 @@ void __init at91_add_device_mmc(short mmc_id, struct at91_mmc_data *data)
 		return;
 
 	/* input/irq */
-	if (data->det_pin) {
+	if (gpio_is_valid(data->det_pin)) {
 		at91_set_gpio_input(data->det_pin, 1);
 		at91_set_deglitch(data->det_pin, 1);
 	}
-	if (data->wp_pin)
+	if (gpio_is_valid(data->wp_pin))
 		at91_set_gpio_input(data->wp_pin, 1);
-	if (data->vcc_pin)
+	if (gpio_is_valid(data->vcc_pin))
 		at91_set_gpio_output(data->vcc_pin, 0);
 
 	/* CLK */
@@ -411,15 +411,15 @@ void __init at91_add_device_nand(struct atmel_nand_data *data)
 	);
 
 	/* enable pin */
-	if (data->enable_pin)
+	if (gpio_is_valid(data->enable_pin))
 		at91_set_gpio_output(data->enable_pin, 1);
 
 	/* ready/busy pin */
-	if (data->rdy_pin)
+	if (gpio_is_valid(data->rdy_pin))
 		at91_set_gpio_input(data->rdy_pin, 1);
 
 	/* card detect pin */
-	if (data->det_pin)
+	if (gpio_is_valid(data->det_pin))
 		at91_set_gpio_input(data->det_pin, 1);
 
 	at91_set_A_periph(AT91_PIN_PC1, 0);		/* SMOE */
diff --git a/arch/arm/mach-at91/at91sam9260_devices.c b/arch/arm/mach-at91/at91sam9260_devices.c
index 39f81f4..b981a5c 100644
--- a/arch/arm/mach-at91/at91sam9260_devices.c
+++ b/arch/arm/mach-at91/at91sam9260_devices.c
@@ -107,7 +107,7 @@ void __init at91_add_device_udc(struct at91_udc_data *data)
 	if (!data)
 		return;
 
-	if (data->vbus_pin) {
+	if (gpio_is_valid(data->vbus_pin)) {
 		at91_set_gpio_input(data->vbus_pin, 0);
 		at91_set_deglitch(data->vbus_pin, 1);
 	}
@@ -160,7 +160,7 @@ void __init at91_add_device_eth(struct at91_eth_data *data)
 	if (!data)
 		return;
 
-	if (data->phy_irq_pin) {
+	if (gpio_is_valid(data->phy_irq_pin)) {
 		at91_set_gpio_input(data->phy_irq_pin, 0);
 		at91_set_deglitch(data->phy_irq_pin, 1);
 	}
@@ -235,13 +235,13 @@ void __init at91_add_device_mmc(short mmc_id, struct at91_mmc_data *data)
 		return;
 
 	/* input/irq */
-	if (data->det_pin) {
+	if (gpio_is_valid(data->det_pin)) {
 		at91_set_gpio_input(data->det_pin, 1);
 		at91_set_deglitch(data->det_pin, 1);
 	}
-	if (data->wp_pin)
+	if (gpio_is_valid(data->wp_pin))
 		at91_set_gpio_input(data->wp_pin, 1);
-	if (data->vcc_pin)
+	if (gpio_is_valid(data->vcc_pin))
 		at91_set_gpio_output(data->vcc_pin, 0);
 
 	/* CLK */
@@ -322,11 +322,11 @@ void __init at91_add_device_mci(short mmc_id, struct mci_platform_data *data)
 	for (i = 0; i < ATMEL_MCI_MAX_NR_SLOTS; i++) {
 		if (data->slot[i].bus_width) {
 			/* input/irq */
-			if (data->slot[i].detect_pin) {
+			if (gpio_is_valid(data->slot[i].detect_pin)) {
 				at91_set_gpio_input(data->slot[i].detect_pin, 1);
 				at91_set_deglitch(data->slot[i].detect_pin, 1);
 			}
-			if (data->slot[i].wp_pin)
+			if (gpio_is_valid(data->slot[i].wp_pin))
 				at91_set_gpio_input(data->slot[i].wp_pin, 1);
 
 			switch (i) {
@@ -418,15 +418,15 @@ void __init at91_add_device_nand(struct atmel_nand_data *data)
 	at91_sys_write(AT91_MATRIX_EBICSA, csa | AT91_MATRIX_CS3A_SMC_SMARTMEDIA);
 
 	/* enable pin */
-	if (data->enable_pin)
+	if (gpio_is_valid(data->enable_pin))
 		at91_set_gpio_output(data->enable_pin, 1);
 
 	/* ready/busy pin */
-	if (data->rdy_pin)
+	if (gpio_is_valid(data->rdy_pin))
 		at91_set_gpio_input(data->rdy_pin, 1);
 
 	/* card detect pin */
-	if (data->det_pin)
+	if (gpio_is_valid(data->det_pin))
 		at91_set_gpio_input(data->det_pin, 1);
 
 	nand_data = *data;
@@ -1274,17 +1274,17 @@ void __init at91_add_device_cf(struct at91_cf_data *data)
 
 	at91_sys_write(AT91_MATRIX_EBICSA, csa);
 
-	if (data->rst_pin) {
+	if (gpio_is_valid(data->rst_pin)) {
 		at91_set_multi_drive(data->rst_pin, 0);
 		at91_set_gpio_output(data->rst_pin, 1);
 	}
 
-	if (data->irq_pin) {
+	if (gpio_is_valid(data->irq_pin)) {
 		at91_set_gpio_input(data->irq_pin, 0);
 		at91_set_deglitch(data->irq_pin, 1);
 	}
 
-	if (data->det_pin) {
+	if (gpio_is_valid(data->det_pin)) {
 		at91_set_gpio_input(data->det_pin, 0);
 		at91_set_deglitch(data->det_pin, 1);
 	}
diff --git a/arch/arm/mach-at91/at91sam9261_devices.c b/arch/arm/mach-at91/at91sam9261_devices.c
index 0f91792..0dd3960 100644
--- a/arch/arm/mach-at91/at91sam9261_devices.c
+++ b/arch/arm/mach-at91/at91sam9261_devices.c
@@ -110,7 +110,7 @@ void __init at91_add_device_udc(struct at91_udc_data *data)
 	if (!data)
 		return;
 
-	if (data->vbus_pin) {
+	if (gpio_is_valid(data->vbus_pin)) {
 		at91_set_gpio_input(data->vbus_pin, 0);
 		at91_set_deglitch(data->vbus_pin, 1);
 	}
@@ -163,13 +163,13 @@ void __init at91_add_device_mmc(short mmc_id, struct at91_mmc_data *data)
 		return;
 
 	/* input/irq */
-	if (data->det_pin) {
+	if (gpio_is_valid(data->det_pin)) {
 		at91_set_gpio_input(data->det_pin, 1);
 		at91_set_deglitch(data->det_pin, 1);
 	}
-	if (data->wp_pin)
+	if (gpio_is_valid(data->wp_pin))
 		at91_set_gpio_input(data->wp_pin, 1);
-	if (data->vcc_pin)
+	if (gpio_is_valid(data->vcc_pin))
 		at91_set_gpio_output(data->vcc_pin, 0);
 
 	/* CLK */
@@ -232,15 +232,15 @@ void __init at91_add_device_nand(struct atmel_nand_data *data)
 	at91_sys_write(AT91_MATRIX_EBICSA, csa | AT91_MATRIX_CS3A_SMC_SMARTMEDIA);
 
 	/* enable pin */
-	if (data->enable_pin)
+	if (gpio_is_valid(data->enable_pin))
 		at91_set_gpio_output(data->enable_pin, 1);
 
 	/* ready/busy pin */
-	if (data->rdy_pin)
+	if (gpio_is_valid(data->rdy_pin))
 		at91_set_gpio_input(data->rdy_pin, 1);
 
 	/* card detect pin */
-	if (data->det_pin)
+	if (gpio_is_valid(data->det_pin))
 		at91_set_gpio_input(data->det_pin, 1);
 
 	at91_set_A_periph(AT91_PIN_PC0, 0);		/* NANDOE */
diff --git a/arch/arm/mach-at91/at91sam9263_devices.c b/arch/arm/mach-at91/at91sam9263_devices.c
index a050f41..077d853 100644
--- a/arch/arm/mach-at91/at91sam9263_devices.c
+++ b/arch/arm/mach-at91/at91sam9263_devices.c
@@ -70,7 +70,7 @@ void __init at91_add_device_usbh(struct at91_usbh_data *data)
 
 	/* Enable VBus control for UHP ports */
 	for (i = 0; i < data->ports; i++) {
-		if (data->vbus_pin[i])
+		if (gpio_is_valid(data->vbus_pin[i]))
 			at91_set_gpio_output(data->vbus_pin[i], 0);
 	}
 
@@ -117,7 +117,7 @@ void __init at91_add_device_udc(struct at91_udc_data *data)
 	if (!data)
 		return;
 
-	if (data->vbus_pin) {
+	if (gpio_is_valid(data->vbus_pin)) {
 		at91_set_gpio_input(data->vbus_pin, 0);
 		at91_set_deglitch(data->vbus_pin, 1);
 	}
@@ -170,7 +170,7 @@ void __init at91_add_device_eth(struct at91_eth_data *data)
 	if (!data)
 		return;
 
-	if (data->phy_irq_pin) {
+	if (gpio_is_valid(data->phy_irq_pin)) {
 		at91_set_gpio_input(data->phy_irq_pin, 0);
 		at91_set_deglitch(data->phy_irq_pin, 1);
 	}
@@ -270,13 +270,13 @@ void __init at91_add_device_mmc(short mmc_id, struct at91_mmc_data *data)
 		return;
 
 	/* input/irq */
-	if (data->det_pin) {
+	if (gpio_is_valid(data->det_pin)) {
 		at91_set_gpio_input(data->det_pin, 1);
 		at91_set_deglitch(data->det_pin, 1);
 	}
-	if (data->wp_pin)
+	if (gpio_is_valid(data->wp_pin))
 		at91_set_gpio_input(data->wp_pin, 1);
-	if (data->vcc_pin)
+	if (gpio_is_valid(data->vcc_pin))
 		at91_set_gpio_output(data->vcc_pin, 0);
 
 	if (mmc_id == 0) {		/* MCI0 */
@@ -424,17 +424,17 @@ void __init at91_add_device_cf(struct at91_cf_data *data)
 	}
 	at91_sys_write(AT91_MATRIX_EBI0CSA, ebi0_csa);
 
-	if (data->det_pin) {
+	if (gpio_is_valid(data->det_pin)) {
 		at91_set_gpio_input(data->det_pin, 1);
 		at91_set_deglitch(data->det_pin, 1);
 	}
 
-	if (data->irq_pin) {
+	if (gpio_is_valid(data->irq_pin)) {
 		at91_set_gpio_input(data->irq_pin, 1);
 		at91_set_deglitch(data->irq_pin, 1);
 	}
 
-	if (data->vcc_pin)
+	if (gpio_is_valid(data->vcc_pin))
 		/* initially off */
 		at91_set_gpio_output(data->vcc_pin, 0);
 
@@ -494,15 +494,15 @@ void __init at91_add_device_nand(struct atmel_nand_data *data)
 	at91_sys_write(AT91_MATRIX_EBI0CSA, csa | AT91_MATRIX_EBI0_CS3A_SMC_SMARTMEDIA);
 
 	/* enable pin */
-	if (data->enable_pin)
+	if (gpio_is_valid(data->enable_pin))
 		at91_set_gpio_output(data->enable_pin, 1);
 
 	/* ready/busy pin */
-	if (data->rdy_pin)
+	if (gpio_is_valid(data->rdy_pin))
 		at91_set_gpio_input(data->rdy_pin, 1);
 
 	/* card detect pin */
-	if (data->det_pin)
+	if (gpio_is_valid(data->det_pin))
 		at91_set_gpio_input(data->det_pin, 1);
 
 	nand_data = *data;
@@ -743,7 +743,7 @@ void __init at91_add_device_ac97(struct ac97c_platform_data *data)
 	at91_set_A_periph(AT91_PIN_PB3, 0);	/* AC97RX */
 
 	/* reset */
-	if (data->reset_pin)
+	if (gpio_is_valid(data->reset_pin))
 		at91_set_gpio_output(data->reset_pin, 0);
 
 	ac97_data = *data;
diff --git a/arch/arm/mach-at91/at91sam9g45_devices.c b/arch/arm/mach-at91/at91sam9g45_devices.c
index 600bffb..3a0daa3 100644
--- a/arch/arm/mach-at91/at91sam9g45_devices.c
+++ b/arch/arm/mach-at91/at91sam9g45_devices.c
@@ -120,7 +120,7 @@ void __init at91_add_device_usbh_ohci(struct at91_usbh_data *data)
 
 	/* Enable VBus control for UHP ports */
 	for (i = 0; i < data->ports; i++) {
-		if (data->vbus_pin[i])
+		if (gpio_is_valid(data->vbus_pin[i]))
 			at91_set_gpio_output(data->vbus_pin[i], 0);
 	}
 
@@ -175,7 +175,7 @@ void __init at91_add_device_usbh_ehci(struct at91_usbh_data *data)
 
 	/* Enable VBus control for UHP ports */
 	for (i = 0; i < data->ports; i++) {
-		if (data->vbus_pin[i])
+		if (gpio_is_valid(data->vbus_pin[i]))
 			at91_set_gpio_output(data->vbus_pin[i], 0);
 	}
 
@@ -257,7 +257,7 @@ void __init at91_add_device_usba(struct usba_platform_data *data)
 	usba_udc_data.pdata.num_ep = ARRAY_SIZE(usba_udc_ep);
 	memcpy(usba_udc_data.ep, usba_udc_ep, sizeof(usba_udc_ep));
 
-	if (data && data->vbus_pin > 0) {
+	if (data && gpio_is_valid(data->vbus_pin)) {
 		at91_set_gpio_input(data->vbus_pin, 0);
 		at91_set_deglitch(data->vbus_pin, 1);
 		usba_udc_data.pdata.vbus_pin = data->vbus_pin;
@@ -310,7 +310,7 @@ void __init at91_add_device_eth(struct at91_eth_data *data)
 	if (!data)
 		return;
 
-	if (data->phy_irq_pin) {
+	if (gpio_is_valid(data->phy_irq_pin)) {
 		at91_set_gpio_input(data->phy_irq_pin, 0);
 		at91_set_deglitch(data->phy_irq_pin, 1);
 	}
@@ -443,11 +443,11 @@ void __init at91_add_device_mci(short mmc_id, struct mci_platform_data *data)
 
 
 	/* input/irq */
-	if (data->slot[0].detect_pin) {
+	if (gpio_is_valid(data->slot[0].detect_pin)) {
 		at91_set_gpio_input(data->slot[0].detect_pin, 1);
 		at91_set_deglitch(data->slot[0].detect_pin, 1);
 	}
-	if (data->slot[0].wp_pin)
+	if (gpio_is_valid(data->slot[0].wp_pin))
 		at91_set_gpio_input(data->slot[0].wp_pin, 1);
 
 	if (mmc_id == 0) {		/* MCI0 */
@@ -550,15 +550,15 @@ void __init at91_add_device_nand(struct atmel_nand_data *data)
 	at91_sys_write(AT91_MATRIX_EBICSA, csa | AT91_MATRIX_EBI_CS3A_SMC_SMARTMEDIA);
 
 	/* enable pin */
-	if (data->enable_pin)
+	if (gpio_is_valid(data->enable_pin))
 		at91_set_gpio_output(data->enable_pin, 1);
 
 	/* ready/busy pin */
-	if (data->rdy_pin)
+	if (gpio_is_valid(data->rdy_pin))
 		at91_set_gpio_input(data->rdy_pin, 1);
 
 	/* card detect pin */
-	if (data->det_pin)
+	if (gpio_is_valid(data->det_pin))
 		at91_set_gpio_input(data->det_pin, 1);
 
 	nand_data = *data;
@@ -853,7 +853,7 @@ void __init at91_add_device_ac97(struct ac97c_platform_data *data)
 	at91_set_A_periph(AT91_PIN_PD6, 0);	/* AC97RX */
 
 	/* reset */
-	if (data->reset_pin)
+	if (gpio_is_valid(data->reset_pin))
 		at91_set_gpio_output(data->reset_pin, 0);
 
 	ac97_data = *data;
diff --git a/arch/arm/mach-at91/at91sam9rl_devices.c b/arch/arm/mach-at91/at91sam9rl_devices.c
index aacb19d..56cb73d 100644
--- a/arch/arm/mach-at91/at91sam9rl_devices.c
+++ b/arch/arm/mach-at91/at91sam9rl_devices.c
@@ -147,7 +147,7 @@ void __init at91_add_device_usba(struct usba_platform_data *data)
 	usba_udc_data.pdata.num_ep = ARRAY_SIZE(usba_udc_ep);
 	memcpy(usba_udc_data.ep, usba_udc_ep, sizeof(usba_udc_ep));
 
-	if (data && data->vbus_pin > 0) {
+	if (data && gpio_is_valid(data->vbus_pin)) {
 		at91_set_gpio_input(data->vbus_pin, 0);
 		at91_set_deglitch(data->vbus_pin, 1);
 		usba_udc_data.pdata.vbus_pin = data->vbus_pin;
@@ -201,13 +201,13 @@ void __init at91_add_device_mmc(short mmc_id, struct at91_mmc_data *data)
 		return;
 
 	/* input/irq */
-	if (data->det_pin) {
+	if (gpio_is_valid(data->det_pin)) {
 		at91_set_gpio_input(data->det_pin, 1);
 		at91_set_deglitch(data->det_pin, 1);
 	}
-	if (data->wp_pin)
+	if (gpio_is_valid(data->wp_pin))
 		at91_set_gpio_input(data->wp_pin, 1);
-	if (data->vcc_pin)
+	if (gpio_is_valid(data->vcc_pin))
 		at91_set_gpio_output(data->vcc_pin, 0);
 
 	/* CLK */
@@ -275,15 +275,15 @@ void __init at91_add_device_nand(struct atmel_nand_data *data)
 	at91_sys_write(AT91_MATRIX_EBICSA, csa | AT91_MATRIX_CS3A_SMC_SMARTMEDIA);
 
 	/* enable pin */
-	if (data->enable_pin)
+	if (gpio_is_valid(data->enable_pin))
 		at91_set_gpio_output(data->enable_pin, 1);
 
 	/* ready/busy pin */
-	if (data->rdy_pin)
+	if (gpio_is_valid(data->rdy_pin))
 		at91_set_gpio_input(data->rdy_pin, 1);
 
 	/* card detect pin */
-	if (data->det_pin)
+	if (gpio_is_valid(data->det_pin))
 		at91_set_gpio_input(data->det_pin, 1);
 
 	at91_set_A_periph(AT91_PIN_PB4, 0);		/* NANDOE */
@@ -483,7 +483,7 @@ void __init at91_add_device_ac97(struct ac97c_platform_data *data)
 	at91_set_A_periph(AT91_PIN_PD4, 0);	/* AC97RX */
 
 	/* reset */
-	if (data->reset_pin)
+	if (gpio_is_valid(data->reset_pin))
 		at91_set_gpio_output(data->reset_pin, 0);
 
 	ac97_data = *data;
-- 
1.7.5.4
