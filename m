From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 18 Jun 2013 10:07:51 -0300
Subject: [PATCH v3 00/12] MBus device tree binding
In-Reply-To: <51C04591.3010206@gmail.com>
References: <1371554737-25319-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <51C04591.3010206@gmail.com>
Message-ID: <20130618130750.GB25416@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sebastian,

On Tue, Jun 18, 2013 at 01:33:37PM +0200, Sebastian Hesselbarth wrote:
> On 06/18/13 13:25, Ezequiel Garcia wrote:
> > In the example below there's an extract of a device tree showing how
> > the internal-regs and pcie nodes can be represented:
> >
> > 	#define MBUS_ID(target,attributes) (((target) << 24) | ((attributes) << 16))
> >
> > 	soc {
> > 		compatible = "marvell,armadaxp-mbus";
> > 		reg = <0 0xd0020000 0 0x100>, <0 0xd0020180 0 0x20>;
> >
> > 		ranges = <0xffff0001 0 0 0xd0000000 0x100000   /* internal-regs */
> > 			  0xffff0000 0 0 0xe0000000 0x8100000  /* pcie */
> > 			  MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000
> > 			  MBUS_ID(0x01, 0x2f) 0 0 0xf0000000 0x8000000>;
> 
> Ezequiel,
> 
> you should update PCIE above (and possibly anywhere else) too.
> 

Right. I've just checked and I only forgot to update the PCIe first-cell
(0xffff0000 -> 0xffff0002) in this cover-letter. The device tree files 
and the documentation look correct.

Sorry for the confusion!

> > 		pcie-controller {
> > 			compatible = "marvell,armada-xp-pcie";
> > 			status = "okay";
> > 			device_type = "pci";
> >
> > 			#address-cells = <3>;
> > 			#size-cells = <2>;
> >
> > 			ranges =
> > 			       <0x82000000 0 0x40000 0xffff0001 0x40000 0 0x00002000   /* Port 0.0 registers */
> > 				0x82000000 0 0x42000 0xffff0001 0x42000 0 0x00002000   /* Port 2.0 registers */
> > 				0x82000000 0 0x44000 0xffff0001 0x44000 0 0x00002000   /* Port 0.1 registers */
> > 				0x82000000 0 0x48000 0xffff0001 0x48000 0 0x00002000   /* Port 0.2 registers */
> > 				0x82000000 0 0x4c000 0xffff0001 0x4c000 0 0x00002000   /* Port 0.3 registers */
> > 				0x82000000 0 0x80000 0xffff0001 0x80000 0 0x00002000   /* Port 1.0 registers */
> > 				0x82000000 0 0x82000 0xffff0001 0x82000 0 0x00002000   /* Port 3.0 registers */
> > 				0x82000000 0 0xe0000000 0xffff0000 0 0 0x08000000   /* non-prefetchable memory */
> > 				0x81000000 0 0 0xffff0000 0x8000000 0 0x00100000>; /* downstream I/O */
> 
> Here for example.
> 
> > Changes from v2:
> >   * Replaced the PCIe mapping with 0xffff0002, to avoid using a representation
> >     that might correspond to a possible window id.
> 
> Out of curiosity, how will these fake mappings play with LPAE? If you
> extend possible address space to >32b the lower bits may belong to valid
> addresses.
> Maybe you can (already do?) ignore that because of the 32b address
> restriction for internal registers IIRC Thomas mentioned?
> 

That's a tricky question. The best explanation I can give you is that
these fake mappings belong to the MBus children address space, which is
different from the physical address space where LPAE comes into play.

This MBus children address space consists of two 32-bit cells:

IIAA00CC 00oooooo

The first one encodes the target ID and attribute in its upper 16 bits,
and custom values for the fake mappings in the lower 8 bits.
The second one encodes the offset into the MBus decoding window, and
this window can be as large as 4 GiB.

The address space I've just described is not the physical 64-bit address
space; it's the one where MBus children sit.

I hope I understood you're question, and I hope any of the above makes
sense!

-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
