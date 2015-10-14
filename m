From: tony@atomide.com (Tony Lindgren)
Date: Wed, 14 Oct 2015 09:02:45 -0700
Subject: [PATCH] ARM: OMAP2+: Fix oops with LPAE and more than 2GB of
 memory
In-Reply-To: <561DD014.10403@ti.com>
References: <1444778000-22537-1-git-send-email-tony@atomide.com>
 <561DD014.10403@ti.com>
Message-ID: <20151014160245.GA10113@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Lokesh Vutla <a0131933@ti.com> [151013 20:53]:
> Hi Tony,
> 
> On Wednesday 14 October 2015 04:43 AM, Tony Lindgren wrote:
> > On boards with more than 2GB of RAM booting goes wrong with things not working
> > and we're getting lots of l3 warnings:
> > 
> > WARNING: CPU: 0 PID: 1 at drivers/bus/omap_l3_noc.c:147 l3_interrupt_handler+0x260/0x384()
> > 44000000.ocp:L3 Custom Error: MASTER MMC6 TARGET DMM1 (Idle): Data Access in User mode during Functional access
> > ...
> > [<c044e158>] (scsi_add_host_with_dma) from [<c04705c8>] (ata_scsi_add_hosts+0x5c/0x18c)
> > [<c04705c8>] (ata_scsi_add_hosts) from [<c046b13c>] (ata_host_register+0x150/0x2cc)
> > [<c046b13c>] (ata_host_register) from [<c046b38c>] (ata_host_activate+0xd4/0x124)
> > [<c046b38c>] (ata_host_activate) from [<c047f42c>] (ahci_host_activate+0x5c/0x194)
> > [<c047f42c>] (ahci_host_activate) from [<c0480854>] (ahci_platform_init_host+0x1f0/0x3f0)
> > [<c0480854>] (ahci_platform_init_host) from [<c047c9dc>] (ahci_probe+0x70/0x98)
> > [<c047c9dc>] (ahci_probe) from [<c04220cc>] (platform_drv_probe+0x54/0xb4)
> > 
> > Let's fix the issue by enabling ZONE_DMA for LPAE.
> 
> May I know on which platform you have reproduced this?

This is on the 4GB version of isee igepv5 GEP0050-RB10

https://isee.biz/products/igep-processor-boards/igepv5-omap5432

> Just wondering what other changes you made for booting a OMAP5+ based
> board with more than 2GB.

Just the minimal dts changes I posted yesterday to use shared dtsi file
for omap5-uevm variants. Then boot with something like this in the kernel
cmdline:

mem=2032M at 0x80000000 mem=2048M at 0x300000000

Regards,

Tony
