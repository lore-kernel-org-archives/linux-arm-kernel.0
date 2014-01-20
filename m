From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 20 Jan 2014 13:18:57 +0530
Subject: [PATCH v4] dmaengine: sirf: enable generic dt binding for dma
 channels
In-Reply-To: <1389190369-2012-1-git-send-email-21cnbao@gmail.com>
References: <1389190369-2012-1-git-send-email-21cnbao@gmail.com>
Message-ID: <20140120074857.GJ26823@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 08, 2014 at 10:12:49PM +0800, Barry Song wrote:
> From: Barry Song <Baohua.Song@csr.com>
> 
> move to support of_dma_request_slave_channel() and dma_request_slave_channel.
> we add a xlate() to let dma clients be able to find right dma_chan by generic
> "dmas" properties in dts.
> 
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>
Look okay, need an ACk from DT maintainers before I can apply...

--
~Vinod
> ---
>  -v4: clear dt-binding document according to Mark's feedback
> 
>  .../devicetree/bindings/dma/sirfsoc-dma.txt        |   43 ++++++++++++++++++++
>  arch/arm/boot/dts/atlas6.dtsi                      |    2 +
>  arch/arm/boot/dts/prima2.dtsi                      |    2 +
>  drivers/dma/sirf-dma.c                             |   23 ++++++++++
>  4 files changed, 70 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/dma/sirfsoc-dma.txt
> 
> diff --git a/Documentation/devicetree/bindings/dma/sirfsoc-dma.txt b/Documentation/devicetree/bindings/dma/sirfsoc-dma.txt
> new file mode 100644
> index 0000000..ecbc96a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/sirfsoc-dma.txt
> @@ -0,0 +1,43 @@
> +* CSR SiRFSoC DMA controller
> +
> +See dma.txt first
> +
> +Required properties:
> +- compatible: Should be "sirf,prima2-dmac" or "sirf,marco-dmac"
> +- reg: Should contain DMA registers location and length.
> +- interrupts: Should contain one interrupt shared by all channel
> +- #dma-cells: must be <1>. used to represent the number of integer
> +    cells in the dmas property of client device.
> +- clocks: clock required
> +
> +Example:
> +
> +Controller:
> +dmac0: dma-controller at b00b0000 {
> +	compatible = "sirf,prima2-dmac";
> +	reg = <0xb00b0000 0x10000>;
> +	interrupts = <12>;
> +	clocks = <&clks 24>;
> +	#dma-cells = <1>;
> +};
> +
> +
> +Client:
> +Fill the specific dma request line in dmas. In the below example, spi0 read
> +channel request line is 9 of the 2nd dma controller, while write channel uses
> +4 of the 2nd dma controller; spi1 read channel request line is 12 of the 1st
> +dma controller, while write channel uses 13 of the 1st dma controller:
> +
> +spi0: spi at b00d0000 {
> +	compatible = "sirf,prima2-spi";
> +	dmas = <&dmac1 9>,
> +		<&dmac1 4>;
> +	dma-names = "rx", "tx";
> +};
> +
> +spi1: spi at b0170000 {
> +	compatible = "sirf,prima2-spi";
> +	dmas = <&dmac0 12>,
> +		<&dmac0 13>;
> +	dma-names = "rx", "tx";
> +};
> diff --git a/arch/arm/boot/dts/atlas6.dtsi b/arch/arm/boot/dts/atlas6.dtsi
> index b63cfef..4f41f0a 100644
> --- a/arch/arm/boot/dts/atlas6.dtsi
> +++ b/arch/arm/boot/dts/atlas6.dtsi
> @@ -260,6 +260,7 @@
>  				reg = <0xb00b0000 0x10000>;
>  				interrupts = <12>;
>  				clocks = <&clks 24>;
> +				#dma-cells = <1>;
>  			};
>  
>  			dmac1: dma-controller at b0160000 {
> @@ -268,6 +269,7 @@
>  				reg = <0xb0160000 0x10000>;
>  				interrupts = <13>;
>  				clocks = <&clks 25>;
> +				#dma-cells = <1>;
>  			};
>  
>  			vip at b00C0000 {
> diff --git a/arch/arm/boot/dts/prima2.dtsi b/arch/arm/boot/dts/prima2.dtsi
> index b292a5c..19e4e22 100644
> --- a/arch/arm/boot/dts/prima2.dtsi
> +++ b/arch/arm/boot/dts/prima2.dtsi
> @@ -277,6 +277,7 @@
>  				reg = <0xb00b0000 0x10000>;
>  				interrupts = <12>;
>  				clocks = <&clks 24>;
> +				#dma-cells = <1>;
>  			};
>  
>  			dmac1: dma-controller at b0160000 {
> @@ -285,6 +286,7 @@
>  				reg = <0xb0160000 0x10000>;
>  				interrupts = <13>;
>  				clocks = <&clks 25>;
> +				#dma-cells = <1>;
>  			};
>  
>  			vip at b00C0000 {
> diff --git a/drivers/dma/sirf-dma.c b/drivers/dma/sirf-dma.c
> index 6aec3ad..8b74c0d 100644
> --- a/drivers/dma/sirf-dma.c
> +++ b/drivers/dma/sirf-dma.c
> @@ -18,6 +18,7 @@
>  #include <linux/of_device.h>
>  #include <linux/of_platform.h>
>  #include <linux/clk.h>
> +#include <linux/of_dma.h>
>  #include <linux/sirfsoc_dma.h>
>  
>  #include "dmaengine.h"
> @@ -640,6 +641,18 @@ bool sirfsoc_dma_filter_id(struct dma_chan *chan, void *chan_id)
>  }
>  EXPORT_SYMBOL(sirfsoc_dma_filter_id);
>  
> +static struct dma_chan *of_dma_sirfsoc_xlate(struct of_phandle_args *dma_spec,
> +	struct of_dma *ofdma)
> +{
> +	struct sirfsoc_dma *sdma = ofdma->of_dma_data;
> +	unsigned int request = dma_spec->args[0];
> +
> +	if (request > SIRFSOC_DMA_CHANNELS)
> +		return NULL;
> +
> +	return dma_get_slave_channel(&sdma->channels[request].chan);
> +}
> +
>  static int sirfsoc_dma_probe(struct platform_device *op)
>  {
>  	struct device_node *dn = op->dev.of_node;
> @@ -744,11 +757,20 @@ static int sirfsoc_dma_probe(struct platform_device *op)
>  	if (ret)
>  		goto free_irq;
>  
> +	/* Device-tree DMA controller registration */
> +	ret = of_dma_controller_register(dn, of_dma_sirfsoc_xlate, sdma);
> +	if (ret) {
> +		dev_err(dev, "failed to register DMA controller\n");
> +		goto unreg_dma_dev;
> +	}
> +
>  	pm_runtime_enable(&op->dev);
>  	dev_info(dev, "initialized SIRFSOC DMAC driver\n");
>  
>  	return 0;
>  
> +unreg_dma_dev:
> +	dma_async_device_unregister(dma);
>  free_irq:
>  	free_irq(sdma->irq, sdma);
>  irq_dispose:
> @@ -761,6 +783,7 @@ static int sirfsoc_dma_remove(struct platform_device *op)
>  	struct device *dev = &op->dev;
>  	struct sirfsoc_dma *sdma = dev_get_drvdata(dev);
>  
> +	of_dma_controller_free(op->dev.of_node);
>  	dma_async_device_unregister(&sdma->dma);
>  	free_irq(sdma->irq, sdma);
>  	irq_dispose_mapping(sdma->irq);
> -- 
> 1.7.5.4
> 

-- 
