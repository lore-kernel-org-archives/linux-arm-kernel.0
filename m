From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 19 Aug 2015 15:31:30 -0300
Subject: [PATCH] ARM: imx: mach-imx6ul: Fix allmodconfig build
Message-ID: <1440009090-25799-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

We should call phy_register_fixup_for_uid() only when CONFIG_PHYLIB
is built-in, otherwise we get the following link error when building
allmodconfig:

arch/arm/mach-imx/built-in.o: In function `imx6ul_init_machine':
:(.init.text+0xa714): undefined reference to `phy_register_fixup_for_uid'

This is the same approach done in mach-imx6q.c and mach-imx6sx.c.

Reported-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/mach-imx6ul.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/mach-imx6ul.c b/arch/arm/mach-imx/mach-imx6ul.c
index db74da5..1b97fe1 100644
--- a/arch/arm/mach-imx/mach-imx6ul.c
+++ b/arch/arm/mach-imx/mach-imx6ul.c
@@ -45,7 +45,9 @@ static int ksz8081_phy_fixup(struct phy_device *dev)
 
 static void __init imx6ul_enet_phy_init(void)
 {
-	phy_register_fixup_for_uid(PHY_ID_KSZ8081, 0xffffffff, ksz8081_phy_fixup);
+	if (IS_BUILTIN(CONFIG_PHYLIB))
+		phy_register_fixup_for_uid(PHY_ID_KSZ8081, 0xffffffff,
+					   ksz8081_phy_fixup);
 }
 
 static inline void imx6ul_enet_init(void)
-- 
1.9.1
