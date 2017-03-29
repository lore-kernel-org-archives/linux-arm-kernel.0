From: leonard.crestez@nxp.com (Leonard Crestez)
Date: Wed, 29 Mar 2017 13:48:02 +0300
Subject: [PATCH v2] ARM: imx_v6_v7_defconfig: Select SMSC_PHY
Message-ID: <0d4ff89ce2276dfbde2db8ced3fff10582a5b899.1490783707.git.leonard.crestez@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The imx6sl-evk board has a LAN8720A ethernet phy supported by SMSC_PHY.
Add this driver to the default imx config since the device is present on
one of the evaluation boards.

This used to work mostly fine with the generic phy driver until
commit 0878fff1f42c ("net: phy: Do not perform software reset for
Generic PHY"). The fact that soft reset is no longer performed
apparently causes RX to sometimes failes which can cause netboot to
timeout on DHCP. This is eventually retried and it works after link
up/down but can takes 90 seconds to reach the login prompt.

This was generated with "make savedefconfig" and it includes a few
additional minor cleanups.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Acked-by: Fugang Duan <fugang.duan@nxp.com>
---

I also tried to do some debugging in the fec driver and it apparently receives
corrupted packets when this happens. If I hack it to go into promiscuous mode
unconditionally it gets a whole bunch of rx errors (crc errors, length errors
and so on). So the phy config is probably wrong and is confusing the mac?

In theory it might be possible to make that driver "just work" with phy
settings from uboot but it's not clear that's worthwhile.

Link to v1: https://lkml.org/lkml/2017/3/22/416
Changes:
 * Improve commit message to fix checkpatch.pl warnings.

 arch/arm/configs/imx_v6_v7_defconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index eaba3b1..e605389 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -143,6 +143,7 @@ CONFIG_SMSC911X=y
 # CONFIG_NET_VENDOR_STMICRO is not set
 CONFIG_AT803X_PHY=y
 CONFIG_MICREL_PHY=y
+CONFIG_SMSC_PHY=y
 CONFIG_USB_PEGASUS=m
 CONFIG_USB_RTL8150=m
 CONFIG_USB_RTL8152=m
@@ -152,7 +153,6 @@ CONFIG_BRCMFMAC=m
 CONFIG_WL12XX=m
 CONFIG_WLCORE_SDIO=m
 # CONFIG_WILINK_PLATFORM_DATA is not set
-# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
 CONFIG_INPUT_EVDEV=y
 CONFIG_INPUT_EVBUG=m
 CONFIG_KEYBOARD_GPIO=y
@@ -376,7 +376,6 @@ CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_ISO8859_15=m
 CONFIG_NLS_UTF8=y
 CONFIG_PRINTK_TIME=y
-CONFIG_DEBUG_FS=y
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_SCHED_DEBUG is not set
 CONFIG_PROVE_LOCKING=y
-- 
2.7.4
