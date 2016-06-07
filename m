From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 7 Jun 2016 07:48:09 +0200
Subject: [PATCH 5/7] mtd: nand: Add Hynix H27UBG8T2BTR-BC to nand_ids table
In-Reply-To: <20160607000645.5d1f428b40406a5db7cbe285@gmail.com>
References: <1465208664-9366-1-git-send-email-mamlinav@gmail.com>
 <1465208664-9366-6-git-send-email-mamlinav@gmail.com>
 <20160606205549.1ecd6fdb@bbrezillon>
 <20160606225903.264abc01647eb1528cc226bd@gmail.com>
 <20160606223138.3c2032ee@bbrezillon>
 <20160607000645.5d1f428b40406a5db7cbe285@gmail.com>
Message-ID: <20160607074809.5c18b4b2@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 7 Jun 2016 00:06:45 +0300
Aleksei Mamlin <mamlinav@gmail.com> wrote:

> On Mon, 6 Jun 2016 22:31:38 +0200
> Boris Brezillon <boris.brezillon@free-electrons.com> wrote:
> 
> > On Mon, 6 Jun 2016 22:59:03 +0300
> > Aleksei Mamlin <mamlinav@gmail.com> wrote:
> >   
> > > On Mon, 6 Jun 2016 20:55:49 +0200
> > > Boris Brezillon <boris.brezillon@free-electrons.com> wrote:
> > >   
> > > > On Mon,  6 Jun 2016 13:24:22 +0300
> > > > Aleksei Mamlin <mamlinav@gmail.com> wrote:
> > > >     
> > > > > Add the full description of the Hynix H27UBG8T2BTR-BC NAND chip in the
> > > > > nand_ids table so that we can later use the NAND ECC infos and ONFI timings
> > > > > mode in controller drivers.    
> > > > 
> > > > Still hoping to get this series [1] merged in 4.8, but if that's
> > > > not the case, I'll apply your patch.
> > > > 
> > > > BTW, that would be great if you could test it on your platforms.
> > > >     
> > > 
> > > It seems that Hynix-specific initialization code can't handle H27UBG8T2BTR-BC
> > > chip:
> > > 
> > > [    0.886153] nand: Could not find valid ONFI parameter page; aborting
> > > [    0.892665] nand: device found, Manufacturer ID: 0xad, Chip ID: 0xd7
> > > [    0.899025] nand: Hynix 1c03000.nand
> > > [    0.902596] nand: bus width 8 instead 16 bit
> > > [    0.906858] nand: No NAND device found
> > > [    0.910620] sunxi_nand 1c03000.nand: failed to init nand chips
> > > [    0.916528] sunxi_nand: probe of 1c03000.nand failed with error -22  
> > 
> > Can you try this patch? It should fix the problem [1].
> > 
> > [1]http://code.bulix.org/6hjww1-100494
> >   
> 
> Yes, it fixes problem. What about ONFI parameter page? Should it be ignored?

It should be ignored: your NAND is not 'ONFI compatible', the datasheet
just says that it supports the' ONFI command set', which is not the
same :).
The trace you're seeing here is just notifying that the core failed to
detect an ONFI NAND, which is expected in your case.

> [    0.886068] nand: Could not find valid ONFI parameter page; aborting
> [    0.892571] nand: device found, Manufacturer ID: 0xad, Chip ID: 0xd7
> [    0.898917] nand: Hynix NAND 4GiB 3,3V 8-bit
> [    0.903198] nand: 4096 MiB, MLC, erase size: 2048 KiB, page size: 8192, OOB size: 640
> [    0.911908] Bad block table found at page 524032, version 0x01
> [    0.918534] Bad block table found at page 523776, version 0x01
> [    0.972112] 5 ofpart partitions found on MTD device 1c03000.nand
> [    0.978116] Creating 5 MTD partitions on "1c03000.nand":
> [    0.983477] 0x000000000000-0x000000200000 : "boot0"
> [    0.988803] 0x000000200000-0x000000400000 : "boot0-rescue"
> [    0.994692] 0x000000400000-0x000000600000 : "uboot"
> [    0.999944] 0x000000600000-0x000000800000 : "uboot-rescue"
> [    1.005763] 0x000000800000-0x000100000000 : "main"
> 
> > 
> > -- 
> > Boris Brezillon, Free Electrons
> > Embedded Linux and Kernel engineering
> > http://free-electrons.com  
> 
> 



-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
