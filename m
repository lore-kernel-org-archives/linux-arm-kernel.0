From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 26 Oct 2015 22:00:46 +0100
Subject: [linux-sunxi] Re: [PATCH 5/6] ARM: dts: sunxi: Add Allwinner H3
 DTSI
In-Reply-To: <562B43D5.5060900@redhat.com>
References: <1445444428-4652-1-git-send-email-jenskuske@gmail.com>
 <1445444428-4652-2-git-send-email-jenskuske@gmail.com>
 <20151023181406.GK10947@lukather> <562B43D5.5060900@redhat.com>
Message-ID: <20151026210046.GA10947@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 24, 2015 at 10:39:49AM +0200, Hans de Goede wrote:
> Hi,
> 
> On 10/23/2015 08:14 PM, Maxime Ripard wrote:
> >On Wed, Oct 21, 2015 at 06:20:27PM +0200, Jens Kuske wrote:
> >>+		bus_gates: clk at 01c20060 {
> >>+			#clock-cells = <1>;
> >>+			compatible = "allwinner,sun8i-h3-bus-gates-clk";
> >>+			reg = <0x01c20060 0x14>;
> >>+			clock-indices = <5>, <6>, <8>,
> >>+					<9>, <10>, <13>,
> >>+					<14>, <17>, <18>,
> >>+					<19>, <20>,
> >>+					<21>, <23>,
> >>+					<24>, <25>,
> >>+					<26>, <27>,
> >>+					<28>, <29>,
> >>+					<30>, <31>, <32>,
> >>+					<35>, <36>, <37>,
> >>+					<40>, <41>, <43>,
> >>+					<44>, <52>, <53>,
> >>+					<54>, <64>,
> >>+					<65>, <69>, <72>,
> >>+					<76>, <77>, <78>,
> >>+					<96>, <97>, <98>,
> >>+					<112>, <113>,
> >>+					<114>, <115>, <116>,
> >>+					<128>, <135>;
> >>+			clocks = <&ahb1>, <&ahb1>, <&ahb1>,
> >>+				 <&ahb1>, <&ahb1>, <&ahb1>,
> >>+				 <&ahb1>, <&ahb2>, <&ahb1>,
> >>+				 <&ahb1>, <&ahb1>,
> >>+				 <&ahb1>, <&ahb1>,
> >>+				 <&ahb1>, <&ahb1>,
> >>+				 <&ahb1>, <&ahb1>,
> >>+				 <&ahb1>, <&ahb2>,
> >>+				 <&ahb2>, <&ahb2>, <&ahb1>,
> >>+				 <&ahb1>, <&ahb1>, <&ahb1>,
> >>+				 <&ahb1>, <&ahb1>, <&ahb1>,
> >>+				 <&ahb1>, <&ahb1>, <&ahb1>,
> >>+				 <&ahb1>, <&apb1>,
> >>+				 <&apb1>, <&apb1>, <&apb1>,
> >>+				 <&apb1>, <&apb1>, <&apb1>,
> >>+				 <&apb2>, <&apb2>, <&apb2>,
> >>+				 <&apb2>, <&apb2>,
> >>+				 <&apb2>, <&apb2>, <&apb2>,
> >>+				 <&ahb1>, <&ahb1>;
> >
> >This is not really what I had in mind...
> 
> I came to the same solution independently, I took my inspiration from
> the rockchip clocks driver which is dealing with this problem in the
> same way, so there is precedent for doing things this way, and this
> does give us lot of flexibility. Given that I expect other new allwinnner
> SoCs to have the same problem I believe it is good to have that
> flexibility.

The rockchip clocks driver are very different from our own regarding
the DT bindings. Being consistent within our own platform seems to
bring much more value than getting bits and pieces here and there when
it's convenient.

Plus, you actually forgot in your argument to mention that this
binding was documented as deprecated, and not used anywhere since
3.17... So apparently, someone tried that, and finally changed its
mind.

Again, this is clearly a workaround, with no way to easily identify if
a given clock has the right parent afterwards. We can't review it
properly, and it's going to be a pain to fix after the facts.

Having some association masks in the driver itself, using the BIT
macro, will be much easier to maintain in the long run.

> >This IP has 2 parents, and only two parents.
> 
> Nope it has 4: apb1, apb2, ahb1 and ahb2.

The point still remains though.

> >The mapping between the IPs should be done in the driver itself,
> >not in the DT where it is very error prone and barely readable.
> 
> It is just as error prone and barely readable in C-code, see Jens original
> patchset, he did an array of clock indices there (range 0-3 with an index
> into the parent clocks array), which is arguably even more unreadable since
> there is an extra level of indirection here.

I agree, and it's why I suggested another approach at the time.

> The problem with the unreadability simply comes from allwinner's decision
> to no longer have a gates register per bus but instead shove everything
> in a single bit-array in random order, there is nothing we can do to fix
> that.

Indeed. Except one solution is easier to maintain than the other.

> Also the argument "this belongs in the driver not in the DT" is a
> bit inconsistent with the moving of the mask of valid gates from the
> driver into the clock-indices in devicetree.

Except I never used that argument.

> The way things are done here actually are doing pretty much the same
> thing, putting info which could be derived from the compatible
> string into devicetree.
>
> Last as said already there is precedent for doing things this way
> in the rockchip driver, and given that 2 people have come up
> with this approach independently of of each other this clearly
> seems to be the most straight-foward / logical way to deal with
> this.
> 
> >And note that I never have expected you to use clk-simple-gates
> >either. This is a complicated clock
> 
> No it is not complicated, have you looked at the changes to the
> simple-clk-gates driver which Jean Francois Moine suggested?
> 
> Those 5 extra lines (4 new lines) are all that is needed when
> going with the approach of listing a parent per gate. This is
> actually still a quite simple clock, we only need to find a way
> to specify a parent per gate, preferably via DT since this gives
> us greater flexibility which will be quite useful when adding
> support for other SoCs.

The problem boils down to this: so far, we've used one DT node per
clock controller (and we won't change that, sorry).

The clocks property is defined as "List of phandle and clock specifier
pairs, one pair for each clock input to the device.".

There's only 4 clock inputs. Really. What this clock controller
controls is whether one of these four input will be output, and that's
pretty much it. The routing between the input and output pins is
internal to the controller, just like it should be internal to the
driver.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151026/63321a5a/attachment.sig>
