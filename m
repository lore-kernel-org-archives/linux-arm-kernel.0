From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 10 Jun 2014 15:34:43 -0300
Subject: [PATCH v2] ARM: mvebu: Don't apply the thermal quirk if the SoC
 revision is unknown
Message-ID: <1402425283-24989-1-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, the thermal quirk is skipped only if the SoC revision is known to be
one that does not need them, but if the SoC revision cannot be obtained, the
quirk is applied assuming it's needed.

However, this quirk must be applied only we are sure the SoC needs it, for it
breaks the thermal support if applied on a SoC that doesn't need it. The reason
for this is that the quirk consists in changing the thermal devicetree
compatible string and register offsets, to workaround a hardware bug in the
early SoC revision.

Such changes are wrong if the SoC is a new revision and doesn't need
the workaround. Therefore, this commit changes the behavior, by
requiring the SoC revision to be known in order to peform a quirk.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
Changes from v1:
  * Add better commit log and a proper explanation in the code.

  * Dropped the I2C quirk modification, this fix is only applicable
    for the thermal quirk.

 arch/arm/mach-mvebu/board-v7.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mvebu/board-v7.c b/arch/arm/mach-mvebu/board-v7.c
index 594262b..c94caa1 100644
--- a/arch/arm/mach-mvebu/board-v7.c
+++ b/arch/arm/mach-mvebu/board-v7.c
@@ -119,8 +119,16 @@ static void __init thermal_quirk(void)
 {
 	struct device_node *np;
 	u32 dev, rev;
+	int res;
 
-	if (mvebu_get_soc_id(&dev, &rev) == 0 && rev > ARMADA_375_Z1_REV)
+	/*
+	 * The early SoC Z1 revision needs a quirk to be applied in order
+	 * for the thermal controller to work properly. This quirk breaks
+	 * the thermal support if applied on a SoC that doesn't need it,
+	 * so we enforce the SoC revision to be known.
+	 */
+	res = mvebu_get_soc_id(&dev, &rev);
+	if (res < 0 || (res == 0 && rev > ARMADA_375_Z1_REV))
 		return;
 
 	for_each_compatible_node(np, NULL, "marvell,armada375-thermal") {
@@ -154,7 +162,8 @@ static void __init thermal_quirk(void)
 
 		/*
 		 * The thermal controller needs some quirk too, so let's change
-		 * the compatible string to reflect this.
+		 * the compatible string to reflect this and allow the driver
+		 * the take the necessary action.
 		 */
 		prop = kzalloc(sizeof(*prop), GFP_KERNEL);
 		prop->name = kstrdup("compatible", GFP_KERNEL);
-- 
1.9.1
