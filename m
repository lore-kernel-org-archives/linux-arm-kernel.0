From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 22 May 2013 12:19:53 -0600
Subject: [PATCH 0/9] Switch internal registers address to 0xF1 on Armada
 370/XP
In-Reply-To: <20130522185757.60091a66@skate>
References: <1369132414-18959-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201305221633.46705.arnd@arndb.de> <20130522170643.54a2b9d2@skate>
 <201305221735.11815.arnd@arndb.de> <20130522180842.7edcc3ee@skate>
 <20130522163557.GC27348@1wt.eu> <20130522184250.1d5f2f10@skate>
 <20130522164936.GE31290@titan.lakedaemon.net>
 <20130522185757.60091a66@skate>
Message-ID: <20130522181953.GD12320@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 22, 2013 at 06:57:57PM +0200, Thomas Petazzoni wrote:
> Dear Jason Cooper,
> 
> On Wed, 22 May 2013 12:49:36 -0400, Jason Cooper wrote:
> 
> > > As far as I know, a DT-capable bootloader doesn't pass any ATAG. The
> > > ARM register that was used to pass the pointer to the ATAGS is now used
> > > to pass the pointer to the DTB in memory.
> > 
> > So we could look for the ATAG magic or the dtb magic at that address,
> > then we know if we have an old or new bootloader...
> 
> No, because you can use an old bootloader, and still do some old-style
> appended-DTB booting, in which case you have a new bootloader
> (registers mapped at 0xf1), but you see the ATAG magic, which will make
> you think you booted from an old bootloader (registers mapped at 0xd0).

Just to chime in a bit here.. We also hit this problem on Kirkwood,
and fixed it in the bootloader. The power on default for Kirkwood
chips is 0xd0000000 and Linux has long required the bootloader to move
it.. Not sure why 370/XP dropped this.

Also, can you talk abit more about how this works to give more low DDR
memory? The docs say you can't overlap windows, and DDR CS's have a
power of two size/alignment requirement.

Does this mean the desire is to place a DDR CS from 3G -> 3.5G?

> For example, I'm currently booting alternatively with an old and a new
> bootloader (to test that things work properly), and in both cases I'm
> booting old style, DTB-appended, with ATAGs.

IMHO the DTB must match both the hardware *and* the bootloader. The
bootloader is setting the address map, the DTB contains that address
map, they must all match together.

Using a DTB property really is the right way to go.

Yes, I realize this means you now need to vary the DTB you will use
depending on boot loader version (see below)

To use a DTB property, the approach would be to make the internal regs
base address inside the kernel dynamic instead of hard coded. Do not
remap the internal regs, just use whatever the bootloader setup
directly. The kernel can early parse the FDT to find the correct
address, instead of hardwiring an arbitary base address.

Also, the blind remapping approach in these patches is sketchy. If the
bootloader has placed some other mapping at the 0xf1.. target address
this will blow up. The mbus driver gets it right, to change the window
layout you have to clear out and disable all window registers except
for internal, then rebuild the entire mapping from scratch to avoid
address overlap conflicts. That approach doesn't seem possible from
early assembly.. :(

All things considered, I think it is much safer and cleaner to make
the physical base of internal regs dynamic within the kernel, than to
try and relocate it during early boot.

So, please consider this instead. The kernel has functions already to
parse the fdt directly, they can be called before anything attempts to
map internal regs based stuff.

You can combine this idea with the CP15 signalling mechanism. Check
CP15 and use it to alter the DTB, similar to how ATAGs are used to
fixup the DTB. Don't relocate the registers.

Jason
