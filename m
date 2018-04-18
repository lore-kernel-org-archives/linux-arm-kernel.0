From: stefan@agner.ch (Stefan Agner)
Date: Wed, 18 Apr 2018 17:43:14 +0200
Subject: [PATCH 1/2] cpufreq: imx6q: check speed grades for i.MX6ULL
In-Reply-To: <20180418145230.10249-1-sebastien.szymanski@armadeus.com>
References: <20180418145230.10249-1-sebastien.szymanski@armadeus.com>
Message-ID: <3b01e6f282514aa10b083a3d0f8400f9@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18.04.2018 16:52, S?bastien Szymanski wrote:
> Check the max speed supported from the fuses for i.MX6ULL and update the
> operating points table accordingly.

Thanks for working on this.

Due to lack of this feature we added operating points directly to the
board level device tree:
arch/arm/boot/dts/imx6ull-colibri-wifi.dtsi

> 
> Signed-off-by: S?bastien Szymanski <sebastien.szymanski@armadeus.com>
> ---
>  drivers/cpufreq/imx6q-cpufreq.c | 29 +++++++++++++++++++++++------
>  1 file changed, 23 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
> index 83cf631fc9bc..f094687cae52 100644
> --- a/drivers/cpufreq/imx6q-cpufreq.c
> +++ b/drivers/cpufreq/imx6q-cpufreq.c
> @@ -266,6 +266,8 @@ static void imx6q_opp_check_speed_grading(struct
> device *dev)
>  }
>  
>  #define OCOTP_CFG3_6UL_SPEED_696MHZ	0x2
> +#define OCOTP_CFG3_6ULL_SPEED_792MHZ	0x2
> +#define OCOTP_CFG3_6ULL_SPEED_900MHZ	0x3
>  
>  static void imx6ul_opp_check_speed_grading(struct device *dev)
>  {
> @@ -287,16 +289,30 @@ static void
> imx6ul_opp_check_speed_grading(struct device *dev)
>  	 * Speed GRADING[1:0] defines the max speed of ARM:
>  	 * 2b'00: Reserved;
>  	 * 2b'01: 528000000Hz;
> -	 * 2b'10: 696000000Hz;
> -	 * 2b'11: Reserved;
> +	 * 2b'10: 696000000Hz on i.MX6UL, 792000000Hz on i.MX6ULL;
> +	 * 2b'11: 900000000Hz on i.MX6ULL only;
>  	 * We need to set the max speed of ARM according to fuse map.
>  	 */
>  	val = readl_relaxed(base + OCOTP_CFG3);
>  	val >>= OCOTP_CFG3_SPEED_SHIFT;
>  	val &= 0x3;
> -	if (val != OCOTP_CFG3_6UL_SPEED_696MHZ)
> -		if (dev_pm_opp_disable(dev, 696000000))
> -			dev_warn(dev, "failed to disable 696MHz OPP\n");
> +
> +	if (of_machine_is_compatible("fsl,imx6ul")) {
> +		if (val != OCOTP_CFG3_6UL_SPEED_696MHZ)
> +			if (dev_pm_opp_disable(dev, 696000000))
> +				dev_warn(dev, "failed to disable 696MHz OPP\n");
> +	}
> +
> +	if (of_machine_is_compatible("fsl,imx6ull")) {
> +		if (val != OCOTP_CFG3_6ULL_SPEED_792MHZ)
> +			if (dev_pm_opp_disable(dev, 792000000))
> +				dev_warn(dev, "failed to disable 792MHz OPP\n");
> +
> +		if (val != OCOTP_CFG3_6ULL_SPEED_900MHZ)
> +			if (dev_pm_opp_disable(dev, 900000000))
> +				dev_warn(dev, "failed to disable 900MHz OPP\n");


We use the 800MHz SKU, so our device tree has no 900MHz setpoint. 

I guess we should remove the operating points in the board level device
tree then to avoid warnings on boot-up...?

--
Stefan

> +	}
> +
>  	iounmap(base);
>  put_node:
>  	of_node_put(np);
> @@ -356,7 +372,8 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
>  		goto put_reg;
>  	}
>  
> -	if (of_machine_is_compatible("fsl,imx6ul"))
> +	if (of_machine_is_compatible("fsl,imx6ul") ||
> +	    of_machine_is_compatible("fsl,imx6ull"))
>  		imx6ul_opp_check_speed_grading(cpu_dev);
>  	else
>  		imx6q_opp_check_speed_grading(cpu_dev);
