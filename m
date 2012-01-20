From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 20 Jan 2012 11:51:08 +0000
Subject: Making allyesconfig work
Message-ID: <20120120115108.GJ1068@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Presently, allyesconfig fails to get anywhere near building on ARM, which
is caused mainly by a Kconfig problem.

The problem is XIP_KERNEL gets enabled, which turns off ARM_PATCH_PHYS_VIRT,
and then we have Kconfig wanting a value for PHYS_OFFSET.  Because 'y'
doesn't suit this, Kconfig leaves this blank.

The result is that make allyesconfig produces an invalid configuration
file, which fails on building - killing off the build before we've even
compiled any of the kernel .c files.

One solution to this would be:

config __ALLYESCONFIG
	bool "If you enable me, your personal universe will implode"
	help
	  Never enable this option.  This option is here to detect
	  'make allyesconfig' and allow certain options to be disabled.
	  Saying 'y' here yourself will result in those options being
	  hidden from you, which is probably not what you want.

and then we can have:

config XIP_KERNEL
        bool "Kernel Execute-In-Place from ROM"
        depends on !ZBOOT_ROM && !ARM_LPAE && !__ALLYESCONFIG

Once this is done, then we can actually get to a point where we can
start building the kernel.  The good news is that most of the kernel
builds relatively cleanly, although there are the expected warnings
about virt_to_bus(), bus_to_virt().

However, it seems we're exporting a few constants which don't have a
good namespace - one of those is fixed by a patches I posted earlier
today to avoid exporting the CR_* constants to the entire kernel
build.  CR_* is not a good namespace to be visible to drivers and the
like, so these definitions have been moved to a private ARM header.

There's also the troublesome T() macro, which conflicts with a bunch
of other drivers.  (I've added Catalin to the To: line for this
reason.)

I won't post the entire build log - it comes in around 430K which is
much too large for these lists.  Instead, below are the errors and
warnings from the build.

Below are the errors from a fresh allyesconfig build:

drivers/input/touchscreen/eeti_ts.c:65: error: implicit declaration of function 'irq_to_gpio'
drivers/mfd/ezx-pcap.c:205: error: implicit declaration of function 'irq_to_gpio'
drivers/net/ethernet/faraday/ftgmac100.c:983: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'ftgmac100_interrupt'
drivers/net/ethernet/faraday/ftgmac100.c:1085: error: implicit declaration of function 'request_irq'
drivers/net/ethernet/faraday/ftgmac100.c:1085: error: 'ftgmac100_interrupt' undeclared (first use in this function)
drivers/net/ethernet/faraday/ftgmac100.c:1085: error: (Each undeclared identifier is reported only once
drivers/net/ethernet/faraday/ftgmac100.c:1085: error: for each function it appears in.)
drivers/net/ethernet/faraday/ftgmac100.c:1113: error: implicit declaration of function 'free_irq'
drivers/net/ethernet/faraday/ftmac100.c:859: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'ftmac100_interrupt'
drivers/net/ethernet/faraday/ftmac100.c:964: error: implicit declaration of function 'request_irq'
drivers/net/ethernet/faraday/ftmac100.c:964: error: 'ftmac100_interrupt' undeclared (first use in this function)
drivers/net/ethernet/faraday/ftmac100.c:964: error: (Each undeclared identifier is reported only once
drivers/net/ethernet/faraday/ftmac100.c:964: error: for each function it appears in.)
drivers/net/ethernet/faraday/ftmac100.c:987: error: implicit declaration of function 'free_irq'
drivers/net/ethernet/stmicro/stmmac/mmc_core.c:142: error: implicit declaration of function 'pr_debug'
drivers/scsi/advansys.c:8376: error: implicit declaration of function 'dma_cache_sync'
drivers/staging/iio/accel/lis3l02dq_core.c:702: error: implicit declaration of function 'irq_to_gpio'
drivers/staging/iio/accel/lis3l02dq_ring.c:295: error: implicit declaration of function 'irq_to_gpio'

which shows mostly its irq_to_gpio, and three drivers with missing
include files.

The warnings are (with virt_to_bus/bus_to_virt omitted):

arch/arm/kernel/return_address.c:62:2: warning: #warning "TODO: return_address should use unwind tables"
arch/arm/kernel/return_address.c:62:2: warning: #warning "TODO: return_address should use unwind tables"
kernel/debug/kdb/kdb_support.c:639: warning: passing argument 1 of 'is_idle_task' discards qualifiers from pointer target type
kernel/sched/fair.c:419: warning: 'account_cfs_rq_runtime' declared inline after being called
kernel/sched/fair.c:419: warning: previous declaration of 'account_cfs_rq_runtime' was here
kernel/sched/fair.c:1178: warning: 'return_cfs_rq_runtime' declared inline after being called
kernel/sched/fair.c:1178: warning: previous declaration of 'return_cfs_rq_runtime' was here
kernel/trace/trace.c:3697: warning: 'page2' may be used uninitialized in this function
mm/memcontrol.c:381: warning: 'mem_cgroup_is_root' declared inline after being called
mm/memcontrol.c:381: warning: previous declaration of 'mem_cgroup_is_root' was here
fs/btrfs/backref.c:419: warning: 'ret' may be used uninitialized in this function
fs/nfs/callback_proc.c:116: warning: 'ino' may be used uninitialized in this function
fs/nfs/callback_proc.c:115: warning: 'lo' may be used uninitialized in this function
include/asm-generic/xor.h:696: warning: 'xor_block_8regs_p' defined but not usedinclude/asm-generic/xor.h:704: warning: 'xor_block_32regs_p' defined but not used
drivers/dma/pl330.c:859: warning: comparison of distinct pointer types lacks a cast
drivers/gpu/drm/drm_edid.c:1341: warning: array subscript is above array bounds
drivers/gpu/drm/drm_edid.c:1341: warning: array subscript is above array bounds
drivers/gpu/drm/drm_edid.c:1341: warning: array subscript is above array bounds
drivers/gpu/drm/drm_edid.c:1341: warning: array subscript is above array bounds
drivers/gpu/drm/drm_edid.c:1341: warning: array subscript is above array bounds
drivers/gpu/drm/nouveau/nv50_display.c:618: warning: 'mc' may be used uninitialized in this function
drivers/infiniband/hw/mlx4/qp.c:1366: warning: 'vlan' may be used uninitialized in this function
drivers/input/joystick/analog.c:175:2: warning: #warning Precise timer not defined for this architecture.
drivers/isdn/hardware/mISDN/hfcpci.c:2319: warning: ignoring return value of 'driver_for_each_device', declared with attribute warn_unused_result
drivers/isdn/hardware/mISDN/w6692.c:1189: warning: unsupported argument to '__builtin_return_address'
drivers/isdn/hardware/mISDN/mISDNipac.c:755: warning: unsupported argument to '__builtin_return_address'
drivers/leds/leds-lp5521.c:648: warning: 'ret' may be used uninitialized in this function
drivers/leds/leds-lp5521.c:649: warning: 'buf' may be used uninitialized in this function
drivers/leds/leds-lp5521.c:197: warning: 'mode' may be used uninitialized in this function
drivers/leds/leds-lp5523.c:443: warning: 'vdd' may be used uninitialized in this function
drivers/leds/leds-lp5523.c:443: warning: 'adc' may be used uninitialized in this function
drivers/leds/leds-lp5523.c:196: warning: 'status' may be used uninitialized in this function
drivers/media/dvb/pt1/pt1.c:395: warning: 'addr' may be used uninitialized in this function
drivers/media/dvb/pt1/pt1.c:397: warning: 'buf_pfn' may be used uninitialized in this function
drivers/media/rc/redrat3.c:1100: warning: assignment from incompatible pointer type
drivers/media/video/em28xx/em28xx-core.c:1116: warning: 'packet_size' may be used uninitialized in this function
drivers/mmc/card/block.c:794: warning: 'arg' may be used uninitialized in this function
drivers/mmc/card/block.c:794: warning: 'nr' may be used uninitialized in this function
drivers/mmc/card/block.c:794: warning: 'from' may be used uninitialized in this function
drivers/mtd/devices/doc2000.c:874: warning: value computed is not used
drivers/mtd/devices/doc2000.c:1043: warning: value computed is not used
drivers/mtd/devices/doc2000.c:1068: warning: value computed is not used
drivers/mtd/devices/doc2000.c:1143: warning: value computed is not used
drivers/mtd/devices/doc2001plus.c:634: warning: value computed is not used
drivers/mtd/devices/doc2001plus.c:635: warning: value computed is not used
drivers/mtd/devices/doc2001plus.c:891: warning: value computed is not used
drivers/mtd/devices/doc2001plus.c:892: warning: value computed is not used
drivers/mtd/devices/docg3.c:753: warning: 'doc_get_erase_count' defined but not used
drivers/mtd/devices/docprobe.c:74:2: warning: #warning Unknown architecture for DiskOnChip. No default probe locations defined
drivers/mtd/devices/docprobe.c:138: warning: value computed is not used
drivers/mtd/devices/docprobe.c:139: warning: value computed is not used
drivers/mtd/devices/docprobe.c:158: warning: value computed is not used
drivers/mtd/devices/slram.c:52:1: warning: "T" redefined
arch/arm/include/asm/domain.h:86:1: warning: this is the location of the previous definition
drivers/mtd/devices/sst25l.c:381: warning: unused variable 'i'
drivers/mtd/nand/diskonchip.c:57:2: warning: #warning Unknown architecture for DiskOnChip. No default probe locations defined
drivers/mtd/nand/diskonchip.c:318: warning: value computed is not used
drivers/mtd/nand/diskonchip.c:494: warning: value computed is not used
drivers/mtd/nand/diskonchip.c:520: warning: value computed is not used
drivers/mtd/nand/diskonchip.c:537: warning: value computed is not used
drivers/mtd/nand/diskonchip.c:541: warning: value computed is not used
drivers/mtd/nand/diskonchip.c:556: warning: value computed is not used
drivers/mtd/nand/diskonchip.c:557: warning: value computed is not used
drivers/mtd/nand/diskonchip.c:593: warning: value computed is not used
drivers/mtd/nand/diskonchip.c:594: warning: value computed is not used
drivers/mtd/nand/diskonchip.c:624: warning: value computed is not used
drivers/mtd/nand/diskonchip.c:625: warning: value computed is not used
drivers/mtd/nand/diskonchip.c:629: warning: value computed is not used
drivers/mtd/nand/diskonchip.c:630: warning: value computed is not used
drivers/mtd/nand/diskonchip.c:1454: warning: value computed is not used
drivers/mtd/nand/diskonchip.c:1455: warning: value computed is not used
drivers/mtd/nand/diskonchip.c:1456: warning: value computed is not used
drivers/mtd/nand/diskonchip.c:1547: warning: value computed is not used
drivers/net/ethernet/amd/nmclan_cs.c:626: warning: 'pcmcia_request_exclusive_irq' is deprecated (declared at include/pcmcia/ds.h:203)
drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c:2784: warning: comparison of distinct pointer types lacks a cast
drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c:1530: warning: comparison of distinct pointer types lacks a cast
drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c:1614:1: warning: "T" redefined
arch/arm/include/asm/domain.h:86:1: warning: this is the location of the previous definition
drivers/net/ethernet/dec/tulip/winbond-840.c:914:2: warning: #warning Processor architecture undefined
drivers/net/ethernet/marvell/sky2.c:1762: warning: 'imask' may be used uninitialized in this function
drivers/net/ethernet/neterion/vxge/vxge-main.c:2117: warning: 'adaptive_coalesce_tx_interrupts' defined but not used
drivers/net/ethernet/neterion/vxge/vxge-main.c:2145: warning: 'adaptive_coalesce_rx_interrupts' defined but not used
drivers/net/ethernet/via/via-velocity.c:3062: warning: array subscript is above array bounds
drivers/net/ethernet/via/via-velocity.c:3064: warning: array subscript is above array bounds
drivers/net/ethernet/via/via-velocity.c:3074: warning: array subscript is above array bounds
drivers/net/tokenring/ibmtr_cs.c:195: warning: 'pcmcia_request_exclusive_irq' is deprecated (declared at include/pcmcia/ds.h:203)
drivers/net/wireless/ath/ath6kl/sdio.c:330: warning: 'sg_sz' may be used uninitialized in this function
drivers/net/wireless/brcm80211/brcmfmac/wl_cfg80211.c:346: warning: 'wsec' may be used uninitialized in this function
drivers/net/wireless/brcm80211/brcmsmac/aiutils.c:1159: warning: 'val' may be used uninitialized in this function
drivers/net/wireless/rt2x00/rt2800lib.c:1291: warning: 'gf40_mode' may be used uninitialized in this function
drivers/net/wireless/rt2x00/rt2800lib.c:1291: warning: 'gf20_mode' may be used uninitialized in this function
drivers/net/wireless/rt2x00/rt2800lib.c:1291: warning: 'mm40_mode' may be used uninitialized in this function
drivers/net/wireless/rt2x00/rt2800lib.c:1291: warning: 'mm20_mode' may be used uninitialized in this function
drivers/net/wireless/rtlwifi/rtl8192de/trx.c:124: warning: 'rx_pwr_all' may be used uninitialized in this function
drivers/rtc/rtc-m41t80.c:217: warning: 'm41t80_rtc_alarm_irq_enable' defined but not used
drivers/rtc/rtc-m41t80.c:239: warning: 'm41t80_rtc_set_alarm' defined but not used
drivers/rtc/rtc-m41t80.c:309: warning: 'm41t80_rtc_read_alarm' defined but not used
drivers/scsi/aic94xx/aic94xx_sds.c:985: warning: 'offs' may be used uninitialized in this function
drivers/scsi/lpfc/lpfc_scsi.c:1307: warning: integer constant is too large for 'long' type
drivers/scsi/lpfc/lpfc_scsi.c:1333: warning: integer constant is too large for 'long' type
drivers/scsi/lpfc/lpfc_scsi.c:1344: warning: integer constant is too large for 'long' type
drivers/scsi/lpfc/lpfc_scsi.c:1367: warning: integer constant is too large for 'long' type
drivers/scsi/lpfc/lpfc_scsi.c:1378: warning: integer constant is too large for 'long' type
drivers/scsi/lpfc/lpfc_scsi.c:1412: warning: integer constant is too large for 'long' type
drivers/scsi/lpfc/lpfc_scsi.c:1434: warning: integer constant is too large for 'long' type
drivers/scsi/lpfc/lpfc_debugfs.c:3892: warning: integer constant is too large for 'long' type
drivers/scsi/advansys.c:72:2: warning: #warning this driver is still not properly converted to the DMA API
drivers/scsi/dpt_i2o.c:183: warning: 'dptids' defined but not used
drivers/scsi/ips.c:210:2: warning: #warning "This driver has only been tested on the x86/ia64/x86_64 platforms"
drivers/scsi/fdomain.c:1775: warning: 'fdomain_pci_tbl' defined but not used
drivers/scsi/initio.c:131: warning: 'i91u_pci_devices' defined but not used
drivers/staging/iio/gyro/adis16080_core.c:85: warning: 'ut' may be used uninitialized in this function
drivers/staging/iio/light/isl29018.c:297: warning: 'new_adc_bit' may be used uninitialized in this function
drivers/staging/iio/light/isl29018.c:255: warning: 'new_range' may be used uninitialized in this function
drivers/staging/media/dt3155v4l/dt3155v4l.c:307: warning: initialization from incompatible pointer type
drivers/staging/media/dt3155v4l/dt3155v4l.c:311: warning: initialization from incompatible pointer type
include/linux/jhash.h:90: warning: array subscript is above array bounds
include/linux/jhash.h:91: warning: array subscript is above array bounds
include/linux/jhash.h:92: warning: array subscript is above array bounds
include/linux/jhash.h:93: warning: array subscript is above array bounds
include/linux/jhash.h:94: warning: array subscript is above array bounds
include/linux/jhash.h:95: warning: array subscript is above array bounds
include/linux/jhash.h:96: warning: array subscript is above array bounds
include/linux/jhash.h:97: warning: array subscript is above array bounds
drivers/staging/rtl8712/rtl8712_recv.c:752: warning: 'rx_pwr_all' may be used uninitialized in this function
drivers/staging/usbip/usbip_common.c:796: warning: 'ret' may be used uninitialized in this function
drivers/staging/wlan-ng/cfg80211.c:404: warning: ignoring return value of 'cfg80211_inform_bss', declared with attribute warn_unused_result
drivers/tty/serial/ifx6x60.c:609: warning: 'more' may be used uninitialized in this function
drivers/usb/host/xhci-ring.c:1253: warning: 'hcd' may be used uninitialized in this function
drivers/usb/musb/musb_gadget.c:1087: warning: 'double_buffer_not_ok' is deprecated (declared at drivers/usb/musb/musb_core.h:450)
drivers/usb/musb/musb_gadget.c:1127: warning: 'double_buffer_not_ok' is deprecated (declared at drivers/usb/musb/musb_core.h:450)
drivers/usb/musb/musb_host.c:599: warning: 'double_buffer_not_ok' is deprecated (declared at drivers/usb/musb/musb_core.h:450)
drivers/usb/musb/musb_host.c:774: warning: 'double_buffer_not_ok' is deprecated (declared at drivers/usb/musb/musb_core.h:450)
drivers/usb/otg/ab8500-usb.c:156: warning: 'event' may be used uninitialized in this function
drivers/video/aty/atyfb_base.c:169: warning: array subscript is above array bounds
drivers/video/aty/atyfb_base.c:154: warning: array subscript is above array bounds
drivers/video/aty/radeon_pm.c:1719: warning: 'radeon_reinitialize_M10' defined but not used
sound/soc/codecs/wm_hubs.c:120: warning: 'reg_r' may be used uninitialized in this function
sound/soc/codecs/wm_hubs.c:120: warning: 'reg_l' may be used uninitialized in this function
sound/soc/codecs/wm8994.c:58: warning: unused variable 'wm8994'
sound/soc/codecs/wm8996.c:1661: warning: 'bclk_reg' may be used uninitialized in this function
net/bluetooth/rfcomm/tty.c:218: warning: 'p' may be used uninitialized in this function
net/ceph/ceph_fs.c:33: warning: 'mode' may be used uninitialized in this function
include/net/netfilter/xt_log.h:50: warning: value computed is not used
include/net/netfilter/xt_log.h:50: warning: value computed is not used

The biggest one in there that I think we need to be concerned about is
the T() thing, which really needs to change to something more suitable
or move to a private header file which isn't exposed to the entire
kernel build.
