From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 27 Mar 2015 14:15:03 +0000
Subject: [PATCH 2/4] irqchip: gicv3-its: Fix device ID encoding
In-Reply-To: <1427465705-17126-1-git-send-email-marc.zyngier@arm.com>
References: <1427465705-17126-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1427465705-17126-3-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andre Przywara <andre.przywara@arm.com>

When building ITS commands which have the device ID in it, we
should mask off the whole upper 32 bits of the first command word
before inserting the new value in there.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 7318dba..fa0c436 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -169,7 +169,7 @@ static void its_encode_cmd(struct its_cmd_block *cmd, u8 cmd_nr)
 
 static void its_encode_devid(struct its_cmd_block *cmd, u32 devid)
 {
-	cmd->raw_cmd[0] &= ~(0xffffUL << 32);
+	cmd->raw_cmd[0] &= BIT_ULL(32) - 1;
 	cmd->raw_cmd[0] |= ((u64)devid) << 32;
 }
 
-- 
2.1.4
