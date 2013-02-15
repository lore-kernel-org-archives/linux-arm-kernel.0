From: balbi@ti.com (Felipe Balbi)
Date: Fri, 15 Feb 2013 08:44:29 +0200
Subject: [RFC/NOT FOR MERGING 2/3] serial: omap: remove hwmod dependency
In-Reply-To: <alpine.DEB.2.00.1302141946110.11016@utopia.booyaka.com>
References: <1360840554-26901-1-git-send-email-balbi@ti.com>
 <1360840554-26901-2-git-send-email-balbi@ti.com>
 <20130214171253.GC7144@atomide.com>
 <20130214175650.GA25891@arwen.pp.htv.fi>
 <20130214181217.GA11806@atomide.com>
 <20130214192719.GB26679@arwen.pp.htv.fi>
 <20130214193911.GD11806@atomide.com>
 <alpine.DEB.2.00.1302141946110.11016@utopia.booyaka.com>
Message-ID: <20130215064429.GA30038@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Feb 14, 2013 at 08:47:53PM +0000, Paul Walmsley wrote:
> Hi,
> 
> On Thu, 14 Feb 2013, Tony Lindgren wrote:
> 
> > I don't think so as hwmod should only touch the sysconfig space
> > when no driver has claimed it.
> 
> hwmod does need to touch the SYSCONFIG register during pm_runtime suspend 
> and resume operations, and during device enable and disable operations.  
> Here's the relevant code:
> 
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=blob;f=arch/arm/mach-omap2/omap_hwmod.c;h=4653efb87a2721ea20a9fe06a30a6c204d6d2282;hb=HEAD#l2157
> 
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=blob;f=arch/arm/mach-omap2/omap_hwmod.c;h=4653efb87a2721ea20a9fe06a30a6c204d6d2282;hb=HEAD#l2195
> 
> Drivers shouldn't touch their IP block's SYSCONFIG registers.  They don't 

why not ? It's part of the driver's address space anyway. It's not part
of the IP in question (usb, ethernet, etc) but it's part of the TI
wrapper which usually involves a bridge (ocp2scp, ocp2axi, etc) plus the
TI-specific integration registers (revision, sysc, syss...).

So they're not part of the licensed IP, but they're part of the TI
wrapper around those.

> have anything specifically to do with the underlying device IP block, but 

of course they do, soft reset touches the underlying IP, so does force
idle, no idle, etc. But I agree that part is more changing the the
asynchronous idle request handshake.

> with the SoC integration, even though they live in the device's 
> memory-mapped address range.  It's unfortunate that TI didn't allocate a 
> separate, small address space for these registers, translated by the bus, 
> similar to the PCI-E Enhanced Configuration Access Mechanism:
> 
> http://wiki.osdev.org/PCI_Express#Extended_Configuration_Space
> 
> ... but that's unfortunately the reality of the OMAP hardware.

right.

> Regarding ioremap(), it seems reasonable for drivers to call ioremap(), as 
> long as the implementation of ioremap() can be overridden by the device's 
> bus.  PCI device drivers already do this -- albeit in a PCI-specific way 
> -- with pci_ioremap_bar():
> 
> http://git.kernel.org/?p=linux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git&a=search&h=HEAD&st=grep&s=pci_ioremap_bar
> 
> So instead of something bus-specific like that, a better way would be to 
> use something like:
> 
> va = dev->bus->ioremap( ... );
> va = dev->bus->iounmap( ... );
> 
> Any driver using such a mechanism would be intrinsically generic. 
> platform_bus could simply set its bus->ioremap to the existing ioremap() 
> function, while buses like a omap_hwmod_bus could use a function that 
> returned the address range that omap_hwmod_bus has already ioremap()ped.

although I'm not sure I like the idea exposed here, ioremap() is the
least of our problems :-) The biggest problem is having functioning PM
for all drivers on a DT boot with CPUIDLE enabled.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130215/8ce7c5cc/attachment.sig>
