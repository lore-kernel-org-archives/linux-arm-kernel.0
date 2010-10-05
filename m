From: peter.ujfalusi@nokia.com (Peter Ujfalusi)
Date: Tue, 5 Oct 2010 11:35:36 +0300
Subject: [PATCH 07/10] OMAP: McBSP: implement functional clock switching
	via clock framework
In-Reply-To: <20101001213531.1408.87922.stgit@twilight.localdomain>
References: <20101001213119.1408.65395.stgit@twilight.localdomain>
	<20101001213531.1408.87922.stgit@twilight.localdomain>
Message-ID: <201010051135.36436.peter.ujfalusi@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I have only one question...

On Saturday 02 October 2010 00:35:32 ext Paul Walmsley wrote:
...

> +/* McBSP CLKS source switching function */
> +
> +int omap2_mcbsp_set_clks_src(u8 id, u8 fck_src_id)
> +{
> +	struct omap_mcbsp *mcbsp;
> +	struct clk *fck_src;
> +	char *fck_src_name;
> +	int r;
> +
> +	if (!omap_mcbsp_check_valid_id(id)) {
> +		pr_err("%s: Invalid id (%d)\n", __func__, id + 1);
> +		return -EINVAL;
> +	}
> +	mcbsp = id_to_mcbsp_ptr(id);
> +
> +	if (fck_src_id == MCBSP_CLKS_PAD_SRC)
> +		fck_src_name = "pad_fck";
> +	else if (fck_src_id == MCBSP_CLKS_PRCM_SRC)
> +		fck_src_name = "prcm_fck";
> +	else
> +		return -EINVAL;
> +
> +	fck_src = clk_get(mcbsp->dev, fck_src_name);
> +	if (IS_ERR_OR_NULL(fck_src)) {
> +		pr_err("omap-mcbsp: %s: could not clk_get() %s\n", "clks",
> +		       fck_src_name);
> +		return -EINVAL;
> +	}
> +
> +	clk_disable(mcbsp->fclk);
> +
> +	r = clk_set_parent(mcbsp->fclk, fck_src);
> +	if (IS_ERR_VALUE(r)) {
> +		pr_err("omap-mcbsp: %s: could not clk_set_parent() to %s\n",
> +		       "clks", fck_src_name);
> +		clk_put(fck_src);
> +		return -EINVAL;
> +	}
> +
> +	clk_enable(mcbsp->fclk);
> +
> +	clk_put(fck_src);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(omap2_mcbsp_set_clks_src);

...

>  static int omap_mcbsp_dai_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
>  					 int clk_id, unsigned int freq,
>  					 int dir)
>  {
>  	struct omap_mcbsp_data *mcbsp_data = to_mcbsp(cpu_dai->private_data);
>  	struct omap_mcbsp_reg_cfg *regs = &mcbsp_data->regs;
> -	struct omap_mcbsp_platform_data *pdata = cpu_dai->dev->platform_data;
>  	int err = 0;
> 
>  	/* The McBSP signal muxing functions are only available on McBSP1 */
> @@ -685,8 +630,20 @@ static int omap_mcbsp_dai_set_dai_sysclk(struct
> snd_soc_dai *cpu_dai, regs->srgr2	|= CLKSM;
>  		break;
>  	case OMAP_MCBSP_SYSCLK_CLKS_FCLK:
> +		if (cpu_class_is_omap1()) {
> +			err = -EINVAL;
> +			break;
> +		}
> +		err = omap2_mcbsp_set_clks_src(mcbsp_data->bus_id,
> +					       MCBSP_CLKS_PRCM_SRC);
> +		break;
>  	case OMAP_MCBSP_SYSCLK_CLKS_EXT:
> -		err = omap_mcbsp_dai_set_clks_src(mcbsp_data, clk_id);
> +		if (cpu_class_is_omap1()) {
> +			err = 0;
> +			break;
> +		}
> +		err = omap2_mcbsp_set_clks_src(mcbsp_data->bus_id,
> +					       MCBSP_CLKS_PAD_SRC);
>  		break;
> 
>  	case OMAP_MCBSP_SYSCLK_CLKX_EXT:

What is the fclk source by default.
What I mean is that most of the machine drivers are not calling the 
snd_soc_dai_set_sysclk for the cpu_dai.
It has been by default to prcm_fclk (core_96 or per_96).
Is this still the case after this series?
Do we need to go through the ASoC machine drivers, and need to select explicitly 
the prcm_fclk from now on?

-- 
P?ter
