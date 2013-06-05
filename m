From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  5 Jun 2013 17:26:34 +0900
Subject: [PATCH 103/130] ARM: shmobile: r8a7779 pinmux platform device cleanup
In-Reply-To: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
References: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1370420821-28420-104-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Use DEFINE_RES_MEM() to save a couple of lines of code.

Signed-off-by: Magnus Damm <damm@opensource.se>
[lp: Don't declare r8a7779_pfc_resources as const]
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-r8a7779.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c b/arch/arm/mach-shmobile/setup-r8a7779.c
index b0b3948..dbb13f2 100644
--- a/arch/arm/mach-shmobile/setup-r8a7779.c
+++ b/arch/arm/mach-shmobile/setup-r8a7779.c
@@ -65,11 +65,7 @@ void __init r8a7779_map_io(void)
 }
 
 static struct resource r8a7779_pfc_resources[] = {
-	[0] = {
-		.start	= 0xfffc0000,
-		.end	= 0xfffc023b,
-		.flags	= IORESOURCE_MEM,
-	},
+	DEFINE_RES_MEM(0xfffc0000, 0x023c),
 };
 
 static struct platform_device r8a7779_pfc_device = {
@@ -81,15 +77,8 @@ static struct platform_device r8a7779_pfc_device = {
 
 #define R8A7779_GPIO(idx, npins) \
 static struct resource r8a7779_gpio##idx##_resources[] = {		\
-	[0] = {								\
-		.start	= 0xffc40000 + 0x1000 * (idx),			\
-		.end	= 0xffc4002b + 0x1000 * (idx),			\
-		.flags	= IORESOURCE_MEM,				\
-	},								\
-	[1] = {								\
-		.start	= gic_iid(0xad + (idx)),			\
-		.flags	= IORESOURCE_IRQ,				\
-	}								\
+	DEFINE_RES_MEM(0xffc40000 + (0x1000 * (idx)), 0x002c),		\
+	DEFINE_RES_IRQ(gic_iid(0xad + (idx))),				\
 };									\
 									\
 static struct gpio_rcar_config r8a7779_gpio##idx##_platform_data = {	\
-- 
1.8.2.1
