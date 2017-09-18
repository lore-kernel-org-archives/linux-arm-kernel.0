From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 18 Sep 2017 09:33:36 +0200
Subject: [PATCH v4 1/6] dt-bindings: update the Allwinner GPADC device
 tree binding for H3
In-Reply-To: <20170914145251.21784-2-icenowy@aosc.io>
References: <20170914145251.21784-1-icenowy@aosc.io>
 <20170914145251.21784-2-icenowy@aosc.io>
Message-ID: <20170918073336.j7finend3g76chsu@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 14, 2017 at 10:52:46PM +0800, Icenowy Zheng wrote:
> Allwinner H3 features a thermal sensor like the one in A33, but has its
> register re-arranged, the clock divider moved to CCU (originally the
> clock divider is in ADC) and added a pair of bus clock and reset.
> 
> Update the binding document to cover H3.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> ---
> Changes in v4:
> - Add nvmem calibration data (not yet used by the driver)
> Changes in v3:
> - Clock name changes.
> - Example node name changes.
> - Add interupts (not yet used by the driver).
> 
>  .../devicetree/bindings/mfd/sun4i-gpadc.txt        | 30 ++++++++++++++++++++--
>  1 file changed, 28 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt b/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt
> index badff3611a98..6c470d584bf9 100644
> --- a/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt
> +++ b/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt
> @@ -4,12 +4,26 @@ The Allwinner SoCs all have an ADC that can also act as a thermal sensor
>  and sometimes as a touchscreen controller.
>  
>  Required properties:
> -  - compatible: "allwinner,sun8i-a33-ths",
> +  - compatible: must contain one of the following compatibles:
> +		- "allwinner,sun8i-a33-ths"
> +		- "allwinner,sun8i-h3-ths"
>    - reg: mmio address range of the chip,
>    - #thermal-sensor-cells: shall be 0,
>    - #io-channel-cells: shall be 0,
>  
> -Example:
> +Optional properties:
> +  - nvmem-cells: A phandle to the calibration data provided by a nvmem device.
> +                 If unspecified default values shall be used.
> +  - nvmem-cell-names: Should be "calibration-data"

I'd prefer to have which sensor it applies to here. It wouldn't change
anything for the H3, but it definitely does for example for the A83t
that has two sensors, one for each cluster, and one for the GPU, each
with calibration data.

What about cluster0-calibration?

> +
> +Required properties for the following compatibles:
> +		- "allwinner,sun8i-h3-ths"
> +  - clocks: the bus clock and the input clock of the ADC,
> +  - clock-names: should be "bus" and "mod",
> +  - resets: the bus reset of the ADC,
> +  - interrupts: the sampling interrupt of the ADC,

For resets and interrupts, you should list all of them. If there's
only one, then there's no point telling which one it is.


Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170918/6f3914d7/attachment.sig>
