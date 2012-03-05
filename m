From: swarren@nvidia.com (Stephen Warren)
Date: Mon, 5 Mar 2012 09:51:15 -0800
Subject: [PATCH v3 07/10] arm/tegra: Add PWFM controller device tree
 probing
In-Reply-To: <20120303225404.GC6661@avionic-0098.mockup.avionic-design.de>
References: <1329923841-32017-1-git-send-email-thierry.reding@avionic-design.de>
 <1329923841-32017-8-git-send-email-thierry.reding@avionic-design.de>
 <74CDBE0F657A3D45AFBB94109FB122FF17BDDF1E67@HQMAIL01.nvidia.com>
 <20120303225404.GC6661@avionic-0098.mockup.avionic-design.de>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF17BE861C46@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thierry Reding wrote at Saturday, March 03, 2012 3:54 PM:
> * Stephen Warren wrote:
> > Thierry Reding wrote at Wednesday, February 22, 2012 8:17 AM:
> > > Add auxdata to instantiate a device tree for the PWFM controller and
> > > include a corresponding node in the device tree.
> >
> > > diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
> >
> > > +	pwm: pwm at 7000a000 {
> > > +		compatible = "nvidia,tegra20-pwm";
> > > +		reg = <0x7000a000 0x100>;
> > > +		#pwm-cells = <2>;
> > > +	};
> >
> > The compatible value probably should list both Tegra30 and Tegra20, so
> > we can know exactly which HW is present, just in case we need to turn
> > on some bug-fix only for one of the variants:
> >
> >     compatible = "nvidia,tegra30-pwm", "nvidia,tegra20-pwm";
> 
> I'm confused. If I know exactly that the hardware is Tegra30 (which it
> definitely should be if I include tegra30.dtsi), then why list "tegra20-pwm"
> as compatible?
> 
> Or did you mean to list tegra30-pwm as compatible value in the PWM driver?

Standard practice is to list the exact model of the HW as the first entry
in compatible in the .dts file:

    nvidia,tegra30-pwm

This is so that the DT always describes exactly which HW model is actually
present, so that if HW-model-specific WARs/... are required in the future,
the DT already lists that information up-front.

Then additionally list any older HW models that this HW is also compatible
with:

    nvidia,tegra20-pwm


This allows the driver to list just nvidia,tegra20-pwm but still bind
to DT nodes that are for later HW.

So, in other words, you end up with the following in the .dts/.dtsi file:

    compatible = "nvidia,tegra30-pwm", "nvidia,tegra20-pwm";

> > Could you also write binding documentation, in particular explaining
> > what the two pwm-cells are specifically for Tegra:
> >
> > Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
> >
> > (although perhaps that'd be part of the previous patch which implements
> > the driver)
> 
> Actually for Tegra the values would be those documented in the generic
> binding because Tegra uses of_pwm_simple_xlate(). Does it still make sense to
> add a Tegra-specific binding?

There should still be a Tegra-specific binding. Without it, there's no
definite way to know whether the "standard" properties actually apply,
or someone simply forgot to document it.

-- 
nvpublic
