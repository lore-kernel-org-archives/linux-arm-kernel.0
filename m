From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 18 May 2012 09:39:03 +0100
Subject: [PATCH 04/16] ARM: ux500: Only initialise STE's UIBs on boards which
 support them
In-Reply-To: <1337330355-17747-1-git-send-email-lee.jones@linaro.org>
References: <1337330355-17747-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1337330355-17747-5-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ST-Ericsson uses User Interface Boards to extend functionality of
some of their development boards. However, these aren't compatible
with all the supported boards found in Mainline (Snowball for
instance). This patch ensures that the UIBs are only probed on
boards which can actually support them. This in turn saves lots of
unnecessary error messages normally found in Snowball's boot log.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/board-mop500-uib.c |    4 +---
 arch/arm/mach-ux500/board-mop500.c     |    8 ++++++++
 arch/arm/mach-ux500/board-mop500.h     |    1 +
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500-uib.c b/arch/arm/mach-ux500/board-mop500-uib.c
index b29a788..1f47d96 100644
--- a/arch/arm/mach-ux500/board-mop500-uib.c
+++ b/arch/arm/mach-ux500/board-mop500-uib.c
@@ -96,7 +96,7 @@ static void __init __mop500_uib_init(struct uib *uib, const char *why)
 /*
  * Detect the UIB attached based on the presence or absence of i2c devices.
  */
-static int __init mop500_uib_init(void)
+int __init mop500_uib_init(void)
 {
 	struct uib *uib = mop500_uib;
 	struct i2c_adapter *i2c0;
@@ -131,5 +131,3 @@ static int __init mop500_uib_init(void)
 
 	return 0;
 }
-
-module_init(mop500_uib_init);
diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index 8845286..faa46b1 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -635,6 +635,8 @@ static void __init mop500_init_machine(void)
 
 	/* This board has full regulator constraints */
 	regulator_has_full_constraints();
+
+	mop500_uib_init();
 }
 
 static void __init snowball_init_machine(void)
@@ -699,6 +701,8 @@ static void __init hrefv60_init_machine(void)
 
 	/* This board has full regulator constraints */
 	regulator_has_full_constraints();
+
+	mop500_uib_init();
 }
 
 MACHINE_START(U8500, "ST-Ericsson MOP500 platform")
@@ -809,6 +813,8 @@ static void __init u8500_init_machine(void)
 		i2c_register_board_info(2, mop500_i2c2_devices,
 					ARRAY_SIZE(mop500_i2c2_devices));
 
+		mop500_uib_init();
+
 	} else if (of_machine_is_compatible("calaosystems,snowball-a9500")) {
 		//snowball_pins_init();
 
@@ -842,6 +848,8 @@ static void __init u8500_init_machine(void)
 		i2c_register_board_info(0, mop500_i2c0_devices, i2c0_devs);
 		i2c_register_board_info(2, mop500_i2c2_devices,
 					ARRAY_SIZE(mop500_i2c2_devices));
+
+		mop500_uib_init();
 	}
 
 	/* This board has full regulator constraints */
diff --git a/arch/arm/mach-ux500/board-mop500.h b/arch/arm/mach-ux500/board-mop500.h
index 44ab4bd..b5bfc1a 100644
--- a/arch/arm/mach-ux500/board-mop500.h
+++ b/arch/arm/mach-ux500/board-mop500.h
@@ -92,6 +92,7 @@ void __init mop500_pinmaps_init(void);
 void __init snowball_pinmaps_init(void);
 void __init hrefv60_pinmaps_init(void);
 
+int __init mop500_uib_init(void);
 void mop500_uib_i2c_add(int busnum, struct i2c_board_info *info,
 		unsigned n);
 
-- 
1.7.9.5
