From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Mar 2014 20:29:04 +0100
Subject: [PATCH 07/62] ARM: davinci: make dm644x-evm phy fixup conditional
In-Reply-To: <1395257399-359545-1-git-send-email-arnd@arndb.de>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
Message-ID: <1395257399-359545-8-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We cannot call phy_register_fixup_for_uid() if CONFIG_PHYLIB
is not built into the kernel, and we should not enforce that
to be built into vmlinux either, because one might want to
disable the entire network stack.

This change uses a compile-time condition on CONFIG_PHYLIB
to remove the call in the cases where it cannot work.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Sekhar Nori <nsekhar@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: davinci-linux-open-source at linux.davincidsp.com
---
 arch/arm/mach-davinci/board-dm644x-evm.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
index 5602957..e583e58 100644
--- a/arch/arm/mach-davinci/board-dm644x-evm.c
+++ b/arch/arm/mach-davinci/board-dm644x-evm.c
@@ -804,11 +804,12 @@ static __init void davinci_evm_init(void)
 	/* irlml6401 switches over 1A, in under 8 msec */
 	davinci_setup_usb(1000, 8);
 
-	soc_info->emac_pdata->phy_id = DM644X_EVM_PHY_ID;
-	/* Register the fixup for PHY on DaVinci */
-	phy_register_fixup_for_uid(LXT971_PHY_ID, LXT971_PHY_MASK,
-					davinci_phy_fixup);
-
+	if (IS_BUILTIN(CONFIG_PHYLIB)) {
+		soc_info->emac_pdata->phy_id = DM644X_EVM_PHY_ID;
+		/* Register the fixup for PHY on DaVinci */
+		phy_register_fixup_for_uid(LXT971_PHY_ID, LXT971_PHY_MASK,
+						davinci_phy_fixup);
+	}
 }
 
 MACHINE_START(DAVINCI_EVM, "DaVinci DM644x EVM")
-- 
1.8.3.2
