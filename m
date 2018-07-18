From: aisheng.dong@nxp.com (A.s. Dong)
Date: Wed, 18 Jul 2018 09:14:08 +0000
Subject: [PATCH v4 2/4] dt-bindings: arm: fsl: rework mu doc
In-Reply-To: <20180718071251.8857-3-o.rempel@pengutronix.de>
References: <20180718071251.8857-1-o.rempel@pengutronix.de>
 <20180718071251.8857-3-o.rempel@pengutronix.de>
Message-ID: <AM0PR04MB4211E48ACD3B832236FA228180530@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Oleksij Rempel [mailto:o.rempel at pengutronix.de]
> Sent: Wednesday, July 18, 2018 3:13 PM
> To: Shawn Guo <shawnguo@kernel.org>; Fabio Estevam
> <fabio.estevam@nxp.com>; Rob Herring <robh+dt@kernel.org>; Mark
> Rutland <mark.rutland@arm.com>; A.s. Dong <aisheng.dong@nxp.com>
> Cc: Oleksij Rempel <o.rempel@pengutronix.de>; kernel at pengutronix.de;
> linux-arm-kernel at lists.infradead.org; devicetree at vger.kernel.org; dl-linux-
> imx <linux-imx@nxp.com>
> Subject: [PATCH v4 2/4] dt-bindings: arm: fsl: rework mu doc
> 

The patch title may be improved like:
dt-bindings: mailbox: imx-mu: add generic MU channel support

And explain in commit message:
Each MU has four pairs of rx/tx data register with four rx/tx interrupts which can also
be used as a separate channel. This patch intends to .....

> - Remove software specific description. MU has many use cases limited only
> by imagination. So remove this confusing part.
> - Add all currently known SoCs with MU
> - Make sure this documentation covers not only Firmware specific use case.
> Parameters for generic configurations should be described as well.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  .../devicetree/bindings/mailbox/fsl,mu.txt    | 32 +++++++++----------
>  1 file changed, 15 insertions(+), 17 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/fsl,mu.txt
> b/Documentation/devicetree/bindings/mailbox/fsl,mu.txt
> index 90e4905dfc69..9d5e6ee61e22 100644
> --- a/Documentation/devicetree/bindings/mailbox/fsl,mu.txt
> +++ b/Documentation/devicetree/bindings/mailbox/fsl,mu.txt
> @@ -1,28 +1,26 @@
>  NXP i.MX Messaging Unit (MU)
>  --------------------------------------------------------------------
> 
> -The Messaging Unit module enables two processors within the SoC to -
> communicate and coordinate by passing messages (e.g. data, status -and
> control) through the MU interface. The MU also provides the ability -for one
> processor to signal the other processor using interrupts.
> -
> -Because the MU manages the messaging between processors, the MU uses
> -different clocks (from each side of the different peripheral buses).
> -Therefore, the MU must synchronize the accesses from one side to the -
> other. The MU accomplishes synchronization using two sets of matching -
> registers (Processor A-facing, Processor B-facing).
> -
> -Messaging Unit Device Node:
> -=============================
> -

Here you removed all the HW description of MU from the reference manual
which is a bit strange to me.

The reason you given is "remove software specific description. MU has many use
cases limited only by imagination. So remove this confusing part" looks not quit
convince. What confusing did you mean?
Is it " passing messages (e.g. data, status -and control)"?
Those are HW capabilities and I'm not sure it's quite necessary to remove them.

Regards
Dong Aisheng

>  Required properties:
>  -------------------
> -- compatible :	should be "fsl,<chip>-mu", the supported chips include
> -		imx8qxp, imx8qm.
> +- compatible :	should be "fsl,<chip>-mu", the supported chips include:
> +		fsl,imx6sx-mu	- i.MX 6SoloX
> +		fsl,imx7d-mu	- i.MX 7Dual
> +		fsl,imx7s-mu	- i.MX 7Solo
> +		fsl,imx7ulp-mu	- i.MX 7ULP
> +		fsl,imx8qm-mu	- i.MX 8QM
> +		fsl,imx8qxp-mu	- i.MX 8QXP
>  - reg :		Should contain the registers location and length
>  - interrupts :	Interrupt number. The interrupt specifier format depends
>  		on the interrupt controller parent.
> -- #mbox-cells:  Must be 0. Number of cells in a mailbox
> +- #mbox-cells:  Must be:
> +		0 - for single channel mode. i.MX8* SCU protocol specific.
> +		1 - for multichannel (generic) mode.
> +
> +Optional properties:
> +-------------------
> +- clocks :	phandle to the input clock.
> +- fsl,mu-side-b : Should be set for side B MU.
> 
>  Examples:
>  --------
> --
> 2.18.0
