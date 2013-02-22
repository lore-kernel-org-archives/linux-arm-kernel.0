From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 22 Feb 2013 14:46:06 +0000
Subject: [PATCH] dma: imx-dma: Add oftree support
In-Reply-To: <1361543838-12604-1-git-send-email-mpa@pengutronix.de>
References: <1361543838-12604-1-git-send-email-mpa@pengutronix.de>
Message-ID: <201302221446.07069.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 22 February 2013, Markus Pargmann wrote:
> Adding devicetree support for imx-dma driver. Use driver name for
> function 'imx_dma_is_general_purpose' because the devicename for
> devicetree initialized devices is different.
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>

Hi Markus,

Please make sure you are following the generic dma binding from
Documentation/devicetree/bindings/dma/dma.txt that is getting added
in Linux-3.9.

> +++ b/Documentation/devicetree/bindings/dma/fsl-imx-dma.txt
> @@ -0,0 +1,13 @@
> +* Freescale Direct Memory Access (DMA) Controller for i.MX
> +
> +Required properties:
> +- compatible : Should be "fsl,<chip>-dma". chip can be imx1, imx21 or imx27
> +- reg : Should contain DMA registers location and length
> +- interrupts : First item should be DMA interrupt, second one is optional and
> +  should contain DMA Error interrupt
> +
> +dma: dma at 10001000 {
> +       compatible = "fsl,imx27-dma";
> +       reg = <0x10001000 0x1000>;
> +       interrupts = <32 33>;
> +};

In particular, the "#dma-cells" property is required here, along with
dma-channels and dma-requests. You also need to describe the format
of the "dmas" property in slave drivers referring to this node.
In a lot of cases, you only need a single cell there, which is the
request line number.

	Arnd
