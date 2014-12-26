From: balbi@ti.com (Felipe Balbi)
Date: Fri, 26 Dec 2014 10:26:18 -0600
Subject: [PATCH] arm: omap: reduce zImage size on omap2plus_defconfig
In-Reply-To: <20141226161349.GC12409@atomide.com>
References: <1419271535-4057-1-git-send-email-balbi@ti.com>
 <54991A25.2030804@compulab.co.il> <20141223161936.GA9147@saruman>
 <549AA94A.8030209@compulab.co.il> <20141224154948.GA423@saruman>
 <20141224190401.GN23854@atomide.com>
 <549BE333.9060709@compulab.co.il> <549D5CC0.2090408@linaro.org>
 <20141226152620.GF17430@saruman>
 <20141226161349.GC12409@atomide.com>
Message-ID: <20141226162618.GJ17430@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 26, 2014 at 08:13:49AM -0800, Tony Lindgren wrote:
> * Felipe Balbi <balbi@ti.com> [141226 07:29]:
> > On Fri, Dec 26, 2014 at 03:04:00PM +0200, Grygorii.Strashko at linaro.org wrote:
> > > >>>
> > > >>> Tony, your call
> > > 
> > > May be it will be good thing to split this patch. That way more
> > > information will be stored in commit log about which set of options
> > > gives us what benefits.  And also, It will allow to continue with
> > > agreed changes.  ?
> > 
> > can be done, but then again, it's just a defconfig change. Tony, your
> > call.
> > 
> > > >> I think we should move omap2plus_defconfig to be mostly modular and
> > > >> usable for distros as a base. Most distros prefer to build almost
> > > >> everything as loadable modules. And my preference is that we should
> > > >> only keep the minimum rootfs for devices and serial support as
> > > >> built-in and rely on initramfs for most drivers. And slowly move
> > > >> also the remaining built-in drivers to be loadable modules.
> > > >>
> > > >> The reasons for having drivers as loadable modules are many. It
> > > >> allows distros to use the same kernel for all the devices without
> > > >> bloating the kernel. It makes developing drivers easier as just the
> > > >> module needs to be reloaded. And loadable modules protect us from
> > > >> cross-framework spaghetti calls in the kernel as the interfaces are
> > > >> clearly defined.
> > > >>
> > > >> Are there people really using SATA as rootfs right now on omaps?
> > > > 
> > > > Yes. That is exactly my point.
> > > > 
> > > 
> > > From my side I'd like to note that I know about few ongoing projects
> > > on DRA7x EVM where SATA is used as rootfs - now It is the fast
> > > possible way to start Android.
> > 
> > now this is something different. This is evidence that there are people
> > relying on SATA on rootfs. I'll leave to Tony again.
> 
> OK sounds like people are really using SATA as rootfs, so we might as
> well keep it built in then. And it does not affect the PM on the devices
> that do have PM working, that has been a problem with having some
> drivers built-in.
> 
> We can still work towards making the current rootfs device drivers
> into loadable modules in the long term :)

Here's v3:

8<-----------------------------------------------------------------------

>From 7e6d99cedb12004bad1205bbaf556ebf3db0f730 Mon Sep 17 00:00:00 2001
From: Felipe Balbi <balbi@ti.com>
Date: Mon, 22 Dec 2014 11:56:27 -0600
Subject: [PATCH v3] arm: omap: reduce zImage size on omap2plus_defconfig

By converting a few drivers to modules because they
won't be needed during boot anyways, we can shave off
about 700KiB of text.

Note that while at that, and after discussions with Tony
Lindgren, a few extra drivers were either removed because
they weren't needed, or added because they're useful for
debugging/testing.

Below is output of size for pre and post vmlinux binaries:

   text    data     bss     dec     hex filename
8514799  765532 8416064 17696395        10e068b vmlinux-post-patch
9069110  800316 8419072 18288498        1170f72 vmlinux-pre-patch

Signed-off-by: Felipe Balbi <balbi@ti.com>
---

changes since v1:
        - leave TWL4030 gpio alone

changes since v2:
	- leave SATA as built-in

 arch/arm/configs/omap2plus_defconfig | 116 ++++++++++++++++++++++-------------
 1 file changed, 72 insertions(+), 44 deletions(-)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index c2c3a85..efb0810 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -13,7 +13,6 @@ CONFIG_CGROUP_FREEZER=y
 CONFIG_CGROUP_DEVICE=y
 CONFIG_CPUSETS=y
 CONFIG_CGROUP_CPUACCT=y
-CONFIG_RESOURCE_COUNTERS=y
 CONFIG_MEMCG=y
 CONFIG_MEMCG_SWAP=y
 CONFIG_MEMCG_KMEM=y
@@ -68,7 +67,6 @@ CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
 CONFIG_CPU_FREQ_GOV_POWERSAVE=y
 CONFIG_CPU_FREQ_GOV_USERSPACE=y
 CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
-CONFIG_GENERIC_CPUFREQ_CPU0=y
 # CONFIG_ARM_OMAP2PLUS_CPUFREQ is not set
 CONFIG_CPU_IDLE=y
 CONFIG_BINFMT_MISC=y
@@ -103,7 +101,7 @@ CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_DMA_CMA=y
 CONFIG_OMAP_OCP2SCP=y
-CONFIG_CONNECTOR=y
+CONFIG_CONNECTOR=m
 CONFIG_MTD=y
 CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_BLOCK=y
@@ -122,14 +120,12 @@ CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=16384
 CONFIG_SENSORS_TSL2550=m
 CONFIG_BMP085_I2C=m
-CONFIG_SENSORS_LIS3_I2C=m
 CONFIG_SRAM=y
-CONFIG_SCSI=y
+CONFIG_SENSORS_LIS3_I2C=m
 CONFIG_BLK_DEV_SD=y
 CONFIG_SCSI_SCAN_ASYNC=y
 CONFIG_ATA=y
 CONFIG_SATA_AHCI_PLATFORM=y
-CONFIG_MD=y
 CONFIG_NETDEVICES=y
 # CONFIG_NET_VENDOR_ARC is not set
 # CONFIG_NET_CADENCE is not set
@@ -154,8 +150,8 @@ CONFIG_TI_CPSW=y
 # CONFIG_NET_VENDOR_WIZNET is not set
 CONFIG_AT803X_PHY=y
 CONFIG_SMSC_PHY=y
-CONFIG_USB_USBNET=y
-CONFIG_USB_NET_SMSC95XX=y
+CONFIG_USB_USBNET=m
+CONFIG_USB_NET_SMSC95XX=m
 CONFIG_USB_ALI_M5632=y
 CONFIG_USB_AN2720=y
 CONFIG_USB_EPSON2888=y
@@ -172,18 +168,22 @@ CONFIG_WLCORE_SDIO=m
 CONFIG_MWIFIEX=m
 CONFIG_MWIFIEX_SDIO=m
 CONFIG_MWIFIEX_USB=m
-CONFIG_INPUT_JOYDEV=y
-CONFIG_INPUT_EVDEV=y
-CONFIG_KEYBOARD_GPIO=y
+CONFIG_INPUT_JOYDEV=m
+CONFIG_INPUT_EVDEV=m
+CONFIG_KEYBOARD_ATKBD=m
+CONFIG_KEYBOARD_GPIO=m
 CONFIG_KEYBOARD_MATRIX=m
-CONFIG_KEYBOARD_TWL4030=y
+CONFIG_KEYBOARD_OMAP4=m
+CONFIG_KEYBOARD_TWL4030=m
+# CONFIG_INPUT_MOUSE is not set
 CONFIG_INPUT_TOUCHSCREEN=y
 CONFIG_TOUCHSCREEN_ADS7846=m
 CONFIG_TOUCHSCREEN_EDT_FT5X06=m
 CONFIG_TOUCHSCREEN_TSC2005=m
 CONFIG_TOUCHSCREEN_TSC2007=m
 CONFIG_INPUT_MISC=y
-CONFIG_INPUT_TWL4030_PWRBUTTON=y
+CONFIG_INPUT_TWL4030_PWRBUTTON=m
+CONFIG_SERIO=m
 # CONFIG_LEGACY_PTYS is not set
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
@@ -196,15 +196,16 @@ CONFIG_SERIAL_8250_RSA=y
 CONFIG_SERIAL_OF_PLATFORM=y
 CONFIG_SERIAL_OMAP=y
 CONFIG_SERIAL_OMAP_CONSOLE=y
-CONFIG_HW_RANDOM=y
 CONFIG_I2C_CHARDEV=y
 CONFIG_SPI=y
 CONFIG_SPI_OMAP24XX=y
+CONFIG_SPI_TI_QSPI=m
 CONFIG_PINCTRL_SINGLE=y
 CONFIG_DEBUG_GPIO=y
 CONFIG_GPIO_SYSFS=y
 CONFIG_GPIO_TWL4030=y
-CONFIG_W1=y
+CONFIG_W1=m
+CONFIG_HDQ_MASTER_OMAP=m
 CONFIG_BATTERY_BQ27x00=m
 CONFIG_CHARGER_ISP1704=m
 CONFIG_CHARGER_TWL4030=m
@@ -213,20 +214,21 @@ CONFIG_CHARGER_BQ24190=m
 CONFIG_CHARGER_BQ24735=m
 CONFIG_POWER_RESET=y
 CONFIG_POWER_AVS=y
+CONFIG_HWMON=m
 CONFIG_SENSORS_LM75=m
-CONFIG_THERMAL=y
+CONFIG_SENSORS_TMP102=m
+CONFIG_THERMAL=m
 CONFIG_THERMAL_GOV_FAIR_SHARE=y
 CONFIG_THERMAL_GOV_USER_SPACE=y
 CONFIG_CPU_THERMAL=y
-CONFIG_TI_SOC_THERMAL=y
+CONFIG_TI_SOC_THERMAL=m
 CONFIG_TI_THERMAL=y
 CONFIG_OMAP4_THERMAL=y
 CONFIG_OMAP5_THERMAL=y
 CONFIG_DRA752_THERMAL=y
 CONFIG_WATCHDOG=y
-CONFIG_OMAP_WATCHDOG=y
-CONFIG_TWL4030_WATCHDOG=y
-CONFIG_MFD_SYSCON=y
+CONFIG_OMAP_WATCHDOG=m
+CONFIG_TWL4030_WATCHDOG=m
 CONFIG_MFD_PALMAS=y
 CONFIG_MFD_TPS65217=y
 CONFIG_MFD_TPS65218=y
@@ -289,51 +291,77 @@ CONFIG_SND_OMAP_SOC=m
 CONFIG_SND_OMAP_SOC_OMAP_TWL4030=m
 CONFIG_SND_OMAP_SOC_OMAP_ABE_TWL6040=m
 CONFIG_SND_OMAP_SOC_OMAP3_PANDORA=m
-CONFIG_USB=y
+CONFIG_HID_GENERIC=m
+CONFIG_USB_HIDDEV=y
+CONFIG_USB_KBD=m
+CONFIG_USB_MOUSE=m
+CONFIG_USB=m
 CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
-CONFIG_USB_MON=y
+CONFIG_USB_MON=m
 CONFIG_USB_XHCI_HCD=m
-CONFIG_USB_WDM=y
-CONFIG_USB_STORAGE=y
+CONFIG_USB_WDM=m
+CONFIG_USB_STORAGE=m
+CONFIG_USB_MUSB_HDRC=m
+CONFIG_USB_MUSB_OMAP2PLUS=m
+CONFIG_USB_MUSB_AM35X=m
+CONFIG_USB_MUSB_DSPS=m
 CONFIG_USB_DWC3=m
-CONFIG_USB_TEST=y
+CONFIG_USB_TEST=m
 CONFIG_AM335X_PHY_USB=y
-CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET=m
 CONFIG_USB_GADGET_DEBUG=y
 CONFIG_USB_GADGET_DEBUG_FILES=y
 CONFIG_USB_GADGET_DEBUG_FS=y
+CONFIG_USB_CONFIGFS=m
+CONFIG_USB_CONFIGFS_SERIAL=y
+CONFIG_USB_CONFIGFS_ACM=y
+CONFIG_USB_CONFIGFS_OBEX=y
+CONFIG_USB_CONFIGFS_NCM=y
+CONFIG_USB_CONFIGFS_ECM=y
+CONFIG_USB_CONFIGFS_ECM_SUBSET=y
+CONFIG_USB_CONFIGFS_RNDIS=y
+CONFIG_USB_CONFIGFS_EEM=y
+CONFIG_USB_CONFIGFS_MASS_STORAGE=y
+CONFIG_USB_CONFIGFS_F_LB_SS=y
+CONFIG_USB_CONFIGFS_F_FS=y
+CONFIG_USB_CONFIGFS_F_UAC1=y
+CONFIG_USB_CONFIGFS_F_UAC2=y
+CONFIG_USB_CONFIGFS_F_MIDI=y
+CONFIG_USB_CONFIGFS_F_HID=y
 CONFIG_USB_ZERO=m
 CONFIG_MMC=y
 CONFIG_SDIO_UART=y
 CONFIG_MMC_OMAP=y
 CONFIG_MMC_OMAP_HS=y
 CONFIG_NEW_LEDS=y
-CONFIG_LEDS_CLASS=y
-CONFIG_LEDS_GPIO=y
+CONFIG_LEDS_CLASS=m
+CONFIG_LEDS_GPIO=m
 CONFIG_LEDS_TRIGGERS=y
-CONFIG_LEDS_TRIGGER_TIMER=y
-CONFIG_LEDS_TRIGGER_ONESHOT=y
-CONFIG_LEDS_TRIGGER_HEARTBEAT=y
-CONFIG_LEDS_TRIGGER_BACKLIGHT=y
+CONFIG_LEDS_TRIGGER_TIMER=m
+CONFIG_LEDS_TRIGGER_ONESHOT=m
+CONFIG_LEDS_TRIGGER_HEARTBEAT=m
+CONFIG_LEDS_TRIGGER_BACKLIGHT=m
 CONFIG_LEDS_TRIGGER_CPU=y
-CONFIG_LEDS_TRIGGER_GPIO=y
-CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
+CONFIG_LEDS_TRIGGER_GPIO=m
+CONFIG_LEDS_TRIGGER_DEFAULT_ON=m
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_TWL92330=y
-CONFIG_RTC_DRV_TWL4030=y
-CONFIG_RTC_DRV_OMAP=y
+CONFIG_RTC_DRV_TWL4030=m
+CONFIG_RTC_DRV_OMAP=m
 CONFIG_DMADEVICES=y
 CONFIG_TI_EDMA=y
 CONFIG_DMA_OMAP=y
-CONFIG_EXTCON=y
-CONFIG_EXTCON_PALMAS=y
+# CONFIG_IOMMU_SUPPORT is not set
+CONFIG_EXTCON=m
+CONFIG_EXTCON_PALMAS=m
+CONFIG_TI_EMIF=m
 CONFIG_PWM=y
-CONFIG_PWM_TIECAP=y
-CONFIG_PWM_TIEHRPWM=y
-CONFIG_PWM_TWL=y
-CONFIG_PWM_TWL_LED=y
-CONFIG_OMAP_USB2=y
-CONFIG_TI_PIPE3=y
+CONFIG_PWM_TIECAP=m
+CONFIG_PWM_TIEHRPWM=m
+CONFIG_PWM_TWL=m
+CONFIG_PWM_TWL_LED=m
+CONFIG_OMAP_USB2=m
+CONFIG_TI_PIPE3=m
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
 # CONFIG_EXT3_FS_XATTR is not set
-- 
2.2.0


-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141226/a0fa0eb7/attachment.sig>
