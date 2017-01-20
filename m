From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 20 Jan 2017 09:59:49 +0100
Subject: [PATCH 1/2] dt-bindings: gpu: Add Mali Utgard bindings
In-Reply-To: <20170119161648.u6tta5mogadli7ih@rob-hp-laptop>
References: <20170116132424.7038-1-maxime.ripard@free-electrons.com>
 <20170119161648.u6tta5mogadli7ih@rob-hp-laptop>
Message-ID: <20170120085949.ccptp76bnlyw7nxy@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Thu, Jan 19, 2017 at 10:16:48AM -0600, Rob Herring wrote:
> On Mon, Jan 16, 2017 at 02:24:23PM +0100, Maxime Ripard wrote:
> > The ARM Mali Utgard GPU family is embedded into a number of SoCs from
> > Allwinner, Amlogic, Mediatek or Rockchip.
> > 
> > Add a binding for the GPU of that family.
> > 
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  .../devicetree/bindings/gpu/arm,mali-utgard.txt    | 76 ++++++++++++++++++++++
> >  1 file changed, 76 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
> > new file mode 100644
> > index 000000000000..df05ba0ec357
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
> > @@ -0,0 +1,76 @@
> > +ARM Mali Utgard GPU
> > +===================
> > +
> > +Required properties:
> > +  - compatible:
> > +    * "arm,mali-utgard" and one of the following:
> 
> Drop this. It's meaningless and 3 compatibles to match is the kernel is 
> not a big deal.

Ok.

> > +      + "arm,mali-300"
> > +      + "arm,mali-400"
> > +      + "arm,mali-450"
> > +
> > +  - reg: Physical base address and length of the GPU registers
> > +
> > +  - interrupts: an entry for each entry in interrupt-names.
> > +    See ../interrupt-controller/interrupts.txt for details.
> > +
> > +  - interrupt-names:
> > +    * ppX: Pixel Processor X interrupt (X from 0 to 7)
> > +    * ppmmuX: Pixel Processor X MMU interrupt (X from 0 to 7)
> 
> Is the number of pixel processors probe-able? If not, then it needs to 
> be implied by the vendor compatible string or a property.

Yes, this is something that can be discovered by reading the pixel
processors version register. If the value is not 0, the processor is
there, otherwise it's not.

> > +    * pp: Pixel Processor broadcast interrupt (mali-450 only)
> > +    * gp: Geometry Processor interrupt
> > +    * gpmmu: Geometry Processor MMU interrupt
> 
> That's a lot of interrupts. Was going to ask about combining, but 
> I see Linus raised that.

Yes, apparently, some SoCs use that, but that doesn't seem to be a
standard feature (or at least, it's not used on our SoCs). So we're
stuck with those :/

> > +Optional properties:
> > +  - interrupt-names:
> > +    * pmu: Power Management Unit interrupt, if implemented in hardware
> > +
> > +Vendor-specific bindings
> > +------------------------
> > +
> > +The Mali GPU is integrated very differently from one SoC to
> > +another. In order to accommodate those differences, you have the option
> > +to specify one more vendor-specific compatible, among:
> > +
> > +  - allwinner,sun4i-a10-mali
> 
> List this with the compatible strings. I assume one of the arm,mali-??? 
> strings applies too.

Yep.

> > +    Required properties:
> > +      * clocks: an entry for each entry in clock-names
> > +      * clock-names:
> > +        + bus: bus clock for the GPU
> > +        + core: clock driving the GPU itself
> 
> This should be in the core binding. The number of clocks should not 
> vary. We often get this wrong because the IP blocks get integrated and 
> connected to the same clock source. But this should be equal to the 
> number of clock inputs.

Ok. So far, the Allwinner one and the examples from Linus and John
have been using two clocks, but apparently on rockchip it's using a
single one, which is why I made it that way. I'll move that to the
core binding.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170120/c89b2246/attachment.sig>
