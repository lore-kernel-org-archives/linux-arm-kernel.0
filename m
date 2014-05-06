From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Tue, 06 May 2014 19:18:52 +0200
Subject: [PATCH v4 06/15] clk: exynos5420: update clocks for DISP1 block
In-Reply-To: <1399393610-23394-7-git-send-email-shaik.ameer@samsung.com>
References: <1399393610-23394-1-git-send-email-shaik.ameer@samsung.com>
 <1399393610-23394-7-git-send-email-shaik.ameer@samsung.com>
Message-ID: <5369197C.4000200@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shaik,

On 06.05.2014 18:26, Shaik Ameer Basha wrote:
> This patch corrects some child-parent clock relationships,
> and updates the clocks according to the latest datasheet.
>
> Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
> Signed-off-by: Shaik Ameer Basha <shaik.ameer@samsung.com>
> ---
>   drivers/clk/samsung/clk-exynos5420.c   |   58 ++++++++++++++++++++++----------
>   include/dt-bindings/clock/exynos5420.h |    3 +-
>   2 files changed, 43 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
> index 5bc4798..9750659 100644
> --- a/drivers/clk/samsung/clk-exynos5420.c
> +++ b/drivers/clk/samsung/clk-exynos5420.c
> @@ -61,7 +61,8 @@
>   #define SRC_TOP10		0x10280
>   #define SRC_TOP11		0x10284
>   #define SRC_TOP12		0x10288
> -#define	SRC_MASK_DISP10		0x1032c
> +#define SRC_MASK_TOP2		0x10308
> +#define SRC_MASK_DISP10		0x1032c
>   #define SRC_MASK_FSYS		0x10340
>   #define SRC_MASK_PERIC0		0x10350
>   #define SRC_MASK_PERIC1		0x10354
> @@ -100,6 +101,7 @@
>   #define GATE_TOP_SCLK_MAU	0x1083c
>   #define GATE_TOP_SCLK_FSYS	0x10840
>   #define GATE_TOP_SCLK_PERIC	0x10850
> +#define TOP_SPARE2		0x10b08
>   #define BPLL_LOCK		0x20010
>   #define BPLL_CON0		0x20110
>   #define SRC_CDREX		0x20200
> @@ -146,6 +148,7 @@ static unsigned long exynos5420_clk_regs[] __initdata = {
>   	SRC_TOP10,
>   	SRC_TOP11,
>   	SRC_TOP12,
> +	SRC_MASK_TOP2,
>   	SRC_MASK_DISP10,
>   	SRC_MASK_FSYS,
>   	SRC_MASK_PERIC0,
> @@ -186,6 +189,7 @@ static unsigned long exynos5420_clk_regs[] __initdata = {
>   	GATE_TOP_SCLK_MAU,
>   	GATE_TOP_SCLK_FSYS,
>   	GATE_TOP_SCLK_PERIC,
> +	TOP_SPARE2,
>   	SRC_CDREX,
>   	SRC_KFC,
>   	DIV_KFC0,
> @@ -252,6 +256,7 @@ PNAME(mout_group3_p) = {"mout_sclk_rpll", "mout_sclk_spll"};
>   PNAME(mout_group4_p) = {"mout_sclk_ipll", "mout_sclk_dpll", "mout_sclk_mpll"};
>   PNAME(mout_group5_p) = {"mout_sclk_vpll", "mout_sclk_dpll"};
>
> +PNAME(mout_fimd1_final_p) = {"mout_fimd1", "mout_fimd1_opt"};
>   PNAME(mout_sw_aclk66_p)	= {"dout_aclk66", "mout_sclk_spll"};
>   PNAME(mout_aclk66_peric_p)	= { "fin_pll", "mout_sw_aclk66" };
>
> @@ -271,7 +276,7 @@ PNAME(mout_sw_aclk333_432_isp_p) = {"dout_aclk333_432_isp", "mout_sclk_spll"};
>   PNAME(mout_user_aclk333_432_isp_p) = {"fin_pll", "mout_sw_aclk333_432_isp"};
>
>   PNAME(mout_sw_aclk200_p) = {"dout_aclk200", "mout_sclk_spll"};
> -PNAME(mout_aclk200_disp1_p) = {"fin_pll", "mout_sw_aclk200"};
> +PNAME(mout_user_aclk200_disp1_p) = {"fin_pll", "mout_sw_aclk200"};
>
>   PNAME(mout_sw_aclk400_mscl_p) = {"dout_aclk400_mscl", "mout_sclk_spll"};
>   PNAME(mout_user_aclk400_mscl_p)	= {"fin_pll", "mout_sw_aclk400_mscl"};
> @@ -293,7 +298,9 @@ PNAME(mout_sw_aclk300_gscl_p) = {"dout_aclk300_gscl", "mout_sclk_spll"};
>   PNAME(mout_user_aclk300_gscl_p)	= {"fin_pll", "mout_sw_aclk300_gscl"};
>
>   PNAME(mout_sw_aclk300_disp1_p) = {"dout_aclk300_disp1", "mout_sclk_spll"};
> +PNAME(mout_sw_aclk400_disp1_p) = {"dout_aclk400_disp1", "mout_sclk_spll"};
>   PNAME(mout_user_aclk300_disp1_p) = {"fin_pll", "mout_sw_aclk300_disp1"};
> +PNAME(mout_user_aclk400_disp1_p) = {"fin_pll", "mout_sw_aclk400_disp1"};
>
>   PNAME(mout_sw_aclk300_jpeg_p) = {"dout_aclk300_jpeg", "mout_sclk_spll"};
>   PNAME(mout_user_aclk300_jpeg_p) = {"fin_pll", "mout_sw_aclk300_jpeg"};
> @@ -368,6 +375,7 @@ static struct samsung_mux_clock exynos5420_mux_clks[] __initdata = {
>   	MUX(0, "mout_aclk166", mout_group1_p, SRC_TOP1, 24, 2),
>   	MUX(0, "mout_aclk333", mout_group1_p, SRC_TOP1, 28, 2),
>
> +	MUX(0, "mout_aclk400_disp1", mout_group1_p, SRC_TOP2, 4, 2),
>   	MUX(0, "mout_aclk333_g2d", mout_group1_p, SRC_TOP2, 8, 2),
>   	MUX(0, "mout_aclk266_g2d", mout_group1_p, SRC_TOP2, 12, 2),
>   	MUX(0, "mout_aclk_g3d", mout_group5_p, SRC_TOP2, 16, 1),
> @@ -379,7 +387,8 @@ static struct samsung_mux_clock exynos5420_mux_clks[] __initdata = {
>   			SRC_TOP3, 0, 1),
>   	MUX(0, "mout_user_aclk400_mscl", mout_user_aclk400_mscl_p,
>   			SRC_TOP3, 4, 1),
> -	MUX(0, "mout_aclk200_disp1", mout_aclk200_disp1_p, SRC_TOP3, 8, 1),
> +	MUX(0, "mout_user_aclk200_disp1", mout_user_aclk200_disp1_p,
> +			SRC_TOP3, 8, 1),
>   	MUX(0, "mout_user_aclk200_fsys2", mout_user_aclk200_fsys2_p,
>   			SRC_TOP3, 12, 1),
>   	MUX(0, "mout_user_aclk200_fsys", mout_user_aclk200_fsys_p,
> @@ -398,6 +407,8 @@ static struct samsung_mux_clock exynos5420_mux_clks[] __initdata = {
>   	MUX(0, "mout_user_aclk166", mout_user_aclk166_p, SRC_TOP4, 24, 1),
>   	MUX(0, "mout_user_aclk333", mout_user_aclk333_p, SRC_TOP4, 28, 1),
>
> +	MUX(0, "mout_user_aclk400_disp1", mout_user_aclk400_disp1_p,
> +			SRC_TOP5, 0, 1),
>   	MUX(0, "mout_aclk66_psgen", mout_aclk66_peric_p, SRC_TOP5, 4, 1),
>   	MUX(0, "mout_user_aclk333_g2d", mout_user_aclk333_g2d_p, SRC_TOP5,
>   			8, 1),
> @@ -442,6 +453,8 @@ static struct samsung_mux_clock exynos5420_mux_clks[] __initdata = {
>   	MUX(0, "mout_sw_aclk166", mout_sw_aclk166_p, SRC_TOP11, 24, 1),
>   	MUX(0, "mout_sw_aclk333", mout_sw_aclk333_p, SRC_TOP11, 28, 1),
>
> +	MUX(0, "mout_sw_aclk400_disp1", mout_sw_aclk400_disp1_p,
> +			SRC_TOP12, 4, 1),
>   	MUX(0, "mout_sw_aclk333_g2d", mout_sw_aclk333_g2d_p,
>   			SRC_TOP12, 8, 1),
>   	MUX(0, "mout_sw_aclk266_g2d", mout_sw_aclk266_g2d_p,
> @@ -460,6 +473,10 @@ static struct samsung_mux_clock exynos5420_mux_clks[] __initdata = {
>   	MUX(0, "mout_dp1", mout_group2_p, SRC_DISP10, 20, 3),
>   	MUX(0, "mout_pixel", mout_group2_p, SRC_DISP10, 24, 3),
>   	MUX(CLK_MOUT_HDMI, "mout_hdmi", mout_hdmi_p, SRC_DISP10, 28, 1),
> +	MUX_F(0, "mout_fimd1_opt", mout_group2_p,
> +			SRC_DISP10, 8, 3, CLK_SET_RATE_PARENT, 0),
> +	MUX_F(0, "mout_fimd1_final", mout_fimd1_final_p,
> +			TOP_SPARE2, 8, 1, CLK_SET_RATE_PARENT, 0),

the CLK_SET_RATE_PARENT flag doesn't seem right here as it would cause 
reconfiguration of a lot of shared clocks if set_rate called on this 
clock. Is there any reason to have it here?

In general this flag should be set for simple clock paths without nodes 
inside shared across multiple other clock paths to don't let one driver 
step on another with calls to clk_set_rate().

>
>   	/* MAU Block */
>   	MUX(0, "mout_maudio0", mout_maudio0_p, SRC_MAU, 28, 3),
> @@ -523,15 +540,16 @@ static struct samsung_div_clock exynos5420_div_clks[] __initdata = {
>   	DIV(0, "dout_aclk266_g2d", "mout_aclk266_g2d", DIV_TOP2, 12, 3),
>   	DIV(0, "dout_aclk_g3d", "mout_aclk_g3d", DIV_TOP2, 16, 3),
>   	DIV(0, "dout_aclk300_jpeg", "mout_aclk300_jpeg", DIV_TOP2, 20, 3),
> -	DIV_A(0, "dout_aclk300_disp1", "mout_aclk300_disp1",
> -			DIV_TOP2, 24, 3, "aclk300_disp1"),
> +	DIV(0, "dout_aclk300_disp1", "mout_aclk300_disp1", DIV_TOP2, 24, 3),
>   	DIV(0, "dout_aclk300_gscl", "mout_aclk300_gscl", DIV_TOP2, 28, 3),
>
>   	/* DISP1 Block */
> -	DIV(0, "dout_fimd1", "mout_fimd1", DIV_DISP10, 0, 4),
> +	DIV(0, "dout_fimd1", "mout_fimd1_final", DIV_DISP10, 0, 4),
>   	DIV(0, "dout_mipi1", "mout_mipi1", DIV_DISP10, 16, 8),
>   	DIV(0, "dout_dp1", "mout_dp1", DIV_DISP10, 24, 4),
>   	DIV(CLK_DOUT_PIXEL, "dout_hdmi_pixel", "mout_pixel", DIV_DISP10, 28, 4),
> +	DIV(0, "dout_disp1_blk", "aclk200_disp1", DIV2_RATIO0, 16, 2),
> +	DIV(0, "dout_aclk400_disp1", "mout_aclk400_disp1", DIV_TOP2, 4, 3),
>
>   	/* Audio Block */
>   	DIV(0, "dout_maudio0", "mout_maudio0", DIV_MAU, 20, 4),
> @@ -640,6 +658,11 @@ static struct samsung_gate_clock exynos5420_gate_clks[] __initdata = {
>   			GATE_BUS_TOP, 16, 0, 0),
>   	GATE(CLK_ACLK400_MSCL, "aclk400_mscl", "mout_user_aclk400_mscl",
>   			GATE_BUS_TOP, 17, CLK_IGNORE_UNUSED, 0),
> +	GATE(CLK_ACLK200_DISP1, "aclk200_disp1", "mout_user_aclk200_disp1",
> +			GATE_BUS_TOP, 18, CLK_IGNORE_UNUSED, 0),
> +
> +	GATE(CLK_ACLK300_DISP1, "aclk300_disp1", "mout_user_aclk300_disp1",
> +			SRC_MASK_TOP2, 24, CLK_IGNORE_UNUSED, 0),

The CLK_IGNORE_UNUSED flags would suggest that you don't need to define 
this clock here at all and use their parents directly for child clocks 
of these intermediate clocks defined here. In general, this is related 
to the mis-use of GATE_BUS_* registers in this driver.

>
>   	/* sclk */
>   	GATE(CLK_SCLK_UART0, "sclk_uart0", "dout_uart0",
> @@ -689,15 +712,15 @@ static struct samsung_gate_clock exynos5420_gate_clks[] __initdata = {
>
>   	/* Display */
>   	GATE(CLK_SCLK_FIMD1, "sclk_fimd1", "dout_fimd1",
> -		GATE_TOP_SCLK_DISP1, 0, CLK_SET_RATE_PARENT, 0),
> +			GATE_TOP_SCLK_DISP1, 0, CLK_SET_RATE_PARENT, 0),
>   	GATE(CLK_SCLK_MIPI1, "sclk_mipi1", "dout_mipi1",
> -		GATE_TOP_SCLK_DISP1, 3, CLK_SET_RATE_PARENT, 0),
> +			GATE_TOP_SCLK_DISP1, 3, CLK_SET_RATE_PARENT, 0),
>   	GATE(CLK_SCLK_HDMI, "sclk_hdmi", "mout_hdmi",
> -		GATE_TOP_SCLK_DISP1, 9, CLK_SET_RATE_PARENT, 0),
> +			GATE_TOP_SCLK_DISP1, 9, CLK_SET_RATE_PARENT, 0),

CLK_SET_RATE_PARENT for a clock with a mux as the parent doesn't seem 
right to me. Is there any specific reason to have it here?

>   	GATE(CLK_SCLK_PIXEL, "sclk_pixel", "dout_hdmi_pixel",
> -		GATE_TOP_SCLK_DISP1, 10, CLK_SET_RATE_PARENT, 0),
> +			GATE_TOP_SCLK_DISP1, 10, CLK_SET_RATE_PARENT, 0),
>   	GATE(CLK_SCLK_DP1, "sclk_dp1", "dout_dp1",
> -		GATE_TOP_SCLK_DISP1, 20, CLK_SET_RATE_PARENT, 0),
> +			GATE_TOP_SCLK_DISP1, 20, CLK_SET_RATE_PARENT, 0),
>
>   	/* Maudio Block */
>   	GATE(CLK_SCLK_MAUDIO0, "sclk_maudio0", "dout_maudio0",
> @@ -826,10 +849,14 @@ static struct samsung_gate_clock exynos5420_gate_clks[] __initdata = {
>   	GATE(CLK_FIMD1, "fimd1", "aclk300_disp1", GATE_IP_DISP1, 0, 0, 0),
>   	GATE(CLK_DSIM1, "dsim1", "aclk200_disp1", GATE_IP_DISP1, 3, 0, 0),
>   	GATE(CLK_DP1, "dp1", "aclk200_disp1", GATE_IP_DISP1, 4, 0, 0),
> -	GATE(CLK_MIXER, "mixer", "aclk166", GATE_IP_DISP1, 5, 0, 0),
> +	GATE(CLK_MIXER, "mixer", "aclk200_disp1", GATE_IP_DISP1, 5, 0, 0),
>   	GATE(CLK_HDMI, "hdmi", "aclk200_disp1", GATE_IP_DISP1, 6, 0, 0),
> -	GATE(CLK_SMMU_FIMD1, "smmu_fimd1", "aclk300_disp1", GATE_IP_DISP1, 8, 0,
> -		0),
> +	GATE(CLK_SMMU_FIMD1M0, "smmu_fimd1m0", "dout_disp1_blk",
> +			GATE_IP_DISP1, 7, CLK_SET_RATE_PARENT, 0),
> +	GATE(CLK_SMMU_FIMD1M1, "smmu_fimd1m1", "dout_disp1_blk",
> +			GATE_IP_DISP1, 8, CLK_SET_RATE_PARENT, 0),

CLK_SET_RATE_PARENT for these two definitely is not right, since these 
clocks have a shared divider block as their parents.

Best regards,
Tomasz
