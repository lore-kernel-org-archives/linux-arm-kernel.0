From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 26 Mar 2014 11:18:28 -0600
Subject: Armada XP (mvebu) PCIe memory (BAR/window) re-allocation
In-Reply-To: <20140326180634.4ac266b2@skate>
References: <CAFJTrDt7OrtE4B52419F2KGbmXeLR9NEcgF6yMTMUBe5vdKwfg@mail.gmail.com>
 <20140326180634.4ac266b2@skate>
Message-ID: <20140326171828.GA31887@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 26, 2014 at 06:06:34PM +0100, Thomas Petazzoni wrote:

> Thanks for your report. I'm adding Jason Gunthorpe in Cc, as his
> insights are always very helpful when investigating PCIe issues on
> Marvell platforms.

To me, this looks like standard problems with hot plug - unrelated to
Marvell.

Actually supporting the full generality of hot plug requires someone
pre-allocate and reserve bridge window address space. On x86 the BIOS
knows which slots are hot plug capable and ensures that address space
is set aside for that slot when doing window assignment. Linux will
just keep the BIOS assignment and when the hot plug happens the extra
space is used.

What you seem to be seeing is that Linux does an optimal allocation at
boot, and the PCI-E switch port that connects to your hot plug slot is
not allocated any spare address space for a future device.

During rescan there is no free address space to assign to the new
device so everything blows up.

I know there are some provisions in the PCI core to solve this issue,
I know on x86 the BIOS plays a role, but I'm not familiar enough with
the details to give you an exact path to solve your problem, other
than to say, at first boot you need to arrange for there to be extra
address space available.

A really simple dumb hack that might work is to change the order of
the PCI-E ports on the Armada (I think you can do this through the
DT). What you want is to place the port connected to the PLX last.
The goal here is to have it do address assignment last, so it will get
the last chunk of address space, and will have room to grow into
unused space, instead of being blocked by another port.

Regards,
Jason
