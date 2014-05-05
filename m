From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon,  5 May 2014 17:05:22 +0200
Subject: [PATCH v2 1/5] ARM: mvebu: fix thermal quirk SoC revision check
In-Reply-To: <1399302326-6917-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1399302326-6917-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1399302326-6917-2-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In commit 54fe26a900bc528f3df1e4235cb6b9ca5c6d4dc2 ('ARM: mvebu: Add
thermal quirk for the Armada 375 DB board'), a check on the Armada SoC
revision was added to decide whether a quirk for the thermal device
should be applied or not.

However, the quirk implementation has a bug: it assumes
mvebu_get_soc_id() returns true on success, but it returns
0. Therefore, the condition:

  if (mvebu_get_soc_id(&dev, &rev) && rev > ARMADA_375_Z1_REV)

is always false (as long as mvebu-soc-id is properly initialized). As
a consequence, the quirk is always applied, even on A0 steppings, for
which the quirk should not be applied.

This was spotted by testing the thermal driver on Armada 375 A0, which
Ezequiel could not do since he does not have access to the A0 revision
of the SoC for the moment.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Fixes: 54fe26a900bc528f3df1e4235cb6b9ca5c6d4dc2 ('ARM: mvebu: Add thermal quirk for the Armada 375 DB board')
Acked-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/mach-mvebu/board-v7.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-mvebu/board-v7.c b/arch/arm/mach-mvebu/board-v7.c
index bc0283f..01cfce6 100644
--- a/arch/arm/mach-mvebu/board-v7.c
+++ b/arch/arm/mach-mvebu/board-v7.c
@@ -120,7 +120,7 @@ static void __init thermal_quirk(void)
 	struct device_node *np;
 	u32 dev, rev;
 
-	if (mvebu_get_soc_id(&dev, &rev) && rev > ARMADA_375_Z1_REV)
+	if (mvebu_get_soc_id(&dev, &rev) == 0 && rev > ARMADA_375_Z1_REV)
 		return;
 
 	for_each_compatible_node(np, NULL, "marvell,armada375-thermal") {
-- 
1.9.2
