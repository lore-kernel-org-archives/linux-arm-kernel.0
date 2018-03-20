From: lambertarthur22@gmail.com (Arthur LAMBERT)
Date: Tue, 20 Mar 2018 11:04:27 +0100
Subject: issue with kexec/kdump on imx6ull
Message-ID: <20180320100427.GA21933@arthur-bzh>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I am trying to use kexec/kdump on imx6ull evaluation kit without success.
kernel : git://git.freescale.com/imx/linux-imx.git
kernel tag : rel_imx_4.9.x_1.0.0_ga
defconfig : imx_v7
device tree :  imx6ull-14x14-evk

First I enable kexec/kdump in kernel config and add crashkernel to kernel command line :

[arthur * dreem] diff -Naur arch/arm/configs/imx_v7_defconfig defconfig
--- arch/arm/configs/imx_v7_defconfig			      2017-09-07 11:46:46.000000000 +0200
+++ defconfig						      2018-03-19 18:33:22.776513159 +0100
@@ -1,4 +1,3 @@
-CONFIG_KERNEL_LZO=y
 CONFIG_SYSVIPC=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
@@ -36,7 +35,10 @@
 CONFIG_AEABI=y
 CONFIG_HIGHMEM=y
 CONFIG_CMA=y
-CONFIG_CMDLINE="noinitrd console=ttymxc0,115200"
+CONFIG_CMDLINE="console=ttymxc0,115200 root=/dev/mmcblk1p2 rootwait rw crashkernel=50M"
+CONFIG_CMDLINE_FORCE=y
+CONFIG_KEXEC=y
+CONFIG_CRASH_DUMP=y
 CONFIG_CPU_FREQ=y
 CONFIG_CPU_FREQ_STAT=y
 CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
@@ -416,6 +418,7 @@
 CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_ISO8859_15=m
 CONFIG_NLS_UTF8=y
+CONFIG_DEBUG_INFO=y
 CONFIG_DEBUG_FS=y
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_SCHED_DEBUG is not set

crashkernel initialization is a success :

# dmesg | grep -i crash
Reserving 50MB of memory at 2176MB for crashkernel (System RAM: 512MB)
Kernel command line: console=ttymxc0,115200 root=/dev/mmcblk1p2 rootwait rw crashkernel=50M

I used a script to load kernel in crashkernel area with kexec :

# cat kx.sh
#!/bin/sh

DUMPK_CMDLINE="console=ttymxc0,115200 root=/dev/mmcblk1p2 rootwait rw  maxcpus=1 reset_devices init=/sbin/init"
kexec --type zImage \
-p /root/zImage \
--dtb=/root/imx6ull-14x14-evk.dtb \
--append="${DUMPK_CMDLINE}"
[ $? -ne 0 ] && {
    echo "kexec failed." ; exit 1
    }
    echo "$0: kexec: success, dump kernel loaded."
    exit 0

I used the same kernel && device tree in kexec that the current one :

# mkdir kernel
# mount /dev/mmcblk1p1  kernel
# cp kernel/zImage /root/.
# cp kernel/imx6ull-14x14-evk.dtb /root/.
#
# sync
# umount kernel
# rm -r kernel

I run the test :

# sh kx.sh
kx.sh: kexec: success, dump kernel loaded.
#

I trigger a kernel panic to test the kdump feature :

# echo c > /proc/sysrq-trigger
sysrq: SysRq : Trigger a crash
Unable to handle kernel NULL pointer dereference at virtual address 00000000
(...)
Loading crashdump kernel...
Bye!

No more output after that. In my opinion the kernel loaded with kexec is frozen
during init.

Is there a mistake in my process ? Is there a freeze during the kernel init ? How can I debug
this kind of issue ?

Thanks,
Arthur.
