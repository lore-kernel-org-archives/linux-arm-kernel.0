From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Tue, 09 Dec 2014 11:33:19 +0530
Subject: [PATCH 10/19] clk: samsung: exynos5433: Add missing clocks for
 CMU_FSYS domain
In-Reply-To: <1417510196-6714-11-git-send-email-cw00.choi@samsung.com>
References: <1417510196-6714-1-git-send-email-cw00.choi@samsung.com>
 <1417510196-6714-11-git-send-email-cw00.choi@samsung.com>
Message-ID: <548690A7.4000409@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chanwoo,

On Tuesday 02 December 2014 02:19 PM, Chanwoo Choi wrote:
> This patch adds the mux/divider/gate clocks for CMU_FSYS domain which
> contains the clocks of USB/UFS/SDMMC/TSI/PDMA IPs.
>
> Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Acked-by: Inki Dae <inki.dae@samsung.com>
> Acked-by: Geunsik Lim <geunsik.lim@samsung.com>
> ---
>   drivers/clk/samsung/clk-exynos5433.c   | 286 +++++++++++++++++++++++++++++++++
>   include/dt-bindings/clock/exynos5433.h |  82 +++++++++-
>   2 files changed, 365 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/clk/samsung/clk-exynos5433.c b/drivers/clk/samsung/clk-exynos5433.c
> index 5b4ec83..e2b7ea6 100644
> --- a/drivers/clk/samsung/clk-exynos5433.c
> +++ b/drivers/clk/samsung/clk-exynos5433.c
> @@ -464,6 +464,16 @@ static struct samsung_div_clock top_div_clks[] __initdata = {
>   	DIV(CLK_DIV_SCLK_MMC2_A, "div_sclk_mmc2_a", "mout_sclk_mmc2_b",
>   			DIV_TOP_FSYS1, 0, 4),
>
> +	/* DIV_TOP_FSYS2 */
> +	DIV(CLK_DIV_SCLK_PCIE_100, "div_sclk_pcie_100", "mout_sclk_pcie_100",
> +			DIV_TOP_FSYS2, 12, 3),
> +	DIV(CLK_DIV_SCLK_USBHOST30, "div_sclk_usbhost30",
> +			"mout_sclk_usbhost30", DIV_TOP_FSYS2, 8, 4),
> +	DIV(CLK_DIV_SCLK_UFSUNIPRO, "div_sclk_ufsunipro",
> +			"mout_sclk_ufsunipro", DIV_TOP_FSYS2, 4, 4),
> +	DIV(CLK_DIV_SCLK_USBDRD30, "div_sclk_usbdrd30", "mout_sclk_usbdrd30",
> +			DIV_TOP_FSYS2, 0, 4),
> +
>   	/* DIV_TOP_PERIC0 */
>   	DIV(CLK_DIV_SCLK_SPI1_B, "div_sclk_spi1_b", "div_sclk_spi1_a",
>   			DIV_TOP_PERIC0, 16, 8),
> @@ -536,12 +546,20 @@ static struct samsung_gate_clock top_gate_clks[] __initdata = {
>   			ENABLE_ACLK_TOP, 0, CLK_IGNORE_UNUSED, 0),
>
>   	/* ENABLE_SCLK_TOP_FSYS */
> +	GATE(CLK_SCLK_PCIE_100_FSYS, "sclk_pcie_100_fsys", "div_sclk_pcie_100",
> +			ENABLE_SCLK_TOP_FSYS, 7, 0, 0),
>   	GATE(CLK_SCLK_MMC2_FSYS, "sclk_mmc2_fsys", "div_sclk_mmc2_b",
>   			ENABLE_SCLK_TOP_FSYS, 6, 0, 0),
>   	GATE(CLK_SCLK_MMC1_FSYS, "sclk_mmc1_fsys", "div_sclk_mmc1_b",
>   			ENABLE_SCLK_TOP_FSYS, 5, 0, 0),
>   	GATE(CLK_SCLK_MMC0_FSYS, "sclk_mmc0_fsys", "div_sclk_mmc0_b",
>   			ENABLE_SCLK_TOP_FSYS, 4, 0, 0),
> +	GATE(CLK_SCLK_UFSUNIPRO_FSYS, "sclk_ufsunipro_fsys",
> +			"div_sclk_ufsunipro", ENABLE_SCLK_TOP_FSYS, 7, 0, 0),

bit_index for sclk_ufsunipro_fsys is '3'.

> +	GATE(CLK_SCLK_USBHOST30_FSYS, "sclk_usbhost30_fsys",
> +			"div_sclk_usbhost30", ENABLE_SCLK_TOP_FSYS, 7, 0, 0),

bit_index for sclk_usbhost30_fsys is '1'.

> +	GATE(CLK_SCLK_USBDRD30_FSYS, "sclk_usbdrd30_fsys",
> +			"div_sclk_usbdrd30", ENABLE_SCLK_TOP_FSYS, 7, 0, 0),

bit_index for sclk_usbdrd30_fsys is '0'.

>
>   	/* ENABLE_SCLK_TOP_PERIC */
>   	GATE(CLK_SCLK_SPI4_PERIC, "sclk_spi4_peric", "div_sclk_spi4_b",
> @@ -1819,10 +1837,45 @@ CLK_OF_DECLARE(exynos5433_cmu_peris, "samsung,exynos5433-cmu-peris",
>   #define ENABLE_IP_FSYS1			0x0b04
>
>   /* list of all parent clock list */
> +PNAME(mout_sclk_ufs_mphy_user_p)	= { "fin_pll", "sclk_ufs_mphy", };
>   PNAME(mout_aclk_fsys_200_user_p)	= { "fin_pll", "aclk_fsys_200", };
> +PNAME(mout_sclk_pcie_100_user_p)	= { "fin_pll", "sclk_ufsunipro_fsys",};

This parent list looks wrong.
As per UM, it should be: { "fin_pll", "sclk_pcie_100_fsys",};

> +PNAME(mout_sclk_ufsunipro_user_p)	= { "fin_pll", "sclk_ufsunipro_fsys",};
>   PNAME(mout_sclk_mmc2_user_p)		= { "fin_pll", "sclk_mmc2_fsys", };
>   PNAME(mout_sclk_mmc1_user_p)		= { "fin_pll", "sclk_mmc1_fsys", };
>   PNAME(mout_sclk_mmc0_user_p)		= { "fin_pll", "sclk_mmc0_fsys", };
> +PNAME(mout_sclk_usbhost30_user_p)	= { "fin_pll", "sclk_usbhost30_fsys",};
> +PNAME(mout_sclk_usbdrd30_user_p)	= { "fin_pll", "sclk_usbdrd30_fsys", };
> +
> +PNAME(mout_phyclk_usbhost30_uhost30_pipe_pclk_user_p)
> +		= { "fin_pll", "phyclk_usbhost30_uhost30_pipe_pclk_phy", };
> +PNAME(mout_phyclk_usbhost30_uhost30_phyclock_user_p)
> +		= { "fin_pll", "phyclk_usbhost30_uhost30_phyclock_phy", };
> +PNAME(mout_phyclk_usbhost20_phy_hsic1_p)
> +		= { "fin_pll", "phyclk_usbhost20_phy_hsic1_phy", };
> +PNAME(mout_phyclk_usbhost20_phy_clk48mohci_user_p)
> +		= { "fin_pll", "phyclk_usbhost20_phy_clk48mohci_phy", };
> +PNAME(mout_phyclk_usbhost20_phy_phyclock_user_p)
> +		= { "fin_pll", "phyclk_usbhost20_phy_phyclock_phy", };
> +PNAME(mout_phyclk_usbhost20_phy_freeclk_user_p)
> +		= { "fin_pll", "phyclk_usbhost20_phy_freeclk_phy", };
> +PNAME(mout_phyclk_usbdrd30_udrd30_pipe_pclk_p)
> +		= { "fin_pll", "phyclk_usbhost30_uhost30_pipe_pclk_phy", };

Here second parent should be 'phyclk_usbdrd30_udrd30_pipe_pclk_phy'.

> +PNAME(mout_phyclk_usbdrd30_udrd30_phyclock_user_p)
> +		= { "fin_pll", "phyclk_usbhost30_uhost30_phyclock_phy", };

Here second parent should be 'phyclk_usbdrd30_udrd30_phyclock_phy'.

> +PNAME(mout_phyclk_ufs_rx1_symbol_user_p)
> +		= { "fin_pll", "phyclk_ufs_rx1_symbol_phy", };
> +PNAME(mout_phyclk_ufs_rx0_symbol_user_p)
> +		= { "fin_pll", "phyclk_ufs_rx0_symbol_phy", };
> +PNAME(mout_phyclk_ufs_tx1_symbol_user_p)
> +		= { "fin_pll", "phyclk_ufs_tx1_symbol_phy", };
> +PNAME(mout_phyclk_ufs_tx0_symbol_user_p)
> +		= { "fin_pll", "phyclk_ufs_tx0_symbol_phy", };
> +PNAME(mout_phyclk_lli_mphy_to_ufs_user_p)
> +		= { "fin_pll", "phyclk_lli_mphy_to_ufs_phy", };
> +PNAME(mout_sclk_mphy_p)
> +		= { "mout_sclk_ufs_mphy_user",
> +			    "mout_phyclk_lli_mphy_to_ufs_user", };
>
>   static unsigned long fsys_clk_regs[] __initdata = {
>   	MUX_SEL_FSYS0,
> @@ -1850,18 +1903,117 @@ static unsigned long fsys_clk_regs[] __initdata = {
>   	ENABLE_IP_FSYS1,
>   };
>
> +static struct samsung_fixed_rate_clock fsys_fixed_clks[] __initdata = {
> +	/* PHY clocks from USBDRD30_PHY */
> +	FRATE(0, "phyclk_usbdrd30_udrd30_phyclock_phy", NULL, CLK_IS_ROOT,
> +			60000000),
> +	FRATE(0, "phyclk_usbdrd30_udrd30_pipe_pclk_phy", NULL, CLK_IS_ROOT,
> +			125000000),
> +	/* PHY clocks from USBHOST30_PHY */
> +	FRATE(0, "phyclk_usbhost30_uhost30_phyclock_phy", NULL, CLK_IS_ROOT,
> +			60000000),
> +	FRATE(0, "phyclk_usbhost30_uhost30_pipe_pclk_phy", NULL, CLK_IS_ROOT,
> +			125000000),
> +	/* PHY clocks from USBHOST20_PHY */
> +	FRATE(0, "phyclk_usbhost20_phy_freeclk_phy", NULL, CLK_IS_ROOT,
> +			60000000),
> +	FRATE(0, "phyclk_usbhost20_phy_phyclock_phy", NULL, CLK_IS_ROOT,
> +			60000000),
> +	FRATE(0, "phyclk_usbhost20_phy_clk48mohci_phy", NULL, CLK_IS_ROOT,
> +			48000000),
> +	FRATE(0, "phyclk_usbhost20_phy_hsic1_phy", NULL, CLK_IS_ROOT,
> +			60000000),
> +	/* PHY clocks from UFS_PHY */
> +	FRATE(0, "phyclk_ufs_tx0_symbol_phy", NULL, CLK_IS_ROOT, 300000000),
> +	FRATE(0, "phyclk_ufs_rx0_symbol_phy", NULL, CLK_IS_ROOT, 300000000),
> +	FRATE(0, "phyclk_ufs_tx1_symbol_phy", NULL, CLK_IS_ROOT, 300000000),
> +	FRATE(0, "phyclk_ufs_rx1_symbol_phy", NULL, CLK_IS_ROOT, 300000000),
> +	/* PHY clocks from LLI_PHY */
> +	FRATE(0, "phyclk_lli_mphy_to_ufs_phy", NULL, CLK_IS_ROOT, 260000000),

This should be 26 MHz or 260 MHz? Please cross verify.

> +};
> +
>   static struct samsung_mux_clock fsys_mux_clks[] __initdata = {
>   	/* MUX_SEL_FSYS0 */
> +	MUX(CLK_MOUT_SCLK_UFS_MPHY_USER, "mout_sclk_ufs_mphy_user",
> +			mout_sclk_ufs_mphy_user_p, MUX_SEL_FSYS0, 4, 1),
>   	MUX(CLK_MOUT_ACLK_FSYS_200_USER, "mout_aclk_fsys_200_user",
>   			mout_aclk_fsys_200_user_p, MUX_SEL_FSYS0, 0, 1),
>
>   	/* MUX_SEL_FSYS1 */
> +	MUX(CLK_MOUT_SCLK_PCIE_100_USER, "mout_sclk_pcie_100_user",
> +			mout_sclk_pcie_100_user_p, MUX_SEL_FSYS1, 28, 1),
> +	MUX(CLK_MOUT_SCLK_UFSUNIPRO_USER, "mout_sclk_ufsunipro_user",
> +			mout_sclk_ufsunipro_user_p, MUX_SEL_FSYS1, 24, 1),
>   	MUX(CLK_MOUT_SCLK_MMC2_USER, "mout_sclk_mmc2_user",
>   			mout_sclk_mmc2_user_p, MUX_SEL_FSYS1, 20, 1),
>   	MUX(CLK_MOUT_SCLK_MMC1_USER, "mout_sclk_mmc1_user",
>   			mout_sclk_mmc1_user_p, MUX_SEL_FSYS1, 16, 1),
>   	MUX(CLK_MOUT_SCLK_MMC0_USER, "mout_sclk_mmc0_user",
>   			mout_sclk_mmc0_user_p, MUX_SEL_FSYS1, 12, 1),
> +	MUX(CLK_MOUT_SCLK_USBHOST30_USER, "mout_sclk_usbhost30_user",
> +			mout_sclk_usbhost30_user_p, MUX_SEL_FSYS1, 4, 1),
> +	MUX(CLK_MOUT_SCLK_USBDRD30_USER, "mout_sclk_usbdrd30_user",
> +			mout_sclk_usbdrd30_user_p, MUX_SEL_FSYS1, 0, 1),
> +
> +	/* MUX_SEL_FSYS2 */
> +	MUX(CLK_MOUT_PHYCLK_USBHOST30_UHOST30_PIPE_PCLK_USER,
> +			"mout_phyclk_usbhost30_uhost30_pipe_pclk_user",
> +			mout_phyclk_usbhost30_uhost30_pipe_pclk_user_p,
> +			MUX_SEL_FSYS2, 28, 1),
> +	MUX(CLK_MOUT_PHYCLK_USBHOST30_UHOST30_PHYCLOCK_USER,
> +			"mout_phyclk_usbhost30_uhost30_phyclock_user",
> +			mout_phyclk_usbhost30_uhost30_phyclock_user_p,
> +			MUX_SEL_FSYS2, 24, 1),
> +	MUX(CLK_MOUT_PHYCLK_USBHOST20_PHY_HSIC1_USER,
> +			"mout_phyclk_usbhost20_phy_hsic1",
> +			mout_phyclk_usbhost20_phy_hsic1_p,
> +			MUX_SEL_FSYS2, 20, 1),
> +	MUX(CLK_MOUT_PHYCLK_USBHOST20_PHY_CLK48MOHCI_USER,
> +			"mout_phyclk_usbhost20_phy_clk48mohci_user",
> +			mout_phyclk_usbhost20_phy_clk48mohci_user_p,
> +			MUX_SEL_FSYS2, 16, 1),
> +	MUX(CLK_MOUT_PHYCLK_USBHOST20_PHY_PHYCLOCK_USER,
> +			"mout_phyclk_usbhost20_phy_phyclock_user",
> +			mout_phyclk_usbhost20_phy_phyclock_user_p,
> +			MUX_SEL_FSYS2, 12, 1),
> +	MUX(CLK_MOUT_PHYCLK_USBHOST20_PHY_PHY_FREECLK_USER,
> +			"mout_phyclk_usbhost20_phy_freeclk_user",
> +			mout_phyclk_usbhost20_phy_freeclk_user_p,
> +			MUX_SEL_FSYS2, 8, 1),
> +	MUX(CLK_MOUT_PHYCLK_USBDRD30_UDRD30_PIPE_PCLK_USER,
> +			"mout_phyclk_usbdrd30_udrd30_pipe_pclk_user",
> +			mout_phyclk_usbdrd30_udrd30_pipe_pclk_p,
> +			MUX_SEL_FSYS2, 4, 1),
> +	MUX(CLK_MOUT_PHYCLK_USBDRD30_UDRD30_PHYCLOCK_USER,
> +			"mout_phyclk_usbdrd30_udrd30_phyclock_user",
> +			mout_phyclk_usbdrd30_udrd30_phyclock_user_p,
> +			MUX_SEL_FSYS2, 0, 1),
> +
> +	/* MUX_SEL_FSYS3 */
> +	MUX(CLK_MOUT_PHYCLK_UFS_RX1_SYMBOL_USER,
> +			"mout_phyclk_ufs_rx1_symbol_user",
> +			mout_phyclk_ufs_rx1_symbol_user_p,
> +			MUX_SEL_FSYS3, 16, 1),
> +	MUX(CLK_MOUT_PHYCLK_UFS_RX0_SYMBOL_USER,
> +			"mout_phyclk_ufs_rx0_symbol_user",
> +			mout_phyclk_ufs_rx0_symbol_user_p,
> +			MUX_SEL_FSYS3, 12, 1),
> +	MUX(CLK_MOUT_PHYCLK_UFS_TX1_SYMBOL_USER,
> +			"mout_phyclk_ufs_tx1_symbol_user",
> +			mout_phyclk_ufs_tx1_symbol_user_p,
> +			MUX_SEL_FSYS3, 8, 1),
> +	MUX(CLK_MOUT_PHYCLK_UFS_TX0_SYMBOL_USER,
> +			"mout_phyclk_ufs_tx0_symbol_user",
> +			mout_phyclk_ufs_tx0_symbol_user_p,
> +			MUX_SEL_FSYS3, 4, 1),
> +	MUX(CLK_MOUT_PHYCLK_LLI_MPHY_TO_UFS_USER,
> +			"mout_phyclk_lli_mphy_to_ufs_user",
> +			mout_phyclk_lli_mphy_to_ufs_user_p,
> +			MUX_SEL_FSYS4, 0, 1),

Please change MUX_SEL_FSYS4 -> MUX_SEL_FSYS3

> +
> +	/* MUX_SEL_FSYS4 */
> +	MUX(CLK_MOUT_SCLK_MPHY, "mout_sclk_mphy", mout_sclk_mphy_p,
> +			MUX_SEL_FSYS4, 0, 1),
>   };
>

Thanks,
Pankaj Dubey
