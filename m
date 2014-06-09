From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Mon,  9 Jun 2014 16:27:16 -0300
Subject: [RFC/PATCH] ARM: mvebu: Don't apply the quirks if the SoC revision is
 unknown
Message-ID: <1402342036-9168-1-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We currently skip the I2C and thermal quirks only if the SoC revision is
known to be one that does not need them. If the SoC revision cannot be
obtained, the current behavior is to apply the quirk assuming it's needed.

This commit changes this, by requiring the SoC revision to be known in order
to peform a quirk.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/mach-mvebu/board-v7.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mvebu/board-v7.c b/arch/arm/mach-mvebu/board-v7.c
index 594262b..14bf590 100644
--- a/arch/arm/mach-mvebu/board-v7.c
+++ b/arch/arm/mach-mvebu/board-v7.c
@@ -89,13 +89,15 @@ static void __init i2c_quirk(void)
 {
 	struct device_node *np;
 	u32 dev, rev;
+	int res;
 
 	/*
 	 * Only revisons more recent than A0 support the offload
 	 * mechanism. We can exit only if we are sure that we can
 	 * get the SoC revision and it is more recent than A0.
 	 */
-	if (mvebu_get_soc_id(&dev, &rev) == 0 && rev > MV78XX0_A0_REV)
+	res = mvebu_get_soc_id(&dev, &rev);
+	if (res < 0 || (res == 0 &&  rev > MV78XX0_A0_REV))
 		return;
 
 	for_each_compatible_node(np, NULL, "marvell,mv78230-i2c") {
@@ -119,8 +121,10 @@ static void __init thermal_quirk(void)
 {
 	struct device_node *np;
 	u32 dev, rev;
+	int res;
 
-	if (mvebu_get_soc_id(&dev, &rev) == 0 && rev > ARMADA_375_Z1_REV)
+	res = mvebu_get_soc_id(&dev, &rev);
+	if (res < 0 || (res == 0 && rev > ARMADA_375_Z1_REV))
 		return;
 
 	for_each_compatible_node(np, NULL, "marvell,armada375-thermal") {
-- 
1.9.1
