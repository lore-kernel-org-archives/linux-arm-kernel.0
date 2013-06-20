From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Thu, 20 Jun 2013 11:51:23 +0200
Subject: BUG: commit "ARM: Remove __ARCH_WANT_INTERRUPTS_ON_CTXSW on
 pre-ARMv6 CPUs" breaks armv5 with CONFIG_PREEMPT
In-Reply-To: <20130620092527.GD2842@mudshark.cambridge.arm.com>
References: <51C2C0B5.8020802@pengutronix.de>
 <20130620092527.GD2842@mudshark.cambridge.arm.com>
Message-ID: <51C2D09B.3090108@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/20/2013 11:25 AM, Will Deacon wrote:
> On Thu, Jun 20, 2013 at 09:43:33AM +0100, Marc Kleine-Budde wrote:
>> The problem can be reproduced on several mx28 and an at91sam9263 and
>> only occurs of CONFIG_PREEMPT (Preemptible Kernel (Low-Latency Desktop))
>> is enabled.
>>
>> I have the gut feeling that the "if (irqs_disabled())" check in the
>> above patch is not correct for CONFIG_PREEMPT.
>>
>> Marc
>>
>> [1] The test program creating 150 threads in a row crashes like this:
>>> [8]+  Segmentation fault         ./thread_test_c
>>> [5]   Illegal instruction        ./thread_test_c
>>> [4]   Illegal instruction        ./thread_test_c
>>> [2]   Segmentation fault         ./thread_test_c
>>> [3]   Illegal instruction        ./thread_test_c
>>> [1]   Segmentation fault         ./thread_test_c
> 
> Any chance you can make your test available somewhere please? I remember
> testing on a 926 when the patch was written, so it could be a bad
> interaction with some later changes.

Test attached. Nothing fancy. compile with:

    gcc -Wall -O0 main-c.c -o main-c -lpthread -lrt

Then start several (here 16) of these tests in parallel in the background:

> root at halo22:~ ./main-c &
> root at halo22:~ ./main-c &
> root at halo22:~ ./main-c &
> root at halo22:~ ./main-c &
> root at halo22:~ ./main-c &
> root at halo22:~ ./main-c &
> root at halo22:~ ./main-c &
> root at halo22:~ ./main-c &
> root at halo22:~ ./main-c &
> root at halo22:~ ./main-c &
> root at halo22:~ ./main-c &
> root at halo22:~ ./main-c &
> root at halo22:~ ./main-c &
> root at halo22:~ ./main-c &
> root at halo22:~ ./main-c &
> root at halo22:~ ./main-c &
> root at halo22:~
> root at halo22:~ jobs
> [16]+  Running                   ./main-c
> [15]-  Running                   ./main-c
> [14]   Running                   ./main-c
> [13]   Running                   ./main-c
> [12]   Running                   ./main-c
> [11]   Running                   ./main-c
> [10]   Running                   ./main-c
> [9]   Running                    ./main-c
> [8]   Running                    ./main-c
> [7]   Running                    ./main-c
> [6]   Running                    ./main-c
> [5]   Running                    ./main-c
> [4]   Running                    ./main-c
> [3]   Running                    ./main-c
> [2]   Running                    ./main-c
> [1]   Running                    ./main-c
> root at halo22:~ jobs
> [16]+  Running                   ./main-c
> [15]-  Running                   ./main-c
> [14]   Running                   ./main-c
> [13]   Running                   ./main-c
> [12]   Running                   ./main-c
> [11]   Running                   ./main-c
> [10]   Running                   ./main-c
> [9]   Running                    ./main-c
> [8]   Running                    ./main-c
> [7]   Running                    ./main-c
> [6]   Running                    ./main-c
> [5]   Running                    ./main-c
> [4]   Segmentation fault         ./main-c
> [3]   Running                    ./main-c
> [2]   Running                    ./main-c
> [1]   Running                    ./main-c
> root at halo22:~ jobs
> [16]+  Running                   ./main-c
> [15]-  Segmentation fault        ./main-c
> [14]-  Segmentation fault        ./main-c
> [13]-  Running                   ./main-c
> [12]   Running                   ./main-c
> [11]   Segmentation fault        ./main-c
> [10]   Segmentation fault        ./main-c
> [9]   Running                    ./main-c
> [8]   Running                    ./main-c
> [7]   Segmentation fault         ./main-c
> [6]   Illegal instruction        ./main-c
> [5]   Segmentation fault         ./main-c
> [3]   Segmentation fault         ./main-c
> [2]   Illegal instruction        ./main-c
> [1]   Running                    ./main-c
> [16]+  Illegal instruction       ./main-c

However during my tests it shows that it crashes on mx28 (400 MHz)
within seconds, on an at91sam9263 (200 MHx) it takes up to several
minutes. The current number of threads and time is sleeps must hit a
"sweet spot" on an usual mx28.

I have attached the defconfig I used with linus/master on mx28evk.  This
is the basically the arch/arm/configs/mxs_defconfig with preemption
model set to CONFIG_PREEMPT (Preemptible Kernel (Low-Latency Desktop)).

regards,
Marc

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: main-c.c
Type: text/x-csrc
Size: 1906 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130620/1a2634d5/attachment.bin>
-------------- next part --------------
CONFIG_EXPERIMENTAL=y
CONFIG_SYSVIPC=y
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
CONFIG_TASK_IO_ACCOUNTING=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_UTS_NS is not set
# CONFIG_IPC_NS is not set
# CONFIG_PID_NS is not set
# CONFIG_NET_NS is not set
CONFIG_PERF_EVENTS=y
# CONFIG_COMPAT_BRK is not set
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_MODVERSIONS=y
CONFIG_BLK_DEV_INTEGRITY=y
# CONFIG_IOSCHED_DEADLINE is not set
# CONFIG_IOSCHED_CFQ is not set
CONFIG_ARCH_MXS=y
CONFIG_MACH_STMP378X_DEVB=y
CONFIG_MACH_MX23EVK=y
CONFIG_MACH_MX28EVK=y
CONFIG_MACH_TX28=y
CONFIG_MACH_M28EVK=y
# CONFIG_ARM_THUMB is not set
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
CONFIG_PREEMPT=y
CONFIG_AEABI=y
CONFIG_USE_OF=y
CONFIG_AUTO_ZRELADDR=y
CONFIG_FPE_NWFPE=y
CONFIG_NET=y
CONFIG_PACKET=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
CONFIG_SYN_COOKIES=y
# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
# CONFIG_INET_XFRM_MODE_TUNNEL is not set
# CONFIG_INET_XFRM_MODE_BEET is not set
# CONFIG_INET_LRO is not set
# CONFIG_INET_DIAG is not set
# CONFIG_IPV6 is not set
CONFIG_CAN=m
CONFIG_CAN_RAW=m
CONFIG_CAN_BCM=m
CONFIG_CAN_FLEXCAN=m
# CONFIG_WIRELESS is not set
CONFIG_DEVTMPFS=y
# CONFIG_FIRMWARE_IN_KERNEL is not set
# CONFIG_BLK_DEV is not set
CONFIG_NETDEVICES=y
CONFIG_ENC28J60=y
# CONFIG_WLAN is not set
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_EVDEV=m
# CONFIG_INPUT_KEYBOARD is not set
# CONFIG_INPUT_MOUSE is not set
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_TSC2007=m
# CONFIG_SERIO is not set
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_DEVPTS_MULTIPLE_INSTANCES=y
# CONFIG_LEGACY_PTYS is not set
# CONFIG_DEVKMEM is not set
CONFIG_SERIAL_AMBA_PL011=y
CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
# CONFIG_HW_RANDOM is not set
CONFIG_I2C=y
# CONFIG_I2C_COMPAT is not set
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_MXS=y
CONFIG_SPI=y
CONFIG_SPI_GPIO=m
CONFIG_DEBUG_GPIO=y
CONFIG_GPIO_SYSFS=y
# CONFIG_HWMON is not set
CONFIG_REGULATOR=y
CONFIG_REGULATOR_FIXED_VOLTAGE=y
CONFIG_SOUND=y
CONFIG_SND=y
CONFIG_SND_SOC=y
CONFIG_SND_MXS_SOC=y
CONFIG_SND_SOC_MXS_SGTL5000=y
# CONFIG_USB_SUPPORT is not set
CONFIG_MMC=y
CONFIG_MMC_MXS=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_DRV_DS1307=m
CONFIG_DMADEVICES=y
CONFIG_MXS_DMA=y
CONFIG_EXT3_FS=y
# CONFIG_DNOTIFY is not set
CONFIG_FSCACHE=m
CONFIG_FSCACHE_STATS=y
CONFIG_CACHEFILES=m
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
# CONFIG_MISC_FILESYSTEMS is not set
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=y
CONFIG_ROOT_NFS=y
CONFIG_PRINTK_TIME=y
CONFIG_FRAME_WARN=2048
CONFIG_MAGIC_SYSRQ=y
CONFIG_UNUSED_SYMBOLS=y
CONFIG_DEBUG_KERNEL=y
CONFIG_LOCKUP_DETECTOR=y
CONFIG_TIMER_STATS=y
CONFIG_PROVE_LOCKING=y
CONFIG_DEBUG_INFO=y
CONFIG_BLK_DEV_IO_TRACE=y
CONFIG_STRICT_DEVMEM=y
CONFIG_DEBUG_USER=y
CONFIG_CRYPTO=y
CONFIG_CRYPTO_CRC32C=m
# CONFIG_CRYPTO_ANSI_CPRNG is not set
# CONFIG_CRYPTO_HW is not set
CONFIG_CRC_ITU_T=m
CONFIG_CRC7=m
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 259 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130620/1a2634d5/attachment.sig>
