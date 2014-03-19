From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Mar 2014 20:29:14 +0100
Subject: [PATCH 17/62] ARM: ixp4xx: fix gpio rework
In-Reply-To: <1395257399-359545-1-git-send-email-arnd@arndb.de>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
Message-ID: <1395257399-359545-18-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 098e30f6558f8 "ARM: ixp4xx: stop broadcasting the custom GPIO API"
changed the internal gpio code of ixp4xx to be accessible only from
common.c, but unfortunately that broke the Goramo MultiLink code, which
uses this API.

This tries to restore the previous state without exposing the
API globally again. A better solution might be needed.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Imre Kaloz <kaloz@openwrt.org>
---
 arch/arm/mach-ixp4xx/common.c     | 6 +++---
 arch/arm/mach-ixp4xx/goramo_mlr.c | 7 +++++++
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-ixp4xx/common.c b/arch/arm/mach-ixp4xx/common.c
index bffbce4..d628b3d 100644
--- a/arch/arm/mach-ixp4xx/common.c
+++ b/arch/arm/mach-ixp4xx/common.c
@@ -110,7 +110,7 @@ void __init ixp4xx_map_io(void)
 #define IXP4XX_GPIO_CLK_0		14
 #define IXP4XX_GPIO_CLK_1		15
 
-static void gpio_line_config(u8 line, u32 direction)
+void gpio_line_config(u8 line, u32 direction)
 {
 	if (direction == IXP4XX_GPIO_IN)
 		*IXP4XX_GPIO_GPOER |= (1 << line);
@@ -118,12 +118,12 @@ static void gpio_line_config(u8 line, u32 direction)
 		*IXP4XX_GPIO_GPOER &= ~(1 << line);
 }
 
-static void gpio_line_get(u8 line, int *value)
+void gpio_line_get(u8 line, int *value)
 {
 	*value = (*IXP4XX_GPIO_GPINR >> line) & 0x1;
 }
 
-static void gpio_line_set(u8 line, int value)
+void gpio_line_set(u8 line, int value)
 {
 	if (value == IXP4XX_GPIO_HIGH)
 	    *IXP4XX_GPIO_GPOUTR |= (1 << line);
diff --git a/arch/arm/mach-ixp4xx/goramo_mlr.c b/arch/arm/mach-ixp4xx/goramo_mlr.c
index e54ff491..5a635c6 100644
--- a/arch/arm/mach-ixp4xx/goramo_mlr.c
+++ b/arch/arm/mach-ixp4xx/goramo_mlr.c
@@ -17,6 +17,13 @@
 #include <asm/mach/pci.h>
 #include <asm/system_info.h>
 
+#define IXP4XX_GPIO_OUT 		0x1
+#define IXP4XX_GPIO_IN  		0x2
+
+void gpio_line_config(u8 line, u32 direction);
+void gpio_line_get(u8 line, int *value);
+void gpio_line_set(u8 line, int value);
+
 #define SLOT_ETHA		0x0B	/* IDSEL = AD21 */
 #define SLOT_ETHB		0x0C	/* IDSEL = AD20 */
 #define SLOT_MPCI		0x0D	/* IDSEL = AD19 */
-- 
1.8.3.2
