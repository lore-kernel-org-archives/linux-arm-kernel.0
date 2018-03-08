From: robh@kernel.org (Rob Herring)
Date: Wed, 7 Mar 2018 19:37:45 -0600
Subject: [PATCH v5 2/3] USB3/DWC3: Add property "snps,
 incr-burst-type-adjustment" for INCR burst type
In-Reply-To: <20180306085911.5930-2-ran.wang_1@nxp.com>
References: <20180306085911.5930-1-ran.wang_1@nxp.com>
 <20180306085911.5930-2-ran.wang_1@nxp.com>
Message-ID: <20180308013745.xaqiwoyaytu56rfq@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 06, 2018 at 04:59:10PM +0800, Ran Wang wrote:
> Property "snps,incr-burst-type-adjustment = <x>, <y>..." for USB3.0 DWC3.
> When only one value means INCRx mode with fix burst type.
> When more than one value, means undefined length burst mode, USB controller
> can use the length less than or equal to the largest enabled burst length.
> 
> While enabling undefined length INCR burst type and INCR16 burst type,
> get better write performance on NXP Layerscape platforms:
> around 3% improvement (from 364MB/s to 375MB/s).
> 
> Signed-off-by: Changming Huang <jerry.huang@nxp.com>
> Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> ---
> Changes in v5:
>   - add support for ls1021a, ls1012a, ls1046a, ls1088a, ls1021a
>   - update ls208xa support according to code base change
> Changes in v4:
>   - change definition for this property.
> Changes in v3:
>   - add new property for INCR burst in usb node.
> 
>  Documentation/devicetree/bindings/usb/dwc3.txt |    6 ++++++
>  arch/arm/boot/dts/ls1021a.dtsi                 |    1 +
>  arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi |    1 +
>  arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi |    3 +++
>  arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi |    3 +++
>  arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi |    2 ++
>  arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi |    2 ++
>  7 files changed, 18 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/dwc3.txt b/Documentation/devicetree/bindings/usb/dwc3.txt
> index 44e8bab..d1779b2 100644
> --- a/Documentation/devicetree/bindings/usb/dwc3.txt
> +++ b/Documentation/devicetree/bindings/usb/dwc3.txt
> @@ -59,6 +59,11 @@ Optional properties:
>  	fladj_30mhz_sdbnd signal is invalid or incorrect.
>  
>   - <DEPRECATED> tx-fifo-resize: determines if the FIFO *has* to be reallocated.
> + - snps,incr-burst-type-adjustment: Value for INCR burst type of GSBUSCFG0
> +	register, undefined length INCR burst type enable and INCRx type.
> +	When just one value, which means INCRX burst mode. When more than one
> +	value, which means undefined length INCR burst type enabled.
> +	The values can be 1, 4, 8, 16, 32, 64, 128 and 256.

I don't understand the multiple values for undefined length burst. Why 
do you need burst length if length is undefined? Looking at the driver, 
it looks like you only care about the largest value.

Rob
