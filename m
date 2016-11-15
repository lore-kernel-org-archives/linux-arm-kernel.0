From: youlin.pei@mediatek.com (Youlin Pei)
Date: Tue, 15 Nov 2016 11:09:49 +0800
Subject: [PATCH v2 1/3] binding: irqchip: mtk-cirq: Add binding document
In-Reply-To: <20161109182613.7tvzewua6ewxdvjc@rob-hp-laptop>
References: <1478001122-8664-1-git-send-email-youlin.pei@mediatek.com>
 <1478001122-8664-2-git-send-email-youlin.pei@mediatek.com>
 <20161109182613.7tvzewua6ewxdvjc@rob-hp-laptop>
Message-ID: <1479179389.10566.11.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2016-11-09 at 12:26 -0600, Rob Herring wrote:
> On Tue, Nov 01, 2016 at 07:52:00PM +0800, Youlin Pei wrote:
> > This commit adds the device tree binding document for
> > the mediatek cirq.
> > 
> > Signed-off-by: Youlin Pei <youlin.pei@mediatek.com>
> > ---
> >  .../interrupt-controller/mediatek,cirq.txt         |   30 ++++++++++++++++++++
> >  1 file changed, 30 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/mediatek,cirq.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/mediatek,cirq.txt b/Documentation/devicetree/bindings/interrupt-controller/mediatek,cirq.txt
> > new file mode 100644
> > index 0000000..84e8123
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/mediatek,cirq.txt
> > @@ -0,0 +1,30 @@
> > +* Mediatek 27xx cirq
> > +
> > +In Mediatek SOCs, the CIRQ is a low power interrupt controller designed to
> > +works outside MCUSYS which comprises with Cortex-Ax cores,CCI and GIC.
> 
> s/works/work/

will fix in next version.

> 
> > +The external interrupts (outside MCUSYS) will feed through CIRQ and connect
> > +to GIC in MCUSYS. When CIRQ is enabled, it will record the edge-sensitive
> > +interrupts and generated a pulse signal to parent interrupt controller when
> 
> s/generated/generate/

will fix in next version.

> 
> > +flush command is executed. With CIRQ, MCUSYS can be completely turned off
> > +to improve the system power consumption without losing interrupts.
> > +
> > +Required properties:
> > +- compatible: should be: "mediatek,mtk-cirq".
> 
> This should be SoC specific. This is fine as a fallback if the same 
> block is in many SoCs, but mediatek and mtk is a bit redundant.
> 

In next version, i will improve as following:
- compatible: Should be one of 
  - "mediatek,mt2701-cirq" for mt2701 CIRQ
  - "mediatek,mt8173-cirq" for mt8173 CIRQ
  - "mediatek,mt8135-cirq" for mt8135 CIRQ
  and "mediatek,cirq" as a fallback.

> > +- interrupt-controller : Identifies the node as an interrupt controller.
> > +- #interrupt-cells : Use the same format as specified by GIC in arm,gic.txt.
> > +- interrupt-parent: phandle of irq parent for cirq. The parent must
> > +  use the same interrupt-cells format as GIC.
> > +- reg: Physical base address of the cirq registers and length of memory
> > +  mapped region.
> > +- mediatek,ext-irq-start: Identifies external irq start number in different
> > +  SOCs.
> 
> Wouldn't this always be 32 if the GIC is the parent? If 32 is the common 
> case, then use the SoC compatible to determine this value.
> 

ext-irq-start is not always 32. In different Socs, this value is
different.
Thanks a lot!

> > +
> > +Example:
> > +	cirq: interrupt-controller at 10204000 {
> > +		compatible = "mediatek,mtk-cirq";
> > +		interrupt-controller;
> > +		#interrupt-cells = <3>;
> > +		interrupt-parent = <&sysirq>;
> > +		reg = <0 0x10204000 0 0x4000>;
> > +		mediatek,ext-irq-start = <32>;
> > +	};
> > -- 
> > 1.7.9.5
> > 
