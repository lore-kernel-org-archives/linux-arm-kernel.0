From: aisheng.dong@nxp.com (A.s. Dong)
Date: Wed, 2 May 2018 17:29:00 +0000
Subject: [PATCH 2/4] dt-bindings: arm: fsl: add mu binding doc
In-Reply-To: <20180501152547.GA6565@rob-hp-laptop>
References: <1524854776-14863-1-git-send-email-aisheng.dong@nxp.com>
 <1524854776-14863-3-git-send-email-aisheng.dong@nxp.com>
 <20180501152547.GA6565@rob-hp-laptop>
Message-ID: <AM0PR04MB4211D063192A35AC7727ADAA80800@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

Thanks for the review.

> -----Original Message-----
> From: Rob Herring [mailto:robh at kernel.org]
> Sent: Tuesday, May 1, 2018 11:26 PM
> To: A.s. Dong <aisheng.dong@nxp.com>
> Cc: linux-arm-kernel at lists.infradead.org; dongas86 at gmail.com;
> kernel at pengutronix.de; shawnguo at kernel.org; Fabio Estevam
> <fabio.estevam@nxp.com>; dl-linux-imx <linux-imx@nxp.com>; Mark
> Rutland <mark.rutland@arm.com>; devicetree at vger.kernel.org
> Subject: Re: [PATCH 2/4] dt-bindings: arm: fsl: add mu binding doc
> 
> On Sat, Apr 28, 2018 at 02:46:14AM +0800, Dong Aisheng wrote:
> > The Messaging Unit module enables two processors within the SoC to
> > communicate and coordinate by passing messages (e.g. data, status and
> > control) through the MU interface.
> >
> > Cc: Shawn Guo <shawnguo@kernel.org>
> > Cc: Sascha Hauer <kernel@pengutronix.de>
> > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: devicetree at vger.kernel.org
> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > ---
> >  .../devicetree/bindings/arm/freescale/fsl,mu.txt   | 33
> ++++++++++++++++++++++
> 
> bindings/mailbox/ ?
> 
> Why aren't you using the mailbox binding?
> 

It's mainly because MU is not implemented as a mailbox driver,
Instead, they're provided in library calls to gain higher efficiency.

For this case, do i still need to change to mailbox binding?

BTW i.MX MU has only one channel. But the binding doc claims
#mbox-cells must be at least 1. That means the index cells is meaningless
to i.MX MUs.
(Probably mailbox binding could be extended to cover this case?
 E.g. #mbox-cells = <0>)

> >  1 file changed, 33 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/arm/freescale/fsl,mu.txt
> >
> > diff --git
> > a/Documentation/devicetree/bindings/arm/freescale/fsl,mu.txt
> > b/Documentation/devicetree/bindings/arm/freescale/fsl,mu.txt
> > new file mode 100644
> > index 0000000..a7ceb1f
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/freescale/fsl,mu.txt
> > @@ -0,0 +1,33 @@
> > +NXP i.MX Messaging Unit (MU)
> > +--------------------------------------------------------------------
> > +
> > +The Messaging Unit module enables two processors within the SoC to
> > +communicate and coordinate by passing messages (e.g. data, status and
> > +control) through the MU interface. The MU also provides the ability
> > +for one processor to signal the other processor using interrupts.
> > +
> > +Because the MU manages the messaging between processors, the MU
> uses
> > +different clocks (from each side of the different peripheral buses).
> > +Therefore, the MU must synchronize the accesses from one side to the
> > +other. The MU accomplishes synchronization using two sets of matching
> > +registers (Processor A-facing, Processor Bfacing).
> 
> B-facing
> 

Got it

> > +
> > +Messaging Unit Device Node:
> > +=============================
> > +
> > +Required properties:
> > +-------------------
> > +- compatible :	should be "fsl,<chip>-mu", the supported chips
> include
> > +		imx6sx, imx7d, imx7ulp, imx8qxp, imx8qm, imx8mq.
> 
> 'qm' and 'mq' are really both parts?
> 

Yes, they're two SoCs.

> > +- reg :		Should contain the registers location and length
> > +- interrupts :	Interrupt number. The interrupt specifier format
> depends
> > +		on the interrupt controller parent.
> > +
> > +Examples:
> > +--------
> > +lsio_mu0: mu at 5d1b0000 {
> > +	compatible = "fsl,imx8qxp-mu", "fsl,imx6sx-mu";
> 
> It is not clear from the definition above that fsl,imx6sx-mu is a fallback. Is that
> true for all the other chips too?
> 

Mx6sx is the first one introducing MU while all others chips are almost using the
same one except MX7ULP with a bit differences.

> > +	reg = <0x0 0x5d1b0000 0x0 0x10000>;
> 
> Really has 64KB of registers? You are just wasting virtual address space which
> is scarce on 32-bit processors with GBs of RAM.
> 

For 32-bit processors, it's 16KB.
For 64-bit processors, yes, according to RM, it's 64KB one slot in the memory
map chapter. But actually It has only 10 registers for user to access,
do you think we need to reduce to the real register size?

> > +	interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>;
> > +	status = "okay";
> 
> Don't show status in examples.
> 

Got it.

Regards
Dong Aisheng

> > +};
> > --
> > 2.7.4
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe devicetree"
> > in the body of a message to majordomo at vger.kernel.org More
> majordomo
> > info at
> >
> https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fvger
> > .kernel.org%2Fmajordomo-
> info.html&data=02%7C01%7Caisheng.dong%40nxp.co
> >
> m%7C94ea748130d84ea27d0e08d5af77d20a%7C686ea1d3bc2b4c6fa92cd99c5
> c30163
> >
> 5%7C0%7C0%7C636607851512054847&sdata=%2BFi05UUHdS77rlQpcFqqxg2Z
> VDx60ci
> > Zemf%2BM4lHlpg%3D&reserved=0
