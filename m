From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 17 Apr 2012 16:44:22 +0100
Subject: [PATCH 11/16 v2] ARM: ux500: Do not attempt to register
 non-existent i2c devices on Snowball
In-Reply-To: <1334659448-11521-12-git-send-email-lee.jones@linaro.org>
References: <1334659448-11521-1-git-send-email-lee.jones@linaro.org>
 <1334659448-11521-12-git-send-email-lee.jones@linaro.org>
Message-ID: <4F8D8FD6.1070508@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lee Jones <lee.jones@linaro.org>
Date: Mon, 16 Apr 2012 15:26:55 +0100
Subject: [PATCH 11/16] ARM: ux500: Do not attempt to register non-existent
 i2c devices on Snowball

This patch prevents i2c devices which are not present on the Snowball
low-cost development board from being registered. Devices such as;
tc3589x, bu1780 and lp5521 are present on other supported boards,
but are not located on Snowball.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/board-mop500.c |   24 +++++++++++++-----------
 1 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index a46345e..ed92456 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -652,7 +652,6 @@ static void __init mop500_init_machine(void)
 static void __init snowball_init_machine(void)
 {
 	struct device *parent = NULL;
-	int i2c0_devs;
 	int i;
 
 	parent = u8500_init_devices();
@@ -670,11 +669,6 @@ static void __init snowball_init_machine(void)
 	mop500_spi_init(parent);
 	mop500_uart_init(parent);
 
-	i2c0_devs = ARRAY_SIZE(mop500_i2c0_devices);
-	i2c_register_board_info(0, mop500_i2c0_devices, i2c0_devs);
-	i2c_register_board_info(2, mop500_i2c2_devices,
-				ARRAY_SIZE(mop500_i2c2_devices));
-
 	/* This board has full regulator constraints */
 	regulator_has_full_constraints();
 }
@@ -787,7 +781,6 @@ static void __init u8500_init_machine(void)
 	int i;
 
 	parent = u8500_of_init_devices();
-	i2c0_devs = ARRAY_SIZE(mop500_i2c0_devices);
 
 	for (i = 0; i < ARRAY_SIZE(mop500_platform_devs); i++)
 		mop500_platform_devs[i]->dev.parent = parent;
@@ -805,6 +798,12 @@ static void __init u8500_init_machine(void)
 				ARRAY_SIZE(mop500_platform_devs));
 
 		mop500_sdi_init(parent);
+
+		i2c0_devs = ARRAY_SIZE(mop500_i2c0_devices);
+		i2c_register_board_info(0, mop500_i2c0_devices, i2c0_devs);
+		i2c_register_board_info(2, mop500_i2c2_devices,
+					ARRAY_SIZE(mop500_i2c2_devices));
+
 	} else if (of_machine_is_compatible("calaosystems,snowball-a9500")) {
 		snowball_pins_init();
 
@@ -831,13 +830,16 @@ static void __init u8500_init_machine(void)
 				ARRAY_SIZE(mop500_platform_devs));
 
 		hrefv60_sdi_init(parent);
+
+		i2c0_devs = ARRAY_SIZE(mop500_i2c0_devices);
+		i2c0_devs -= NUM_PRE_V60_I2C0_DEVICES;
+
+		i2c_register_board_info(0, mop500_i2c0_devices, i2c0_devs);
+		i2c_register_board_info(2, mop500_i2c2_devices,
+					ARRAY_SIZE(mop500_i2c2_devices));
 	}
 	mop500_i2c_init(parent);
 
-	i2c_register_board_info(0, mop500_i2c0_devices, i2c0_devs);
-	i2c_register_board_info(2, mop500_i2c2_devices,
-				ARRAY_SIZE(mop500_i2c2_devices));
-
 	/* This board has full regulator constraints */
 	regulator_has_full_constraints();
 }
-- 
1.7.9.1

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515 
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
