From: lee.jones@linaro.org (Lee Jones)
Date: Thu,  9 Aug 2012 16:47:28 +0100
Subject: [PATCH 02/22] ARM: ux500: Ensure probing of Audio devices when Device
 Tree is enabled
In-Reply-To: <1344527268-5964-1-git-send-email-lee.jones@linaro.org>
References: <1344527268-5964-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1344527268-5964-3-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Previous attempts to add platform probing of the Audio related devices
only call from non-DT initialisation functions. This patch extends that
functionality to the Device Tree related ones too.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/board-mop500.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index f413587..5d9600b 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -799,6 +799,7 @@ static void __init u8500_init_machine(void)
 				ARRAY_SIZE(mop500_platform_devs));
 
 		mop500_sdi_init(parent);
+		mop500_msp_init(parent);
 		i2c0_devs = ARRAY_SIZE(mop500_i2c0_devices);
 		i2c_register_board_info(0, mop500_i2c0_devices, i2c0_devs);
 		i2c_register_board_info(2, mop500_i2c2_devices,
@@ -806,6 +807,8 @@ static void __init u8500_init_machine(void)
 
 		mop500_uib_init();
 
+	} else if (of_machine_is_compatible("calaosystems,snowball-a9500")) {
+		mop500_msp_init(parent);
 	} else if (of_machine_is_compatible("st-ericsson,hrefv60+")) {
 		/*
 		 * The HREFv60 board removed a GPIO expander and routed
@@ -817,6 +820,7 @@ static void __init u8500_init_machine(void)
 				ARRAY_SIZE(mop500_platform_devs));
 
 		hrefv60_sdi_init(parent);
+		mop500_msp_init(parent);
 
 		i2c0_devs = ARRAY_SIZE(mop500_i2c0_devices);
 		i2c0_devs -= NUM_PRE_V60_I2C0_DEVICES;
-- 
1.7.9.5
