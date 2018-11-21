From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Wed, 21 Nov 2018 21:39:38 +0900
Subject: [PATCH 4/4] clk: samsung: exynos5433: add imem clock
In-Reply-To: <20181121120509.18892-5-k.konieczny@partner.samsung.com>
References: <20181121120509.18892-1-k.konieczny@partner.samsung.com>
 <CGME20181121120524eucas1p166a26857df78947c9e08f0fb8dbf75e4@eucas1p1.samsung.com>
 <20181121120509.18892-5-k.konieczny@partner.samsung.com>
Message-ID: <5BF5520A.5050500@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 2018? 11? 21? 21:05, Kamil Konieczny wrote:
> Add imem clock for exynos5433.

It is diffcult to understand the meaning of 'imem' without the description.
Please add more detailed description as the patch2 description.

> 
> Signed-off-by: Kamil Konieczny <k.konieczny@partner.samsung.com>
> ---
>  drivers/clk/samsung/clk-exynos5433.c   | 123 +++++++++++++++++++++++++
>  include/dt-bindings/clock/exynos5433.h |  55 +++++++++++
>  2 files changed, 178 insertions(+)
> 
> diff --git a/drivers/clk/samsung/clk-exynos5433.c b/drivers/clk/samsung/clk-exynos5433.c
> index 24c3360db65b..db29cbd1fbdc 100644
> --- a/drivers/clk/samsung/clk-exynos5433.c
> +++ b/drivers/clk/samsung/clk-exynos5433.c
> @@ -2345,6 +2345,129 @@ static const struct samsung_cmu_info fsys_cmu_info __initconst = {
>  	.clk_name		= "aclk_fsys_200",
>  };
>  
> +/*
> + * Register offset definitions for CMU_IMEM
> + *
> + */
> +

Remove unneeded blank line.

> +#define ENABLE_ACLK_IMEM			0x0800
> +#define ENABLE_ACLK_IMEM_SSS			0x0808
> +#define ENABLE_ACLK_IMEM_SLIMSSS		0x080c
> +#define ENABLE_PCLK_IMEM			0x0900
> +#define ENABLE_PCLK_IMEM_SSS			0x0904
> +#define ENABLE_PCLK_IMEM_SLIMSSS		0x0908

When I checked the registers of IMEM block, there are more registers as following:
Why do you implement the clocks for only six registers?

CLK_ENABLE_ACLK_IMEM			0x0800

CLK_ENABLE_ACLK_IMEM_SECURE_INT_MEM	0x0804

CLK_ENABLE_ACLK_IMEM_SECURE_SSS		0x0808

CLK_ENABLE_ACLK_IMEM_SECURE_SLIMSSS	0x080C

CLK_ENABLE_ACLK_IMEM_SECURE_RTIC	0x0810

CLK_ENABLE_ACLK_IMEM_SECURE_SMMU_SSS	0x0814

CLK_ENABLE_ACLK_IMEM_SECURE_SMMU_SLIMSSS 0x0818

CLK_ENABLE_ACLK_IMEM_SECURE_SMMU_RTIC	0x081C

CLK_ENABLE_ACLK_IMEM_SECURE_ARGB_TX	0x0820

CLK_ENABLE_ACLK_IMEM_SECURE_SMMU_ARGB_TX 0x0824



CLK_ENABLE_PCLK_IMEM 0x0900

CLK_ENABLE_PCLK_IMEM_SECURE_SSS 0x0904

CLK_ENABLE_PCLK_IMEM_SECURE_SLIMSSS 0x0908

CLK_ENABLE_PCLK_IMEM_SECURE_RTIC 0x090C

CLK_ENABLE_PCLK_IMEM_SECURE_SMMU_SSS 0x0910

CLK_ENABLE_PCLK_IMEM_SECURE_SMMU_SLIMSSS 0x0914

CLK_ENABLE_PCLK_IMEM_SECURE_SMMU_RTIC 0x0918

CLK_ENABLE_PCLK_IMEM_SECURE_SMMU_ARGB_TX 0x091C

CLK_ENABLE_IP_IMEM0 0x0B00

CLK_ENABLE_IP_IMEM1 0x0B04

CLK_ENABLE_IP_IMEM_SECURE_INT_MEM 0x0B08

CLK_ENABLE_IP_IMEM_SECURE_SSS 0x0B0C

CLK_ENABLE_IP_IMEM_SECURE_SLIMSSS 0x0B10

CLK_ENABLE_IP_IMEM_SECURE_RTIC 0x0B14

CLK_ENABLE_IP_IMEM_SECURE_SMMU_SSS 0x0B18

CLK_ENABLE_IP_IMEM_SECURE_SMMU_SLIMSSS 0x0B1C

CLK_ENABLE_IP_IMEM_SECURE_SMMU_RTIC 0x0B20

CLK_ENABLE_IP_IMEM_SECURE_ARBG_TX 0x0B24

CLK_ENABLE_IP_IMEM_SECURE_SMMU_ARBG_TX 0x0B28

> +
> +static const unsigned long imem_clk_regs[] __initconst = {
> +ENABLE_ACLK_IMEM,
> +ENABLE_ACLK_IMEM_SSS,
> +ENABLE_ACLK_IMEM_SLIMSSS,
> +ENABLE_PCLK_IMEM,
> +ENABLE_PCLK_IMEM_SSS,
> +ENABLE_PCLK_IMEM_SLIMSSS,

Add a tab in front of registers.

> +};
> +
> +static const struct samsung_gate_clock imem_gate_clks[] __initconst = {
> +	/* ENABLE_ACLK_IMEM */
> +	GATE(CLK_ACLK_AXI2AHB_IMEMH, "aclk_axi2ahb_imemh", "aclk_imem_200",
> +			ENABLE_ACLK_IMEM, 24, 0, 0),
> +	GATE(CLK_ACLK_AXIDS_SROMC, "aclk_axids_sromc", "aclk_imem_200",
> +			ENABLE_ACLK_IMEM, 23, CLK_IGNORE_UNUSED, 0),
> +	GATE(CLK_ACLK_SROMC, "aclk_sromc", "aclk_imem_200",
> +			ENABLE_ACLK_IMEM, 22, CLK_IGNORE_UNUSED, 0),
> +	GATE(CLK_ACLK_BTS_ARBG_TX, "aclk_bts_arbg_tx", "aclk_imem_266",
> +			ENABLE_ACLK_IMEM, 21, CLK_IGNORE_UNUSED, 0),
> +	GATE(CLK_ACLK_ASYNCAXI_IMEMX, "aclk_asyncaxi_imemx", "aclk_imem_266",
> +			ENABLE_ACLK_IMEM, 20, CLK_IGNORE_UNUSED, 0),
> +	GATE(CLK_ACLK_AXIUS_IMEMX, "aclk_axius_imemx", "aclk_imem_266",
> +			ENABLE_ACLK_IMEM, 19, CLK_IGNORE_UNUSED, 0),
> +	GATE(CLK_ACLK_XIU_IMEMX, "aclk_xiu_imemx", "aclk_imem_266",
> +			ENABLE_ACLK_IMEM, 18, CLK_IGNORE_UNUSED, 0),
> +	GATE(CLK_ACLK_ASYNCAXI_SSSX, "aclk_asyncaxi_sssx", "aclk_imem_sssx_266",
> +			ENABLE_ACLK_IMEM, 17, CLK_IGNORE_UNUSED, 0),
> +	GATE(CLK_ACLK_BTS_SLIMSSS, "aclk_bts_slimsss", "aclk_imem_sssx_266",
> +			ENABLE_ACLK_IMEM, 15, CLK_IGNORE_UNUSED, 0),
> +	GATE(CLK_ACLK_BTS_SSS_DRAM, "aclk_bts_sss_dram", "aclk_imem_sssx_266",
> +			ENABLE_ACLK_IMEM, 14, CLK_IGNORE_UNUSED, 0),
> +	GATE(CLK_ACLK_BTS_SSS_CCI, "aclk_bts_sss_cci", "aclk_imem_sssx_266",
> +			ENABLE_ACLK_IMEM, 13, CLK_IGNORE_UNUSED, 0),
> +	GATE(CLK_ACLK_ALB_IMEM, "aclk_alb_imem", "aclk_imem_266",
> +			ENABLE_ACLK_IMEM, 12, CLK_IGNORE_UNUSED, 0),
> +	GATE(CLK_ACLK_AXIDS_PIMEMX_IMEM1P, "aclk_axids_pimemx_imem1p", "aclk_imem_200",
> +			ENABLE_ACLK_IMEM, 11, CLK_IGNORE_UNUSED, 0),
> +	GATE(CLK_ACLK_AXIDS_PIMEMX_IMEM0P, "aclk_axids_pimemx_imem0p", "aclk_imem_200",
> +			ENABLE_ACLK_IMEM, 10, CLK_IGNORE_UNUSED, 0),
> +	GATE(CLK_ACLK_AXIDS_PIMEMX_GIC, "aclk_axids_pimemx_gic", "aclk_imem_200",
> +			ENABLE_ACLK_IMEM, 9, CLK_IGNORE_UNUSED, 0),
> +	GATE(CLK_ACLK_ASYNCAHBM_SSS_ATLAS, "aclk_asyncahbm_sss_atlas", "aclk_imem_sssx_266",
> +			ENABLE_ACLK_IMEM, 7, CLK_IGNORE_UNUSED, 0),
> +	GATE(CLK_ACLK_ASYNCAXIS_MIF_PIMEMX, "aclk_asyncaxis_mif_pimemx", "aclk_imem_200",
> +			ENABLE_ACLK_IMEM, 6, CLK_IGNORE_UNUSED, 0),
> +	GATE(CLK_ACLK_AXI2APB_IMEM1P, "aclk_axi2apb_imem1p", "aclk_imem_200",
> +			ENABLE_ACLK_IMEM, 5, CLK_IGNORE_UNUSED, 0),
> +	GATE(CLK_ACLK_AXI2APB_IMEM0P, "aclk_axi2apb_imem0p", "aclk_imem_200",
> +			ENABLE_ACLK_IMEM, 4, CLK_IGNORE_UNUSED, 0),
> +	GATE(CLK_ACLK_XIU_SSSX, "aclk_xiu_sssx", "aclk_imem_sssx_266",
> +			ENABLE_ACLK_IMEM, 3, CLK_IGNORE_UNUSED, 0),
> +	GATE(CLK_ACLK_XIU_PIMEMX, "aclk_xiu_pimemx", "aclk_imem_200",
> +			ENABLE_ACLK_IMEM, 2, CLK_IGNORE_UNUSED, 0),
> +	GATE(CLK_ACLK_IMEMND_266, "aclk_imemnd_266", "aclk_imem_266",
> +			ENABLE_ACLK_IMEM, 1, CLK_IGNORE_UNUSED, 0),
> +	GATE(CLK_ACLK_GIC, "aclk_gic", "aclk_imem_200",
> +			ENABLE_ACLK_IMEM, 0, CLK_IGNORE_UNUSED, 0),
> +
> +	/* ENABLE_ACLK_IMEM_SSS */
> +	GATE(CLK_ACLK_SSS, "aclk_sss", "aclk_imem_sssx_266",
> +			ENABLE_ACLK_IMEM_SSS, 0, CLK_IGNORE_UNUSED, 0),
> +	/* ENABLE_ACLK_IMEM_SLIMSSS */
> +	GATE(CLK_ACLK_SLIMSSS, "aclk_slimsss", "aclk_imem_sssx_266",
> +			ENABLE_ACLK_IMEM_SLIMSSS, 0, CLK_IGNORE_UNUSED, 0),
> +
> +	/* ENABLE_PCLK_IMEM */
> +	GATE(CLK_PCLK_GPIO_IMEM, "pclk_gpio_imem", "aclk_imem_200",
> +			ENABLE_PCLK_IMEM, 17, CLK_IGNORE_UNUSED, 0),
> +	GATE(CLK_PCLK_ASYNCAXI_IMEMX, "pclk_asyncaxi_imemx", "aclk_imem_200",
> +			ENABLE_PCLK_IMEM, 16, CLK_IGNORE_UNUSED, 0),
> +	GATE(CLK_PCLK_BTS_ARBG_TX, "pclk_bts_arbg_tx", "aclk_imem_200",
> +			ENABLE_PCLK_IMEM, 15, CLK_IGNORE_UNUSED, 0),
> +	GATE(CLK_PCLK_ASYNCAPB_ARBG_TX, "pclk_asyncapb_arbg_tx", "aclk_imem_200",
> +			ENABLE_PCLK_IMEM, 14, CLK_IGNORE_UNUSED, 0),
> +
> +	GATE(CLK_PCLK_BTS_SLIMSSS, "pclk_bts_slimsss", "aclk_imem_200",
> +			ENABLE_PCLK_IMEM, 8, CLK_IGNORE_UNUSED, 0),
> +	GATE(CLK_PCLK_BTS_SSS_DRAM, "pclk_bts_sss_dram", "aclk_imem_200",
> +			ENABLE_PCLK_IMEM, 7, CLK_IGNORE_UNUSED, 0),
> +	GATE(CLK_PCLK_BTS_SSS_CCI, "pclk_bts_sss_cci", "aclk_imem_200",
> +			ENABLE_PCLK_IMEM, 6, CLK_IGNORE_UNUSED, 0),
> +	GATE(CLK_PCLK_ALB_IMEM, "pclk_alb_imem", "aclk_imem_200",
> +			ENABLE_PCLK_IMEM, 5, CLK_IGNORE_UNUSED, 0),
> +	GATE(CLK_PCLK_PMU_IMEM, "pclk_pmu_imem", "aclk_imem_200",
> +			ENABLE_PCLK_IMEM, 4, CLK_IGNORE_UNUSED, 0),
> +	GATE(CLK_PCLK_SYSREG_IMEM, "pclk_sysreg_imem", "aclk_imem_200",
> +			ENABLE_PCLK_IMEM, 3, CLK_IGNORE_UNUSED, 0),
> +	/* ENABLE_PCLK_IMEM_SSS */
> +	GATE(CLK_PCLK_SSS, "pclk_sss", "aclk_imem_200",
> +			ENABLE_PCLK_IMEM, 0, CLK_IGNORE_UNUSED, 0),
> +	/* ENABLE_PCLK_IMEM_SLIMSSS */
> +	GATE(CLK_PCLK_SLIMSSS, "pclk_slimsss", "aclk_imem_200",
> +			ENABLE_PCLK_IMEM, 0, CLK_IGNORE_UNUSED, 0),
> +};
> +
> +static const struct samsung_cmu_info imem_cmu_info __initconst = {
> +	.gate_clks		= imem_gate_clks,
> +	.nr_gate_clks		= ARRAY_SIZE(imem_gate_clks),
> +	.nr_clk_ids		= IMEM_NR_CLK,
> +	.clk_regs		= imem_clk_regs,
> +	.nr_clk_regs		= ARRAY_SIZE(imem_clk_regs),
> +};
> +
> +static void __init exynos5433_cmu_imem_init(struct device_node *np)
> +{
> +	samsung_cmu_register_one(np, &imem_cmu_info);
> +}
> +
> +CLK_OF_DECLARE(exynos5433_cmu_imem, "samsung,exynos5433-cmu-imem",
> +		exynos5433_cmu_imem_init);

Except for "samsmung,exynos5433-cmu-atlas/apollo", the remained clock blocks
were added to exynos5433_cmu_of_match[] table for power management.

If there is no any h/w issue, add the new entry to exynos5433_cmu_of_match for imem block.

> +
>  /*
>   * Register offset definitions for CMU_G2D
>   */
> diff --git a/include/dt-bindings/clock/exynos5433.h b/include/dt-bindings/clock/exynos5433.h
> index 87bb2b017143..312d8810b56d 100644
> --- a/include/dt-bindings/clock/exynos5433.h
> +++ b/include/dt-bindings/clock/exynos5433.h
> @@ -623,6 +623,61 @@
>  
>  #define FSYS_NR_CLK			116
>  
> +/* CMU_IMEM */
> +#define CLK_ACLK_SSS			1
> +#define CLK_ACLK_SLIMSSS		2
> +#define CLK_ACLK_RTIC			3
> +#define CLK_ACLK_XIU_SSSX		4
> +#define CLK_ACLK_ASYNCAHBM_SSS_ATLAS	5
> +#define CLK_ACLK_ASYNCAXI_SSSX		6
> +#define CLK_ACLK_BTS_SSS_CCI		7
> +#define CLK_ACLK_BTS_SSS_DRAM		8
> +#define CLK_ACLK_BTS_SLIMSSS		9
> +#define CLK_ACLK_SMMU_SSS_CCI		10
> +#define CLK_ACLK_SMMU_SSS_DRAM		11
> +#define CLK_ACLK_SMMU_SLIMSSS		12
> +#define CLK_ACLK_SMMU_RTIC		13
> +#define CLK_ACLK_IMEMND_266		14
> +#define CLK_ACLK_ALB_IMEM		15
> +#define CLK_ACLK_XIU_IMEMX		16
> +#define CLK_ACLK_AXIUS_IMEMX		17
> +#define CLK_ACLK_ASYNCAXI_IMEMX		18
> +#define CLK_ACLK_ARBG_TX		19
> +#define CLK_ACLK_BTS_ARBG_TX		20
> +#define CLK_ACLK_SMMU_ARBG_TX		21
> +#define CLK_ACLK_GIC			22
> +#define CLK_ACLK_INT_MEM		23
> +#define CLK_ACLK_XIU_PIMEMX		24
> +#define CLK_ACLK_AXI2APB_IMEM0P		25
> +#define CLK_ACLK_AXI2APB_IMEM1P		26
> +#define CLK_ACLK_ASYNCAXIS_MIF_PIMEMX	27
> +#define CLK_ACLK_AXIDS_PIMEMX_GIC	28
> +#define CLK_ACLK_AXIDS_PIMEMX_IMEM0P	29
> +#define CLK_ACLK_AXIDS_PIMEMX_IMEM1P	30
> +#define CLK_ACLK_SROMC			31
> +#define CLK_ACLK_AXIDS_SROMC		32
> +#define CLK_ACLK_AXI2AHB_IMEMH		33
> +#define CLK_PCLK_SSS			34
> +#define CLK_PCLK_SLIMSSS		35
> +#define CLK_PCLK_RTIC			36
> +#define CLK_PCLK_SYSREG_IMEM		37
> +#define CLK_PCLK_PMU_IMEM		38
> +#define CLK_PCLK_ALB_IMEM		39
> +#define CLK_PCLK_BTS_SSS_CCI		40
> +#define CLK_PCLK_BTS_SSS_DRAM		41
> +#define CLK_PCLK_BTS_SLIMSSS		42
> +#define CLK_PCLK_SMMU_SSS_CCI		43
> +#define CLK_PCLK_SMMU_SSS_DRAM		44
> +#define CLK_PCLK_SMMU_SLIMSSS		45
> +#define CLK_PCLK_SMMU_RTIC		46
> +#define CLK_PCLK_ASYNCAPB_ARBG_TX	47
> +#define CLK_PCLK_BTS_ARBG_TX		48
> +#define CLK_PCLK_SMMU_ARBG_TX		49
> +#define CLK_PCLK_ASYNCAXI_IMEMX		50
> +#define CLK_PCLK_GPIO_IMEM		51
> +
> +#define IMEM_NR_CLK			52
> +
>  /* CMU_G2D */
>  #define CLK_MUX_ACLK_G2D_266_USER	1
>  #define CLK_MUX_ACLK_G2D_400_USER	2
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
