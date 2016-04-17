From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 17 Apr 2016 15:14:34 +0200
Subject: [PATCH] Axi-usb: Add support for 64-bit addressing.
In-Reply-To: <20160412140338.GA19311@rob-hp-laptop>
References: <1460360506-14692-1-git-send-email-navam@xilinx.com>
 <20160412140338.GA19311@rob-hp-laptop>
Message-ID: <4542055.HvdgVkDRYK@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 12 April 2016 09:03:38 Rob Herring wrote:
> On Mon, Apr 11, 2016 at 01:11:46PM +0530, Nava kishore Manne wrote:
> > This patch updates the driver to support 64-bit DMA
> > addressing.
> > 
> > Signed-off-by: Nava kishore Manne <navam@xilinx.com>
> > ---
> >  .../devicetree/bindings/usb/udc-xilinx.txt         |  3 +-
> >  drivers/usb/gadget/udc/udc-xilinx.c                | 38 ++++++++++++++++++++--
> >  2 files changed, 37 insertions(+), 4 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/usb/udc-xilinx.txt b/Documentation/devicetree/bindings/usb/udc-xilinx.txt
> > index 47b4e39..d417872 100644
> > --- a/Documentation/devicetree/bindings/usb/udc-xilinx.txt
> > +++ b/Documentation/devicetree/bindings/usb/udc-xilinx.txt
> > @@ -7,12 +7,13 @@ Required properties:
> >  - interrupts         : Should contain single irq line of USB2 device
> >                         controller
> >  - xlnx,has-builtin-dma       : if DMA is included
> > -
> > +- xlnx,addrwidth       : Should be the dma addressing size in bits(ex: 40 bits).
> 
> Now this property shows up in a 2nd device. Now I'm more convinced this 
> is the wrong approach and should use dma-ranges.

Not necessarily: We need to be careful not to mix up two different things here:

* dma-ranges describes the address width of a bus, along with possible offsets.
  In order to do wider than 32-bit addressing, all upstream busses must be
  capable of supporting this, and AXI can have either 64-bit or 32-bit addressing.

* A device may have a register set that allows wider DMA. This is normally
  identified through the 'compatible' property, and you can have all
  combinations with bus addressing: a device with 32-bit DMA can be connected
  to a 64-bit AXI bus, and a device with 64-bit DMA can have an upstream parent
  or grandparent that is limited to 32 bits (or any other width really).

The patch here is almost certainly wrong. For one thing, it never sets the
DMA mask to the correct value, and it also infers the presence of the
0x308..0x317 register range from an arbitrary DT property that describes
something else (the supported width of the DMA).

Someone with access to the data sheet of the hardware should look up
what the device capabilities actually are, and add the necessary properties
accordingly.

	Arnd
