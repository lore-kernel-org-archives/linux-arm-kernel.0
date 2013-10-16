From: HartleyS@visionengravers.com (Hartley Sweeten)
Date: Wed, 16 Oct 2013 01:08:06 +0000
Subject: [PATCH v2] usb: ohci: remove ep93xx bus glue platform driver
In-Reply-To: <525DE460.1070107@gmail.com>
References: <201310151747.37003.hartleys@visionengravers.com>
 <525DE460.1070107@gmail.com>
Message-ID: <DC148C5AA1CEBA4E87973D432B1C2D8817DAE2B4@P3PWEX4MB008.ex4.secureserver.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, October 15, 2013 5:57 PM, Ryan Mallon wrote:
> On 16/10/13 11:47, H Hartley Sweeten wrote:
>> Convert ep93xx to use the OHCI platform driver and remove the
>> ohci-ep93xx bus glue driver.
>> 
>> Enable CONFIG_OHCI_HCD_PLATFORM and refresh the ep93xx_defconfig
>> so that USB is still enabled by default on the EP93xx platform.
>> 
>> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
>> Cc: Alan Stern <stern@rowland.harvard.edu>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Ryan Mallon <rmallon@gmail.com>
>> Cc: Olof Johansson <olof@lixom.net>
>> ---
>> v2: Use the (*power_off) callback for (*power_suspend), as suggested
>>     by Alan Stern.
>>     Remove the Kconfig change to USB_OHCI_HCD_PLATFORM and refresh
>>     the ep93xx_defconfig to enable this option, as suggested by Alan Stern.
>> 
>>  arch/arm/configs/ep93xx_defconfig |  17 +---
>>  arch/arm/mach-ep93xx/clock.c      |   2 +-
>>  arch/arm/mach-ep93xx/core.c       |  40 ++++++++-
>>  drivers/usb/host/ohci-ep93xx.c    | 184 --------------------------------------
>>  drivers/usb/host/ohci-hcd.c       |  18 ----
>>  5 files changed, 40 insertions(+), 221 deletions(-)
>>  delete mode 100644 drivers/usb/host/ohci-ep93xx.c
>> 
>> diff --git a/arch/arm/configs/ep93xx_defconfig b/arch/arm/configs/ep93xx_defconfig
>> index 806005a..6ac5ea7 100644
>> --- a/arch/arm/configs/ep93xx_defconfig
>> +++ b/arch/arm/configs/ep93xx_defconfig
>> @@ -1,15 +1,14 @@
>> -CONFIG_EXPERIMENTAL=y
>>  CONFIG_SYSVIPC=y
>>  CONFIG_IKCONFIG=y
>>  CONFIG_IKCONFIG_PROC=y
>>  CONFIG_LOG_BUF_SHIFT=14
>> -CONFIG_SYSFS_DEPRECATED_V2=y
>>  CONFIG_EXPERT=y
>>  CONFIG_SLAB=y
>>  CONFIG_MODULES=y
>>  CONFIG_MODULE_UNLOAD=y
>>  CONFIG_MODULE_FORCE_UNLOAD=y
>>  # CONFIG_BLK_DEV_BSG is not set
>> +CONFIG_PARTITION_ADVANCED=y
>>  # CONFIG_IOSCHED_CFQ is not set
>>  CONFIG_ARCH_EP93XX=y
>>  CONFIG_CRUNCH=y
>> @@ -47,11 +46,8 @@ CONFIG_IPV6=y
>>  CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
>>  # CONFIG_FW_LOADER is not set
>>  CONFIG_MTD=y
>> -CONFIG_MTD_CONCAT=y
>> -CONFIG_MTD_PARTITIONS=y
>>  CONFIG_MTD_REDBOOT_PARTS=y
>>  CONFIG_MTD_CMDLINE_PARTS=y
>> -CONFIG_MTD_CHAR=y
>>  CONFIG_MTD_BLOCK=y
>>  CONFIG_MTD_CFI=y
>>  CONFIG_MTD_CFI_ADV_OPTIONS=y
>> @@ -67,15 +63,14 @@ CONFIG_SCSI=y
>>  # CONFIG_SCSI_PROC_FS is not set
>>  CONFIG_BLK_DEV_SD=y
>>  CONFIG_NETDEVICES=y
>> -CONFIG_NET_ETHERNET=y
>>  CONFIG_EP93XX_ETH=y
>>  CONFIG_USB_RTL8150=y
>>  # CONFIG_INPUT is not set
>>  # CONFIG_SERIO is not set
>>  # CONFIG_VT is not set
>> +# CONFIG_LEGACY_PTYS is not set
>>  CONFIG_SERIAL_AMBA_PL010=y
>>  CONFIG_SERIAL_AMBA_PL010_CONSOLE=y
>> -# CONFIG_LEGACY_PTYS is not set
>>  # CONFIG_HW_RANDOM is not set
>>  CONFIG_I2C=y
>>  CONFIG_I2C_CHARDEV=y
>> @@ -86,9 +81,9 @@ CONFIG_WATCHDOG=y
>>  CONFIG_EP93XX_WATCHDOG=y
>>  CONFIG_USB=y
>>  CONFIG_USB_DEBUG=y
>> -CONFIG_USB_DEVICEFS=y
>>  CONFIG_USB_DYNAMIC_MINORS=y
>>  CONFIG_USB_OHCI_HCD=y
>> +CONFIG_USB_OHCI_HCD_PLATFORM=y
>>  CONFIG_USB_STORAGE=y
>>  CONFIG_USB_SERIAL=y
>>  CONFIG_USB_SERIAL_CONSOLE=y
>> @@ -100,24 +95,18 @@ CONFIG_RTC_DRV_EP93XX=y
>>  CONFIG_EXT2_FS=y
>>  CONFIG_EXT3_FS=y
>>  # CONFIG_EXT3_FS_XATTR is not set
>> -CONFIG_INOTIFY=y
>>  CONFIG_VFAT_FS=y
>>  CONFIG_TMPFS=y
>>  CONFIG_JFFS2_FS=y
>>  CONFIG_NFS_FS=y
>> -CONFIG_NFS_V3=y
>>  CONFIG_ROOT_NFS=y
>> -CONFIG_PARTITION_ADVANCED=y
>>  CONFIG_NLS_CODEPAGE_437=y
>>  CONFIG_NLS_ISO8859_1=y
>>  CONFIG_MAGIC_SYSRQ=y
>> -CONFIG_DEBUG_KERNEL=y
>>  CONFIG_DEBUG_SLAB=y
>>  CONFIG_DEBUG_SPINLOCK=y
>>  CONFIG_DEBUG_MUTEXES=y
>> -# CONFIG_RCU_CPU_STALL_DETECTOR is not set
>>  CONFIG_DEBUG_USER=y
>> -CONFIG_DEBUG_ERRORS=y
>>  CONFIG_DEBUG_LL=y
>>  # CONFIG_CRYPTO_ANSI_CPRNG is not set
>>  CONFIG_LIBCRC32C=y
>
> Gah, defconfig changes are a pest. I assume the other removed options
> are implicitly selected, and their removal is the result of
> re-minimising the defconfig? Can you put a note about this is the
> changelog please.

Yah... It's a mess.

All I did was:
make ARCH=arm ep93xx_defconfig
make ARCH=arm menuconfig		# enable USB_OHCI_HCD_PLATFORM
make ARCH=arm savedefconfig
mv defconfig arch/arm/configs/ep93xx_defconfig

Looks like the last time the ep93xx_defconfig was refreshed was:

commit 07a8c03f3e06129e847acd068b8b89c13357ee64
Author: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Date:   Thu Jun 10 07:12:18 2010 +0200

    ARM: reduce defconfigs

Hence the ugly changes.

>> +static struct clk *ep93xx_ohci_host_clock;
>> +
>> +static int ep93xx_ohci_power_on(struct platform_device *pdev)
>> +{
>> +	if (!ep93xx_ohci_host_clock) {
>> +		ep93xx_ohci_host_clock = devm_clk_get(&pdev->dev, NULL);
>> +		if (IS_ERR(ep93xx_ohci_host_clock))
>> +			return PTR_ERR(ep93xx_ohci_host_clock);
>> +	}
>> +
>> +	clk_enable(ep93xx_ohci_host_clock);
>> +
>> +	return 0;
>
> Nit:
>
>	return clk_enable(ep93xx_ohci_host_clock);

Ah, good catch. I'll post a v3 tomorrow in case there are any other comments.

Thanks,
Hartley
