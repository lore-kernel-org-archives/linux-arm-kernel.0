From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 22 May 2013 13:36:29 -0600
Subject: [PATCH 0/9] Switch internal registers address to 0xF1 on Armada
 370/XP
In-Reply-To: <20130522185521.GR26249@lunn.ch>
References: <201305221633.46705.arnd@arndb.de> <20130522170643.54a2b9d2@skate>
 <201305221735.11815.arnd@arndb.de> <20130522180842.7edcc3ee@skate>
 <20130522163557.GC27348@1wt.eu> <20130522184250.1d5f2f10@skate>
 <20130522164936.GE31290@titan.lakedaemon.net>
 <20130522185757.60091a66@skate>
 <20130522181953.GD12320@obsidianresearch.com>
 <20130522185521.GR26249@lunn.ch>
Message-ID: <20130522193629.GA18344@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 22, 2013 at 08:55:21PM +0200, Andrew Lunn wrote:
> > Just to chime in a bit here.. We also hit this problem on Kirkwood,
> > and fixed it in the bootloader. The power on default for Kirkwood
> > chips is 0xd0000000 and Linux has long required the bootloader to move
> > it.. Not sure why 370/XP dropped this.
> > 
> > Also, can you talk abit more about how this works to give more low DDR
> > memory? The docs say you can't overlap windows, and DDR CS's have a
> > power of two size/alignment requirement.
> > 
> > Does this mean the desire is to place a DDR CS from 3G -> 3.5G?
> > 
> > > For example, I'm currently booting alternatively with an old and a new
> > > bootloader (to test that things work properly), and in both cases I'm
> > > booting old style, DTB-appended, with ATAGs.
> > 
> > IMHO the DTB must match both the hardware *and* the bootloader. The
> > bootloader is setting the address map, the DTB contains that address
> > map, they must all match together.
> > 
> > Using a DTB property really is the right way to go.
> 
> Interesting you said that, yet for your kirkwood, you hacked your
> bootloader rather than Linux.

Not sure what you mean?

I don't care where internal-regs is on my box, so least-work is to
have the bootloader produce a DTB and memory map that matches the
hardwired expectations in Linux.

Keep in mind, the internal regs base is already encoded in the DTB,
but it must be 0xf1.. otherwise Linux blows up. That is a Linux 'bug',
IMHO.

> I think in practice, it is not going to be easy to match the DTB to
> the hardware and the bootloader. Look at debians flash-kernel, used to
> prepare the kernel for an embedded system. For each target it has a
> database entry:

Right, that is why I suggested using the CP15 indication to fix the
DTB on-the-fly. Similar to how ATAGs fixes the DTB. This makes the
meaning of the CP15 bit much cleaner: 'If set, override the internal
regs base in the DTB to be XYZ, if clear do not mangle the DTB'

Obviously this mangling should migrate into the DTB aware bootloader.

> So it appends the kirkwood-dreamplug.dtb blob to the kernel.  What
> you are saying is that it also needs to somehow query the version of
> uboot running on the hardware so it can pick the correct dtb blob
> from a collection of kirkwood-dreamplug.dtb blobs and append it to
> the kernel.

IMHO, if you are already booted and running in Linux you can just look
at the DTB Linux is already using to find a match in the available
DTBs. A DTB database is only needed for the OS install.

> To keep the problems tractable, we should not really be dependent on
> the bootloader version.

So, as bootloaders get updated to support native DTB, how do you
envision supporting that through flash-kernel? The way to set the DTB
is bootloader version dependent..

Jason
