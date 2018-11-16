From: anton@picapica.im (Anton)
Date: Fri, 16 Nov 2018 16:48:32 +0100
Subject: [BUG] Is "mem=" kernel command line parameter broken on ARM?
In-Reply-To: <a2071791-0a95-282c-0c56-33108438186f@ti.com>
References: <20181116133236.GA27819@picapica.im>
 <20181116140627.GW30658@n2100.armlinux.org.uk>
 <20181116145216.GA3365@picapica.im>
 <20181116150806.GX30658@n2100.armlinux.org.uk>
 <20181116153026.GA6803@picapica.im>
 <a2071791-0a95-282c-0c56-33108438186f@ti.com>
Message-ID: <20181116154832.GA9485@picapica.im>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 16, 2018 at 09:03:29PM +0530, Lokesh Vutla wrote:
> 
> 
> On 16/11/18 9:00 PM, Anton wrote:
> > On Fri, Nov 16, 2018 at 03:08:06PM +0000, Russell King - ARM Linux wrote:
> > > On Fri, Nov 16, 2018 at 03:52:16PM +0100, Anton wrote:
> > > > On Fri, Nov 16, 2018 at 02:06:27PM +0000, Russell King - ARM Linux wrote:
> > > > > On Fri, Nov 16, 2018 at 02:32:36PM +0100, Anton wrote:
> > > > > > Hello
> > > > > > 
> > > > > > 
> > > > > > I am trying to boot Linux on a custom board having SAMA5D21 chip.
> > > > > > It has 64MiB of DRAM. So I thought it was a good idea to pass amount
> > > > > > of physical memory available through command line parameter "mem=64M".
> > > > > 
> > > > > mem specifies not only the amount of memory, but also its location.
> > > > > mem=64M tells the kernel that there is 64M at physical address zero.
> > > > > Your device may not have memory at physical address zero, so that
> > > > > will cause the kernel to try to use something that isn't RAM as
> > > > > memory.
> > > > > 
> > > > > My guess is that memory starts at 0x20000000 on your platform based
> > > > > on what you've provided in uboot, but I can't be certain.
> > > > > 
> > > > 
> > > > But this does not explain successful boot with mem=512M.
> > > > Yes, physical memory (DRAM mapping) starts at physical address 0x20000000.
> > > > 0x20000000 = 512M so in this case kernel should try to use address range
> > > > from 0 to 0x20000000 and fail, because DRAM is mapped above that range.
> > > > 
> > > > mem=64M at 0x20000000 crashes in a same way:
> > > > 
> > > > => setenv bootargs console=ttyS0,115200 earlyprintk root=/dev/mmcblk1p2 rw rootwait mem=64M at 0x20000000
> > > > => boot
> > > > reading at91-sama5d2_xplained_at86rf230.dtb
> > > > 29351 bytes read in 22 ms (1.3 MiB/s)
> > > > reading zImage
> > > > 4320368 bytes read in 277 ms (14.9 MiB/s)
> > > > ## Flattened Device Tree blob at 21000000
> > > >     Booting using the fdt blob at 0x21000000
> > > >     Loading Device Tree to 3fb57000, end 3fb612a6 ... OK
> 
> U-boot is relocating the DT to 3fb57000. Before booting  can you set
> fdt_high as 0xffffffff and try again?
> 
> Thanks and regards,
> Lokesh
> 

Hmm, that explains many things, thank you.

> fdt_high as 0xffffffff

Yes, this makes kernel boot successful, with mem=64M at 0x20000000

Btw, this is not question for this mailing list, but why does u-boot
relocate device tree, is there any reason 0x21000000 is not good enough
as a device tree location?
