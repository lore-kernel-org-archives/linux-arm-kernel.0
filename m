From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 12 Jun 2013 00:22:29 +0200
Subject: [PATCH 04/14] bus: mvebu-mbus: Add static window allocation to
 the DT binding
In-Reply-To: <20130611215023.GA12649@obsidianresearch.com>
References: <1370623671-7748-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130609014506.GB10027@obsidianresearch.com>
 <20130611135737.GC3996@localhost> <20835253.Agl4DfuI3k@wuerfel>
 <20130611215023.GA12649@obsidianresearch.com>
Message-ID: <51B7A325.8070108@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/11/2013 11:50 PM, Jason Gunthorpe wrote:
> On Tue, Jun 11, 2013 at 05:26:47PM +0200, Arnd Bergmann wrote:
>> That looks ok to me, yes. If you have just one device under some of the nodes
>> however, I think it's easier use an empty ranges property and do
>>
>>   	devbus-bootcs {
>>   		ranges;
>>   		nor {
>>   			reg =<0x012f0000 0 0x1000000>;
>>   		};
>>
>> The 'ranges' here is most useful if you have multiple devices
>> add different offsets. I would also predefine those ranges to
>> be as large as possible so you don't have to adapt them when
>> the child device grows beyond it.
>
> It isn't super critical, but the ranges does keep the 0x012f0000 value
> in the SOC .dtsi and the board level doesn't have to be exposed to the
> value, it just uses 0 to setup the NOR.

Jason, Ezequiel, Arnd,

sorry to kick into this thread that late but Ezequiel made me think of
address windows when asking on IRC. From what I can see from your and
Arnd's proposal the only real difference is that having it Arnd's way
allows you to have two or more windows mapped to e.g. devbus with
totally independent address ranges - while yours requires one large
window for all child devices?

> Also, it makes it much simpler for the mbus driver to detect which
> target id's are required so they can be allocated/setup - the rule
> would be every child stanza should have a ranges with the target(s) it
> needs.
>
> The full version probably looks like this:
>
> mbus {
>      ranges ....
>
>                          devbus-bootcs at 10400 {
>                                  compatible = "marvell,mvebu-devbus";
>                                  reg =<INTERNAL_REGS + 0x10400 0x8>;
>                                  ranges =<0 DEVBUS_BOOTCS 0x1000000>;
>                                  #address-cells =<1>;
>                                  #size-cells =<1>;
>                                  clocks =<&coreclk 0>;
>
> 				// In board .dts:
>                                  nor at 0 {
>                                          compatible = "cfi-flash";
>                                          reg =<0 0x1000000>;
>                                          bank-width =<2>;
>                                  };
>                          };
> };
>
> And notice here that we need to offset INTERNAL_REGS to make this
> work. To me, this is the primary reason why the 2nd cell of the mbus
> address format *must* be the address offset within the target, and not
> anything else.

Given the limited number of windows, I personally prefer your proposal
above - but nevertheless I can also think of separating target id from
ranges completely. (I know this discussion has been here for a while,
and I apologize if below was already NACKed before)

Although, not thought to the bare end this could also work and maybe
reflects the actual hardware more accuate:

mbus {
	compatible = "marvell,kirkwood-mbus";
	ranges; /* 1:1 mapping */

	internal-regs {
		ranges = <0 0xf1000000 0x800000>;
		/* target-id target-attr size */
		marvell,mbus-target = <0xff 0x12 0x800000>;

		nand {
			compatible = "marvell,orion-nand";
			reg = <0x10400 0x80>;
			marvell,mbus-target = <0x01 0x2f 0x100000>;

			/* in board dts */
			spansion-flash {
				...
			};
		};
	};

	sram {
		marvell,mbus-target = <...>;
	};
};

>>> 2. There's no need to use an algorithm to 'find' a base address for decoding
>>>     windows (such as first-fit as Arnd suggested in another mail).
>>>     The base address is already there in the ranges property, so the mbus can
>>>     simply allocate the window on that base address.
>>>
>>> So, am I right or completely lost?
>>
>> Since you already need code to update the ranges property, I think
>> it's best to discard the ranges at boot time and create a new mapping
>> that just maps the devices you actually want to use. That would make
>> it much easier to cope with boot loaders that don't set up the
>> mappings in the same way that is listed in the device tree. Just
>> put the one entry for the internal-regs in the ranges, since that
>> is needed to map do the mbus setup.
>
> So, I think we can/have agree that the ranges in the FDT should
> reflect the bootloader's settings, and if the ranges is missing an
> element it means the bootloader didn't set it up.
>
> A compatible bootloader should dump the entire mbus register table
> into the ranges. The address encoding is such that we can represent
> every mbus window entry in ranges. If no bootloader support is present
> then the ranges value is forced into the mbus windows anyhow.
>
> If there isn't a ranges entry, but there is a child that requires it
> (how do we figure this out?) then dynamic assignment of that window
> makes sense to me. (however, this also looks a bit tricky, how do you
> avoid hitting the PCI-E window reservations, for instance?)
>
> Unconditional dynamic assignment is a bit more tricky, for instance
> the boot rom has to be located at a specific address since it is used
> as the SMP secondary startup trampoline. (Ezequiel: IMHO, you should
> check for this and bail secondary startup if it is not setup)

When removing size from marvell,mbus-target above, mbus driver could
also probe for required max size from the reg properties of the child
nodes. Arnd already said that mbus isn't "simple-bus" anymore, why
can't it just walk through the nodes and collect required windows?

Sebastian
