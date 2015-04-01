From: dinguyen@opensource.altera.com (Dinh Nguyen)
Date: Wed, 1 Apr 2015 09:50:55 -0500
Subject: [RESEND] Altera socfpga big endian work
In-Reply-To: <551BCD77.6060906@codethink.co.uk>
References: <1427282872-10563-1-git-send-email-ben.dooks@codethink.co.uk>
 <551AAB9D.1000809@opensource.altera.com> <551ABE7D.4090908@codethink.co.uk>
 <551ADDA0.5010500@opensource.altera.com> <551BCD77.6060906@codethink.co.uk>
Message-ID: <551C05CF.2000809@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/01/2015 05:50 AM, Ben Dooks wrote:
> On 31/03/15 18:47, Dinh Nguyen wrote:
>>
>>
>> On 3/31/15 10:34 AM, Ben Dooks wrote:
>>> On 31/03/15 15:13, Dinh Nguyen wrote:
>>>> Hi Ben,
>>>>
>>>> On 3/25/15 6:27 AM, Ben Dooks wrote:
>>>>> This series enables the core of the socfpga systen to run in big endian
>>>>> mode. It inclusdes support for debug uart, secondary core boot and has
>>>>> support for timers and initial conversion patches for the mmc.
>>>>>
>>>>> The two drivers that are known to not work are the Ethernet and the
>>>>> dwc2 usb. I do not have data for either, so I currently do not know
>>>>> if it possible to change the hardware's endian fetch mode.
>>>>>
>>>>> The dwc2 driver on my cyclone5 socfpga board with v4.0-rc5 does not
>>>>> work in little endian mode, which makes testing converting the driver
>>>>> difficult. The supplied 3.10 kernel does work so it is not down to the
>>>>> hardware. It detects the presence of a new device and then fails to
>>>>> enumerate it (no other errors shown)
>>>>>
>>>>> This is up on git.baserock.org/delta/linux.git in the branch
>>>>> baserock/bjdooks/socfpga-v5
>>>>>
>>>>> Sorry, this is a resend due to incorrect linux-arm-kernel mailing list
>>>>> address.
>>>>>
>>>>
>>>> I think I can take patches 1-3 through my tree, but the mmc patches
>>>> [4-7] will need to linux-mmc tree.
>>>
>>> Thanks. I did CC 4-7 to the relevant maintainers.
>>>
>>> Any idea if dwc2 is going to be fixed before 4.1?
>>>
>>>
>>
>> I'll have to double check again, but I thought dwc2 on the socfpga has
>> been work fine for quite some time now. What are the errors that you are
>> seeing?
> 
> With 4.0-rc5 it failed to enumerate a USB memory stick attached to
> the board. It looked like VCC was supplied. We know the adapter is
> working as it comes up under the default boot supplied on the board.
> 

Hmm...4.0-rc6's USB is working fine on my devkit:

socfpga_cyclone5 login: [   74.933518] usb 1-1: new high-speed USB
device number 2 using dwc2
[   75.144505] usb-storage 1-1:1.0: USB Mass Storage device detected
[   75.150873] scsi host0: usb-storage 1-1:1.0
[   76.154413] scsi 0:0:0:0: Direct-Access     SanDisk  Ultra
 1.26 PQ: 0 ANSI: 5
[   76.164091] sd 0:0:0:0: [sda] 31266816 512-byte logical blocks: (16.0
GB/14.9 GiB)
[   76.172386] sd 0:0:0:0: [sda] Write Protect is off
[   76.177645] sd 0:0:0:0: [sda] Write cache: disabled, read cache:
enabled, doesn't support DPO or FUA
[   76.194265]  sda: sda1
[   76.198088] sd 0:0:0:0: [sda] Attached SCSI removable disk
root
root at socfpga_cyclone5:~# uname -a
Linux socfpga_cyclone5 4.0.0-rc6-00009-g6c310bc #1 SMP Wed Apr 1
09:46:55 CDT 2015 armv7l GNU/Linux
root at socfpga_cyclone5:~#

Attached is my defconfig...

Dinh

-------------- next part --------------
CONFIG_SYSVIPC=y
CONFIG_FHANDLE=y
CONFIG_HIGH_RES_TIMERS=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_LOG_BUF_SHIFT=14
CONFIG_CGROUPS=y
CONFIG_CPUSETS=y
CONFIG_NAMESPACES=y
CONFIG_EMBEDDED=y
CONFIG_PROFILING=y
CONFIG_OPROFILE=y
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_LBDAF is not set
# CONFIG_BLK_DEV_BSG is not set
# CONFIG_IOSCHED_DEADLINE is not set
# CONFIG_IOSCHED_CFQ is not set
CONFIG_ARCH_SOCFPGA=y
CONFIG_ARM_THUMBEE=y
CONFIG_SMP=y
CONFIG_NR_CPUS=2
CONFIG_AEABI=y
CONFIG_ZBOOT_ROM_TEXT=0x0
CONFIG_ZBOOT_ROM_BSS=0x0
CONFIG_VFP=y
CONFIG_NEON=y
CONFIG_NET=y
CONFIG_PACKET=y
CONFIG_UNIX=y
CONFIG_NET_KEY=y
CONFIG_NET_KEY_MIGRATE=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
CONFIG_IP_PNP_BOOTP=y
CONFIG_IP_PNP_RARP=y
CONFIG_IPV6=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
CONFIG_VLAN_8021Q=y
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_CAN=y
CONFIG_CAN_C_CAN=y
CONFIG_CAN_C_CAN_PLATFORM=y
CONFIG_CAN_DEBUG_DEVICES=y
CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_COUNT=2
CONFIG_BLK_DEV_RAM_SIZE=8192
CONFIG_SRAM=y
CONFIG_SCSI=y
# CONFIG_SCSI_PROC_FS is not set
CONFIG_BLK_DEV_SD=y
# CONFIG_SCSI_LOWLEVEL is not set
CONFIG_NETDEVICES=y
CONFIG_STMMAC_ETH=y
CONFIG_MICREL_PHY=y
CONFIG_INPUT_EVDEV=y
# CONFIG_SERIO_SERPORT is not set
CONFIG_SERIO_AMBAKMI=y
CONFIG_LEGACY_PTY_COUNT=16
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_NR_UARTS=2
CONFIG_SERIAL_8250_RUNTIME_UARTS=2
CONFIG_SERIAL_8250_DW=y
CONFIG_I2C=y
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_DESIGNWARE_PLATFORM=y
CONFIG_GPIOLIB=y
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_DWAPB=y
CONFIG_PMBUS=y
CONFIG_SENSORS_LTC2978=y
CONFIG_SENSORS_LTC2978_REGULATOR=y
CONFIG_WATCHDOG=y
CONFIG_DW_WATCHDOG=y
CONFIG_REGULATOR=y
CONFIG_REGULATOR_FIXED_VOLTAGE=y
CONFIG_USB=y
CONFIG_USB_STORAGE=y
CONFIG_USB_DWC2=y
CONFIG_MMC=y
CONFIG_MMC_DW=y
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
CONFIG_EXT3_FS=y
CONFIG_EXT4_FS=y
CONFIG_VFAT_FS=y
CONFIG_NTFS_FS=y
CONFIG_NTFS_RW=y
CONFIG_TMPFS=y
CONFIG_CONFIGFS_FS=y
CONFIG_NFS_FS=y
CONFIG_ROOT_NFS=y
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_ISO8859_1=y
CONFIG_PRINTK_TIME=y
CONFIG_DEBUG_INFO=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_DETECT_HUNG_TASK=y
# CONFIG_SCHED_DEBUG is not set
CONFIG_ENABLE_DEFAULT_TRACERS=y
CONFIG_DEBUG_USER=y
CONFIG_XZ_DEC=y
