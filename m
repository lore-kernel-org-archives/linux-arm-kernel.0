From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 23 May 2013 11:53:21 +0200
Subject: [PATCH 0/9] Switch internal registers address to 0xF1 on Armada
 370/XP
In-Reply-To: <20130522181953.GD12320@obsidianresearch.com>
References: <1369132414-18959-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201305221633.46705.arnd@arndb.de> <20130522170643.54a2b9d2@skate>
 <201305221735.11815.arnd@arndb.de> <20130522180842.7edcc3ee@skate>
 <20130522163557.GC27348@1wt.eu> <20130522184250.1d5f2f10@skate>
 <20130522164936.GE31290@titan.lakedaemon.net>
 <20130522185757.60091a66@skate>
 <20130522181953.GD12320@obsidianresearch.com>
Message-ID: <20130523115321.660fa521@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Gunthorpe,

On Wed, 22 May 2013 12:19:53 -0600, Jason Gunthorpe wrote:

> Just to chime in a bit here.. We also hit this problem on Kirkwood,
> and fixed it in the bootloader. The power on default for Kirkwood
> chips is 0xd0000000 and Linux has long required the bootloader to move
> it.. Not sure why 370/XP dropped this.

This is a mistake from the original support of Armada 370/XP. What we
want to do now is to fix this mistake by moving everybody to 0xf1 and
align with the other Marvell EBU platforms.

What we're proposing here is only a *temporary* solution to provide a
smooth upgrade path for users of platforms that have an old bootloader.
This temporary solution is meant to go away when we have a good
confidence that new bootloaders for OpenBlocks and Mirabox are
available, and that enough users will have seen the warning that we
plan to add in two release cycles.

> Also, can you talk abit more about how this works to give more low DDR
> memory? The docs say you can't overlap windows, and DDR CS's have a
> power of two size/alignment requirement.
> 
> Does this mean the desire is to place a DDR CS from 3G -> 3.5G?

The MBus windows can overlap the DRAM chip selects. On Armada 370/XP,
there is a tuple of registers, called the MBus Bridge Window Base
Register and the MBus Bridge Window Control Register, that provide a
range of addresses for which the CPU should go look at MBus windows
instead of looking at the DRAM.

So, on a board with 8 GB of RAM, you have one DRAM chip select for the
first 4 GB of RAM, and a second chip select for the last 4 GB of RAM.
This is currently visible with the Armada XP GP board:

# cat /sys/kernel/debug/mvebu-mbus/sdram 
[0] 0000000000000000 - 0000000100000000 : cs0
[1] 0000000100000000 - 0000000200000000 : cs1
[2] disabled
[3] disabled

And the internal registers (be they mapped at 0xd0000000 of 0xf1000000)
and all the other windows (for PCIe and al) are overlapping the DRAM CS.

This is not a problem, because the MBus Bridge Window {Base,Control}
Register tell the CPU that memory accesses between addresses X and Y
are for MBus windows, and the other accesses are for the DRAM.

With the old bootloader, the MBus Bridge Window Base is set to
0xC0000000 (3G), so you cannot benefit from this additional memory
between 3G and 3.5G. But the only two consumers platforms available
that are using the old bootloaders have 3 GB of RAM or less (the
OpenBlocks has an expansion slot, but I believe it's reasonable to ask
the user to upgrade the bootloader if he wants to use a larger RAM on
this specific board).

With the new bootloader, the MBus Bridge Window Base is set to
0xE0000000 (3.5 GB). So any access in [ 0 ; 3.5 GB ] and [ 4 GB; ... ]
will go to the DRAM, and access between [ 3.5 GB ; 4 GB ] will go to
the MBus windows, including the internal registers one.

Does that make sense to explain how we can actually save 512 MB of RAM ?

> > For example, I'm currently booting alternatively with an old and a new
> > bootloader (to test that things work properly), and in both cases I'm
> > booting old style, DTB-appended, with ATAGs.
> 
> IMHO the DTB must match both the hardware *and* the bootloader. The
> bootloader is setting the address map, the DTB contains that address
> map, they must all match together.
> 
> Using a DTB property really is the right way to go.
> 
> Yes, I realize this means you now need to vary the DTB you will use
> depending on boot loader version (see below)
> 
> To use a DTB property, the approach would be to make the internal regs
> base address inside the kernel dynamic instead of hard coded. Do not
> remap the internal regs, just use whatever the bootloader setup
> directly. The kernel can early parse the FDT to find the correct
> address, instead of hardwiring an arbitary base address.
> 
> Also, the blind remapping approach in these patches is sketchy. If the
> bootloader has placed some other mapping at the 0xf1.. target address
> this will blow up. The mbus driver gets it right, to change the window
> layout you have to clear out and disable all window registers except
> for internal, then rebuild the entire mapping from scratch to avoid
> address overlap conflicts. That approach doesn't seem possible from
> early assembly.. :(
> 
> All things considered, I think it is much safer and cleaner to make
> the physical base of internal regs dynamic within the kernel, than to
> try and relocate it during early boot.

We believe it is not safer to make the physical base of internal regs
dynamic within the kernel. Really, the 0xd0 usage should be seen as a
mistake, and the goal is to align everybody to use 0xf1 for all Marvell
platforms.

> So, please consider this instead. The kernel has functions already to
> parse the fdt directly, they can be called before anything attempts to
> map internal regs based stuff.
> 
> You can combine this idea with the CP15 signalling mechanism. Check
> CP15 and use it to alter the DTB, similar to how ATAGs are used to
> fixup the DTB. Don't relocate the registers.

Where would the code doing this would sit? Remember, this is a
temporary solution that we want to get rid of after some time. So I've
been very careful in this proposal to only touch mvebu-specific code.

With what you're proposing, we would have to add something like:

	if (of_machine_is_compatible("marvell,armada-370-xp")) {
		/* do our crap */
	}

in some ARM generic code. That's something we would definitely like to
avoid, and I'm pretty the ARM maintainers would also like to avoid such
SoC-specific code spreading into generic kernel places.

Could you be more specific about where such early code would be
located, and what it would look like? I'm pretty sure once we will see
it, we'll clearly see that it's not acceptable to put such SoC-specific
code in a generic place of the kernel.

Thanks for your feedback,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
