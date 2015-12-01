From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue,  1 Dec 2015 12:03:01 +0100
Subject: [PATCH v2 04/25] mips: nand: make use of mtd_to_nand() where
 appropriate
In-Reply-To: <1448967802-25796-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1448967802-25796-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1448967802-25796-5-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mtd_to_nand() was recently introduced to avoid direct accesses to the
mtd->priv field. Update all MIPS specific implementations to use this
helper.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 arch/mips/alchemy/devboards/db1200.c | 2 +-
 arch/mips/alchemy/devboards/db1300.c | 2 +-
 arch/mips/alchemy/devboards/db1550.c | 2 +-
 arch/mips/pnx833x/common/platform.c  | 2 +-
 arch/mips/rb532/devices.c            | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/mips/alchemy/devboards/db1200.c b/arch/mips/alchemy/devboards/db1200.c
index 8c13675..992442a 100644
--- a/arch/mips/alchemy/devboards/db1200.c
+++ b/arch/mips/alchemy/devboards/db1200.c
@@ -200,7 +200,7 @@ static struct i2c_board_info db1200_i2c_devs[] __initdata = {
 static void au1200_nand_cmd_ctrl(struct mtd_info *mtd, int cmd,
 				 unsigned int ctrl)
 {
-	struct nand_chip *this = mtd->priv;
+	struct nand_chip *this = mtd_to_nand(mtd);
 	unsigned long ioaddr = (unsigned long)this->IO_ADDR_W;
 
 	ioaddr &= 0xffffff00;
diff --git a/arch/mips/alchemy/devboards/db1300.c b/arch/mips/alchemy/devboards/db1300.c
index b580770..d3c087f 100644
--- a/arch/mips/alchemy/devboards/db1300.c
+++ b/arch/mips/alchemy/devboards/db1300.c
@@ -150,7 +150,7 @@ static void __init db1300_gpio_config(void)
 static void au1300_nand_cmd_ctrl(struct mtd_info *mtd, int cmd,
 				 unsigned int ctrl)
 {
-	struct nand_chip *this = mtd->priv;
+	struct nand_chip *this = mtd_to_nand(mtd);
 	unsigned long ioaddr = (unsigned long)this->IO_ADDR_W;
 
 	ioaddr &= 0xffffff00;
diff --git a/arch/mips/alchemy/devboards/db1550.c b/arch/mips/alchemy/devboards/db1550.c
index 5740bcf..b518f02 100644
--- a/arch/mips/alchemy/devboards/db1550.c
+++ b/arch/mips/alchemy/devboards/db1550.c
@@ -128,7 +128,7 @@ static struct i2c_board_info db1550_i2c_devs[] __initdata = {
 static void au1550_nand_cmd_ctrl(struct mtd_info *mtd, int cmd,
 				 unsigned int ctrl)
 {
-	struct nand_chip *this = mtd->priv;
+	struct nand_chip *this = mtd_to_nand(mtd);
 	unsigned long ioaddr = (unsigned long)this->IO_ADDR_W;
 
 	ioaddr &= 0xffffff00;
diff --git a/arch/mips/pnx833x/common/platform.c b/arch/mips/pnx833x/common/platform.c
index b4b774b..3cd3577 100644
--- a/arch/mips/pnx833x/common/platform.c
+++ b/arch/mips/pnx833x/common/platform.c
@@ -180,7 +180,7 @@ static struct platform_device pnx833x_sata_device = {
 static void
 pnx833x_flash_nand_cmd_ctrl(struct mtd_info *mtd, int cmd, unsigned int ctrl)
 {
-	struct nand_chip *this = mtd->priv;
+	struct nand_chip *this = mtd_to_nand(mtd);
 	unsigned long nandaddr = (unsigned long)this->IO_ADDR_W;
 
 	if (cmd == NAND_CMD_NONE)
diff --git a/arch/mips/rb532/devices.c b/arch/mips/rb532/devices.c
index 9bd7a2d..0966adc 100644
--- a/arch/mips/rb532/devices.c
+++ b/arch/mips/rb532/devices.c
@@ -148,7 +148,7 @@ static int rb532_dev_ready(struct mtd_info *mtd)
 
 static void rb532_cmd_ctrl(struct mtd_info *mtd, int cmd, unsigned int ctrl)
 {
-	struct nand_chip *chip = mtd->priv;
+	struct nand_chip *chip = mtd_to_nand(mtd);
 	unsigned char orbits, nandbits;
 
 	if (ctrl & NAND_CTRL_CHANGE) {
-- 
2.1.4
