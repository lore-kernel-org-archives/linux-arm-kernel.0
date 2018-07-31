From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Tue, 31 Jul 2018 21:28:09 +0530
Subject: [PATCH v8 2/4] dt-bindings: mailbox: imx-mu: add generic MU
 channel support
In-Reply-To: <20180731141146.10788-3-o.rempel@pengutronix.de>
References: <20180731141146.10788-1-o.rempel@pengutronix.de>
 <20180731141146.10788-3-o.rempel@pengutronix.de>
Message-ID: <CABb+yY1ZusgN4UVxmUgXZS9ObGdLwFAL4XkW7F1yVb6Gq=9XPA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 31, 2018 at 7:41 PM, Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> Each MU has four pairs of rx/tx data register with four rx/tx interrupts
> which can also be used as a separate channel.
>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  .../devicetree/bindings/mailbox/fsl,mu.txt    | 28 +++++++++++++++++--
>  1 file changed, 25 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mailbox/fsl,mu.txt b/Documentation/devicetree/bindings/mailbox/fsl,mu.txt
> index 90e4905dfc69..9efd3a9ade44 100644
> --- a/Documentation/devicetree/bindings/mailbox/fsl,mu.txt
> +++ b/Documentation/devicetree/bindings/mailbox/fsl,mu.txt
> @@ -18,11 +18,33 @@ Messaging Unit Device Node:
>  Required properties:
>  -------------------
>  - compatible : should be "fsl,<chip>-mu", the supported chips include
> -               imx8qxp, imx8qm.
> +               imx6sx, imx7s, imx8qxp, imx8qm.
> +               The "fsl,imx6sx-mu" compatible is seen as generic and should
> +               be included together with SoC specific compatible.
>  - reg :                Should contain the registers location and length
>  - interrupts : Interrupt number. The interrupt specifier format depends
>                 on the interrupt controller parent.
> -- #mbox-cells:  Must be 0. Number of cells in a mailbox
> +- #mbox-cells:  Must be 2.
>
This seems like modifying the bindings. But since nothing exists yet,
maybe we should merge patch 1 and 2 ?


> +                         <&phandle type channel>
> +                           phandle   : Label name of controller
> +                           type      : Channel type
> +                           channel   : Channel number
> +
> +               This MU support 4 type of unidirectional channels, each type
> +               has 4 channels. A total of 16 channels. Following types are
> +               supported:
> +               0 - TX channel with 32bit transmit register and IRQ transmit
> +               acknowledgment support.
> +               1 - RX channel with 32bit receive register and IRQ support
> +               2 - TX doorbell channel. Without own register and no ACK support.
> +               3 - RX doorbell channel.
>
Thanks. This is great.

> +               The doorbell channels should be used with shared memory and protocol
> +               level acknowledgment if needed.
> +
I would avoid this. People might get notions that they have to use
shmem with doorbell -- a trivial protocol might mean doing some fixed
action (like reset) whenever the doorbell rings.


> +Optional properties:
> +-------------------
> +- clocks :     phandle to the input clock.
> +- fsl,mu-side-b : Should be set for side B MU.
>
Nit: can we call this 'fsl,no-init' ?
