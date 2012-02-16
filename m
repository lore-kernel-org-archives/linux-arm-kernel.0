From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 16 Feb 2012 14:40:13 +0900
Subject: [PATCH v2 03/11] ARM: EXYNOS: add clock part for EXYNOS5250 SoC
In-Reply-To: <1328981685-8602-4-git-send-email-kgene.kim@samsung.com>
References: <1328981685-8602-1-git-send-email-kgene.kim@samsung.com>
 <1328981685-8602-4-git-send-email-kgene.kim@samsung.com>
Message-ID: <055301ccec6d$747a8a40$5d6f9ec0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kukjin Kim wrote:
> 
> This patch adds clock-exynos5.c for EXYNOS5250 now
> and that can be used for other EXYNOS5 SoCs later.

[...]

> +static int exynos5_clk_ip_acp_ctrl(struct clk *clk, int enable)
> +{
> +	return s5p_gatectrl(EXYNOS5_CLKGATE_IP_ACP, clk, enable);
> +}

This is not used yet. So I removed this function.

[...]

> +static struct clksrc_clk exynos5_clk_sclk_hdmi = {
> +	.clk	= {
> +		.name           = "sclk_hdmi",
                     ^^^^^^^^^^^
I fixed to use tab at above mark ^

[...]

> +static struct clk exynos5_clk_pdma0 = {
> +	.name		= "dma",
> +	.devname	= "dma-pl330.0",
> +	.enable		= exynos5_clk_ip_gen_ctrl,
> +	.ctrlbit	= (1 << 4),

I fixed like following.

	.enable		= exynos5_clk_ip_fsys_ctrl,
	.ctrlbit	= (1 << 1),

[...]

> +static struct clk exynos5_clk_pdma2 = {
> +	.name		= "dma",
> +	.devname	= "dma-pl330.2",
> +	.enable		= exynos5_clk_ip_fsys_ctrl,
> +	.ctrlbit	= (1 << 1),

static struct clk exynos5_clk_mdma1 = {
	.name		= "dma",
	.devname	= "dma-pl330.2",
	.enable		= exynos5_clk_ip_gen_ctrl,
	.ctrlbit	= (1 << 4),

[...]

> +static struct clksrc_clk exynos5_clk_sclk_mmc1 = {
> +	.clk	= {
> +		.name		= "sclk_mmc",
> +		.devname	= "s3c-sdhci.1",
> +		.parent         = &exynos5_clk_dout_mmc1.clk,
                       ^^^^^^^^^
same as above

[...]

> +static struct clksrc_clk exynos5_clk_sclk_mmc2 = {
> +	.clk	= {
> +		.name		= "sclk_mmc",
> +		.devname	= "s3c-sdhci.2",
> +		.parent         = &exynos5_clk_dout_mmc2.clk,
                       ^^^^^^^^^

[...]

> +static struct clksrc_clk exynos5_clk_sclk_mmc3 = {
> +	.reg_div = { .reg = EXYNOS5_CLKDIV_FSYS2, .shift = 8, .size = 8 },

Ooops, this should be moved in above 'exynos5_clk_sclk_mmc2' :(

> +	.clk	= {
> +		.name		= "sclk_mmc",
> +		.devname	= "s3c-sdhci.3",
> +		.parent         = &exynos5_clk_dout_mmc3.clk,
                       ^^^^^^^^^

[...]

> +static struct clksrc_clk exynos5_clksrcs[] = {
> +	{
> +		.clk	= {
> +			.name		= "sclk_dwmci",
> +			.parent         = &exynos5_clk_dout_mmc4.clk,
                               ^^^^^^^^^

[...]

> +static struct clk *exynos5_clk_cdev[] = {
> +	&exynos5_clk_pdma0,
> +	&exynos5_clk_pdma1,
> +	&exynos5_clk_pdma2,

according to above changes,

	&exynos5_clk_mdma1,

[...]

> +	CLKDEV_INIT("dma-pl330.0", "apb_pclk", &exynos5_clk_pdma0),
> +	CLKDEV_INIT("dma-pl330.1", "apb_pclk", &exynos5_clk_pdma1),
> +	CLKDEV_INIT("dma-pl330.2", "apb_pclk", &exynos5_clk_pdma2),

	CLKDEV_INIT("dma-pl330.2", "apb_pclk", &exynos5_clk_mdma1),

[...]

> +struct syscore_ops exynos5_clock_syscore_ops = {
> +	.suspend        = exynos5_clock_suspend,
                ^^^^^^^^
> +	.resume         = exynos5_clock_resume,
               ^^^^^^^^^
Tab

[...]

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
