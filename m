From: const@MakeLinux.com (Constantine Shulyupin)
Date: Thu, 11 Oct 2012 18:44:17 +0200
Subject: [PATCH v7] Initialize USB on dm365 EVM
Message-ID: <1349973857-25140-1-git-send-email-const@MakeLinux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Constantine Shulyupin <const@MakeLinux.com>

Call USB initialization davinci_setup_usb from board initialization dm365_evm_init.

Tested with OTG configuration, usb gadget g_zero on DM365 EVM connected to PC.

Note: register USB_PHY_CTRL must have flag USBPHY_CLKFREQ_24MHZ

References:

Original patch by miguel.aguilar at ridgerun.com three years ago:
- http://www.mail-archive.com/davinci-linux-open-source at linux.davincidsp.com/msg14741.html

Signed-off-by: Constantine Shulyupin <const@MakeLinux.com>
---

Changelog

Changes since v6
- patch splitted accordinly request of Sergei
- this split contains call to davinci_setup_usb from dm365_evm_init

Changes since v5 http://www.spinics.net/lists/kernel/msg1413120.html
accordingy feedback of nsekhar at ti.com http://www.spinics.net/lists/kernel/msg1414914.html
- phy configuration moved to drivers/usb/musb/davinci.c
- USB_OTG configuration is submitted in separated patch: http://www.spinics.net/lists/kernel/msg1414964.html
- Setting current limit to 1000 mA. Any way the current is limited to 510 mA in davinci_setup_usb.

Changes since v4 http://www.spinics.net/lists/kernel/msg1412995.html
- removed fix of dev_info in musb_init_controller

Changes since v3 http://www.spinics.net/lists/kernel/msg1412544.html:
- removed optional altering of pr_info

Changes since v1  http://marc.info/?l=linux-kernel&m=130894150803661&w=2:
- removed optional code and reordered
- removed alternation of GPIO33, which is multiplexed with DRVVBUS, because is not need for peripheral USB

This patch is based on code from projects Arago, Angstom and RidgeRun.

---
 arch/arm/mach-davinci/board-dm365-evm.c |    2 ++

diff --git a/arch/arm/mach-davinci/board-dm365-evm.c b/arch/arm/mach-davinci/board-dm365-evm.c
index 688a9c5..ba5ffc1 100644
--- a/arch/arm/mach-davinci/board-dm365-evm.c
+++ b/arch/arm/mach-davinci/board-dm365-evm.c
@@ -38,6 +38,7 @@
 #include <mach/mmc.h>
 #include <mach/nand.h>
 #include <mach/keyscan.h>
+#include <mach/usb.h>
 
 #include <media/tvp514x.h>
 
@@ -610,6 +611,7 @@ static __init void dm365_evm_init(void)
 
 	dm365_init_spi0(BIT(0), dm365_evm_spi_info,
 			ARRAY_SIZE(dm365_evm_spi_info));
+	davinci_setup_usb(1000, 8);
 }
 
 MACHINE_START(DAVINCI_DM365_EVM, "DaVinci DM365 EVM")
-- 
1.7.9.5
