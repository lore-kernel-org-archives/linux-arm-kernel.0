From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 15 Feb 2017 18:23:03 +0000
Subject: [PATCH 11/11] ARM64: dts: Prepare Actions Semi S900 and
 Bubblegum-96
In-Reply-To: <267b586e-06ce-f123-b7cc-dc0feb880ca9@suse.de>
References: <20170215165528.10052-1-afaerber@suse.de>
 <20170215165528.10052-12-afaerber@suse.de>
 <20170215171232.GI31733@leverpostej>
 <267b586e-06ce-f123-b7cc-dc0feb880ca9@suse.de>
Message-ID: <20170215182303.GL31733@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Feb 15, 2017 at 07:14:14PM +0100, Andreas F?rber wrote:
> Am 15.02.2017 um 18:12 schrieb Mark Rutland:
> > On Wed, Feb 15, 2017 at 05:55:28PM +0100, Andreas F?rber wrote:
> >> +	reserved-memory {
> >> +		#address-cells = <2>;
> >> +		#size-cells = <2>;
> >> +		ranges;
> >> +	};
> > 
> > Why have this empty node?
> 
> Forgotten about... I see these:
> 
>    reserving fdt memory region: addr=19000000 size=3000000
>    reserving fdt memory region: addr=20000000 size=20000000
>    reserving fdt memory region: addr=18fff000 size=1000
>    reserving fdt memory region: addr=1f000000 size=1000000
> 
> Vendor tree says 0x1f000000 is for secure monitor; 0x19000000 for fb,
> 0x20000000 for ion (ignoring), and 0x20000000 for afinfo - whatever that
> may be (not me! :)).
> 
> So as minimum:
> 
> --- a/arch/arm64/boot/dts/actions/s900.dtsi
> +++ b/arch/arm64/boot/dts/actions/s900.dtsi
> @@ -86,6 +86,11 @@
>                 #address-cells = <2>;
>                 #size-cells = <2>;
>                 ranges;
> +
> +               secmon at 1f000000 {
> +                       reg = <0x0 0x1f000000 0x0 0x1000000>;
> +                       no-map;
> +               };
>         };
> 
>         psci {

Once you've added that node, could you try booting with "memtest" on the
command line?

Assuming CONFIG_MEMTEST is enabled, that'll go and verify that the
kernel can access all of the (unresereved) memory without issues, which
should save us lots of pain later on if there's something else that
needs to be reserved.

> >> +	timer {
> >> +		compatible = "arm,armv8-timer";
> >> +		interrupts = <GIC_PPI 13
> >> +			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> >> +			     <GIC_PPI 14
> >> +			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> >> +			     <GIC_PPI 11
> >> +			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> >> +			     <GIC_PPI 10
> >> +			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
> >> +	};
> >> +
> >> +	soc {
> >> +		compatible = "simple-bus";
> >> +		#address-cells = <2>;
> >> +		#size-cells = <2>;
> >> +		ranges;
> >> +
> >> +		gic: interrupt-controller at e00f1000 {
> >> +			compatible = "arm,gic-400";
> >> +			reg = <0x0 0xe00f1000 0x0 0x1000>,
> >> +			      <0x0 0xe00f2000 0x0 0x1000>,
> >> +			      <0x0 0xe00f4000 0x0 0x2000>,
> >> +			      <0x0 0xe00f6000 0x0 0x2000>;
> > 
> > I believe that the second entry should be 0x2000 in length.
> 
> The vendor tree does have 0x1000, but that might be a mistake of course.
> I vaguely recall having such discussions elsewhere in the past.

It is a mistake, and a common one [1] at that! :)

Thanks,
Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2017-January/480590.html
