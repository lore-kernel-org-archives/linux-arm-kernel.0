From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 09 Jun 2013 15:42:24 +0200
Subject: [PATCH 04/14] bus: mvebu-mbus: Add static window allocation to
 the DT binding
In-Reply-To: <20130608183851.GB2354@localhost>
References: <1370623671-7748-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130607200054.GA9010@obsidianresearch.com>
 <20130608183851.GB2354@localhost>
Message-ID: <1695243.lt6nZouziV@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 08 June 2013 15:38:52 Ezequiel Garcia wrote:
> On Fri, Jun 07, 2013 at 02:00:54PM -0600, Jason Gunthorpe wrote:

> Right. I think we have two options here for laying the DT ranges.
> 
> 1) This is the proposal implied in the patchset I sent:
> 
> mbus {
> 	ranges = < we only put the internal-reg translation here>
> 	devbus-bootcs {
> 		ranges = <0 {target_id/attribute} {window_physical_base} {size}>
> 	}
> }

As Jason explained, you cannot have the window_physical_base in the child
device, that just wouldn't work. I don't know if that's a typo or a thinko ;-)

I also think {size} above there would just be 0xffffffff, right?

> 2) This is what Jason is proposing in his mail:
> 
> mbus {
> 	ranges = <{target_id/attribute} 0 {window_physical_base} {size}>
> 	devbus-bootcs {
> 		ranges = <0 {target_id/attribute} 0 {size}>
> 	}
> }
> 
> Of course this looks much cleaner, but it forces a lot of duplication
> in the DT files. Now, if you see some of the recent patches we've been
> sending, I think this duplication is very error-prone, and it'll be a
> nightmare to maintain. Let me propose an example to show this
> duplication:

I don't see where that duplication comes in. The ranges in the
"devbus-bootcs" are just describing how the hardware maps the
child address space into the global mbus space, and that never
changes. For the cases that only have a single device underneath,
you can actually put an empty ranges property in there and adapt
the "regs" property of whatever sits underneath it. These two
representations would do exactly the same for instance:

a)

mbus {
	ranges = <...>;
	devbus-bootcs {
		#address-cells = <1>;
		#size-cells = <1>;
		ranges = <0 MBUS_BOOTCS 0 0xffffffff>;

		flash {
			regs = <0 0x100000>;
		};
	};
};

mbus {
	ranges = <...>;
	devbus-bootcs {
		#address-cells = <2>;
		#size-cells = <1>;
		ranges;

		flash {
			regs = <MBUS_BOOTCS 0 0x100000>;
		};
	};
};

> Let's suppose we have a board "A" with its armada-A.dts,
> and a common one armada.dtsi.
> 
> The common dtsi file would have this ranges property:
> 
> /* armada.dtsi */
> mbus {
> 	ranges = < internal_regs_id 0 internal_regs_base internal_regs_size
> 		         bootrom_id 0       bootrom_base       bootrom_size >
> }
> 
> The A board has a NOR connected to some devbus, so we need to add it
> to the ranges, but also need to duplicate the ones in the common dtsi:
> 
> /* armada-A.dts */
> mbus {
> 	ranges = < internal_regs_id 0 internal_regs_base internal_regs_size
> 		         bootrom_id 0       bootrom_base       bootrom_size
> 		         devbus0_id 0       devbus0_base       devbus0_size >
> }

I think the mbus ranges property is best left only in the
board specific .dts file, since you don't know if all of the
mappings are actually set up to the same value by all boot
loaders. In order to avoid a situation where the mbus ranges
describes a setting that is not actually programmed into the
mbus controller by the boot loader, I would leave that empty
by default and only fill it when the OS actually assigns
a mapping.
 
> Now, if we add something at the common level, and extend the ranges
> property in the common armada.dtsi, we also have to go through *each* of
> the per-board dts files (for *each* board) adding that entry, because
> entries *need* to be duplicated. Otherwise you're effectively
> "shadowing" the entries.

We can't really do that anyway, as that would imply we also change
all the boot loaders that have been deployed. I mentioned earlier that
we could also have the mappings we /want/ described in the DT rather the
ones that are set up, but after the discussion about the 0xd0/0xf1
window for the internal registers I think it's better to keep them
in sync all the time. We can leave out mappings here that are set
up but I'd prefer not to put mappings in there that are actually
incorrect.

When assigning the mappings, it's best to just go through all devices
sitting below the mbus and pick an appropriate address for each
'reg' value that gets put into the mbus hardware and into the ranges
property at the same time. The easiest algorithm would be to do
a 'first fit' starting at the highest address that is not already
occupied. If we need the physical address space to be more compact,
we can also first sort all the resources by size. The simpler approach
wastes at most the size difference between the smallest and the largest
range, and that is probably good enough.

I thought this was actually what you implemented already, but it seems
I was wrong.

	Arnd 
