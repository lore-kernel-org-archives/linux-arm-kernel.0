From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 8 Feb 2013 09:14:20 +0100
Subject: Giving special alignment/size constraints to the Linux PCI core?
In-Reply-To: <CAErSpo7hwG89LTO+4+eqT_Gb+yUn1XKHYJ8CnnZcf_FPo-Kpyw@mail.gmail.com>
References: <20130130120344.GA29490@avionic-0098.mockup.avionic-design.de>
 <2776630.gp5gC9tvLk@wuerfel>
 <20130131180249.GA30869@obsidianresearch.com>
 <201301312046.22560.arnd@arndb.de>
 <20130131224459.GA11846@obsidianresearch.com>
 <20130206175128.1b64196d@skate>
 <20130206170903.GA28198@obsidianresearch.com>
 <20130206181852.4eca53e3@skate>
 <20130206175019.GA24248@obsidianresearch.com>
 <20130207165009.73b1f340@skate>
 <CAErSpo7hwG89LTO+4+eqT_Gb+yUn1XKHYJ8CnnZcf_FPo-Kpyw@mail.gmail.com>
Message-ID: <20130208091420.703a39b4@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Bjorn Helgaas,

On Thu, 7 Feb 2013 21:21:57 -0700, Bjorn Helgaas wrote:

> Huh.  That hardware looks less and less like a P2P bridge all the time
> :(  You can't configure it via standard PCI config accesses, and the
> aperture alignment and size constraints sound completely non-standard.
>  Are the specs for this thing public?

The specs for the Armada XP are not yet public, but the one for earlier
Marvell SoC families are, and the PCIe stuff works basically the same.
The main difference between the Kirkwood family and Armada XP is that
Kirkwood had only 2 PCIe interfaces, so we could perfectly fine do a
static allocation of address decoding windows (see the four PCIe windows
in arch/arm/mach-kirkwood/addr-map.c:addr_map_info[]), while the Armada
XP has 10 PCIe interfaces, which makes the static allocation solution
unreasonable.

The list of publicly available specifications for Marvell EBU SoC is
available at Documentation/arm/Marvell/README. For Kirkwood, I would
recommend
http://www.marvell.com/embedded-processors/kirkwood/assets/FS_88F6180_9x_6281_OpenSource.pdf.
See chapter 2.3:

  The PCI Express address decoding scheme restricts the address window
  to a size of 2^n, and to a start address that is aligned to the window
  size.

> I could imagine changing pcibios_window_alignment() to take the
> resource, so it could deal with the alignment question (though I
> haven't looked in detail and there might be some implementation issue
> with that).
> 
> With regard to the size issue (3MB window using 4MB of address space),
> I can't think of a reasonable way to teach the PCI core about both
> sizes.  But is there any reason to program the bridge for a 3MB window
> instead of a 4MB window, given that there's nothing else we can do
> with the extra 1MB anyway?  Is a 3MB window even possible?  I would
> think something that must be aligned on its size would be restricted
> to power-of-2 sizes anyway, just like PCI BARs are.  Maybe you can
> just always round up window sizes to a power of 2?

The window sizes are power of two sizes. I didn't realize that it was
also the case for PCI BARs. Then there is no problem with the size I
guess, and only a problem of alignment. Having the possibility to
get the resource and return a fixed up start address would solve the
problem I'd say.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
