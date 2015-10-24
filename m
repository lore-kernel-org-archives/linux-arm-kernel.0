From: hdegoede@redhat.com (Hans de Goede)
Date: Sat, 24 Oct 2015 10:39:49 +0200
Subject: [linux-sunxi] Re: [PATCH 5/6] ARM: dts: sunxi: Add Allwinner H3
 DTSI
In-Reply-To: <20151023181406.GK10947@lukather>
References: <1445444428-4652-1-git-send-email-jenskuske@gmail.com>
 <1445444428-4652-2-git-send-email-jenskuske@gmail.com>
 <20151023181406.GK10947@lukather>
Message-ID: <562B43D5.5060900@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 10/23/2015 08:14 PM, Maxime Ripard wrote:
> On Wed, Oct 21, 2015 at 06:20:27PM +0200, Jens Kuske wrote:
>> +		bus_gates: clk at 01c20060 {
>> +			#clock-cells = <1>;
>> +			compatible = "allwinner,sun8i-h3-bus-gates-clk";
>> +			reg = <0x01c20060 0x14>;
>> +			clock-indices = <5>, <6>, <8>,
>> +					<9>, <10>, <13>,
>> +					<14>, <17>, <18>,
>> +					<19>, <20>,
>> +					<21>, <23>,
>> +					<24>, <25>,
>> +					<26>, <27>,
>> +					<28>, <29>,
>> +					<30>, <31>, <32>,
>> +					<35>, <36>, <37>,
>> +					<40>, <41>, <43>,
>> +					<44>, <52>, <53>,
>> +					<54>, <64>,
>> +					<65>, <69>, <72>,
>> +					<76>, <77>, <78>,
>> +					<96>, <97>, <98>,
>> +					<112>, <113>,
>> +					<114>, <115>, <116>,
>> +					<128>, <135>;
>> +			clocks = <&ahb1>, <&ahb1>, <&ahb1>,
>> +				 <&ahb1>, <&ahb1>, <&ahb1>,
>> +				 <&ahb1>, <&ahb2>, <&ahb1>,
>> +				 <&ahb1>, <&ahb1>,
>> +				 <&ahb1>, <&ahb1>,
>> +				 <&ahb1>, <&ahb1>,
>> +				 <&ahb1>, <&ahb1>,
>> +				 <&ahb1>, <&ahb2>,
>> +				 <&ahb2>, <&ahb2>, <&ahb1>,
>> +				 <&ahb1>, <&ahb1>, <&ahb1>,
>> +				 <&ahb1>, <&ahb1>, <&ahb1>,
>> +				 <&ahb1>, <&ahb1>, <&ahb1>,
>> +				 <&ahb1>, <&apb1>,
>> +				 <&apb1>, <&apb1>, <&apb1>,
>> +				 <&apb1>, <&apb1>, <&apb1>,
>> +				 <&apb2>, <&apb2>, <&apb2>,
>> +				 <&apb2>, <&apb2>,
>> +				 <&apb2>, <&apb2>, <&apb2>,
>> +				 <&ahb1>, <&ahb1>;
>
> This is not really what I had in mind...

I came to the same solution independently, I took my inspiration from
the rockchip clocks driver which is dealing with this problem in the
same way, so there is precedent for doing things this way, and this
does give us lot of flexibility. Given that I expect other new allwinnner
SoCs to have the same problem I believe it is good to have that
flexibility.

> This IP has 2 parents, and only two parents.

Nope it has 4: apb1, apb2, ahb1 and ahb2.

> The mapping between the
> IPs should be done in the driver itself, not in the DT where it is
> very error prone and barely readable.

It is just as error prone and barely readable in C-code, see Jens original
patchset, he did an array of clock indices there (range 0-3 with an index
into the parent clocks array), which is arguably even more unreadable since
there is an extra level of indirection here.

The problem with the unreadability simply comes from allwinner's decision
to no longer have a gates register per bus but instead shove everything
in a single bit-array in random order, there is nothing we can do to fix
that.

Also the argument "this belongs in the driver not in the DT" is a bit
inconsistent with the moving of the mask of valid gates from the
driver into the clock-indices in devicetree. The way things are done
here actually are doing pretty much the same thing, putting info which
could be derived from the compatible string into devicetree.

Last as said already there is precedent for doing things this way
in the rockchip driver, and given that 2 people have come up
with this approach independently of of each other this clearly
seems to be the most straight-foward / logical way to deal with
this.

> And note that I never have expected you to use clk-simple-gates
> either. This is a complicated clock

No it is not complicated, have you looked at the changes to the
simple-clk-gates driver which Jean Francois Moine suggested?

Those 5 extra lines (4 new lines) are all that is needed when
going with the approach of listing a parent per gate. This is
actually still a quite simple clock, we only need to find a way
to specify a parent per gate, preferably via DT since this gives
us greater flexibility which will be quite useful when adding
support for other SoCs.

Regards,

Hans
