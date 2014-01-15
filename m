From: joshc@codeaurora.org (Josh Cartwright)
Date: Wed, 15 Jan 2014 10:38:08 -0600
Subject: [PATCH v4 5/6] spmi: document the PMIC arbiter SPMI bindings
In-Reply-To: <20140115001344.GE23276@sonymobile.com>
References: <cover.1389738151.git.joshc@codeaurora.org>
 <6dbb1c77001542e093d3af09ea976d402ed24d17.1389738151.git.joshc@codeaurora.org>
 <20140115001344.GE23276@sonymobile.com>
Message-ID: <20140115163808.GW8153@joshc.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 14, 2014 at 04:13:45PM -0800, Courtney Cavin wrote:
> On Tue, Jan 14, 2014 at 07:41:39PM +0100, Josh Cartwright wrote:
> > Signed-off-by: Josh Cartwright <joshc@codeaurora.org>
> > ---
> >  .../bindings/spmi/qcom,spmi-pmic-arb.txt           | 46 ++++++++++++++++++++++
> >  1 file changed, 46 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.txt b/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.txt
> > new file mode 100644
> > index 0000000..9e50cb3
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.txt
> > @@ -0,0 +1,46 @@
> > +Qualcomm SPMI Controller (PMIC Arbiter)
> > +
> > +The SPMI PMIC Arbiter is found on the Snapdragon 800 Series.  It is an SPMI
> > +controller with wrapping arbitration logic to allow for multiple on-chip
> > +devices to control a single SPMI master.
> > +
> > +The PMIC Arbiter can also act as an interrupt controller, providing interrupts
> > +to slave devices.
> > +
> > +See spmi.txt for the generic SPMI controller binding requirements for child
> > +nodes.
> > +
> > +Required properties:
> > +- compatible : should be "qcom,spmi-pmic-arb".
> > +- reg-names  : should be "core", "intr", "cnfg"
> > +- reg : register specifiers, must contain 3 entries, in the follow order:
> > +     core registers, interrupt controller registers, configuration registers
> 
> As far as I can tell, patch 3/6 doesn't require these to be in any
> order, as it uses 'reg-names' to fetch the values. Perhaps the
> following:
> 
> reg-names : must contain:
> 	"core" - core registers
> 	"intr" - interrupt controller registers
> 	"cnfg" - configuration registers
> reg : A list of address + size pairs for the regs listed in reg-names

Yes, I think this reasonable.  Thanks.

> > +- #address-cells : must be set to 2
> > +- #size-cells : must be set to 0
> > +- qcom,ee : indicates the active Execution Environment identifier (0-5)
> > +- qcom,channel : which of the PMIC Arb provided channels to use for accesses (0-5)
> 
> These two are new.... Is it expected that they should be required?

The 'qcom,channel' property is unconditionally required.  Previous
iterations of the patchset assumed the desired channel was 0, however,
this assumption does not hold for other on-SoC masters.

The 'qcom,ee' property is required for the same reason, however it's
only technically required if the PMIC Arb's interrupt functionality is
to be used.  Right now the driver enforces this property's existence,
however technically this could be dropped to "optional".  But, I imagine
nearly everyone using the SPMI PMIC arb will also want interrupts.

> > +- interrupt-controller : indicates the PMIC arbiter is an interrupt controller
> 
> Although it's probably fairly understood that this is a boolean, it
> wouldn't hurt to mention that here.  It might also be worth referencing
> devicetree/binding/interrupt-controller/interrupts.txt in your opening
> blurb.

Okay.

> > +- #interrupt-cells = <4>:  interrupts are specified as a 4-tuple:
> 
> Nitpick: This '= <X>' differs from the above 'must be set to X' format.

Indeed.  Thanks.

> > +    cell 1: slave ID for the requested interrupt (0-15)
> > +    cell 2: peripheral ID for requested interrupt (0-255)
> > +    cell 3: the requested peripheral interrupt (0-7)
> > +    cell 4: interrupt flags indicating level-sense information, as defined in
> > +            dt-bindings/interrupt-controller/irq.h
> [...]
> 
> -Courtney

Thanks for the comments!

  Josh

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
