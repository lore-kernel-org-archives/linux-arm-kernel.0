From: oss@buserror.net (Scott Wood)
Date: Tue, 28 Aug 2018 19:18:50 -0500
Subject: [PATCH 3/5] drivers: clk-qoriq: Add clockgen support for lx2160a
In-Reply-To: <1534747636-20064-4-git-send-email-vabhav.sharma@nxp.com>
References: <1534747636-20064-1-git-send-email-vabhav.sharma@nxp.com>
 <1534747636-20064-4-git-send-email-vabhav.sharma@nxp.com>
Message-ID: <4a9ea6b451683ec98c92e86a5ae6b91213a6afcf.camel@buserror.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2018-08-20 at 12:17 +0530, Vabhav Sharma wrote:
> From: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> 
> Add clockgen support for lx2160a.
> Added entry for compat 'fsl,lx2160a-clockgen'.
> As LX2160A is 16 core, so modified value for NUM_CMUX
> 
> Signed-off-by: Tang Yuantian <andy.tang@nxp.com>
> Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
> ---
>  drivers/clk/clk-qoriq.c         | 14 +++++++++++++-
>  drivers/cpufreq/qoriq-cpufreq.c |  1 +
>  2 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/clk-qoriq.c b/drivers/clk/clk-qoriq.c
> index 3a1812f..fc6e308 100644
> --- a/drivers/clk/clk-qoriq.c
> +++ b/drivers/clk/clk-qoriq.c
> @@ -60,7 +60,7 @@ struct clockgen_muxinfo {
>  };
>  
>  #define NUM_HWACCEL	5
> -#define NUM_CMUX	8
> +#define NUM_CMUX	16
>  
>  struct clockgen;
>  
> @@ -570,6 +570,17 @@ static const struct clockgen_chipinfo chipinfo[] = {
>  		.flags = CG_VER3 | CG_LITTLE_ENDIAN,
>  	},
>  	{
> +		.compat = "fsl,lx2160a-clockgen",
> +		.cmux_groups = {
> +			&clockgen2_cmux_cga12, &clockgen2_cmux_cgb
> +		},
> +		.cmux_to_group = {
> +			0, 0, 0, 0, 1, 1, 1, 1, -1
> +		},
> +		.pll_mask = 0x37,
> +		.flags = CG_VER3 | CG_LITTLE_ENDIAN,
> +	},

Why are you increasing NUM_CMUX beyond 8 for a chip that only has 8 entries in
cmux_to_group?

-Scott
