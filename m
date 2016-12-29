From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 29 Dec 2016 19:23:02 +0100
Subject: [PATCH v1] mtd: nand: tango: Update DT binding description
In-Reply-To: <ba47f2f1-bcdc-91e8-ed79-153931ccdad8@sigmadesigns.com>
References: <ba47f2f1-bcdc-91e8-ed79-153931ccdad8@sigmadesigns.com>
Message-ID: <20161229192302.5c94ecdb@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 19 Dec 2016 15:30:12 +0100
Marc Gonzalez <marc_gonzalez@sigmadesigns.com> wrote:

> Visually separate register ranges (address/size pairs) in reg prop.
> Change DMA channel name, for consistency with other drivers.
> 
> Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
> ---
>  Documentation/devicetree/bindings/mtd/tango-nand.txt | 6 +++---
>  drivers/mtd/nand/tango_nand.c                        | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mtd/tango-nand.txt b/Documentation/devicetree/bindings/mtd/tango-nand.txt
> index ad5a02f2ac8c..cd1bf2ac9055 100644
> --- a/Documentation/devicetree/bindings/mtd/tango-nand.txt
> +++ b/Documentation/devicetree/bindings/mtd/tango-nand.txt
> @@ -5,7 +5,7 @@ Required properties:
>  - compatible: "sigma,smp8758-nand"
>  - reg: address/size of nfc_reg, nfc_mem, and pbus_reg
>  - dmas: reference to the DMA channel used by the controller
> -- dma-names: "nfc_sbox"
> +- dma-names: "rxtx"

You probably want to fix the driver accordingly ;-).

>  - clocks: reference to the system clock
>  - #address-cells: <1>
>  - #size-cells: <0>
> @@ -17,9 +17,9 @@ Example:
>  
>  	nandc: nand-controller at 2c000 {
>  		compatible = "sigma,smp8758-nand";
> -		reg = <0x2c000 0x30 0x2d000 0x800 0x20000 0x1000>;
> +		reg = <0x2c000 0x30>, <0x2d000 0x800>, <0x20000 0x1000>;
>  		dmas = <&dma0 3>;
> -		dma-names = "nfc_sbox";
> +		dma-names = "rxtx";
>  		clocks = <&clkgen SYS_CLK>;
>  		#address-cells = <1>;
>  		#size-cells = <0>;
> diff --git a/drivers/mtd/nand/tango_nand.c b/drivers/mtd/nand/tango_nand.c
> index cc23db64f0ca..51dc88d6b8da 100644
> --- a/drivers/mtd/nand/tango_nand.c
> +++ b/drivers/mtd/nand/tango_nand.c
> @@ -629,7 +629,7 @@ static int tango_nand_probe(struct platform_device *pdev)
>  	if (IS_ERR(clk))
>  		return PTR_ERR(clk);
>  
> -	nfc->chan = dma_request_chan(&pdev->dev, "nfc_sbox");
> +	nfc->chan = dma_request_chan(&pdev->dev, "rxtx");
>  	if (IS_ERR(nfc->chan))
>  		return PTR_ERR(nfc->chan);
>  
