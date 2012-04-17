From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 17 Apr 2012 11:43:58 +0100
Subject: [PATCH 06/16] ARM: ux500: New DT:ed u8500_init_devices for one-by-one
 device enablement
In-Reply-To: <1334659448-11521-1-git-send-email-lee.jones@linaro.org>
References: <1334659448-11521-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1334659448-11521-7-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

During Device Tree enablement it is necessary to remove
<hw_component>_add_<device> calls one at at time, as and when
particular devices are DT enabled. This patch provides a
temporary solution. Once the new *of_init_devices function
has been fully unpopulated it will be removed again.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/board-mop500.c |    2 +-
 arch/arm/mach-ux500/board-mop500.h |    3 +++
 arch/arm/mach-ux500/cpu-db8500.c   |   22 ++++++++++++++++++++++
 3 files changed, 26 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index ee1296a..29fec0f 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -787,7 +787,7 @@ static void __init u8500_init_machine(void)
 	int i2c0_devs;
 	int i;
 
-	parent = u8500_init_devices();
+	parent = u8500_of_init_devices();
 	i2c0_devs = ARRAY_SIZE(mop500_i2c0_devices);
 
 	for (i = 0; i < ARRAY_SIZE(mop500_platform_devs); i++)
diff --git a/arch/arm/mach-ux500/board-mop500.h b/arch/arm/mach-ux500/board-mop500.h
index 384baf7..fd94722 100644
--- a/arch/arm/mach-ux500/board-mop500.h
+++ b/arch/arm/mach-ux500/board-mop500.h
@@ -92,4 +92,7 @@ void __init snowball_pins_init(void);
 void mop500_uib_i2c_add(int busnum, struct i2c_board_info *info,
 		unsigned n);
 
+/* TODO: Once all pieces are DT:ed, remove completely. */
+struct device * __init u8500_of_init_devices(void);
+
 #endif
diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index 9bd8163..58768d9 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -206,3 +206,25 @@ struct device * __init u8500_init_devices(void)
 
 	return parent;
 }
+
+/* TODO: Once all pieces are DT:ed, remove completely. */
+struct device * __init u8500_of_init_devices(void)
+{
+	struct device *parent;
+	int i;
+
+	parent = db8500_soc_device_init();
+
+	db8500_add_rtc(parent);
+	db8500_add_usb(parent, usb_db8500_rx_dma_cfg, usb_db8500_tx_dma_cfg);
+
+	platform_device_register_data(parent,
+		"cpufreq-u8500", -1, NULL, 0);
+
+	for (i = 0; i < ARRAY_SIZE(platform_devs); i++)
+		platform_devs[i]->dev.parent = parent;
+
+	platform_add_devices(platform_devs, ARRAY_SIZE(platform_devs));
+
+	return parent;
+}
-- 
1.7.9.1
