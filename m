From: ben-linux@fluff.org (Ben Dooks)
Date: Fri, 28 May 2010 07:19:13 +0100
Subject: [PATCH 3/9] ARM: SAMSUNG: Default s3c_device_i2c2 to s3c2440-i2c
In-Reply-To: <1275027559-29278-1-git-send-email-ben-linux@fluff.org>
References: <1275027559-29278-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1275027559-29278-4-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are no current SoCs where i2c2 is anything other than a s3c2440-i2c
implementation (see also e4c5cb3796155eb4f15f7f0b1b7ea705f87743a7) so
change the device's name to s3c2440-i2c by default so we can eliminate
the calls that set the name.

Also remove the singler user of this, the s5pv210.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/mach-s5pv210/cpu.c      |    1 -
 arch/arm/plat-samsung/dev-i2c2.c |    3 ++-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-s5pv210/cpu.c b/arch/arm/mach-s5pv210/cpu.c
index 987fe1d..8a64ef3 100644
--- a/arch/arm/mach-s5pv210/cpu.c
+++ b/arch/arm/mach-s5pv210/cpu.c
@@ -89,7 +89,6 @@ void __init s5pv210_map_io(void)
 
 	/* the i2c devices are directly compatible with s3c2440 */
 	s3c_i2c0_setname("s3c2440-i2c");
-	s3c_i2c2_setname("s3c2440-i2c");
 }
 
 void __init s5pv210_init_clocks(int xtal)
diff --git a/arch/arm/plat-samsung/dev-i2c2.c b/arch/arm/plat-samsung/dev-i2c2.c
index 07036de..ab2b3d5 100644
--- a/arch/arm/plat-samsung/dev-i2c2.c
+++ b/arch/arm/plat-samsung/dev-i2c2.c
@@ -39,7 +39,8 @@ static struct resource s3c_i2c_resource[] = {
 };
 
 struct platform_device s3c_device_i2c2 = {
-	.name		  = "s3c2410-i2c",
+	/* default to s3c2440-i2c as no SoC with >1 I2C is s3c2410 style */
+	.name		  = "s3c2440-i2c",
 	.id		  = 2,
 	.num_resources	  = ARRAY_SIZE(s3c_i2c_resource),
 	.resource	  = s3c_i2c_resource,
-- 
1.6.3.3
