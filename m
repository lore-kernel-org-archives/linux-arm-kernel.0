From: axel.lin@ingics.com (Axel Lin)
Date: Mon, 06 May 2013 15:15:03 +0800
Subject: [PATCH] ARM: U300: Add proper ifdef guard to fix build error when
 CONFIG_I2C_STU300=m
Message-ID: <1367824503.6190.1.camel@phoenix>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I got below build error if CONFIG_I2C_STU300=m.

ERROR: "i2c_register_board_info" [arch/arm/mach-u300/i2c.ko] undefined!
make[1]: *** [__modpost] Error 1
make: *** [modules] Error 2

Fix it by adding proper ifdef guard in i2c.h and Makefile.
So arch/arm/mach-u300/i2c.c will be compiled when CONFIG_I2C_STU300 is
configured as built-in or as a module.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 arch/arm/mach-u300/Makefile | 4 +++-
 arch/arm/mach-u300/i2c.h    | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-u300/Makefile b/arch/arm/mach-u300/Makefile
index 5a86c58..f612d17 100644
--- a/arch/arm/mach-u300/Makefile
+++ b/arch/arm/mach-u300/Makefile
@@ -9,5 +9,7 @@ obj-		:=
 
 obj-$(CONFIG_SPI_PL022)           += spi.o
 obj-$(CONFIG_MACH_U300_SPIDUMMY)  += dummyspichip.o
-obj-$(CONFIG_I2C_STU300)          += i2c.o
+ifneq ($(CONFIG_I2C_STU300),)
+obj-y          += i2c.o
+endif
 obj-$(CONFIG_REGULATOR_AB3100)    += regulator.o
diff --git a/arch/arm/mach-u300/i2c.h b/arch/arm/mach-u300/i2c.h
index 485c02e..9eec276 100644
--- a/arch/arm/mach-u300/i2c.h
+++ b/arch/arm/mach-u300/i2c.h
@@ -11,7 +11,7 @@
 #ifndef MACH_U300_I2C_H
 #define MACH_U300_I2C_H
 
-#ifdef CONFIG_I2C_STU300
+#if IS_ENABLED(ISCONFIG_I2C_STU300)
 void __init u300_i2c_register_board_devices(void);
 #else
 /* Compile out this stuff if no I2C adapter is available */
-- 
1.8.1.2
