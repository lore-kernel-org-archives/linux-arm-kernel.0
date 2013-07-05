From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 6 Jul 2013 00:54:22 +0200
Subject: [PATCH v6 00/21] MBus DT binding: PCIe strikes back
In-Reply-To: <20130705220820.GA11787@obsidianresearch.com>
References: <1373060372-32357-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130705220820.GA11787@obsidianresearch.com>
Message-ID: <201307060054.23086.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 06 July 2013, Jason Gunthorpe wrote:
> This is a good try, but this coding doesn't work...
> 
> Recall the long discussion that came up during the original
> development of this binding. The OF spec says this:
> 
>  In particular, the phys.hi fields of the child address spaces in the
>  "ranges" property for PCI does not contain
>  the same information as "reg" property entries within PCI nodes. The
>  only information that is present in
>  "ranges" phys.hi entries are the non-relocatable, prefetchable and
>  the PCI address space bits for which the en-
>  try applies. I.e., only the n, p and ss bits are present; the
>  bbbbbbbb, ddddd, fff and rrrrrrrr fields are 0.
> 
>  When an address is to be mapped through a PCI bus bridge node, the
>  phys.hi value of the address to be mapped
>  and the child field of a "ranges" entry should be masked so that only
>  the ss bits are compared. I.e., the only
>  portion of phys.hi that should participate in the range determination
>  is the address space indicator (the ss bits).
> 
> Which forbids (0x82000800 .. ..) from being in a ranges

ah, and I thought Ezequiel was being more clever than what I had suggested

> I don't have an idea how to encode MBUS_ID in the PCI-E ranges :(
> 
> Arnd? Didn't you have some idea?

The way I described it during the last review, I suggested using
the middle cell of the PCI address here. Since the PCIe port
is 32 bit only, it's otherwise unused. We can do one of two things
here:

a) put the port number in the second cell

   0x82000000 1 0xe0000000 MBUS_ID(0x04, 0xe8) 0xe0000000 0 0x08000000 /* Port 0.0 MEM */
   0x82000000 2 0xe0000000 MBUS_ID(0x04, 0xe9) 0xe0000000 0 0x08000000 /* Port 1.0 MEM */

b) translate the entire MBUS space here

   0x82000000 0 0 0 0 0x1000000 0 /* all MBUS_IDs */

In both cases, the individual ports would have another non-empty
ranges property

a) 
   0x82000000 1 0xe0000000 0x82000000 0 0xe0000000 0x08000000 /* ranges for port 0.0 */

b)
   0x82000000 MBUS_ID(0x04, 0xe8) 0xe0000000 0x82000000 0 0xe0000000 0 0x08000000

I left out the change I suggested in my other reply to not describe
the aperture in this node but translate the entire 4GB space.

	Arnd
