From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Fri, 7 Jun 2013 14:00:54 -0600
Subject: [PATCH 04/14] bus: mvebu-mbus: Add static window allocation to
 the DT binding
In-Reply-To: <201306072101.44694.arnd@arndb.de>
References: <1370623671-7748-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1370623671-7748-5-git-send-email-ezequiel.garcia@free-electrons.com>
 <201306072101.44694.arnd@arndb.de>
Message-ID: <20130607200054.GA9010@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 07, 2013 at 09:01:44PM +0200, Arnd Bergmann wrote:

> > +- compatible:	Should be set to one of the following:
> > +		marvell,armada370-mbus
> > +		marvell,armadaxp-mbus
> 
> I thought they are compatible with all older ones at the register level,
> as long as we describe all the differences in the ranges property
> and other properties.

Agree, maybe this can come later?
 
> > +- reg:		Device's register space.
> > +		Two entries are expected, see the examples below.
> > +		The first one controls the devices decoding window and
> > +		the second one controls the SDRAM decoding window.
> 
> I think you should also list #address-cells=<2> and #size-cells=<1>
> as required here, as long as an optional "ranges" property.

Yes
 
> I think it makes sense to describe the "ranges" format here,
> even if we expect the property to be empty at boot time and
> only filled at run-time.

Yes, specifically describe how the 2 cell address format is mapped
into the marvell target ID form.

> > +	soc {
> > +		bootrom {
> > +			ranges = <0 0x01e00000 0xfff00000 0x100000>;
> > +		};
> > +	};
> 
> I think I'm a bit lost here. Is the "soc" node in this example the node
> that is described as compatible="marvell,armada370-mbus"? Maybe expand
> the example a little here to clarify this.

Agree, it should be the mbus node..
 
> If you use the new preprocessor feature we have in DT now, you can
> actually list a macro that is used to assembly the cell from target
> and attribute ID.

Yes, that would be great:

#define MAP_ID(target_id,attributes) (((target_id) << 24) | ((attributes) << 16)) 0
#define MAP_BOOTROM MAP_ID(0xXXXX,0xXXXX)

Such that MAP_BOOTROM expands to two cells

> > +	soc {
> > +		devbus-bootcs {
> > +			status = "okay";
> > +			ranges = <0 0x012f0000 0xe8000000 0x8000000>;
> 
> The example should also contain an #address-cells and #size-cells
> property in the devbus-bootcs, as those are required for interpreting the
> ranges property.

Right,

Is the ranges right though? I was expecting this:

 ranges = <0  0x012f0000 0  0x8000000>

The 2nd address cell in the 2dword space should almost always be 0.

The 2nd address cell should be interprited as the offset within the
target's window, not as some kind of physical base address.

>>+ (Note that the windowid cell is encoding the target ID = 0x01 and attribute
>>+ ID = 0x2f, and the selected base address for the window is 0xe8000000).

... The proper place to indicate the base address for the window is in
the mbus ranges:

mbus {
   ranges = <0x012f0000 0  0xe8000000  0x8000000>
   devbus-bootcs {
       ranges = <0  0x012f0000 0  0x8000000>
   }
}

We shouldn't mangle the DT format just to make it convenient for
humans to write - if this is a major problem then I'd try to use the
preprocessor first.. There are several reasonable solutions down that
path, IMHO.

> I don't understand the part about zeroing a windowid. Is "target = 0x0,
> attribute = 0x0" the actual setting for the internal registers? If so,
> don't call it a dummy translation or a special case.
> If not, why not use the actual setting here?

Internal regs has a special window register that doesn't have a target
id. We need to define an address cell for it, I suggest something like
<0xFFFFFFFF 0>, or <0x0000FFFF 0>...

> > +
> > +	soc {
> > +		pcie-controller {
> > +			ranges =
> > +			       <0x82000000 0 0x40000    0          0x40000    0 0x00002000
> > +				0x82000000 0 0x80000    0          0x80000    0 0x00002000
> > +				0x82000000 0 0xe0000000 0xffff0000 0xe0000000 0 0x08000000
> > +				0x81000000 0 0          0xffff0000 0xe8000000 0 0x00100000>;
> > +
> > +			pcie at 1,0 {
> > +				/* ... */
> > +			};
> > +		};
> > +	};

> Again, I don't understand this part. For the purpose of specification, I
> would not make a special case here. It is not a hardware property that makes
> these special but the way we use it from Linux. Consequently I would suggest
> we skip the PCI ranges in the initial boot time setup by identifying the
> pcie-controller node by its "compatible" property.

This is tricky :| The PCIE controller needs both target IDs and the
aperture range to allocate them in.

Jason
