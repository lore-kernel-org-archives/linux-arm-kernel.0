From: dongas86@gmail.com (Dong Aisheng)
Date: Fri, 24 Mar 2017 14:43:18 +0800
Subject: [PATCH] ARM: imx_v6_v7_defconfig: Select SMSC_PHY
In-Reply-To: <82d0aeeaed87ae5c9390b889cef4c54d715cde61.1490191972.git.leonard.crestez@nxp.com>
References: <82d0aeeaed87ae5c9390b889cef4c54d715cde61.1490191972.git.leonard.crestez@nxp.com>
Message-ID: <20170324064318.GD12604@b29396-OptiPlex-7040>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Leonard,

On Wed, Mar 22, 2017 at 04:27:37PM +0200, Leonard Crestez wrote:
> The imx6sl-evk board has a LAN8720A ethernet phy supported by SMSC_PHY.
> Add this driver to the default imx config since the device is present on
> one of the evaluation boards.

Upstream currently no evaluation board support.

This may leave to Shawn to decide whether apply it.

> 
> This used to work mostly fine with the generic phy driver but since
> commit 0878fff1f42c18e448ab5b8b4f6a3eb32365b5b6 that driver no longer

I guess you should get a checkpatch error here.

> performs a soft reset on startup. This causes netboot to sometimes
> timeout on DHCP because RX doesn't work right. DHCP is eventually retried and

Probably another checkpatch warning.

> it works the second time but it takes 90+ seconds to get a login prompt.
> 
> This was generated with "make savedefconfig" and it includes a few
> additional minor cleanups.
> 

It is a bit strange, after apply your patch, i still get a lot difference
as follows when savedefconfig:
diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index bb6fa56..64e5f4b 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -163,9 +163,9 @@ CONFIG_MOUSE_PS2_ELANTECH=y
 CONFIG_INPUT_TOUCHSCREEN=y
 CONFIG_TOUCHSCREEN_ADS7846=y
 CONFIG_TOUCHSCREEN_EGALAX=y
+CONFIG_TOUCHSCREEN_MAX11801=y
 CONFIG_TOUCHSCREEN_IMX6UL_TSC=y
 CONFIG_TOUCHSCREEN_EDT_FT5X06=y
-CONFIG_TOUCHSCREEN_MAX11801=y
 CONFIG_TOUCHSCREEN_MC13783=y
 CONFIG_TOUCHSCREEN_TSC2004=y
 CONFIG_TOUCHSCREEN_TSC2007=y
@@ -174,7 +174,6 @@ CONFIG_TOUCHSCREEN_SX8654=y
 CONFIG_TOUCHSCREEN_COLIBRI_VF50=y
 CONFIG_INPUT_MISC=y
 CONFIG_INPUT_MMA8450=y
-CONFIG_HID_MULTITOUCH=y
 CONFIG_SERIO_SERPORT=m
 # CONFIG_LEGACY_PTYS is not set
 CONFIG_SERIAL_IMX=y
@@ -268,6 +267,7 @@ CONFIG_SND_SOC_CS42XX8_I2C=y
 CONFIG_SND_SOC_TLV320AIC3X=y
 CONFIG_SND_SOC_WM8960=y
 CONFIG_SND_SIMPLE_CARD=y
+CONFIG_HID_MULTITOUCH=y
 CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_MXC=y

I don't know what's wrong. Toolchains difference?
Quite strange...

Regards
Dong Aisheng

> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
> 
> I also tried to do some debugging in the fec driver and it apparently receives
> corrupted packets when this happens. If I hack it to go into promiscuous mode
> unconditionally it gets a whole bunch of rx errors (crc errors, length errors
> and so on). So the phy config is probably wrong and is confusing the mac?
> 
> In theory it might be possible to make that driver "just work" with phy
> settings from uboot but it's not clear it's worthwhile.
> 
>  arch/arm/configs/imx_v6_v7_defconfig | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
> index eaba3b1..e605389 100644
> --- a/arch/arm/configs/imx_v6_v7_defconfig
> +++ b/arch/arm/configs/imx_v6_v7_defconfig
> @@ -143,6 +143,7 @@ CONFIG_SMSC911X=y
>  # CONFIG_NET_VENDOR_STMICRO is not set
>  CONFIG_AT803X_PHY=y
>  CONFIG_MICREL_PHY=y
> +CONFIG_SMSC_PHY=y
>  CONFIG_USB_PEGASUS=m
>  CONFIG_USB_RTL8150=m
>  CONFIG_USB_RTL8152=m
> @@ -152,7 +153,6 @@ CONFIG_BRCMFMAC=m
>  CONFIG_WL12XX=m
>  CONFIG_WLCORE_SDIO=m
>  # CONFIG_WILINK_PLATFORM_DATA is not set
> -# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
>  CONFIG_INPUT_EVDEV=y
>  CONFIG_INPUT_EVBUG=m
>  CONFIG_KEYBOARD_GPIO=y
> @@ -376,7 +376,6 @@ CONFIG_NLS_ISO8859_1=y
>  CONFIG_NLS_ISO8859_15=m
>  CONFIG_NLS_UTF8=y
>  CONFIG_PRINTK_TIME=y
> -CONFIG_DEBUG_FS=y
>  CONFIG_MAGIC_SYSRQ=y
>  # CONFIG_SCHED_DEBUG is not set
>  CONFIG_PROVE_LOCKING=y
> -- 
> 2.7.4
> 
