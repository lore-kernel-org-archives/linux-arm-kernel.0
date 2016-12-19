From: romain.perier@free-electrons.com (Romain Perier)
Date: Mon, 19 Dec 2016 15:16:06 +0100
Subject: [PATCH 1/4] net: dsa: mv88e6xxx: Allow mv88e6xxx_smi_init() to be
 used at address 0x1
In-Reply-To: <20161219141610.30934-1-romain.perier@free-electrons.com>
References: <20161219141610.30934-1-romain.perier@free-electrons.com>
Message-ID: <20161219141610.30934-2-romain.perier@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, the function mv88e6xxx_smi_init() returns -EINVAL if the bit
zero of sw_addr is 0x1. However, on some platforms, ethernet switches
are configured in Multi chip addressing mode and available at MDIO
address 0x1.

Signed-off-by: Romain Perier <romain.perier@free-electrons.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index f7222dc..b5f0e1e 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -4240,10 +4240,6 @@ static void mv88e6xxx_phy_destroy(struct mv88e6xxx_chip *chip)
 static int mv88e6xxx_smi_init(struct mv88e6xxx_chip *chip,
 			      struct mii_bus *bus, int sw_addr)
 {
-	/* ADDR[0] pin is unavailable externally and considered zero */
-	if (sw_addr & 0x1)
-		return -EINVAL;
-
 	if (sw_addr == 0)
 		chip->smi_ops = &mv88e6xxx_smi_single_chip_ops;
 	else if (mv88e6xxx_has(chip, MV88E6XXX_FLAGS_MULTI_CHIP))
-- 
2.9.3
