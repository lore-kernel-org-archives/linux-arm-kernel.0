From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue,  5 Jul 2011 11:05:28 +0200
Subject: [PATCH 3/3] at91-ohci: configure overcurrent pins as GPIOs
In-Reply-To: <1309856728-8265-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1309856728-8265-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1309856728-8265-3-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As a new overcurrent_pin[] array has been added to the at91_usbh_data
structure, those pins must be muxed to work properly. This commit
implements this muxing for all AT91 SoCs that support the AT91 OHCI.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Andrew Victor <linux@maxim.org.za>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
---
 arch/arm/mach-at91/at91cap9_devices.c    |    5 +++++
 arch/arm/mach-at91/at91rm9200_devices.c  |    5 +++++
 arch/arm/mach-at91/at91sam9260_devices.c |    5 +++++
 arch/arm/mach-at91/at91sam9261_devices.c |    5 +++++
 arch/arm/mach-at91/at91sam9263_devices.c |    5 +++++
 arch/arm/mach-at91/at91sam9g45_devices.c |    5 +++++
 6 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-at91/at91cap9_devices.c b/arch/arm/mach-at91/at91cap9_devices.c
index dba0d8d..db7173a 100644
--- a/arch/arm/mach-at91/at91cap9_devices.c
+++ b/arch/arm/mach-at91/at91cap9_devices.c
@@ -80,6 +80,11 @@ void __init at91_add_device_usbh(struct at91_usbh_data *data)
 			at91_set_gpio_output(data->vbus_pin[i], 0);
 	}
 
+	for (i = 0; i < data->ports; i++) {
+		if (data->overcurrent_pin[i])
+			at91_set_GPIO_periph(data->overcurrent_pin[i], 1);
+	}
+
 	usbh_data = *data;
 	platform_device_register(&at91_usbh_device);
 }
diff --git a/arch/arm/mach-at91/at91rm9200_devices.c b/arch/arm/mach-at91/at91rm9200_devices.c
index 7227755..6a1d564 100644
--- a/arch/arm/mach-at91/at91rm9200_devices.c
+++ b/arch/arm/mach-at91/at91rm9200_devices.c
@@ -63,6 +63,11 @@ void __init at91_add_device_usbh(struct at91_usbh_data *data)
 	if (!data)
 		return;
 
+	for (i = 0; i < data->ports; i++) {
+		if (data->overcurrent_pin[i])
+			at91_set_GPIO_periph(data->overcurrent_pin[i], 1);
+	}
+
 	usbh_data = *data;
 	platform_device_register(&at91rm9200_usbh_device);
 }
diff --git a/arch/arm/mach-at91/at91sam9260_devices.c b/arch/arm/mach-at91/at91sam9260_devices.c
index 39f81f4..3a77508 100644
--- a/arch/arm/mach-at91/at91sam9260_devices.c
+++ b/arch/arm/mach-at91/at91sam9260_devices.c
@@ -64,6 +64,11 @@ void __init at91_add_device_usbh(struct at91_usbh_data *data)
 	if (!data)
 		return;
 
+	for (i = 0; i < data->ports; i++) {
+		if (data->overcurrent_pin[i])
+			at91_set_GPIO_periph(data->overcurrent_pin[i], 1);
+	}
+
 	usbh_data = *data;
 	platform_device_register(&at91_usbh_device);
 }
diff --git a/arch/arm/mach-at91/at91sam9261_devices.c b/arch/arm/mach-at91/at91sam9261_devices.c
index 5004bf0..57b3fa7 100644
--- a/arch/arm/mach-at91/at91sam9261_devices.c
+++ b/arch/arm/mach-at91/at91sam9261_devices.c
@@ -67,6 +67,11 @@ void __init at91_add_device_usbh(struct at91_usbh_data *data)
 	if (!data)
 		return;
 
+	for (i = 0; i < data->ports; i++) {
+		if (data->overcurrent_pin[i])
+			at91_set_GPIO_periph(data->overcurrent_pin[i], 1);
+	}
+
 	usbh_data = *data;
 	platform_device_register(&at91sam9261_usbh_device);
 }
diff --git a/arch/arm/mach-at91/at91sam9263_devices.c b/arch/arm/mach-at91/at91sam9263_devices.c
index a050f41..f0fcc93 100644
--- a/arch/arm/mach-at91/at91sam9263_devices.c
+++ b/arch/arm/mach-at91/at91sam9263_devices.c
@@ -74,6 +74,11 @@ void __init at91_add_device_usbh(struct at91_usbh_data *data)
 			at91_set_gpio_output(data->vbus_pin[i], 0);
 	}
 
+	for (i = 0; i < data->ports; i++) {
+		if (data->overcurrent_pin[i])
+			at91_set_GPIO_periph(data->overcurrent_pin[i], 1);
+	}
+
 	usbh_data = *data;
 	platform_device_register(&at91_usbh_device);
 }
diff --git a/arch/arm/mach-at91/at91sam9g45_devices.c b/arch/arm/mach-at91/at91sam9g45_devices.c
index 600bffb..4f2d774 100644
--- a/arch/arm/mach-at91/at91sam9g45_devices.c
+++ b/arch/arm/mach-at91/at91sam9g45_devices.c
@@ -124,6 +124,11 @@ void __init at91_add_device_usbh_ohci(struct at91_usbh_data *data)
 			at91_set_gpio_output(data->vbus_pin[i], 0);
 	}
 
+	for (i = 0; i < data->ports; i++) {
+		if (data->overcurrent_pin[i])
+			at91_set_GPIO_periph(data->overcurrent_pin[i], 1);
+	}
+
 	usbh_ohci_data = *data;
 	platform_device_register(&at91_usbh_ohci_device);
 }
-- 
1.7.4.1
