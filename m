From: public_timo.s@silentcreek.de (Timo Sigurdsson)
Date: Fri,  1 Jan 2016 14:38:22 +0100
Subject: [PATCH for 4.4-rc8] ARM: Fix broken USB support in multi_v7_defconfig
 for sunxi devices
In-Reply-To: <1451353653-17484-1-git-send-email-public_timo.s@silentcreek.de>
References: <1451353653-17484-1-git-send-email-public_timo.s@silentcreek.de>
Message-ID: <1451655502-8561-1-git-send-email-public_timo.s@silentcreek.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 69fb4dcada77 ("power: Add an axp20x-usb-power driver") introduced a
new driver for the USB power supply used on various Allwinner based SBCs.
However, the driver was not added to multi_v7_defconfig which breaks USB
support for some boards (e.g. LeMaker BananaPi) as the kernel will now
turn off the USB power supply during boot by default if the driver isn't
present. (This was not the case in linux 4.3 or lower where the USB power
was always left on.)

Hence, add the driver to multi_v7_defconfig in order to keep USB support
working on those boards that require it.

Signed-off-by: Timo Sigurdsson <public_timo.s@silentcreek.de>
Tested-by: Timo Sigurdsson <public_timo.s@silentcreek.de>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
Notes:

I chose to add AXP20X_POWER as a module here, since linux-next already
has it this way, see commit 83e9e1f84074 ("ARM: multi_v7_defconfig:
Enable RSB and AXP20X related drivers as modules").
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 69a22fd..cd7b198 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -366,6 +366,7 @@ CONFIG_BATTERY_MAX17042=m
 CONFIG_CHARGER_MAX14577=m
 CONFIG_CHARGER_MAX77693=m
 CONFIG_CHARGER_TPS65090=y
+CONFIG_AXP20X_POWER=m
 CONFIG_POWER_RESET_AS3722=y
 CONFIG_POWER_RESET_GPIO=y
 CONFIG_POWER_RESET_GPIO_RESTART=y
-- 
2.1.4
