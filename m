From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sun, 09 Feb 2014 02:54:40 +0100
Subject: [PATCH 02/12] dt-bindings: document s3c24xx controller for
 external clock output
In-Reply-To: <201312131359.00450.heiko@sntech.de>
References: <201312131356.40755.heiko@sntech.de>
 <201312131359.00450.heiko@sntech.de>
Message-ID: <52F6DFE0.7030508@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

On 13.12.2013 13:59, Heiko St?bner wrote:
> The clock settings are distributed over a regular register and parts
> of the misccr register.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>   .../bindings/clock/samsung,s3c2410-dclk.txt        |   53 ++++++++++++++++++++
>   1 file changed, 53 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/clock/samsung,s3c2410-dclk.txt
>
> diff --git a/Documentation/devicetree/bindings/clock/samsung,s3c2410-dclk.txt b/Documentation/devicetree/bindings/clock/samsung,s3c2410-dclk.txt
> new file mode 100644
> index 0000000..0a1f7b1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/samsung,s3c2410-dclk.txt
> @@ -0,0 +1,53 @@
> +* Samsung S3C24XX External Clock Output Controller
> +
> +The S3C24XX series can generate clock signals on two clock output pads.
> +The clock binding described here is applicable to all SoCs in
> +the s3c24x family.
> +
> +Required Properties:
> +
> +- compatible: should be one of the following.
> +  - "samsung,s3c2410-dclk" - controller in S3C2410 SoCs.
> +  - "samsung,s3c2412-dclk" - controller in S3C2412 SoCs.
> +  - "samsung,s3c2440-dclk" - controller in S3C2440 and S3C2442 SoCs.
> +  - "samsung,s3c2443-dclk" - controller in S3C2443 and later SoCs.
> +- reg: physical base address of the controller and length of memory mapped
> +  region.
> +- #clock-cells: should be 1.
> +- samsung,misccr: phandle to the syscon managing the misccr register, which
> +  holds configuration settings for different soc-components (clocks, usb, ...).

Hmm, looking at the datasheet, DCLK and CLKOUT registers seem to be part 
of the pin controller. I wonder if there is really a need for different 
driver and device node to handle them.

Could this be simply made a part of the s3c24xx pinctrl driver, 
extending it to register also a clock provider under the same DT node?

Best regards,
Tomasz
