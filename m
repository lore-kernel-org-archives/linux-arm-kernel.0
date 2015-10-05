From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 5 Oct 2015 13:11:34 +0100
Subject: [PATCH v2 5/5] drivers: firmware: psci: add PSCI v1.0 DT bindings
In-Reply-To: <56126379.6050201@arm.com>
References: <1436375811-10529-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1436375811-10529-6-git-send-email-lorenzo.pieralisi@arm.com>
 <56126379.6050201@arm.com>
Message-ID: <20151005121134.GA1594@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andre,

On Mon, Oct 05, 2015 at 12:48:09PM +0100, Andre Przywara wrote:
> Hi Lorenzo,
> 
> sorry for this late reply, but this came up recently during an IRC
> discussion:
> 
> On 08/07/15 18:16, Lorenzo Pieralisi wrote:
> > PSCI 1.0 is designed to be fully compliant to the PSCI 0.2
> > specification, with minor differences that are described in the
> > PSCI specification.
> 
> So if PSCI 1.0 is fully compliant to the 0.2 spec and PSCI 0.2 mandates
> a version function, why do we need a new binding here?
> IIRC device tree bindings are just for features that cannot be probed,
> whereas the availability of PSCI 1.0 features can be safely probed by
> issuing the PSCI_VERSION call and checking for bits [16:32] >= 1.
> So can't we just skip this extra binding and keep the compatible string
> to 0.2 for every upcoming PSCI implementation?
> This should actually be the last binding we need, since availability of
> specific functions can be checked as well with the PSCI_FEATURES call in
> the future.

The reason is written below, and basically it is to prevent old
kernels using/matching PSCI 1.0 firmware compliant implementations,
owing to the minor 1.0 spec updates implemented in this patchset.

Thanks,
Lorenzo

> Cheers,
> Andre
> 
> > 
> > In particular, PSCI v1.0 augments the specification with a new
> > power_state format (extended stateid - probeable through the
> > PSCI_FEATURES call), changes some function return codes and
> > functions usage requirements wrt PSCI 0.2. These changes mean
> > that 1.0 vs 0.2 compliancy should be enforced through a DT
> > compatible string that allows firmware to specify 1.0 only
> > compliancy so that older kernels are prevented from using
> > PSCI 1.0 FW implementations in a non-compatible way (eg by
> > calling a 1.0 FW implementation and expecting 0.2 behaviour).
> > 
> > This patch adds PSCI 1.0 DT bindings and related compatible
> > string.
> > 
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Acked-by: Sudeep Holla <sudeep.holla@arm.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > ---
> >  Documentation/devicetree/bindings/arm/psci.txt | 6 ++++++
> >  drivers/firmware/psci.c                        | 1 +
> >  2 files changed, 7 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/psci.txt b/Documentation/devicetree/bindings/arm/psci.txt
> > index 5aa40ed..a9adab8 100644
> > --- a/Documentation/devicetree/bindings/arm/psci.txt
> > +++ b/Documentation/devicetree/bindings/arm/psci.txt
> > @@ -31,6 +31,10 @@ Main node required properties:
> >  					support, but are permitted to be present for compatibility with
> >  					existing software when "arm,psci" is later in the compatible list.
> >  
> > +				* "arm,psci-1.0" : for implementations complying to PSCI 1.0. PSCI 1.0 is
> > +					backward compatible with PSCI 0.2 with minor specification updates,
> > +					as defined in the PSCI specification[2].
> > +
> >   - method        : The method of calling the PSCI firmware. Permitted
> >                     values are:
> >  
> > @@ -100,3 +104,5 @@ Case 3: PSCI v0.2 and PSCI v0.1.
> >  
> >  [1] Kernel documentation - ARM idle states bindings
> >      Documentation/devicetree/bindings/arm/idle-states.txt
> > +[2] Power State Coordination Interface (PSCI) specification
> > +    http://infocenter.arm.com/help/topic/com.arm.doc.den0022c/DEN0022C_Power_State_Coordination_Interface.pdf
> > diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
> > index bd2ba5b..5b544d7 100644
> > --- a/drivers/firmware/psci.c
> > +++ b/drivers/firmware/psci.c
> > @@ -392,6 +392,7 @@ out_put_node:
> >  static const struct of_device_id psci_of_match[] __initconst = {
> >  	{ .compatible = "arm,psci",	.data = psci_0_1_init},
> >  	{ .compatible = "arm,psci-0.2",	.data = psci_0_2_init},
> > +	{ .compatible = "arm,psci-1.0",	.data = psci_0_2_init},
> >  	{},
> >  };
> >  
> > 
