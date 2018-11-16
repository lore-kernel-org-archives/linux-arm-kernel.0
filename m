From: anton@picapica.im (Anton)
Date: Fri, 16 Nov 2018 16:30:26 +0100
Subject: [BUG] Is "mem=" kernel command line parameter broken on ARM?
In-Reply-To: <20181116150806.GX30658@n2100.armlinux.org.uk>
References: <20181116133236.GA27819@picapica.im>
 <20181116140627.GW30658@n2100.armlinux.org.uk>
 <20181116145216.GA3365@picapica.im>
 <20181116150806.GX30658@n2100.armlinux.org.uk>
Message-ID: <20181116153026.GA6803@picapica.im>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 16, 2018 at 03:08:06PM +0000, Russell King - ARM Linux wrote:
> On Fri, Nov 16, 2018 at 03:52:16PM +0100, Anton wrote:
> > On Fri, Nov 16, 2018 at 02:06:27PM +0000, Russell King - ARM Linux wrote:
> > > On Fri, Nov 16, 2018 at 02:32:36PM +0100, Anton wrote:
> > > > Hello
> > > > 
> > > > 
> > > > I am trying to boot Linux on a custom board having SAMA5D21 chip.
> > > > It has 64MiB of DRAM. So I thought it was a good idea to pass amount
> > > > of physical memory available through command line parameter "mem=64M".
> > > 
> > > mem specifies not only the amount of memory, but also its location.
> > > mem=64M tells the kernel that there is 64M at physical address zero.
> > > Your device may not have memory at physical address zero, so that
> > > will cause the kernel to try to use something that isn't RAM as
> > > memory.
> > > 
> > > My guess is that memory starts at 0x20000000 on your platform based
> > > on what you've provided in uboot, but I can't be certain.
> > > 
> > 
> > But this does not explain successful boot with mem=512M.
> > Yes, physical memory (DRAM mapping) starts at physical address 0x20000000.
> > 0x20000000 = 512M so in this case kernel should try to use address range
> > from 0 to 0x20000000 and fail, because DRAM is mapped above that range.
> > 
> > mem=64M at 0x20000000 crashes in a same way:
> > 
> > => setenv bootargs console=ttyS0,115200 earlyprintk root=/dev/mmcblk1p2 rw rootwait mem=64M at 0x20000000
> > => boot
> > reading at91-sama5d2_xplained_at86rf230.dtb
> > 29351 bytes read in 22 ms (1.3 MiB/s)
> > reading zImage
> > 4320368 bytes read in 277 ms (14.9 MiB/s)
> > ## Flattened Device Tree blob at 21000000
> >    Booting using the fdt blob at 0x21000000
> >    Loading Device Tree to 3fb57000, end 3fb612a6 ... OK
> > 
> > Starting kernel ...
> > 
> > Booting Linux on physical CPU 0x0
> > Linux version 4.19.2 (user at gentoo) (gcc version 7.3.0 (Buildroot 2018.02-rc1-00043-g06197ed294)) #1 Wed Nov 14 22:29:10 +04 2018
> > CPU: ARMv7 Processor [410fc051] revision 1 (ARMv7), cr=10c53c7d
> > CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
> > OF: fdt: Machine model: Atmel SAMA5D2 Xplained
> > bootconsole [earlycon0] enabled
> > Memory policy: Data cache writeback
> > Unable to handle kernel paging request at virtual address dfb57000
> 
> This is the address at which fdt_check_header() is trying to access the
> device tree.  It is 0xdfb57000 - 0xc000000 into memory, which is almost
> 512MB.

But these are virtual addresses, not physical ones, isn't it?
I think mem= restriction should not apply to them, maybe I'm wrong.

> When you specify your mem=64M parameter, it restricts the amount of
> memory available, and the requirement that the DT is in the RAM
> availble to the kernel is violated.  That causes the oops.

DT is loaded at physical 0x21000000, 16M from the beginning of the DRAM.
So it is located within 64M starting from 0x20000000

> The only solution to this is to lower the point where the DT is loaded
> when you restrict the amount of available memory.
> 
> -- 
> RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
> According to speedtest.net: 11.9Mbps down 500kbps up
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
