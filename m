From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 18 Sep 2013 09:34:55 -0600
Subject: [PATCH 3/3] ARM: kirkwood: Move the nand node under the mbus node
In-Reply-To: <20130918122910.GA2563@localhost>
References: <20130917184433.GF21230@obsidianresearch.com>
 <20130918122910.GA2563@localhost>
Message-ID: <20130918153455.GA18122@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 18, 2013 at 09:29:11AM -0300, Ezequiel Garcia wrote:
> Hi Jason,
> 
> On Tue, Sep 17, 2013 at 12:44:33PM -0600, Jason Gunthorpe wrote:
> > There should be no nodes that are not children of the mbus. Move
> > the nand node under the mbus, and rework the board .dts files
> > to use an & reference to the nand node.

> Thanks for taking the time to do this. However, notice this may
> be not the accurate way of representing NAND in DT. 

These patches (nand and crypto) are just intended to fix the current
use of the mbus driver in the kirkwood boards, not fix the small
problems in the other drivers :)

> The kirkwood specification has a NAND Flash Registers section which
> speaks about registers and they seem to match (to some extent) the
> MVEBU's Device Bus.

Yes, the NAND IP is dual ported like crypto and has a register block
on the internal-regs block that controls the interface timing. The
driver should bind to this block and it should write to it.

However, it is not like devbus. devbus is a generic bus that can
connect to a wide range of devices we already have in the kernel, and
the bus timing configuration cannot be auto-detected. This is why you
need the 'mvebu-devbus' node. That node sets up the bus and then
allows a Linux generic child driver to bind to it.

NAND is not a generic bus, the NAND driver is the final consumer.

Further, the NAND driver itself should determine the bus timing in a
NAND specific way by following the ONFI defined auto detection
method, probably with some help from the MTD layer. That is to say,
determining the timing parmeters is intimately entangled with NAND
itself and should not be separated.

So, there is no need for a mvebu-devbus node with NAND, and the
orion-nand driver should be improved. As things are now the driver
relies on the firmware to set the correct interface timing and doesn't
touch anything.

> I haven't had time to investigate this any further and that's why
> NAND hasn't been moved yet.

Moving the block and improving the orion driver don't need to be
linked. The new location for the nand block doesn't preclude anything
:)

FWIW, my ideal NAND binding would look something like this:

               nand: nand at 012f {
                       compatible = "marvell,orion-nand";
                       #address-cells = <1>;
                       #size-cells = <1>;
                       reg = <MBUS_ID(0x01, 0x2f) 0 0x400
                              MBUS_ID(0xf0, 0x01)  ......>; // control regs
		       /* Clock frequency that is divided down to
		          generate timings */
                       clocks = <&gate_clk 7>; 
		       
		       /* One of these two, if read-gpio is specified
		          then chip-delay is not used, and the driver
		          waits for the flash to raise the RDY# pin to
		          indicate command completion */
                       chip-delay = <25>;
		       ready-gpio = <&gpio ...>;

		       // Indicate that the board cannot support faster timings
		       onfi-disabled-timings = <...>;

                       cle = <0>;
                       ale = <1>;
                       bank-width = <1>;
                       /* partition map  ... */
                       status = "disabled";
               };

Jason
