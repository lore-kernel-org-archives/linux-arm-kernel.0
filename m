From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 20 Apr 2018 11:00:44 +0200
Subject: [PATCH v2] ARM: defconfig: Update Gemini defconfig
Message-ID: <20180420090044.17036-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This updates the Gemini defconfig with a config that will bring
up most of the recently merged and updated devices to some
functional level:

- We enable high resolution timers (the right thing to do)
- Enable CMA for the framebuffer, and the new TVE200
  framebuffer driver and the Ilitek ILI9322 driver for
  graphics on the D-Link DIR-685. HIGHMEM support comes in
  as part of this.
- Enable networking and the new Cortina Gemini ethernet
  driver.
- Enable MDIO over GPIO and the Realtek PHY devices used on
  several of these systems.
- Enable I2C over GPIO and SPI over GPIO which is used on
  several of these devices.
- Enable the Thermal framework, GPIO fan control and LM75 sensor
  adding cooling on the D-Link DNS-313 with no userspace
  involved even if only the kernel is working, rock solid
  thermal for this platform.
- Enable JEDEC flash probing to support the Eon flash chip in
  D-Link DNS-313.
- Enable LED disk triggers for the NAS type devices.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- This update didn't get applied for v4.16 so we gained even
  more stuff in v4.17
- Drop the wireless devices: it is better if people configure
  those in themselves, and it is also what OpenWRT does.
- Drop UHCI and EHCI configs as these may conflict with the
  SoC intrinsic FTOTG adapter.

ARM SoC folks: please apply this for fixes.
---
 arch/arm/configs/gemini_defconfig | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/gemini_defconfig b/arch/arm/configs/gemini_defconfig
index 2a63fa10c813..553777ac2814 100644
--- a/arch/arm/configs/gemini_defconfig
+++ b/arch/arm/configs/gemini_defconfig
@@ -1,6 +1,7 @@
 # CONFIG_LOCALVERSION_AUTO is not set
 CONFIG_SYSVIPC=y
 CONFIG_NO_HZ_IDLE=y
+CONFIG_HIGH_RES_TIMERS=y
 CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_USER_NS=y
 CONFIG_RELAY=y
@@ -12,15 +13,21 @@ CONFIG_ARCH_GEMINI=y
 CONFIG_PCI=y
 CONFIG_PREEMPT=y
 CONFIG_AEABI=y
+CONFIG_HIGHMEM=y
+CONFIG_CMA=y
 CONFIG_CMDLINE="console=ttyS0,115200n8"
 CONFIG_KEXEC=y
 CONFIG_BINFMT_MISC=y
 CONFIG_PM=y
+CONFIG_NET=y
+CONFIG_UNIX=y
+CONFIG_INET=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
 CONFIG_MTD=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CFI=y
+CONFIG_MTD_JEDECPROBE=y
 CONFIG_MTD_CFI_INTELEXT=y
 CONFIG_MTD_CFI_AMDSTD=y
 CONFIG_MTD_CFI_STAA=y
@@ -33,6 +40,11 @@ CONFIG_BLK_DEV_SD=y
 # CONFIG_SCSI_LOWLEVEL is not set
 CONFIG_ATA=y
 CONFIG_PATA_FTIDE010=y
+CONFIG_NETDEVICES=y
+CONFIG_GEMINI_ETHERNET=y
+CONFIG_MDIO_BITBANG=y
+CONFIG_MDIO_GPIO=y
+CONFIG_REALTEK_PHY=y
 CONFIG_INPUT_EVDEV=y
 CONFIG_KEYBOARD_GPIO=y
 # CONFIG_INPUT_MOUSE is not set
@@ -43,9 +55,19 @@ CONFIG_SERIAL_8250_NR_UARTS=1
 CONFIG_SERIAL_8250_RUNTIME_UARTS=1
 CONFIG_SERIAL_OF_PLATFORM=y
 # CONFIG_HW_RANDOM is not set
-# CONFIG_HWMON is not set
+CONFIG_I2C_GPIO=y
+CONFIG_SPI=y
+CONFIG_SPI_GPIO=y
+CONFIG_SENSORS_GPIO_FAN=y
+CONFIG_SENSORS_LM75=y
+CONFIG_THERMAL=y
 CONFIG_WATCHDOG=y
-CONFIG_GEMINI_WATCHDOG=y
+CONFIG_REGULATOR=y
+CONFIG_REGULATOR_FIXED_VOLTAGE=y
+CONFIG_DRM=y
+CONFIG_DRM_PANEL_ILITEK_IL9322=y
+CONFIG_DRM_TVE200=y
+CONFIG_LOGO=y
 CONFIG_USB=y
 CONFIG_USB_MON=y
 CONFIG_USB_FOTG210_HCD=y
@@ -54,6 +76,7 @@ CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
 CONFIG_LEDS_GPIO=y
 CONFIG_LEDS_TRIGGERS=y
+CONFIG_LEDS_TRIGGER_DISK=y
 CONFIG_LEDS_TRIGGER_HEARTBEAT=y
 CONFIG_RTC_CLASS=y
 CONFIG_DMADEVICES=y
-- 
2.14.3
