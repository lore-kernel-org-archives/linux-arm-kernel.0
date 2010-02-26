From: maramaopercheseimorto@gmail.com (Alberto Panizzo)
Date: Fri, 26 Feb 2010 14:29:33 +0100
Subject: [PATCH] mx31pdk: Add NAND support
In-Reply-To: <201002261248.03214.jbe@pengutronix.de>
References: <210155.75899.qm@web51001.mail.re2.yahoo.com>
	<201002261056.37618.jbe@pengutronix.de>
	<1267180433.2778.56.camel@realization>
	<201002261248.03214.jbe@pengutronix.de>
Message-ID: <1267190973.2778.93.camel@realization>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On ven, 2010-02-26 at 12:48 +0100, Juergen Beisert wrote:
> Hi Alberto,
> 
> Alberto Panizzo wrote:
> > On ven, 2010-02-26 at 10:56 +0100, Juergen Beisert wrote:
> > > Fabio Estevam wrote:
> > > > > Are you sure that this works? Don't you see a lot of Bad
> > > > > blocks reports
> > > > > in boot messages?
> > > >
> > > > I followed the same approach used on other i.MX boards. This is what I
> > > > see: ...
> > > > NAND device: Manufacturer ID: 0xec, Chip ID: 0xaa (Samsung NAND 256MiB
> > > > 1,8V 8-bit) Scanning device for bad blocks
> > > > Bad eraseblock 42 at 0x000000540000
> > > > Bad eraseblock 125 at 0x000000fa0000
> > > > Bad eraseblock 887 at 0x000006ee0000
> > > > Bad eraseblock 1750 at 0x00000dac0000
> > > > Bad eraseblock 2046 at 0x00000ffc0000
> > > > Bad eraseblock 2047 at 0x00000ffe0000
> > > > Registering mxc_nand as whole device
> > > >
> > > > If I define it as:
> > > >
> > > > static struct mxc_nand_platform_data mx31pdk_nand_board_info = {
> > > > 	.width = 1,
> > > > 	.hw_ecc = 1,
> > > > 	.flash_bbt =1,
> > > > };
> > >
> > > Your bootloader also use a Bad Block Table? Then also your kernel should
> > > use it. If hardware ECC is in use, its always a good idea to collect the
> > > bad blocks into a BBT. Most of the time you can't control at which offset
> > > in the OOB data the NAND controller will store the ECC sum. There is the
> > > risk it will destroy manufacturer's bad block markers. So, its better to
> > > collect these marked bad blocks into a BBT the first time you use the
> > > NAND device. After that _only_ the BBT should be used to handle bad
> > > blocks (in the boot loader and the kernel).
> >
> > Thank you Juergen to participate on this thread.
> > Ok, so with this board shall be enabled the flash_bbt checking because
> > the bootloader uses it. But how do you explain that on Mine board the
> > kernel recognize it correctly and in Fabio's board the kernel prompt
> > disagree with the bootloader one? It is a kind of bootloader issue?
> 
> Here on my i.MX35 based system the bootloader reports:
> 
> NAND device: Manufacturer ID: 0x20, Chip ID: 0xac (ST Micro NAND 512MiB 1,8V 8-bit)
> Bad block table found at page 262080, version 0x01
> Bad block table found at page 262016, version 0x01
> nand_read_bbt: Bad block at 0x01d00000
> nand_read_bbt: Bad block at 0x10020000
> nand_read_bbt: Bad block at 0x10040000
> nand_read_bbt: Bad block at 0x10060000
> nand_read_bbt: Bad block at 0x10080000
> nand_read_bbt: Bad block at 0x100a0000
> nand_read_bbt: Bad block at 0x100e0000
> nand_read_bbt: Bad block at 0x10120000
> nand_read_bbt: Bad block at 0x10160000
> nand_read_bbt: Bad block at 0x101a0000
> nand_read_bbt: Bad block at 0x101c0000
> nand_read_bbt: Bad block at 0x10200000
> nand_read_bbt: Bad block at 0x10240000
> 
> And the starting kernel reports:
> 
> [...]
> NAND device: Manufacturer ID: 0x20, Chip ID: 0xac (ST Micro NAND 512MiB 1,8V 8-bit)
> Bad block table found at page 262080, version 0x01
> Bad block table found at page 262016, version 0x01
> nand_read_bbt: Bad block at 0x000001d00000
> nand_read_bbt: Bad block at 0x000010020000
> nand_read_bbt: Bad block at 0x000010040000
> nand_read_bbt: Bad block at 0x000010060000
> nand_read_bbt: Bad block at 0x000010080000
> nand_read_bbt: Bad block at 0x0000100a0000
> nand_read_bbt: Bad block at 0x0000100e0000
> nand_read_bbt: Bad block at 0x000010120000
> nand_read_bbt: Bad block at 0x000010160000
> nand_read_bbt: Bad block at 0x0000101a0000
> nand_read_bbt: Bad block at 0x0000101c0000
> nand_read_bbt: Bad block at 0x000010200000
> nand_read_bbt: Bad block at 0x000010240000
> [...]
> 
> Both are configured to use a BBT and will handle the bad blocks in the same
> manner.
> 
> Regards,
> Juergen
> 

Well, also for me. With Bbt active:

++Searching for BBT table in the flash ...
.
Found version 1 Bbt0 at block 2047 (0xffe0000)
Block 55 is bad
Block 1688 is bad
Block 1735 is bad
Block 1742 is bad
Total bad blocks: 4
... Read from 0x07ee0000-0x07f00000 at 0x00080000: ..
... Read from 0x07ed3000-0x07ed4000 at 0x0009f000: .
PMIC ID: 0x0000009b [Rev: 3.3]

...

NAND device: Manufacturer ID: 0xec, Chip ID: 0xaa (Samsung NAND 256MiB 1,8V 8-b)
Bad block table found at page 131008, version 0x01                              
Bad block table found at page 130944, version 0x01                              
nand_read_bbt: Bad block at 0x0000006e0000                                      
nand_read_bbt: Bad block at 0x00000d300000                                      
nand_read_bbt: Bad block at 0x00000d8e0000                                      
nand_read_bbt: Bad block at 0x00000d9c0000

That considering a block size of 64 pages, it is consistent.

But without bad block table enabled:

NAND device: Manufacturer ID: 0xec, Chip ID: 0xaa (Samsung NAND 256MiB 1,8V 8-b)
Scanning device for bad blocks                                                  
Bad eraseblock 4 at 0x000000080000                                              
Bad eraseblock 8 at 0x000000100000                                              
Bad eraseblock 9 at 0x000000120000                                              
Bad eraseblock 10 at 0x000000140000                                             
Bad eraseblock 11 at 0x000000160000                                             
Bad eraseblock 12 at 0x000000180000
all blocks..
Bad eraseblock 342 at 0x000002ac0000                                            
Bad eraseblock 1688 at 0x00000d300000                                           
Bad eraseblock 1735 at 0x00000d8e0000                                           
Bad eraseblock 1742 at 0x00000d9c0000                                           
Bad eraseblock 2046 at 0x00000ffc0000                                           
Bad eraseblock 2047 at 0x00000ffe0000 

All blocks went bad.
I had seen this behaviour developing the machine support for the
Armadillo500 board, and that was solved by updating the ecc layout
management due to bad 2K page sized NAND flash support.
With the new version (V2) of the driver this comes back..

-- 
Alberto!

        Be Persistent!
                - Greg Kroah-Hartman (FOSDEM 2010)
