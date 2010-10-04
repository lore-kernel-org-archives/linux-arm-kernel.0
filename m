From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Mon, 4 Oct 2010 18:54:22 +0530
Subject: [PATCH 02/14] omap: Map only available sram memory
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB030CDFE61A@dbde02.ent.ti.com>
References: <1284716878-27667-1-git-send-email-santosh.shilimkar@ti.com>
	<1284716878-27667-2-git-send-email-santosh.shilimkar@ti.com>
	<1284716878-27667-3-git-send-email-santosh.shilimkar@ti.com>
	<AANLkTi=PM1x7zXbSMRxBHVZ5Z2+4iwebvbiGizca_rC8@mail.gmail.com>
	<20101001225303.GF3117@atomide.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB030CDFE18C@dbde02.ent.ti.com>
	<AANLkTi=zmgSCCg71NsYMte9K-yeyb1i0VxCA4i_9Y8D-@mail.gmail.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB030CDFE61A@dbde02.ent.ti.com>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB030CDFE85B@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: linux-omap-owner at vger.kernel.org [mailto:linux-omap-
> owner at vger.kernel.org] On Behalf Of Shilimkar, Santosh
> Sent: Monday, October 04, 2010 3:08 PM
> To: Grazvydas Ignotas
> Cc: Tony Lindgren; linux-omap at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; Russell King - ARM Linux
> Subject: RE: [PATCH 02/14] omap: Map only available sram memory
> 
> > -----Original Message-----
> > From: Grazvydas Ignotas [mailto:notasas at gmail.com]
> > Sent: Monday, October 04, 2010 2:34 PM
> > To: Shilimkar, Santosh
> > Cc: Tony Lindgren; linux-omap at vger.kernel.org; linux-arm-
> > kernel at lists.infradead.org; Russell King - ARM Linux
> > Subject: Re: [PATCH 02/14] omap: Map only available sram memory
> >
> > >> >
> > >> > This hangs OMAP3 pandora:
> > >> >
> > >> > [ ? ?0.000000] Linux version
> > >> > 2.6.36-rc6-next-20101001-00002-ge76bb53-dirty (notaz at pixelinis)
> (gcc
> > >> > version 4.3.3 (Sourcery G++ Lite 2009q1-20
> > >> > [ ? ?0.000000] CPU: ARMv7 Processor [411fc082] revision 2 (ARMv7),
> > >> cr=10c53c7f
> > >> > [ ? ?0.000000] CPU: VIPT nonaliasing data cache, VIPT nonaliasing
> > >> > instruction cache
> > >> > [ ? ?0.000000] Machine: Pandora Handheld Console
> > >> > [ ? ?0.000000] Ignoring unrecognised tag 0x54410008
> > >> > [ ? ?0.000000] bootconsole [earlycon0] enabled
> > >> > [ ? ?0.000000] Reserving 6422528 bytes SDRAM for VRAM
> > >> > [ ? ?0.000000] Memory policy: ECC disabled, Data cache writeback
> > >> > [ ? ?0.000000] OMAP3430/3530 ES2.1 (l2cache iva sgx neon isp )
> > >> > [ ? ?0.000000] SRAM: Mapped pa 0x40200000 to va 0xfe400000 size:
> > 0x10000
> > >> > (stuck here)
> > >> >
> > >> > reverting this fixes the problem.
> > >>
> > >> Hmm, boots fine here with overo. Any idea what in this patch breaks
> > >> pandora?
> > >>
> > > The change in this patch is not board dependent really. Have tested
> this
> > > on 3430SDP. Pandora is OMAP3 based, right ?
> >
> > OMAP3530 ES2.1, also tried on friend's beagleboard b5 (also ES2.1) and
> > it has the same problem. Maybe it's because of older Cortex A8 used
> > there, or I'm missing some errata workaround in defconfig.
> >
> > BTW, hacking the size to 1M on top of your patch fixes the problem too:
> >
> >         base = omap_sram_start;
> >         base = ROUND_DOWN(base, PAGE_SIZE);
> >         omap_sram_io_desc[0].pfn = __phys_to_pfn(base);
> > -       omap_sram_io_desc[0].length = ROUND_DOWN(omap_sram_size,
> > PAGE_SIZE);
> > +       omap_sram_io_desc[0].length = 0x100000;
> This is the exact reason this patch is created :)
> So that you map only available memory instead of 1 MB
> >         iotable_init(omap_sram_io_desc, ARRAY_SIZE(omap_sram_io_desc));

Just booted latest mainline where this patch is already merged and 
my OMAP3630 boots fine

## Booting image at 80300000 ...
   Image Name:   Linux-2.6.36-rc6-00086-gd4e8aa3
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    3242124 Bytes =  3.1 MB
   Load Address: 80008000
   Entry Point:  80008000
   Verifying Checksum ... OK
OK

Starting kernel ...

Uncompressing Linux... done, booting the kernel.
[    0.000000] Linux version 2.6.36-rc6-00086-gd4e8aa3 (a0393909 at a0393909-desktop) (gcc version 4.4.1 (Sourcery G++ Lite 2010q1-202) ) #1 Mon Oct 4 18:27:30 IST 2010
[    0.000000] CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7), cr=10c53c7f
[    0.000000] CPU: VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
[    0.000000] Machine: OMAP Zoom3 board
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] OMAP3630 ES1.0 (l2cache iva sgx neon isp 192mhz_clk )
[    0.000000] SRAM: Mapped pa 0x40208000 to va 0xfe408000 size: 0x8000
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 32512
[    0.000000] Kernel command line: root=/dev/ram0 rw mem=128M console=ttyS0,115200n8 noinitrd root=/dev/nfs rw nfsroot=172.24.190.46:/ubuntu/nfs-share/omap3_next/,nolock,tcp,rsize=4096,wsize=4096 ip=dhcp earlyprintk
[    0.000000] PID hash table entries: 512 (order: -1, 2048 bytes)
[    0.000000] Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.000000] Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
[    0.000000] Memory: 128MB = 128MB total
[    0.000000] Memory: 116148k/116148k available, 14924k reserved, 0K highmem
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     DMA     : 0xffc00000 - 0xffe00000   (   2 MB)
[    0.000000]     vmalloc : 0xc8800000 - 0xf8000000   ( 760 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xc8000000   ( 128 MB)
[    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
[    0.000000]       .init : 0xc0008000 - 0xc0047000   ( 252 kB)
[    0.000000]       .text : 0xc0047000 - 0xc05e9000   (5768 kB)
[    0.000000]       .data : 0xc0612000 - 0xc07e2900   (1859 kB)
[    0.000000] Hierarchical RCU implementation.
[    0.000000]  RCU-based detection of stalled CPUs is disabled.
[    0.000000]  Verbose stalled-CPUs detection is disabled.
[    0.000000] NR_IRQS:402
[    0.000000] Clocking rate (Crystal/Core/MPU): 26.0/400/600 MHz
[    0.000000]  (null): Could not get uart4_ick
[    0.000000]  (null): Could not get uart4_fck
[    0.000000] Reprogramming SDRC clock to 400000000 Hz
[    0.000000] GPMC revision 5.0
[    0.000000] IRQ: Found an INTC at 0xfa200000 (revision 4.0) with 96 interrupts
[    0.000000] Total of 96 interrupts on 1 active controller
[    0.000000] Could not get gpios_ick
[    0.000000] Could not get gpios_fck

----
Looks like for you " is_sram_locked" function is failing. There was a patch
in my series from Vikram which was fixing this API.

Do you have this patch applied when you are trying this out ?
http://www.spinics.net/linux/lists/arm-kernel/msg98697.html

Regards,
Santosh
