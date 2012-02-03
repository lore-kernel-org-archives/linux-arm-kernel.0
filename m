From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 03 Feb 2012 19:15:52 +0000
Subject: [PATCH 1/3] ARM: sa11x0: fix off-by-one resource sizes
In-Reply-To: <20120203191528.GE14129@n2100.arm.linux.org.uk>
References: <20120203191528.GE14129@n2100.arm.linux.org.uk>
Message-ID: <E1RtObw-0005gH-78@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hackkit defined its flash memory resource to be 32M + 1 byte.
Jornada defined the Epson video controller resources to be one byte
larger than they should be, and mis-mapped the SA-1111 companion
chip one byte smaller than it should be.

Fix these.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-sa1100/hackkit.c    |    2 +-
 arch/arm/mach-sa1100/jornada720.c |    8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-sa1100/hackkit.c b/arch/arm/mach-sa1100/hackkit.c
index c01bb36..9092b3a 100644
--- a/arch/arm/mach-sa1100/hackkit.c
+++ b/arch/arm/mach-sa1100/hackkit.c
@@ -181,7 +181,7 @@ static struct flash_platform_data hackkit_flash_data = {
 
 static struct resource hackkit_flash_resource = {
 	.start		= SA1100_CS0_PHYS,
-	.end		= SA1100_CS0_PHYS + SZ_32M,
+	.end		= SA1100_CS0_PHYS + SZ_32M - 1,
 	.flags		= IORESOURCE_MEM,
 };
 
diff --git a/arch/arm/mach-sa1100/jornada720.c b/arch/arm/mach-sa1100/jornada720.c
index ee121d6..5393b06 100644
--- a/arch/arm/mach-sa1100/jornada720.c
+++ b/arch/arm/mach-sa1100/jornada720.c
@@ -46,7 +46,7 @@
 
 /* memory space (line 52 of HP's doc) */
 #define SA1111REGSTART	0x40000000
-#define SA1111REGLEN	0x00001fff
+#define SA1111REGLEN	0x00002000
 #define EPSONREGSTART	0x48000000
 #define EPSONREGLEN	0x00100000
 #define EPSONFBSTART	0x48200000
@@ -176,12 +176,12 @@ static struct s1d13xxxfb_pdata s1d13xxxfb_data = {
 static struct resource s1d13xxxfb_resources[] = {
 	[0] = {
 		.start	= EPSONFBSTART,
-		.end	= EPSONFBSTART + EPSONFBLEN,
+		.end	= EPSONFBSTART + EPSONFBLEN - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
 		.start	= EPSONREGSTART,
-		.end	= EPSONREGSTART + EPSONREGLEN,
+		.end	= EPSONREGSTART + EPSONREGLEN - 1,
 		.flags	= IORESOURCE_MEM,
 	}
 };
@@ -199,7 +199,7 @@ static struct platform_device s1d13xxxfb_device = {
 static struct resource sa1111_resources[] = {
 	[0] = {
 		.start		= SA1111REGSTART,
-		.end		= SA1111REGSTART + SA1111REGLEN,
+		.end		= SA1111REGSTART + SA1111REGLEN - 1,
 		.flags		= IORESOURCE_MEM,
 	},
 	[1] = {
-- 
1.7.4.4
