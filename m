From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Fri, 5 Jul 2013 16:08:20 -0600
Subject: [PATCH v6 00/21] MBus DT binding: PCIe strikes back
In-Reply-To: <1373060372-32357-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1373060372-32357-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20130705220820.GA11787@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 05, 2013 at 06:39:11PM -0300, Ezequiel Garcia wrote:
 
> 			ranges =
> 			       <0x82000000 0 0x40000 MBUS_ID(0xf0, 0x01) 0x40000 0 0x00002000   /* Port 0.0 registers */
> 				0x82000000 0 0x42000 MBUS_ID(0xf0, 0x01) 0x42000 0 0x00002000   /* Port 2.0 registers */
> 				0x82000000 0 0x44000 MBUS_ID(0xf0, 0x01) 0x44000 0 0x00002000   /* Port 0.1 registers */
> 				0x82000000 0 0x48000 MBUS_ID(0xf0, 0x01) 0x48000 0 0x00002000   /* Port 0.2 registers */
> 				0x82000000 0 0x4c000 MBUS_ID(0xf0, 0x01) 0x4c000 0 0x00002000   /* Port 0.3 registers */
> 				0x82000800 0 0xe0000000 MBUS_ID(0x04, 0xe8) 0xe0000000 0 0x08000000 /* Port 0.0 MEM */
> 				0x81000800 0 0          MBUS_ID(0x04, 0xe0) 0xe8000000 0 0x00100000 /* Port 0.0 IO */>;

This is a good try, but this coding doesn't work...

Recall the long discussion that came up during the original
development of this binding. The OF spec says this:

 In particular, the phys.hi fields of the child address spaces in the
 "ranges" property for PCI does not contain
 the same information as "reg" property entries within PCI nodes. The
 only information that is present in
 "ranges" phys.hi entries are the non-relocatable, prefetchable and
 the PCI address space bits for which the en-
 try applies. I.e., only the n, p and ss bits are present; the
 bbbbbbbb, ddddd, fff and rrrrrrrr fields are 0.

 When an address is to be mapped through a PCI bus bridge node, the
 phys.hi value of the address to be mapped
 and the child field of a "ranges" entry should be masked so that only
 the ss bits are compared. I.e., the only
 portion of phys.hi that should participate in the range determination
 is the address space indicator (the ss bits).

Which forbids (0x82000800 .. ..) from being in a ranges

I don't have an idea how to encode MBUS_ID in the PCI-E ranges :(

Arnd? Didn't you have some idea?

FWIW, I like removing the string tables from the driver, you could
keep the fake MBUS-ID and retain that change by adding a
marvell,target-id type property to the bridges...

Jason
