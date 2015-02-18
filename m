From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 18 Feb 2015 11:27:30 +0100
Subject: [PATCH 01/11] mfd: add the Berlin controller driver
In-Reply-To: <20150218090958.GA18042@x1>
References: <1423671332-24580-1-git-send-email-antoine.tenart@free-electrons.com>
 <1423671332-24580-2-git-send-email-antoine.tenart@free-electrons.com>
 <20150216124808.GC14545@x1> <20150217092020.GC4507@kwain>
 <20150217115447.GA3989@x1> <20150218084004.GD21937@kwain>
 <20150218090958.GA18042@x1>
Message-ID: <54E46912.7030709@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18.02.2015 10:09, Lee Jones wrote:
> On Wed, 18 Feb 2015, Antoine Tenart wrote:
[...]
>> So we had a single node, chip-controller, accessed by multiple
>> devices -and drivers-. We ended up with:
>>
>> chip: chip-control at ea0000 {
>> 	compatible = "marvell,berlin2q-chip-ctrl";
>> 	reg = <0xea0000 0x400>, <0xdd0170 0x10>;
>> 	#clock-cells = <1>;
>> 	#reset-cells = <2>;
>> 	clocks = <&refclk>;
>> 	clock-names = "refclk";
>>
>> 	[pinmux nodes]
>> };
>>
>> In addition to being a mess, how can you probe various drivers with this
>> single node? We had to probe a clock driver in addition to the
>> pin-controller and reset drivers. We ended up using arch_initcall() in
>> the reset driver, which was *not* acceptable.
>>
>> These chip and system controllers are not an IP, but helps not spreading
>> this bank of registers all over the DT.
>>
>> The solution to this problem is to introduce an mtd driver which
>> registers all the sub-devices described by these chip and system
>> controller nodes.
>
> I'm still not convinced that your problem can't be solved in DT, but
> creating a single psudo-hardware node is not correct either.  What
> does the h/w _really_ look like?  Is all of this stuff on a single
> chip?  If so, I would expect to see something like:
>
> control at ea0000 {
> 	compatible = "marvel,control";
>
> 	pinctrl at xxxxx {
> 		compatible = "marvel,pinctrl";
> 	};
>
> 	reset at xxxxx {
> 		compatible = "marvel,reset";
> 	};
> };

Lee,

I guess you never get what you expect ;) Honestly, Antoine is right.

The structure you describe above is a bus and that is definitely not
true for chip control registers. Also, clock, reset, and pinctrl
"units" are SW concepts that HW engineers don't care much about.
Each of the "units" is heavily spread among the chip control registers
and even within a single register.

We simply give up on carving out every single register range to squeeze
them into SW driven units. I think Marvell understood that this kind of
chip control dumpster puts a high burden on the SW guys and newer SoCs
will have a cleaner register set - but for the current SoCs we are stuck
with the situation.

So, what _sane_ options do we have in DT that is also sane for SW?

(a) We could follow your suggestion of a chipctrl bus or move the
nodes back to the SoC bus. Now with that we would end up with
reg = <0x000 0x4>, <0x024 0x10>, <0x78 0x8>, ...
for each of the nodes. Plus, we'll certainly have to overlap some of
the reg ranges because bit0 of one register is reset but bits 31:1 is
clock. This not only exposes the mess in DT but still we have to deal
with it in the driver. Also as soon as we overlap, we loose devm_ for
the ioremap.

(b) We follow Antoine's proposal and have a single chip-ctrl node with
a single reg property spanning over the whole register set. Then have
clock, pinctrl, reset as sub-nodes. Looks sane, but we need some SW
that hooks up to each of the nodes, i.e. as it is not a bus we have to
register devices for each sub-node ourselves. That is why mfd is used
here (and for sunxi SoCs BTW too).

So, back when we wrote the clock driver and tried to find a sane
representation of the corresponding registers, Mike finally suggested
to just have a single node and deal with the register mess in the
driver. This series goes a little further and provides a single regmap
to all sub-drivers that we can think of that have to deal with chip
ctrl registers.

We have looked at the register layout and corresponding driver concepts
over and over again - there is no way to chop this up.

Sebastian
