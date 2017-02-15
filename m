From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 15 Feb 2017 17:36:11 +0000
Subject: [PATCH 08/11] ARM: dts: Prepare Actions Semi S500 and LeMaker
 Guitar
In-Reply-To: <9dbb7749-a58b-9e18-33c9-fd004a713ed1@suse.de>
References: <20170215165528.10052-1-afaerber@suse.de>
 <20170215165528.10052-9-afaerber@suse.de>
 <20170215170742.GH31733@leverpostej>
 <9dbb7749-a58b-9e18-33c9-fd004a713ed1@suse.de>
Message-ID: <20170215173610.GJ31733@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 15, 2017 at 06:28:31PM +0100, Andreas F?rber wrote:
> Hi Mark,
> 
> Am 15.02.2017 um 18:07 schrieb Mark Rutland:
> > On Wed, Feb 15, 2017 at 05:55:25PM +0100, Andreas F?rber wrote:
> >> +	arm-pmu {
> >> +		compatible = "arm,cortex-a9-pmu";
> >> +		interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
> >> +		             <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
> >> +		             <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
> >> +		             <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
> >> +        };
> > 
> > Please add an interrupt-affinity property, as described in
> > Documentation/devicetree/bindings/arm/pmu.txt
> 
> That's not in the vendor tree... My guess is it would be like this then?
> 
> diff --git a/arch/arm/boot/dts/s500.dtsi b/arch/arm/boot/dts/s500.dtsi
> index ee93984..959c6e3 100644
> --- a/arch/arm/boot/dts/s500.dtsi
> +++ b/arch/arm/boot/dts/s500.dtsi
> @@ -82,7 +82,8 @@
>                              <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
>                              <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
>                              <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
> -        };
> +               interrupt-affinity = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>;
> +       };

Assuming that's how they're wired up, yes.

You should be able to test this by using perf record in per-cpu mode,
on an application with its affintiy fixed to a particular CPU, and
verifying that overflow interrupts are recevied on the same CPU.

Thanks,
Mark.
