From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 9 Jan 2014 09:56:38 +0100
Subject: [PATCH 2/2] serial: fsl_lpuart: add eDMA support
In-Reply-To: <1389236681-30372-3-git-send-email-yao.yuan@freescale.com>
References: <1389236681-30372-1-git-send-email-yao.yuan@freescale.com>
 <1389236681-30372-3-git-send-email-yao.yuan@freescale.com>
Message-ID: <201401090956.38789.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 09 January 2014, Yuan Yao wrote:
> Signed-off-by: Yuan Yao <yao.yuan@freescale.com>
> ---
>  .../devicetree/bindings/serial/fsl-lpuart.txt      |  17 +-
>  drivers/tty/serial/fsl_lpuart.c                    | 434 +++++++++++++++++----
>  2 files changed, 365 insertions(+), 86 deletions(-)


Both patches are lacking a changeset description. Please describe why
this patch is needed and what the changes to the interfaces are.

> diff --git a/Documentation/devicetree/bindings/serial/fsl-lpuart.txt b/Documentation/devicetree/bindings/serial/fsl-lpuart.txt
> index 6fd1dd1..311598d 100644
> --- a/Documentation/devicetree/bindings/serial/fsl-lpuart.txt
> +++ b/Documentation/devicetree/bindings/serial/fsl-lpuart.txt
> @@ -4,11 +4,20 @@ Required properties:
>  - compatible : Should be "fsl,<soc>-lpuart"
>  - reg : Address and length of the register set for the device
>  - interrupts : Should contain uart interrupt
> +- clocks : clocks: from common clock binding: handle to uart clock
> +- clock-names : from common clock binding: Shall be "jpg"

	typo: "ipg", not "jpg"

> +- dma-names: Should contain "lpuart-tx" for transmit and "lpuart-rx" for receive channels
> +- dmas: Should contain dma specifiers for transmit and receive channels

I note that this is an incompatible change: Prior to this patch,
the dma properties were not allowed, now they are listed as
"required". We try hard to avoid incompatible changes to the binding
in general. Please make sure that you either

a) list the dma properties as "optional" and verify that the driver still works
   fine when they are absent, or

b) document in the changeset text your motivation for doing an incompatible
   change, why you could not do it in a compatible way, and what the possible
   impact is for existing users.

>  Example:
>  
>  uart0: serial at 40027000 {
> -	       compatible = "fsl,vf610-lpuart";
> -	       reg = <0x40027000 0x1000>;
> -	       interrupts = <0 61 0x00>;
> -       };
> +		compatible = "fsl,vf610-lpuart";
> +		reg = <0x40027000 0x1000>;
> +		interrupts = <0 61 0x00>;
> +		clocks = <&clks VF610_CLK_UART0>;
> +		clock-names = "ipg";
> +		dma-names = "lpuart-tx","lpuart-rx";
> +		dmas = <&edma0 0 VF610_EDMA_MUXID0_UART0_TX>,
> +			<&edma0 0 VF610_EDMA_MUXID0_UART0_RX>;
> +	};

I checked again and found that VF610_EDMA_MUXID0_UART0_TX and RX are not
defined as macros anywhere, and I think they should not be. The common
convention is to just ust number literals here. There is no point
defining the macros in a common header file because they will change
with every new SoC.

> @@ -131,6 +158,10 @@ static struct of_device_id lpuart_dt_ids[] = {
>  };
>  MODULE_DEVICE_TABLE(of, lpuart_dt_ids);
>  
> +static int lpuart_dma_tx(struct lpuart_port *sport, unsigned long count);
> +static int lpuart_dma_rx(struct lpuart_port *sport);
> +static void lpuart_prepare_tx(struct lpuart_port *sport);
> +
>  static void lpuart_stop_tx(struct uart_port *port)
>  {
>  	unsigned char temp;

Coding style: Please try to avoid forward declarations for "static" functions.
Instead, reorder the code in a way that they are not needed.

	Arnd
