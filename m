From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 7 Jun 2013 23:07:43 +0200
Subject: [PATCH 04/14] bus: mvebu-mbus: Add static window allocation to
 the DT binding
In-Reply-To: <20130607200054.GA9010@obsidianresearch.com>
References: <1370623671-7748-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <201306072101.44694.arnd@arndb.de>
 <20130607200054.GA9010@obsidianresearch.com>
Message-ID: <201306072307.44145.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 07 June 2013, Jason Gunthorpe wrote:
> On Fri, Jun 07, 2013 at 09:01:44PM +0200, Arnd Bergmann wrote:
> 
> > > +- compatible:	Should be set to one of the following:
> > > +		marvell,armada370-mbus
> > > +		marvell,armadaxp-mbus
> > 
> > I thought they are compatible with all older ones at the register level,
> > as long as we describe all the differences in the ranges property
> > and other properties.
> 
> Agree, maybe this can come later?

I'm just wondering if the name should be for the original device that
introduced them.

> > > +	soc {
> > > +		devbus-bootcs {
> > > +			status = "okay";
> > > +			ranges = <0 0x012f0000 0xe8000000 0x8000000>;
> > 
> > The example should also contain an #address-cells and #size-cells
> > property in the devbus-bootcs, as those are required for interpreting the
> > ranges property.
> 
> Right,
> 
> Is the ranges right though? I was expecting this:
> 
>  ranges = <0  0x012f0000 0  0x8000000>
> 
> The 2nd address cell in the 2dword space should almost always be 0.
> 
> The 2nd address cell should be interprited as the offset within the
> target's window, not as some kind of physical base address.

Ah, that's right. I missed that.

> >>+ (Note that the windowid cell is encoding the target ID = 0x01 and attribute
> >>+ ID = 0x2f, and the selected base address for the window is 0xe8000000).
> 
> ... The proper place to indicate the base address for the window is in
> the mbus ranges:
> 
> mbus {
>    ranges = <0x012f0000 0  0xe8000000  0x8000000>
>    devbus-bootcs {
>        ranges = <0  0x012f0000 0  0x8000000>
>    }
> }
> 
> We shouldn't mangle the DT format just to make it convenient for
> humans to write - if this is a major problem then I'd try to use the
> preprocessor first.. There are several reasonable solutions down that
> path, IMHO.

agreed.

> > I don't understand the part about zeroing a windowid. Is "target = 0x0,
> > attribute = 0x0" the actual setting for the internal registers? If so,
> > don't call it a dummy translation or a special case.
> > If not, why not use the actual setting here?
> 
> Internal regs has a special window register that doesn't have a target
> id. We need to define an address cell for it, I suggest something like
> <0xFFFFFFFF 0>, or <0x0000FFFF 0>...

Ok. I'd suggest using a value of '0' at least for the bits that are
used for encoding the other windows, and using the remaining bits to
identify whether it's the internal-reg or something else. One bit would
be enough for that, but 0xffff would work as well. I have a (weak)
preference for just using one bit. If we define a bit to mean "not
internal regs", then the macro could always set that, and zero would
actually be a valid and convenient representation of the internal regs.

> > > +
> > > +	soc {
> > > +		pcie-controller {
> > > +			ranges =
> > > +			       <0x82000000 0 0x40000    0          0x40000    0 0x00002000
> > > +				0x82000000 0 0x80000    0          0x80000    0 0x00002000
> > > +				0x82000000 0 0xe0000000 0xffff0000 0xe0000000 0 0x08000000
> > > +				0x81000000 0 0          0xffff0000 0xe8000000 0 0x00100000>;
> > > +
> > > +			pcie at 1,0 {
> > > +				/* ... */
> > > +			};
> > > +		};
> > > +	};
> 
> > Again, I don't understand this part. For the purpose of specification, I
> > would not make a special case here. It is not a hardware property that makes
> > these special but the way we use it from Linux. Consequently I would suggest
> > we skip the PCI ranges in the initial boot time setup by identifying the
> > pcie-controller node by its "compatible" property.
> 
> This is tricky :| The PCIE controller needs both target IDs and the
> aperture range to allocate them in.

And the target ID is port specific, right?

Is the aperture range actually fixed in hardware in any way? Could we just
describe the entire 4GB translation for each port, and let the mbus driver
pass the aperture to the pcie driver, based on whatever address space is left
doing doing the boot-time window assignments?

	Arnd
