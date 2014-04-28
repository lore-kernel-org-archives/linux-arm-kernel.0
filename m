From: alim.akhtar@gmail.com (Alim Akhtar)
Date: Mon, 28 Apr 2014 11:31:35 +0530
Subject: [PATCH v3 03/16] clk: exynos5420: update clocks for GSCL and MSCL
 blocks
In-Reply-To: <1398344632-18623-4-git-send-email-shaik.ameer@samsung.com>
References: <1398344632-18623-1-git-send-email-shaik.ameer@samsung.com>
 <1398344632-18623-4-git-send-email-shaik.ameer@samsung.com>
Message-ID: <CAGOxZ52vcemipA5kUZd+1-AQv3NDZHeVq_1YdapEEaqs4v96Dw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shaik

On Thu, Apr 24, 2014 at 6:33 PM, Shaik Ameer Basha
<shaik.ameer@samsung.com> wrote:
> This patch adds the missing GSCL and MSCL block clocks
> and corrects some wrong parent-child relationships.
>
> Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
> Signed-off-by: Shaik Ameer Basha <shaik.ameer@samsung.com>
> ---
Looks ok
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
>  drivers/clk/samsung/clk-exynos5420.c   |   41 +++++++++++++++++++++-----------
>  include/dt-bindings/clock/exynos5420.h |    2 +-
>  2 files changed, 28 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
> index 972da5d..c3c8ceb 100755
> --- a/drivers/clk/samsung/clk-exynos5420.c
> +++ b/drivers/clk/samsung/clk-exynos5420.c
> @@ -80,6 +80,7 @@
>  #define DIV_PERIC4             0x10568
>  #define SCLK_DIV_ISP0          0x10580
>  #define SCLK_DIV_ISP1          0x10584
> +#define DIV2_RATIO0            0x10590
>  #define GATE_BUS_TOP           0x10700
>  #define GATE_BUS_FSYS0         0x10740
>  #define GATE_BUS_PERIC         0x10750
> @@ -165,6 +166,7 @@ static unsigned long exynos5420_clk_regs[] __initdata = {
>         DIV_PERIC4,
>         SCLK_DIV_ISP0,
>         SCLK_DIV_ISP1,
> +       DIV2_RATIO0,
>         GATE_BUS_TOP,
>         GATE_BUS_FSYS0,
>         GATE_BUS_PERIC,
> @@ -572,6 +574,11 @@ static struct samsung_div_clock exynos5420_div_clks[] __initdata = {
>         DIV(0, "dout_pre_spi1", "dout_spi1", DIV_PERIC4, 16, 8),
>         DIV(0, "dout_pre_spi2", "dout_spi2", DIV_PERIC4, 24, 8),
>
> +       /* GSCL Block */
> +       DIV(0, "dout_gscl_blk_300", "mout_user_aclk300_gscl",
> +               DIV2_RATIO0, 4, 2),
> +       DIV(0, "dout_gscl_blk_333", "aclk333_432_gscl", DIV2_RATIO0, 6, 2),
> +
>         /* ISP Block */
>         DIV(0, "dout_aclk400_isp", "mout_aclk400_isp", DIV_TOP0, 0, 3),
>         DIV(0, "dout_aclk333_432_isp0", "mout_aclk333_432_isp0",
> @@ -666,9 +673,9 @@ static struct samsung_gate_clock exynos5420_gate_clks[] __initdata = {
>         GATE(CLK_SCLK_USBD301, "sclk_unipro", "dout_unipro",
>                 SRC_MASK_FSYS, 24, CLK_SET_RATE_PARENT, 0),
>
> -       GATE(CLK_SCLK_GSCL_WA, "sclk_gscl_wa", "aclK333_432_gscl",
> +       GATE(CLK_SCLK_GSCL_WA, "sclk_gscl_wa", "mout_user_aclk333_432_gscl",
>                 GATE_TOP_SCLK_GSCL, 6, CLK_SET_RATE_PARENT, 0),
> -       GATE(CLK_SCLK_GSCL_WB, "sclk_gscl_wb", "aclk333_432_gscl",
> +       GATE(CLK_SCLK_GSCL_WB, "sclk_gscl_wb", "mout_user_aclk333_432_gscl",
>                 GATE_TOP_SCLK_GSCL, 7, CLK_SET_RATE_PARENT, 0),
>
>         /* Display */
> @@ -766,22 +773,25 @@ static struct samsung_gate_clock exynos5420_gate_clks[] __initdata = {
>
>         GATE(CLK_GSCL0, "gscl0", "aclk300_gscl", GATE_IP_GSCL0, 0, 0, 0),
>         GATE(CLK_GSCL1, "gscl1", "aclk300_gscl", GATE_IP_GSCL0, 1, 0, 0),
> -       GATE(CLK_CLK_3AA, "clk_3aa", "aclk300_gscl", GATE_IP_GSCL0, 4, 0, 0),
> +       GATE(CLK_FIMC_3AA, "fimc_3aa", "aclk333_432_gscl",
> +                       GATE_IP_GSCL0, 4, 0, 0),
>
> -       GATE(CLK_SMMU_3AA, "smmu_3aa", "aclk333_432_gscl", GATE_IP_GSCL1, 2, 0,
> -               0),
> -       GATE(CLK_SMMU_FIMCL0, "smmu_fimcl0", "aclk333_432_gscl",
> +       GATE(CLK_SMMU_3AA, "smmu_3aa", "dout_gscl_blk_333",
> +                       GATE_IP_GSCL1, 2, 0, 0),
> +       GATE(CLK_SMMU_FIMCL0, "smmu_fimcl0", "dout_gscl_blk_333",
>                         GATE_IP_GSCL1, 3, 0, 0),
> -       GATE(CLK_SMMU_FIMCL1, "smmu_fimcl1", "aclk333_432_gscl",
> +       GATE(CLK_SMMU_FIMCL1, "smmu_fimcl1", "dout_gscl_blk_333",
>                         GATE_IP_GSCL1, 4, 0, 0),
> -       GATE(CLK_SMMU_GSCL0, "smmu_gscl0", "aclk300_gscl", GATE_IP_GSCL1, 6, 0,
> -               0),
> -       GATE(CLK_SMMU_GSCL1, "smmu_gscl1", "aclk300_gscl", GATE_IP_GSCL1, 7, 0,
> -               0),
> -       GATE(CLK_GSCL_WA, "gscl_wa", "aclk300_gscl", GATE_IP_GSCL1, 12, 0, 0),
> -       GATE(CLK_GSCL_WB, "gscl_wb", "aclk300_gscl", GATE_IP_GSCL1, 13, 0, 0),
> -       GATE(CLK_SMMU_FIMCL3, "smmu_fimcl3,", "aclk333_432_gscl",
> +       GATE(CLK_SMMU_GSCL0, "smmu_gscl0", "dout_gscl_blk_300",
> +                       GATE_IP_GSCL1, 6, 0, 0),
> +       GATE(CLK_SMMU_GSCL1, "smmu_gscl1", "dout_gscl_blk_300",
> +                       GATE_IP_GSCL1, 7, 0, 0),
> +       GATE(CLK_GSCL_WA, "gscl_wa", "sclk_gscl_wa", GATE_IP_GSCL1, 12, 0, 0),
> +       GATE(CLK_GSCL_WB, "gscl_wb", "sclk_gscl_wb", GATE_IP_GSCL1, 13, 0, 0),
> +       GATE(CLK_SMMU_FIMCL3, "smmu_fimcl3,", "dout_gscl_blk_333",
>                         GATE_IP_GSCL1, 16, 0, 0),
> +       GATE(0, "fimc_lite0", "aclk333_432_gscl", GATE_IP_GSCL0, 5, 0, 0),
> +       GATE(0, "fimc_lite1", "aclk333_432_gscl", GATE_IP_GSCL0, 6, 0, 0),
>         GATE(CLK_FIMC_LITE3, "fimc_lite3", "aclk333_432_gscl",
>                         GATE_IP_GSCL1, 17, 0, 0),
>
> @@ -818,6 +828,9 @@ static struct samsung_gate_clock exynos5420_gate_clks[] __initdata = {
>                 0),
>         GATE(CLK_SMMU_MIXER, "smmu_mixer", "aclk200_disp1", GATE_IP_DISP1, 9, 0,
>                 0),
> +       /* gating of aclk300_gscl causes system hang. It should not be gated. */
[nit] Probably.... s/aclk300_gscl/aclk400_mscl

> +       GATE(CLK_ACLK400_MSCL, "aclk400_mscl", "mout_user_aclk400_mscl",
> +                       GATE_BUS_TOP, 17, CLK_IGNORE_UNUSED, 0),
>         GATE(0, "aclk266_isp", "mout_user_aclk266_isp",
>                         GATE_BUS_TOP, 13, 0, 0),
>         GATE(0, "aclk400_isp", "mout_user_aclk400_isp",
> diff --git a/include/dt-bindings/clock/exynos5420.h b/include/dt-bindings/clock/exynos5420.h
> index 5eefd88..223925f 100644
> --- a/include/dt-bindings/clock/exynos5420.h
> +++ b/include/dt-bindings/clock/exynos5420.h
> @@ -159,7 +159,7 @@
>  #define CLK_GSCL_WB            464
>  #define CLK_GSCL0              465
>  #define CLK_GSCL1              466
> -#define CLK_CLK_3AA            467
> +#define CLK_FIMC_3AA           467
>  #define CLK_ACLK266_G2D                470
>  #define CLK_SSS                        471
>  #define CLK_SLIM_SSS           472
> --
> 1.7.9.5
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel



-- 
Regards,
Alim
