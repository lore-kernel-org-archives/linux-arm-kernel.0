From: stefan@agner.ch (Stefan Agner)
Date: Mon, 13 Oct 2014 23:20:38 +0200
Subject: [RFC 4/7] ARM: dts: add support for Vybrid running on Cortex-M4
In-Reply-To: <5748107.mfAXLUBGQg@wuerfel>
References: <cover.1413136383.git.stefan@agner.ch>
 <2010256.3WXzPqutzu@wuerfel> <e7425f34e2149aa495a2e3611854e952@agner.ch>
 <5748107.mfAXLUBGQg@wuerfel>
Message-ID: <7c474d8f876cbf9adaec55af1dffd6c2@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 2014-10-13 21:54, schrieb Arnd Bergmann:
> On Monday 13 October 2014 18:11:19 Stefan Agner wrote:
>> Am 2014-10-13 13:24, schrieb Arnd Bergmann:
>> > On Monday 13 October 2014 13:08:12 Stefan Agner wrote:
>> >> Am 2014-10-13 12:32, schrieb Mark Rutland:
>> >> > On Sun, Oct 12, 2014 at 07:13:58PM +0100, Stefan Agner wrote:
>> >> >> This adds an initial device tree to run Linux on the Cortex-M4 on
>> >> >> Vybrid.
>> >> >>
>> >> >> HACK: Because we include armv7-m.dtsi, the soc node happens to
>> >> >> be before the clock node. This is a problem for vf610-clk.c, which
>> >> >> tries to optain the fixed clocks defined in the clock nodes. But
>> >> >> because clock drivers are initialized sequencially, and we do not
>> >> >> have support for deferred probing, the clock initialization fails
>> >> >> horrible.
>> >> >> Move the armv7-m.dtsi include to the bottom to temporarily work
>> >> >> work around this...
>> >> >>
>> >> >> Signed-off-by: Stefan Agner <stefan@agner.ch>
>> >> >> ---
>> >> >> Maybe a dummy soc entry in armv7-m.dtsi also helps here. But a
>> >> >> hack as well. Is it common acceptable that the kernel depends
>> >> >> on DTS order?
>> >> >
>> >> > The kernel should not depend on DTS ordering. We should sort out
>> >> > deferred probing if there is an issue with it.
>> >> >
>> >> > [...]
>> >>
>> >> Yes I guess to make this working independent of device tree order, we
>> >> need to defer probing of vf610-clk when the fixed clocks are not
>> >> initialized yet.
>> >>
>> >> Clock initialization (using CLK_OF_DECLARE) doesn't support EPROBE_DEFER
>> >> currently.
>> >>
>> >> We seem to have already a work around merged because of this.
>> >> http://thread.gmane.org/gmane.linux.kernel/1635576
>> >
>> > Ah, maybe that's what I remembered. The clock handling should probably
>> > do something similar to what we do for irqchips, where we probe the
>> > parents first.
>> >
>>
>> Would parent really work here? I mean, vf610-"clk"'s parent is
>> "aips-bus", then "soc" versus "fxosc"'s parent is "clock" (which I can
>> omit according to Mark), so different branches starting from the root. A
>> depth based initialization order would help, but this looks rather
>> arbitrary.
> 
> I meant parents in the clock tree not the device tree. The clock parents
> are the nodes listed in the 'clocks' property of a child clock device
> node.
> 
> This would be similar to how it works for interrupt-controllers, where
> we follow the "interrupt-parent" properties.
> 

Ah ok I see. This parent/child relation is not yet part of the Vybrid
device tree:


slowosc: sxosc {
	compatible = "fixed-clock";
	#clock-cells = <0>;
	clock-frequency = <32768>;
};
fastosc: fxosc {
	compatible = "fixed-clock";
	#clock-cells = <0>;
	clock-frequency = <24000000>;
};

....

clks: ccm at 4006b000 {
	compatible = "fsl,vf610-ccm";
	reg = <0x4006b000 0x1000>;
	#clock-cells = <1>;
};

So we would need something like:

clocks = <&slowosc>, <&fastosc>;
clock-names = "sxosc", "fxosc";

But how can we identify clock tree entries? There is no marker like
"clock-controller;" currently, is there?

--
Stefan
