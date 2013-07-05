From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 6 Jul 2013 00:40:26 +0200
Subject: [PATCH v6 00/21] MBus DT binding: PCIe strikes back
In-Reply-To: <1373060372-32357-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1373060372-32357-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <201307060040.27208.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 05 July 2013, Ezequiel Garcia wrote:
> See the previous version of this patchset for further context:
> 
> http://www.mail-archive.com/devicetree-discuss at lists.ozlabs.org/msg35753.html
> 
> This new proposal is an attempt to address some issues raised about the PCIe
> 'fake' windows mapping present in the previous version.
> 
> Instead of defining a 'fake' MBUS_ID(0xf0, 0x02) region for the whole
> PCIe memory and IO space, we use real target ID and attribute for the windows.

Hi Ezequiel,

This looks really nice, and I is getting very close to where I think it
needs to be headed. I'll have to do a more thorough review, but for now there
is only one detail that I think you should change (we can argue about that):

> 		pcie-controller {
> 			compatible = "marvell,armada-xp-pcie";
> 			status = "okay";
> 			device_type = "pci";
> 
> 			#address-cells = <3>;
> 			#size-cells = <2>;
> 
> 			ranges =
> 			       <0x82000000 0 0x40000 MBUS_ID(0xf0, 0x01) 0x40000 0 0x00002000   /* Port 0.0 registers */
> 				0x82000000 0 0x42000 MBUS_ID(0xf0, 0x01) 0x42000 0 0x00002000   /* Port 2.0 registers */
> 				0x82000000 0 0x44000 MBUS_ID(0xf0, 0x01) 0x44000 0 0x00002000   /* Port 0.1 registers */
> 				0x82000000 0 0x48000 MBUS_ID(0xf0, 0x01) 0x48000 0 0x00002000   /* Port 0.2 registers */
> 				0x82000000 0 0x4c000 MBUS_ID(0xf0, 0x01) 0x4c000 0 0x00002000   /* Port 0.3 registers */
> 				0x82000800 0 0xe0000000 MBUS_ID(0x04, 0xe8) 0xe0000000 0 0x08000000 /* Port 0.0 MEM */
> 				0x81000800 0 0          MBUS_ID(0x04, 0xe0) 0xe8000000 0 0x00100000 /* Port 0.0 IO */>;

>From all I can tell, this is a correct representation of the
translation windows. The one change you made from what I suggested
(either intentionally or because I didn't make myself clear enough)
is that you keep encoding the aperture in the ranges property of
the pcie node.

	0x82000800 0 0xe0000000 MBUS_ID(0x04, 0xe8) 0xe0000000 0 0x08000000 /* Port 0.0 MEM */
			^^^^				^^^^		^^^

This describes the intended setting of the aperture in the mbus, not
the translation that is performed by the pcie-controller as I suggested.
That would look like

	0x82000800 0 0 MBUS_ID(0x04, 0xe8) 0 1 0 /* Port 0.0 MEM */

iow the first 4GB of the 0x82000800 memory space get translated to 4GB
at MBUS_ID(0x04, 0xe8), and the aperture is applied by translating a
small section of that into host mmio space.

The advantage of your approach is that you can keep the existing code
that extracts the aperture (0xe0000000-0xe8000000) from the 
pcie-controller node, and you don't have to find out the aperture
from separate DT property or from looking at the remaining available
address space in mbus.

The disadvantage is that you have mbus policy spread out between the
ranges properties of the mbus node and the pcie node, rather than
having the pcie-controller node just describe the hardware capabilities.

This is actually more of a problem for the I/O space, which is still not
correctly represented:

	0x81000800 0 0 MBUS_ID(0x04, 0xe0) 0xe8000000 0 0x00100000

is not what the hardware does, the hardware probably has something
like 

	0x81000800 0 0 MBUS_ID(0x04, 0xe0) 0 1 0

i.e. the PIO registers are at the start of the 4GB MBUS window and
you want them to get mapped at 0xe8000000, but that is no business
of the PCIe node. Since the addresses for I/O space are fixed (unlike
memory space, which is sized dynamically per port), it would be
straightforward to put the mappings into the mbus node:

	MBUS_ID(0x04, 0xe0) 0x00000 0xe8000000 0x10000 
	MBUS_ID(0x04, 0xe1) 0x10000 0xe8010000 0x10000
	MBUS_ID(0x04, 0xe2) 0x20000 0xe8020000 0x10000

Unfortunately, the number of mapping windows in mbus is very limited
on Armada XP, so you'd run out of windows too fast by mapping them
all at boot time. The options here are to either put them into the
ranges property anyway but get the mbus driver to not map them by
default, or to encode the policy in a different way. Note that the
physical addresses do not actually have to be contiguous any more now,
so one option would be for mbus to just fill the holes whenever
the pcie driver needs an I/O space window, but there we get close
to the "fully dynamic" model again.

	Arnd
