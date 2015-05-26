From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 26 May 2015 18:47:23 +0200
Subject: [PATCH] ata: ahci_mvebu: Fix wrongly set base address for the MBus
 window setting
Message-ID: <1432658843-27622-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nadav Haklai <nadavh@marvell.com>

According to the Armada 38x datasheet, the window base address
registers value is set in bits [31:4] of the register and corresponds
to the transaction address bits [47:20].

Therefore, the 32bit base address value should be shifted right by
20bits and left by 4bits, resulting in 16 bit shift right.

The bug as not been noticed yet because if the memory available on
the platform is less than 2GB, then the base address is zero.

[gregory.clement at free-electrons.com: add extra-explanation]

Fixes: a3464ed2f14 (ata: ahci_mvebu: new driver for Marvell Armada 380
AHCI interfaces)
Signed-off-by: Nadav Haklai <nadavh@marvell.com>
Reviewed-by: Omri Itach <omrii@marvell.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: <stable@vger.kernel.org>
---
 drivers/ata/ahci_mvebu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/ahci_mvebu.c b/drivers/ata/ahci_mvebu.c
index 23716dd8a7ec..5928d0746a27 100644
--- a/drivers/ata/ahci_mvebu.c
+++ b/drivers/ata/ahci_mvebu.c
@@ -45,7 +45,7 @@ static void ahci_mvebu_mbus_config(struct ahci_host_priv *hpriv,
 		writel((cs->mbus_attr << 8) |
 		       (dram->mbus_dram_target_id << 4) | 1,
 		       hpriv->mmio + AHCI_WINDOW_CTRL(i));
-		writel(cs->base, hpriv->mmio + AHCI_WINDOW_BASE(i));
+		writel(cs->base >> 16, hpriv->mmio + AHCI_WINDOW_BASE(i));
 		writel(((cs->size - 1) & 0xffff0000),
 		       hpriv->mmio + AHCI_WINDOW_SIZE(i));
 	}
-- 
2.1.0
