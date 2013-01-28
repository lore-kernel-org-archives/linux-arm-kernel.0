From: balbi@ti.com (Felipe Balbi)
Date: Mon, 28 Jan 2013 13:38:19 +0200
Subject: OMAP baseline test results for v3.8-rc5
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93EA9456A@DBDE01.ent.ti.com>
References: <alpine.DEB.2.00.1301260838300.19277@utopia.booyaka.com>
 <20130126084604.GB8754@arwen.pp.htv.fi>
 <C8443D0743D26F4388EA172BF4E2A7A93EA9456A@DBDE01.ent.ti.com>
Message-ID: <20130128113818.GD28698@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jan 28, 2013 at 11:34:15AM +0100, Mohammed, Afzal wrote:
> Hi,
> 
> On Sat, Jan 26, 2013 at 14:16:04, Balbi, Felipe wrote:
> > On Sat, Jan 26, 2013 at 08:40:07AM +0000, Paul Walmsley wrote:
> 
> > > * am335xbone: hangs after "Starting kernel"
> > >   - Cause unknown; may be due to CONFIG_EARLY_PRINTK=y?
> > >   - http://www.mail-archive.com/linux-omap at vger.kernel.org/msg82297.html
> > >   - http://marc.info/?l=linux-omap&m=135903184512238&w=2
> > 
> > FYI, I don't think it's related to CONFIG_EARLY_PRINTK. Tested with and
> > without it, also removed CONFIG_DEBUG_LL completely and nothing seemed
> > to help my bone, no matter if I had appended DTB or not.
> 
> Following patch with low level debug may help to find where the issue is,
> (my observation is that it boots with mainline u-boot)
> 
> Regards
> Afzal
> 
> 
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index 41b581f..178a411 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -117,6 +117,10 @@ config SOC_AM33XX
>         select CPU_V7
>         select MULTI_IRQ_HANDLER
>         select COMMON_CLK
> +       select MACH_AM335XEVM
> +
> +config MACH_AM335XEVM
> +       bool
> 
>  config OMAP_PACKAGE_ZAF
>         bool

seems to be a bug with __unflatten_device_tree()...

U-Boot SPL 2013.01-00009-g54b08ef (Jan 25 2013 - 10:26:10)
OMAP SD/MMC: 0
reading u-boot.img
reading u-boot.img


U-Boot 2013.01-00009-g54b08ef (Jan 25 2013 - 10:26:10)

I2C:   ready
DRAM:  512 MiB
WARNING: Caches not enabled
NAND:  No NAND device found!!!
0 MiB
MMC:   OMAP SD/MMC: 0, OMAP SD/MMC: 1
*** Warning - readenv() failed, using default environment

musb-hdrc: ConfigData=0xde (UTMI-8, dyn FIFOs, bulk combine, bulk split, HB-ISO Rx, HB-ISO Tx, SoftConn)
musb-hdrc: MHDRC RTL version 2.0 
musb-hdrc: setup fifo_mode 4
musb-hdrc: 28/31 max ep, 16384/16384 memory
USB Peripheral mode controller at 47401000 using PIO, IRQ 0
musb-hdrc: ConfigData=0xde (UTMI-8, dyn FIFOs, bulk combine, bulk split, HB-ISO Rx, HB-ISO Tx, SoftConn)
musb-hdrc: MHDRC RTL version 2.0 
musb-hdrc: setup fifo_mode 4
musb-hdrc: 28/31 max ep, 16384/16384 memory
USB Host mode controller at 47401800 using PIO, IRQ 0
Net:   cpsw, usb_ether
Hit any key to stop autoboot:  1  0 
U-Boot# 
U-Boot# ext2load mmc ${mmcdev}:2 0x80f80000 /boot/am335x-bone.dtb
7967 bytes read in 17 ms (457 KiB/s)
U-Boot# setenv bootargs console=${console} ${optargs} root=${mmcroot} rootfstype=${mmcrootfstype} debug earlyprintk mem=256M
U-Boot# ext2load mmc ${mmcdev}:2 ${loadaddr} ${bootfile}
4265360 bytes read in 502 ms (8.1 MiB/s)
U-Boot# bootm 0x80200000 - 0x80f80000
## Booting kernel from Legacy Image at 80200000 ...
   Image Name:   Linux-3.8.0-rc5-02311-g1308c2b-d
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    4265296 Bytes = 4.1 MiB
   Load Address: 80008000
   Entry Point:  80008000
   Verifying Checksum ... OK
## Flattened Device Tree blob at 80f80000
   Booting using the fdt blob at 0x80f80000
   Loading Kernel Image ... OK
OK
   Loading Device Tree to 9fe3e000, end 9fe42f1e ... OK

Starting kernel ...

Uncompressing Linux... done, booting the kernel.
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 3.8.0-rc5-02311-g1308c2b-dirty (balbi at arwen) (gcc version 4.6.3 (Sourcery CodeBench Lite 2012.03-57) ) #37 SMP Mon Jan 28 13:32:47 EET 2013
[    0.000000] CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7), cr=10c53c7d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000] Machine: Generic AM33XX (Flattened Device Tree), model: TI AM335x BeagleBone
[    0.000000] bootconsole [earlycon0] enabled
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] On node 0 totalpages: 65280
[    0.000000] free_area_init_node: node 0, pgdat c08331c0, node_mem_map c0d91000
[    0.000000]   Normal zone: 512 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 64768 pages, LIFO batch:15
[    0.000000] Unable to handle kernel paging request at virtual address dfe3e000
[    0.000000] pgd = c0004000
[    0.000000] [dfe3e000] *pgd=00000000
[    0.000000] Internal error: Oops: 5 [#1] SMP ARM
[    0.000000] Modules linked in:
[    0.000000] CPU: 0    Not tainted  (3.8.0-rc5-02311-g1308c2b-dirty #37)
[    0.000000] PC is at __unflatten_device_tree+0x1c/0x12c
[    0.000000] LR is at unflatten_device_tree+0x1c/0x34
[    0.000000] pc : [<c0457d2c>]    lr : [<c077a370>]    psr: a0000193
[    0.000000] sp : c07a5f80  ip : 00000000  fp : 00000000
[    0.000000] r10: 00000000  r9 : 413fc082  r8 : 80004059
[    0.000000] r7 : c0755dd0  r6 : c0783ac0  r5 : dfe3e000  r4 : c0755dd0
[    0.000000] r3 : d00dfeed  r2 : c0755dd0  r1 : c0d8a8d4  r0 : dfe3e000
[    0.000000] Flags: NzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
[    0.000000] Control: 10c5387d  Table: 80004019  DAC: 00000017
[    0.000000] Process swapper (pid: 0, stack limit = 0xc07a4240)
[    0.000000] Stack: (0xc07a5f80 to 0xc07a6000)
[    0.000000] 5f80: c07b13d0 c00503b4 8fefffff c0d8a8d4 c0755dd0 c083607c c0783ac0 c07a5fe4
[    0.000000] 5fa0: 80004059 c077a370 c0781dd8 c0755028 00000000 c07a5fc4 c0783abc 00000001
[    0.000000] 5fc0: 00000000 c0783abc c07b11c4 c0751618 00000000 00000000 00000000 00000000
[    0.000000] 5fe0: 00000000 c0783ac0 00000000 10c53c7d c07ac98c 80008078 00000000 00000000
[    0.000000] [<c0457d2c>] (__unflatten_device_tree+0x1c/0x12c) from [<c077a370>] (unflatten_device_tree+0x1c/0x34)
[    0.000000] [<c077a370>] (unflatten_device_tree+0x1c/0x34) from [<c0755028>] (setup_arch+0xf8/0x190)
[    0.000000] [<c0755028>] (setup_arch+0xf8/0x190) from [<c0751618>] (start_kernel+0x80/0x2a8)
[    0.000000] [<c0751618>] (start_kernel+0x80/0x2a8) from [<80008078>] (0x80008078)
[    0.000000] Code: e1a07002 e58d100c 0a000033 e59f30f4 (e5951000) 
[    0.000000] ---[ end trace 1b75b31a2719ed1c ]---
[    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!


-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130128/f83adee0/attachment.sig>
