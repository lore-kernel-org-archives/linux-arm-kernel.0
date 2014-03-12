From: mporter@linaro.org (Matt Porter)
Date: Wed, 12 Mar 2014 09:46:34 -0400
Subject: [PATCH v4 1/5] mfd: add bcm590xx pmu DT binding
In-Reply-To: <20140312133339.GC17461@e106331-lin.cambridge.arm.com>
References: <1394580837-8331-1-git-send-email-mporter@linaro.org>
 <1394580837-8331-2-git-send-email-mporter@linaro.org>
 <20140312133339.GC17461@e106331-lin.cambridge.arm.com>
Message-ID: <20140312134634.GR25092@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 12, 2014 at 01:33:39PM +0000, Mark Rutland wrote:
> On Tue, Mar 11, 2014 at 11:33:53PM +0000, Matt Porter wrote:
> > Add a DT binding for the BCM590xx PMUs. The binding inherits from
> > the generic regulator bindings.
> > 
> > Signed-off-by: Matt Porter <mporter@linaro.org>
> > Reviewed-by: Tim Kryger <tim.kryger@linaro.org>
> > Reviewed-by: Markus Mayer <markus.mayer@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/mfd/bcm590xx.txt | 41 ++++++++++++++++++++++
> >  1 file changed, 41 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mfd/bcm590xx.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/mfd/bcm590xx.txt b/Documentation/devicetree/bindings/mfd/bcm590xx.txt
> > new file mode 100644
> > index 0000000..2300246
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mfd/bcm590xx.txt
> > @@ -0,0 +1,41 @@
> > +-------------------------------
> > +BCM590xx Power Management Units
> > +-------------------------------
> > +
> > +Required properties:
> > +- compatible: "brcm,bcm59056"
> > +- reg: I2C slave address
> > +- interrupts: interrupt for the PMU. Generic interrupt client node bindings
> > +  are described in interrupt-controller/interrupts.txt
> 
> This all looks sane.
> 
> > +
> > +------------------
> > +Voltage Regulators
> > +------------------
> > +
> > +Optional properties:
> > +- regulators: This is the list of child nodes that specify the regulator
> > +  initialization data for defined regulators.  Generic regulator bindings
> > +  are described in regulator/regulator.txt.
> 
> This is a subnode, not a property. How about:
> 
> Optional child nodes:
> 
> - regulators: container node for regulators follwoing the generic
>   regulator binding in regulator/regulator.txt.

Agreed, I'll reword like that...makes more sense like that.

> > +
> > +  The valid regulator nodes for BCM59056 are:
> 
> s/nodes/node names/

Ok

> > +  	rfldo, camldo1, camldo2, simldo1, simldo2, sdldo, sdxldo,
> > +	mmcldo1, mmcldo2, audldo, micldo, usbldo, vibldo,
> > +	csr, iosr1, iosr2, msr, sdsr1, sdsr2, vsr
> > +
> > +Example:
> > +	pmu: bcm59056 at 8 {
> > +		compatible = "brcm,bcm59056";
> > +		reg = <0x08>;
> > +		interrupts = <GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH>;
> > +		regulators {
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +
> > +			rfldo_reg: rfldo {
> > +				regulator-min-microvolt = <1200000>;
> > +				regulator-max-microvolt = <3300000>;
> 
> Are any specific properties required on these children?

None. The only requirement is that when regulator node exists, the
node names must match those listed.

I'll send out another version with rewording suggested above.

Thanks,
Matt
