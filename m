From: briannorris@chromium.org (Brian Norris)
Date: Wed, 12 Jul 2017 11:43:39 -0700
Subject: [PATCH v5 1/5] dt-bindings: gpu: add bindings for the ARM Mali
 Midgard GPU
In-Reply-To: <1692483.PxpH1MfcPQ@diego>
References: <cover.1493804968.git.guillaume.tucker@collabora.com>
 <bebe578ba130de5fa320ca7c6427b2fae83d61d7.1493804968.git.guillaume.tucker@collabora.com>
 <20170712172636.GA90759@google.com> <1692483.PxpH1MfcPQ@diego>
Message-ID: <20170712184338.GA140539@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

On Wed, Jul 12, 2017 at 08:30:55PM +0200, Heiko Stuebner wrote:
> Am Mittwoch, 12. Juli 2017, 10:26:39 CEST schrieb Brian Norris:
> > On Wed, May 03, 2017 at 10:56:25AM +0100, Guillaume Tucker wrote:
> > > The ARM Mali Midgard GPU family is present in a number of SoCs
> > > from many different vendors such as Samsung Exynos and Rockchip.
> > > 
> > > Import the device tree bindings documentation from the r16p0
> > > 
> > > release of the Mali Midgard GPU kernel driver:
> > >   https://developer.arm.com/-/media/Files/downloads/mali-drivers/kernel/ma
> > >   li-midgard-gpu/TX011-SW-99002-r16p0-00rel0.tgz> 
> > > Remove the copyright and GPL licence header as deemed not necessary.
> > > 
> > > Redesign the "compatible" property strings to list all the Mali
> > > Midgard GPU types and add vendor specific ones.
> > > 
> > > Drop the "clock-names" property as the Mali Midgard GPU uses only one
> > > clock (the driver now needs to call clk_get with NULL).
> > > 
> > > Convert the "interrupt-names" property values to lower-case: "job",
> > > "mmu" and "gpu".
> > > 
> > > Replace the deprecated "operating-points" optional property with
> > > "operating-points-v2".
> > > 
> > > Omit the following optional properties in this initial version as they
> > > 
> > > are only used in very specific cases:
> > >   * snoop_enable_smc
> > >   * snoop_disable_smc
> > >   * jm_config
> > >   * power_model
> > >   * system-coherency
> > >   * ipa-model
> > > 
> > > Update the example accordingly to reflect all these changes, based on
> > > rk3288 mali-t760.
> > > 
> > > CC: John Reitan <john.reitan@arm.com>
> > > Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > > Signed-off-by: Guillaume Tucker <guillaume.tucker@collabora.com>
> > > ---
> > > 
> > >  .../devicetree/bindings/gpu/arm,mali-midgard.txt   | 86
> > >  ++++++++++++++++++++++ 1 file changed, 86 insertions(+)
> > >  create mode 100644
> > >  Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt> 
> > > diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
> > > b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt new file
> > > mode 100644
> > > index 000000000000..d3b6e1a4713a
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
> > 
> > ^^ This file name implies we're talking about a base "arm,mali-midgard"
> > compatible property.
> 
> it follows the precedent of arm,mali-utgard.txt and while the file-name
> is not part of the compatible list, it feels way better collecting all the 
> variants in one file, compared to spawning multiple ones for each soc
> vendor using a mali gpu.
> 
> Also in other places the naming of binding descriptions does not follow
> any compatible at all, so the filename = main-compatible does not seem
> to be the rule.

Well, when they do get a name in the form of "<vendor>,<foo>.txt", the
"<vendor>,<foo>" is usually at least *a* valid compatible string. For
example, "nvidia,gk20a.txt" has several other strings, but its filename
is one of the supported ones.

Anyway, that wasn't my main worry. I was mostly curious about the body
of the text.

> > > @@ -0,0 +1,86 @@
> > > +ARM Mali Midgard GPU
> > > +====================
> > > +
> > > +Required properties:
> > > +
> > > +- compatible :
> > > +  * Must contain one of the following:
> > > +    + "arm,mali-t604"
> > > +    + "arm,mali-t624"
> > > +    + "arm,mali-t628"
> > > +    + "arm,mali-t720"
> > > +    + "arm,mali-t760"
> > > +    + "arm,mali-t820"
> > > +    + "arm,mali-t830"
> > > +    + "arm,mali-t860"
> > > +    + "arm,mali-t880"
> > > +  * which must be preceded by one of the following vendor specifics:
> > > +    + "amlogic,meson-gxm-mali"
> > > +    + "rockchip,rk3288-mali"
> > 
> > But it's not listed here.
> > 
> > > +
> > > +- reg : Physical base address of the device and length of the register
> > > area. +
> > > +- interrupts : Contains the three IRQ lines required by Mali Midgard
> > > devices. +
> > > +- interrupt-names : Contains the names of IRQ resources in the order they
> > > were +  provided in the interrupts property. Must contain: "job", "mmu",
> > > "gpu". +
> > > +
> > > +Optional properties:
> > > +
> > > +- clocks : Phandle to clock for the Mali Midgard device.
> > > +
> > > +- mali-supply : Phandle to regulator for the Mali device. Refer to
> > > +  Documentation/devicetree/bindings/regulator/regulator.txt for details.
> > > +
> > > +- operating-points-v2 : Refer to
> > > Documentation/devicetree/bindings/power/opp.txt +  for details.
> > > +
> > > +
> > > +Example for a Mali-T760:
> > > +
> > > +gpu at ffa30000 {
> > > +	compatible = "rockchip,rk3288-mali", "arm,mali-t760",
> > > "arm,mali-midgard";
> > 
> > And it *is* used here in this example.
> > 
> > So, should it be used/documented or not?
> 
> No I don't think it should and have patches that drop the mali-midgard from
> the example + rk3288 dtsi to not confuse people:
> - https://patchwork.kernel.org/patch/9832811/
> - https://patchwork.kernel.org/patch/9832807/

I didn't notice those. Thanks.

> Devicetree supposedly should not contain wildcards and without knowing
> for real that all of then in fact are compatible we should not assume so
> [and that's hard to check with all the secrecy :-) ] . Using the real name 
> (tXXX) sounds nice enough.

Fine with me.

Brian
