From: fugang.duan@nxp.com (Andy Duan)
Date: Thu, 23 Mar 2017 01:17:19 +0000
Subject: [PATCH] ARM: imx_v6_v7_defconfig: Select SMSC_PHY
In-Reply-To: <82d0aeeaed87ae5c9390b889cef4c54d715cde61.1490191972.git.leonard.crestez@nxp.com>
References: <82d0aeeaed87ae5c9390b889cef4c54d715cde61.1490191972.git.leonard.crestez@nxp.com>
Message-ID: <AM4PR0401MB22603DE8193DCACB469438F9FF3F0@AM4PR0401MB2260.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Leonard Crestez <leonard.crestez@nxp.com> Sent: Wednesday, March 22, 2017 10:28 PM
>To: Shawn Guo <shawnguo@kernel.org>; Sascha Hauer
><kernel@pengutronix.de>
>Cc: Leonard Crestez <leonard.crestez@nxp.com>; linux-arm-
>kernel at lists.infradead.org; Fabio Estevam <fabio.estevam@nxp.com>; Andy
>Duan <fugang.duan@nxp.com>; Octavian Purdila
><octavian.purdila@nxp.com>; Florian Fainelli <f.fainelli@gmail.com>; linux-
>kernel at vger.kernel.org
>Subject: [PATCH] ARM: imx_v6_v7_defconfig: Select SMSC_PHY
>
>The imx6sl-evk board has a LAN8720A ethernet phy supported by SMSC_PHY.
>Add this driver to the default imx config since the device is present on one of
>the evaluation boards.
>
>This used to work mostly fine with the generic phy driver but since commit
>0878fff1f42c18e448ab5b8b4f6a3eb32365b5b6 that driver no longer performs a
>soft reset on startup. This causes netboot to sometimes timeout on DHCP
>because RX doesn't work right. DHCP is eventually retried and it works the
>second time but it takes 90+ seconds to get a login prompt.
>
>This was generated with "make savedefconfig" and it includes a few additional
>minor cleanups.
>
>Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
>---
>
>I also tried to do some debugging in the fec driver and it apparently receives
>corrupted packets when this happens. If I hack it to go into promiscuous mode
>unconditionally it gets a whole bunch of rx errors (crc errors, length errors and
>so on). So the phy config is probably wrong and is confusing the mac?
>
>In theory it might be possible to make that driver "just work" with phy settings
>from uboot but it's not clear it's worthwhile.
>
> arch/arm/configs/imx_v6_v7_defconfig | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)
>
>diff --git a/arch/arm/configs/imx_v6_v7_defconfig
>b/arch/arm/configs/imx_v6_v7_defconfig
>index eaba3b1..e605389 100644
>--- a/arch/arm/configs/imx_v6_v7_defconfig
>+++ b/arch/arm/configs/imx_v6_v7_defconfig
>@@ -143,6 +143,7 @@ CONFIG_SMSC911X=y
> # CONFIG_NET_VENDOR_STMICRO is not set
> CONFIG_AT803X_PHY=y
> CONFIG_MICREL_PHY=y
>+CONFIG_SMSC_PHY=y
> CONFIG_USB_PEGASUS=m
> CONFIG_USB_RTL8150=m
> CONFIG_USB_RTL8152=m
>@@ -152,7 +153,6 @@ CONFIG_BRCMFMAC=m
> CONFIG_WL12XX=m
> CONFIG_WLCORE_SDIO=m
> # CONFIG_WILINK_PLATFORM_DATA is not set -#
>CONFIG_INPUT_MOUSEDEV_PSAUX is not set  CONFIG_INPUT_EVDEV=y
>CONFIG_INPUT_EVBUG=m  CONFIG_KEYBOARD_GPIO=y @@ -376,7 +376,6
>@@ CONFIG_NLS_ISO8859_1=y  CONFIG_NLS_ISO8859_15=m
>CONFIG_NLS_UTF8=y  CONFIG_PRINTK_TIME=y -CONFIG_DEBUG_FS=y
>CONFIG_MAGIC_SYSRQ=y  # CONFIG_SCHED_DEBUG is not set
>CONFIG_PROVE_LOCKING=y
>--
>2.7.4

Acked-by: Fugang Duan <fugang.duan@nxp.com>
