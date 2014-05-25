From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 25 May 2014 21:14:34 +0200
Subject: [PATCH 17/22] mfd: sun6i-prcm: Add support for Allwinner A23 PRCM
In-Reply-To: <1400831485-28576-18-git-send-email-wens@csie.org>
References: <1400831485-28576-1-git-send-email-wens@csie.org>
 <1400831485-28576-18-git-send-email-wens@csie.org>
Message-ID: <20140525191434.GX10768@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 23, 2014 at 03:51:20PM +0800, Chen-Yu Tsai wrote:
> The Allwinner A23 SoC has a PRCM unit like the previous A31 SoC.
> The differences are the AR100 clock can no longer be modified,
> and the APB0 clock has different divisors.
> 
> This patch adds a compatible with a modified subdevice list for
> the A23.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  .../devicetree/bindings/mfd/sun6i-prcm.txt         |  2 +-
>  drivers/mfd/sun6i-prcm.c                           | 30 ++++++++++++++++++++++
>  2 files changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/sun6i-prcm.txt b/Documentation/devicetree/bindings/mfd/sun6i-prcm.txt
> index 1f5a31f..03c5a55 100644
> --- a/Documentation/devicetree/bindings/mfd/sun6i-prcm.txt
> +++ b/Documentation/devicetree/bindings/mfd/sun6i-prcm.txt
> @@ -4,7 +4,7 @@ PRCM is an MFD device exposing several Power Management related devices
>  (like clks and reset controllers).
>  
>  Required properties:
> - - compatible: "allwinner,sun6i-a31-prcm"
> + - compatible: "allwinner,sun6i-a31-prcm" or "allwinner,sun8i-a23-prcm"
>   - reg: The PRCM registers range
>  
>  The prcm node may contain several subdevices definitions:
> diff --git a/drivers/mfd/sun6i-prcm.c b/drivers/mfd/sun6i-prcm.c
> index 718fc4d..c96bb6c 100644
> --- a/drivers/mfd/sun6i-prcm.c
> +++ b/drivers/mfd/sun6i-prcm.c
> @@ -76,16 +76,46 @@ static const struct mfd_cell sun6i_a31_prcm_subdevs[] = {
>  	},
>  };
>  
> +static const struct mfd_cell sun8i_a23_prcm_subdevs[] = {
> +	{
> +		.name = "sun6i-a31-apb0-clk",
> +		.of_compatible = "allwinner,sun8i-a23-apb0-clk",
> +		.num_resources = ARRAY_SIZE(sun6i_a31_apb0_clk_res),
> +		.resources = sun6i_a31_apb0_clk_res,
> +	},
> +	{
> +		.name = "sun6i-a31-apb0-gates-clk",
> +		.of_compatible = "allwinner,sun6i-a31-apb0-gates-clk",
> +		.num_resources = ARRAY_SIZE(sun6i_a31_apb0_gates_clk_res),
> +		.resources = sun6i_a31_apb0_gates_clk_res,
> +	},

Did I just have a brainfart, or didn't you just introduced an
sun8i-a23-apb0-gates-clk driver?

And there's no ar100 and ahb0 clocks ?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140525/4334a119/attachment-0001.sig>
