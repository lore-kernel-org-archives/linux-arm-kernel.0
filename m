From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sat, 6 Jul 2013 00:37:32 +0200
Subject: [PATCH v6 00/21] MBus DT binding: PCIe strikes back
In-Reply-To: <20130705220820.GA11787@obsidianresearch.com>
References: <1373060372-32357-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130705220820.GA11787@obsidianresearch.com>
Message-ID: <20130706003732.2013fd8e@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Gunthorpe,

Thanks for your quick feedback!

On Fri, 5 Jul 2013 16:08:20 -0600, Jason Gunthorpe wrote:
> On Fri, Jul 05, 2013 at 06:39:11PM -0300, Ezequiel Garcia wrote:
>  
> > 			ranges =
> > 			       <0x82000000 0 0x40000 MBUS_ID(0xf0, 0x01) 0x40000 0 0x00002000   /* Port 0.0 registers */
> > 				0x82000000 0 0x42000 MBUS_ID(0xf0, 0x01) 0x42000 0 0x00002000   /* Port 2.0 registers */
> > 				0x82000000 0 0x44000 MBUS_ID(0xf0, 0x01) 0x44000 0 0x00002000   /* Port 0.1 registers */
> > 				0x82000000 0 0x48000 MBUS_ID(0xf0, 0x01) 0x48000 0 0x00002000   /* Port 0.2 registers */
> > 				0x82000000 0 0x4c000 MBUS_ID(0xf0, 0x01) 0x4c000 0 0x00002000   /* Port 0.3 registers */
> > 				0x82000800 0 0xe0000000 MBUS_ID(0x04, 0xe8) 0xe0000000 0 0x08000000 /* Port 0.0 MEM */
> > 				0x81000800 0 0          MBUS_ID(0x04, 0xe0) 0xe8000000 0 0x00100000 /* Port 0.0 IO */>;
> 
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

Ah, right, I missed this part of the OF specification. Indeed, having
the ddddd bits non-zero was critical here to allow the PCIe driver to
find which MBUS_ID(x, y) to use for a particular PCIe interface.

> I don't have an idea how to encode MBUS_ID in the PCI-E ranges :(
> 
> Arnd? Didn't you have some idea?
> 
> FWIW, I like removing the string tables from the driver, you could
> keep the fake MBUS-ID and retain that change by adding a
> marvell,target-id type property to the bridges...

The problem we were trying to address here is that apparently the fake
MBUS-ID was not seen by Arnd as a correct solution, if we understood
correctly what Arnd said in
http://www.mail-archive.com/devicetree-discuss at lists.ozlabs.org/msg34650.html:

"""
Using 0xffff0002 as a placeholder for the pcie translation is definitely
better than 0xffff0000 as you had before, but let me ask again in case
you missed it the last time (and sorry if I missed the answer):

Why not just put the actual translation here the way it happens for each
of the PCIe ports? With the definition here, the PCIe driver actually
has no way to figure out what settings the windows need to use!
"""

We're not sure how to handle this comment properly in terms of DT
binding. What the PCIe driver needs is:

 *) One global range of addresses for PCIe memory regions and one global
    range of addresses for PCIe I/O regions. Those were until the v5 of
    this patch set expressed using a fake MBUS_ID(0xf0, 0x02). Those
    are global to all PCIe interfaces.

 *) The target and attribute values for MEM and I/O windows, that are
    per-PCIe interface.

As long as we can get those two informations from the DT, I believe
we're open to all your suggestions on how to encode them.

Thanks!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
