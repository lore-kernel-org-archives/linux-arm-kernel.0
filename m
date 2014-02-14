From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 14 Feb 2014 10:24:15 +0000
Subject: [PATCH v5 2/3] serial: fsl_lpuart: add DMA support
In-Reply-To: <1392362839-8004-3-git-send-email-yao.yuan@freescale.com>
References: <1392362839-8004-1-git-send-email-yao.yuan@freescale.com>
 <1392362839-8004-3-git-send-email-yao.yuan@freescale.com>
Message-ID: <20140214102415.GB9907@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 14, 2014 at 07:27:18AM +0000, Yuan Yao wrote:
> Add dma support for lpuart. This function depend on DMA driver.
> You can turn on it by write both the dmas and dma-name properties in dts node.
> 
> Signed-off-by: Yuan Yao <yao.yuan@freescale.com>
> ---
>  .../devicetree/bindings/serial/fsl-lpuart.txt      |  19 +-
>  drivers/tty/serial/fsl_lpuart.c                    | 430 ++++++++++++++++++++-
>  2 files changed, 433 insertions(+), 16 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/serial/fsl-lpuart.txt b/Documentation/devicetree/bindings/serial/fsl-lpuart.txt
> index 6fd1dd1..6e1cbbf 100644
> --- a/Documentation/devicetree/bindings/serial/fsl-lpuart.txt
> +++ b/Documentation/devicetree/bindings/serial/fsl-lpuart.txt
> @@ -5,10 +5,24 @@ Required properties:
>  - reg : Address and length of the register set for the device
>  - interrupts : Should contain uart interrupt
> 
> +Optional properties:
> +- dmas: List of two DMA specifiers, using a three-cell specifier for each channel.
> +       a phandle plus two integer cells. The three cells in order are:
> +       1.A phandle pointing to the DMA controller.
> +       2.specifies the channel group(DMAMUX) in which this request can be multiplexed,
> +       3.specifies the request source.

The precise format of a dma-specifier is up to the DMA binding. Why does
the client binding care?

> +- dma-names: Contains one identifier string for each DMA specifier in the dmas property.
> +       "tx" for the transmit channel, "rx" for the receive channel.
> +
> +Note: Optional properties for DMA support. Write them both or both not.
> +

All you need is something like:

dmas: A list of two dma specifiers, one for each entry in dma-names
dma-names: should contain "tx" and "rx".

Thanks,
Mark.
