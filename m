From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 28 Jun 2018 10:14:24 +0200
Subject: [PATCH v2] dt-bindings: serial: imx: clarify rs485 support usage
In-Reply-To: <e9beff38e9035c2f33d691f362e37d8e62aaa660.1530170732.git.baruch@tkos.co.il>
References: <e9beff38e9035c2f33d691f362e37d8e62aaa660.1530170732.git.baruch@tkos.co.il>
Message-ID: <20180628081424.hsndzkyhzxjvuzyp@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 28, 2018 at 10:25:32AM +0300, Baruch Siach wrote:
> The i.MX UART peripheral uses the RST_B signal as input, and CTS_B as
> output. This is just like the DCE role in RS-232. This is true
> regardless of the "DTE mode" setting of this peripheral.
> 
> As a result, rs485 support hardware must use the CTS_B signal to control
> the RS-485 transceiver. This is in contrast to generic rs485 kernel
> code, documentation, and DT property names that consistently refer to
> the RTS as transceiver control signal.

Well, the reason is that the pin function is called CTS because
Freescale chose to name it from the DCE's POV which is unusual.
So this isn't exactly specific to rs485 but also affect rs232 operation.

> Add a note in the DT binding document about that, to reduce the
> confusion somewhat.
> 
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
> v2: Fix commit log typos (Lothar Wa?mann)
> ---
>  Documentation/devicetree/bindings/serial/fsl-imx-uart.txt | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/serial/fsl-imx-uart.txt b/Documentation/devicetree/bindings/serial/fsl-imx-uart.txt
> index afcfbc34e243..35957cbf1571 100644
> --- a/Documentation/devicetree/bindings/serial/fsl-imx-uart.txt
> +++ b/Documentation/devicetree/bindings/serial/fsl-imx-uart.txt
> @@ -9,7 +9,11 @@ Optional properties:
>  - fsl,dte-mode : Indicate the uart works in DTE mode. The uart works
>                    in DCE mode by default.
>  - rs485-rts-delay, rs485-rts-active-low, rs485-rx-during-tx,
> -  linux,rs485-enabled-at-boot-time: see rs485.txt
> +  linux,rs485-enabled-at-boot-time: see rs485.txt. Note that for RS485
> +  you must enable either the "uart-has-rtscts" or the "rts-gpios"
> +  properties. In case you use "uart-has-rtscts" the signal that controls
> +  the transceiver is actually CTS_B, not RTS_B. CTS_B is always output,
> +  and RTS_B is input, regardless of dte-mode.

Still this section is correct and better than what we had (not) before.
So:
Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
