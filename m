From: bcmarm@gmail.com (Hemanth Kumar)
Date: Wed, 10 Sep 2014 16:37:44 +0530
Subject: ARM big endian cpu hotplug
Message-ID: <CAMQ1t3oDaYCQ+Uye3NDcHb8O4bvK=cauOfcqQvHqdieb8e8uEA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On ARM VE-A-15 ,When I enable CONFIG_MTD_CFI &
CONFIG_MTD_CFI_LE_BYTE_SWAP and try to do cpu hotplug it throw's an
error
write error: Input/output error,If I enable
CONFIG_MTD_CFI_BE_BYTE_SWAP and fix with below  code
include/linux/mtd/map.h still it throw's write error: Input/output
error when I do cpu hotplug this happening on
v3.10,v3.12,v3.14,v3.15,v3.16,

If I dont enable CONFIG_MTD_CFI & CONFIG_MTD_CFI_LE_BYTE_SWAP or
CONFIG_MTD_CFI_BE_BYTE_SWAP cpu hot plug works fine.

static inline map_word inline_map_read(struct map_info *map, unsigned long ofs)
{

 map_word r;

        if (map_bankwidth_is_1(map))
                r.x[0] = readb_relaxed(map->virt + ofs);
        else if (map_bankwidth_is_2(map))
                r.x[0] = readw_relaxed(map->virt + ofs);
        else if (map_bankwidth_is_4(map))
                r.x[0] = readl_relaxed(map->virt + ofs);
#if BITS_PER_LONG >= 64
        else if (map_bankwidth_is_8(map))
                r.x[0] = __raw_readq(map->virt + ofs);
#endif
        else if (map_bankwidth_is_large(map))
                memcpy_fromio(r.x, map->virt+ofs, map->bankwidth);
        else
                BUG();

        return r;
}

static inline void inline_map_write(struct map_info *map, const
map_word datum, unsigned long ofs)
{
        if (map_bankwidth_is_1(map))
                writeb_relaxed(datum.x[0], map->virt + ofs);
        else if (map_bankwidth_is_2(map))
                writew_relaxed(datum.x[0], map->virt + ofs);
        else if (map_bankwidth_is_4(map))
                writel_relaxed(datum.x[0], map->virt + ofs);
#if BITS_PER_LONG >= 64
        else if (map_bankwidth_is_8(map))
                __raw_writeq(datum.x[0], map->virt + ofs);
#endif
        else if (map_bankwidth_is_large(map))
                memcpy_toio(map->virt+ofs, datum.x, map->bankwidth);



CONFIG_MTD_CFI=y
# CONFIG_MTD_JEDECPROBE is not set
CONFIG_MTD_GEN_PROBE=y
CONFIG_MTD_CFI_ADV_OPTIONS=y
# CONFIG_MTD_CFI_NOSWAP is not set
# CONFIG_MTD_CFI_BE_BYTE_SWAP is not set
CONFIG_MTD_CFI_LE_BYTE_SWAP=y
CONFIG_MTD_CFI_GEOMETRY=y
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_MAP_BANK_WIDTH_8=y
CONFIG_MTD_MAP_BANK_WIDTH_16=y
# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
CONFIG_MTD_CFI_I4=y
CONFIG_MTD_CFI_I8=y
# CONFIG_MTD_OTP is not set
CONFIG_MTD_CFI_INTELEXT=y
CONFIG_MTD_CFI_AMDSTD=y
# CONFIG_MTD_CFI_STAA is not set
CONFIG_MTD_CFI_UTIL=y
CONFIG_MTD_RAM=y
# CONFIG_MTD_ROM is not set
# CONFIG_MTD_ABSENT is not set



root at armeb-cortex-a15:~# cat /proc/mtd
dev:    size   erasesize  name
mtd0: 00100000 00040000 "u-boot"
mtd1: 00700000 00040000 "kernel"
mtd2: 04000000 00040000 "rootfs.jffs2"
mtd3: 02000000 00001000 "14000000.psram"
root at armeb-cortex-a15:~# cat /proc/interrupts
           CPU0       CPU1       CPU2       CPU3       CPU4
 27:       4652       4681       4701       4701       4701       GIC
27  arch_timer
 34:          0          0          0          0          0       GIC  34  timer
 36:          0          0          0          0          0       GIC
36  rtc-pl031
 37:        737          0          0          0          0       GIC
37  uart-pl011
 41:          0          0          0          0          0       GIC
41  mmci-pl18x (cmd)
 42:          0          0          0          0          0       GIC
42  mmci-pl18x (pio)
 47:      13935          0          0          0          0       GIC  47  eth0
 48:         49          0          0          0          0       GIC
48  isp1760-hcd:usb1
127:         16          0          0          0          0       GIC
127  vexpress-spc
IPI0:          0          1          1          1          1  CPU
wakeup interrupts
IPI1:          0          0          0          0          0  Timer
broadcast interrupts
IPI2:       1385       5233       3276       2664       2298
Rescheduling interrupts
IPI3:          0          3          3          3          3  Function
call interrupts
IPI4:          0          0          0          0          0  Single
function call interrupts
IPI5:          0          0          0          0          0  CPU stop
interrupts
IPI6:        216        134        127         99        129  IRQ work
interrupts
IPI7:          0          0          0          0          0
completion interrupts
Err:          0
root at armeb-cortex-a15:~# echo 0 > /sys/devices/system/cpu/cpu3/
online
root at armeb-cortex-a15:~# cat /proc/interrupts
           CPU0       CPU1       CPU2       CPU4
 27:       7147       7176       7196       7196       GIC  27  arch_timer
 34:          0          0          0          0       GIC  34  timer
 36:          0          0          0          0       GIC  36  rtc-pl031
 37:       1045          0          0          0       GIC  37  uart-pl011
 41:          0          0          0          0       GIC  41  mmci-pl18x (cmd)
 42:          0          0          0          0       GIC  42  mmci-pl18x (pio)
 47:      14069          0          0          0       GIC  47  eth0
 48:         49          0          0          0       GIC  48  isp1760-hcd:usb1
127:         16          0          0          0       GIC 127  vexpress-spc
IPI0:          0          1          1          1  CPU wakeup interrupts
IPI1:          0          0          0          0  Timer broadcast interrupts
IPI2:       1392       5235       3277       2300  Rescheduling interrupts
IPI3:          0          3          3          3  Function call interrupts
IPI4:          0          0          0          0  Single function
call interrupts
IPI5:          0          0          0          0  CPU stop interrupts
IPI6:        233        134        127        189  IRQ work interrupts
IPI7:          0          0          0          0  completion interrupts
Err:          0
root at armeb-cortex-a15:~# echo 1 > /sys/devices/system/cpu/cpu3/online
-sh: echo: write error: Input/output error
root at armeb-cortex-a15:~# uname -a
Linux armeb-cortex-a15 3.14.17 #27 SMP Wed Sep 10 14:49:58 IST 2014
armv7b GNU/Linux
