From: aisheng.dong@nxp.com (A.s. Dong)
Date: Thu, 21 Jun 2018 03:38:30 +0000
Subject: [PATCH V2 3/4] dt-bindings: arm: fsl: add scu binding doc
In-Reply-To: <20180620194438.GA3494@rob-hp-laptop>
References: <1529239789-26849-1-git-send-email-aisheng.dong@nxp.com>
 <1529239789-26849-4-git-send-email-aisheng.dong@nxp.com>
 <20180620194438.GA3494@rob-hp-laptop>
Message-ID: <AM0PR04MB4211C2A376E6C74C7C4AC37880760@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

> -----Original Message-----
> From: Rob Herring [mailto:robh at kernel.org]
> Sent: Thursday, June 21, 2018 3:45 AM
> To: A.s. Dong <aisheng.dong@nxp.com>
> Cc: linux-arm-kernel at lists.infradead.org; dongas86 at gmail.com;
> kernel at pengutronix.de; shawnguo at kernel.org; Fabio Estevam
> <fabio.estevam@nxp.com>; dl-linux-imx <linux-imx@nxp.com>; Mark
> Rutland <mark.rutland@arm.com>; devicetree at vger.kernel.org
> Subject: Re: [PATCH V2 3/4] dt-bindings: arm: fsl: add scu binding doc
> 
> On Sun, Jun 17, 2018 at 08:49:48PM +0800, Dong Aisheng wrote:
> > The System Controller Firmware (SCFW) is a low-level system function
> > which runs on a dedicated Cortex-M core to provide power, clock, and
> > resource management. It exists on some i.MX8 processors. e.g. i.MX8QM
> > (QM, QP), and i.MX8QX (QXP, DX).
> >
> > Cc: Shawn Guo <shawnguo@kernel.org>
> > Cc: Sascha Hauer <kernel@pengutronix.de>
> > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: devicetree at vger.kernel.org
> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > ---
> > v1->v2:
> >  * remove status
> >  * changed to mu1
> > ---
> >  .../devicetree/bindings/arm/freescale/fsl,scu.txt  | 38
> > ++++++++++++++++++++++
> >  1 file changed, 38 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> >
> > diff --git
> > a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> > b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> > new file mode 100644
> > index 0000000..9b7c9fe
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> > @@ -0,0 +1,38 @@
> > +NXP i.MX System Controller Firmware (SCFW)
> > +--------------------------------------------------------------------
> > +
> > +The System Controller Firmware (SCFW) is a low-level system function
> > +which runs on a dedicated Cortex-M core to provide power, clock, and
> > +resource management. It exists on some i.MX8 processors. e.g. i.MX8QM
> > +(QM, QP), and i.MX8QX (QXP, DX).
> > +
> > +The AP communicates with the SC using a multi-ported MU module found
> > +in the LSIO subsystem. The current definition of this MU module
> > +provides
> > +5 remote AP connections to the SC to support up to 5 execution
> > +environments (TZ, HV, standard Linux, etc.). The SC side of this MU
> > +module interfaces with the LSIO DSC IP bus. The SC firmware will
> > +communicate with this MU using the MSI bus.
> > +
> > +System Controller Device Node:
> > +=============================
> > +
> > +Required properties:
> > +-------------------
> > +- compatible: should be "fsl,imx8qxp-scu" or "fsl,imx8qm-scu"
> > +- fsl,mu: a phandle to the Message Unit used by SCU. Should be
> > +	  one of LSIO MU0~M4 for imx8qxp and imx8qm. Users need
> > +	  to make sure not use the one which is conflict with
> > +	  other execution environments. e.g. ATF.
> 
> Use the mailbox binding even if you don't use the mailbox subsystem.
> 

Looks reasonable. Will change it.

BTW as I said before, the current mailbox binding fixed #mbox-cells to be
at least 1 which is not suitable for i.MX SCU MU as it has only one physical
channel.

I will cook a patch to update it to allow #mbox-cells = <0>.

If any issue please let me know.

Regards
Dong Aisheng

> > +
> > +Examples:
> > +--------
> > +lsio_mu1: mu at 5d1c0000 {
> > +	compatible = "fsl,imx8qxp-mu";
> > +	reg = <0x0 0x5d1c0000 0x0 0x10000>;
> > +	interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>; };
> > +
> > +scu {
> > +	compatible = "fsl,imx8qxp-scu";
> > +	fsl,mu = <&lsio_mu1>;
> > +};
> > --
> > 2.7.4
> >
