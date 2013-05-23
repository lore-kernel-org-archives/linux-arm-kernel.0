From: arunkk.samsung@gmail.com (Arun Kumar K)
Date: Thu, 23 May 2013 16:13:31 +0530
Subject: [PATCH] clk: exynos5250: Added MUX, DIV and GATE clocks for
 Gscaler and MFC
In-Reply-To: <1364271986-30491-1-git-send-email-prasanna.ps@samsung.com>
References: <1364271986-30491-1-git-send-email-prasanna.ps@samsung.com>
Message-ID: <CALt3h78RSAPYAjPA-sODQtckTTDtwdyU71hCmbgthXSjGQk0=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

NAK

In testing we have seen that, when sysmmu of mfc/gscl is used,
the respective IP clock has to be ON, or else it was malfunctioning.
So for smmu_mfcl and smmu_mfcr, the parent should be mfc
so that we make sure the parent is turned on every time sysmmu is accessed.
Same thing applies to gscl also.

Regards
Arun Kumar

On Tue, Mar 26, 2013 at 9:56 AM, Prasanna Kumar <prasanna.ps@samsung.com> wrote:
> From: Prasanna Kumar <prasanna.ps@samsung.com>
>
> Gscaler :
>
>   1. For "aclk_300_gscl",following clocks are added
>           Mux clocks
>                 mout_aclk_300_gscl_mid,
>                 mout_aclk_300_gscl_mid1,
>                 mout_aclk_300_gscl
>           Divider clock
>                 div_aclk300_gscl
>           Sub-Mux clock ( driven from output of divider clock)
>                 mout_sub_aclk300
>   2. For "aclk_266_gscl",
>            Sub-Mux clock "mout_sub_aclk266" added
>            Divider clock has been modified to refer Sub-Mux clock
>
> MFC :
>    For "aclk_333"
>         Sub-Mux clock "mout_sub_aclk333" added
>            Divider clock has been modified to refer Sub-Mux clock
> Signed-off-by: Prasanna Kumar <prasanna.ps@samsung.com>
> ---
>  drivers/clk/samsung/clk-exynos5250.c |   57 +++++++++++++++++++++++++--------
>  1 files changed, 43 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/clk/samsung/clk-exynos5250.c b/drivers/clk/samsung/clk-exynos5250.c
> index e40d6af..40dff9d 100644
> --- a/drivers/clk/samsung/clk-exynos5250.c
> +++ b/drivers/clk/samsung/clk-exynos5250.c
> @@ -24,7 +24,9 @@
>  #define DIV_CPU0               0x500
>  #define SRC_CORE1              0x4204
>  #define SRC_TOP0               0x10210
> +#define SRC_TOP1               0x10214
>  #define SRC_TOP2               0x10218
> +#define SRC_TOP3               0x1021C
>  #define SRC_GSCL               0x10220
>  #define SRC_DISP1_0            0x1022c
>  #define SRC_MAU                        0x10240
> @@ -112,7 +114,9 @@ static __initdata unsigned long exynos5250_clk_regs[] = {
>         DIV_CPU0,
>         SRC_CORE1,
>         SRC_TOP0,
> +       SRC_TOP1,
>         SRC_TOP2,
> +       SRC_TOP3,
>         SRC_GSCL,
>         SRC_DISP1_0,
>         SRC_MAU,
> @@ -167,6 +171,13 @@ PNAME(mout_mpll_user_p)    = { "fin_pll", "sclk_mpll" };
>  PNAME(mout_bpll_user_p)        = { "fin_pll", "sclk_bpll" };
>  PNAME(mout_aclk166_p)  = { "sclk_cpll", "sclk_mpll_user" };
>  PNAME(mout_aclk200_p)  = { "sclk_mpll_user", "sclk_bpll_user" };
> +PNAME(mout_sub_aclk266_p) = { "fin_pll", "div_aclk266" };
> +PNAME(mout_aclk_300_gscl_mid_p) = { "sclk_mpll_user", "sclk_bpll_user"};
> +PNAME(mout_aclk_300_gscl_mid1_p) = { "sclk_vpll", "sclk_cpll"};
> +PNAME(mout_aclk_300_gscl_p) = { "mout_aclk_300_gscl_mid",
> +                                       "mout_aclk_300_gscl_mid1" };
> +PNAME(mout_sub_aclk300_p) = { "fin_pll", "div_aclk300_gscl" };
> +PNAME(mout_sub_aclk333_p) = { "fin_pll", "div_aclk333" };
>  PNAME(mout_hdmi_p)     = { "div_hdmi_pixel", "sclk_hdmiphy" };
>  PNAME(mout_usb3_p)     = { "sclk_mpll_user", "sclk_cpll" };
>  PNAME(mout_group1_p)   = { "fin_pll", "fin_pll", "sclk_hdmi27m",
> @@ -220,8 +231,20 @@ struct samsung_mux_clock exynos5250_mux_clks[] __initdata = {
>         MUX(none, "sclk_mpll_user", mout_mpll_user_p, SRC_TOP2, 20, 1),
>         MUX(none, "sclk_bpll_user", mout_bpll_user_p, SRC_TOP2, 24, 1),
>         MUX(none, "mout_aclk166", mout_aclk166_p, SRC_TOP0, 8, 1),
> -       MUX(none, "mout_aclk333", mout_aclk166_p, SRC_TOP0, 16, 1),
>         MUX(none, "mout_aclk200", mout_aclk200_p, SRC_TOP0, 12, 1),
> +       MUX_A(none, "mout_sub_aclk266", mout_sub_aclk266_p,
> +                                       SRC_TOP3, 8, 1, "m_sub_aclk266"),
> +       MUX(none, "mout_aclk_300_gscl", mout_aclk_300_gscl_p,
> +                                               SRC_TOP0, 25, 1),
> +       MUX(none, "mout_aclk_300_gscl_mid", mout_aclk_300_gscl_mid_p,
> +                                               SRC_TOP0, 24, 1),
> +       MUX(none, "mout_aclk_300_gscl_mid1", mout_aclk_300_gscl_mid1_p,
> +                                               SRC_TOP1, 12, 1),
> +       MUX_A(none, "mout_sub_aclk300", mout_sub_aclk300_p,
> +                                       SRC_TOP3, 10, 1, "m_sub_aclk300"),
> +       MUX(none, "mout_aclk333", mout_aclk166_p, SRC_TOP0, 16, 1),
> +       MUX_A(none, "mout_sub_aclk333", mout_sub_aclk333_p,
> +                                       SRC_TOP3, 24, 1, "m_sub_aclk333"),
>         MUX(none, "mout_cam_bayer", mout_group1_p, SRC_GSCL, 12, 4),
>         MUX(none, "mout_cam0", mout_group1_p, SRC_GSCL, 16, 4),
>         MUX(none, "mout_cam1", mout_group1_p, SRC_GSCL, 20, 4),
> @@ -257,10 +280,12 @@ struct samsung_div_clock exynos5250_div_clks[] __initdata = {
>         DIV(none, "sclk_apll", "mout_apll", DIV_CPU0, 24, 3),
>         DIV(none, "aclk66_pre", "sclk_mpll_user", DIV_TOP1, 24, 3),
>         DIV(none, "aclk66", "aclk66_pre", DIV_TOP0, 0, 3),
> -       DIV(none, "aclk266", "sclk_mpll_user", DIV_TOP0, 16, 3),
>         DIV(none, "aclk166", "mout_aclk166", DIV_TOP0, 8, 3),
> -       DIV(none, "aclk333", "mout_aclk333", DIV_TOP0, 20, 3),
>         DIV(none, "aclk200", "mout_aclk200", DIV_TOP0, 12, 3),
> +       DIV(none, "div_aclk266", "sclk_mpll_user", DIV_TOP0, 16, 3),
> +       DIV(none, "div_aclk300_gscl", "mout_aclk_300_gscl",
> +                                               DIV_TOP1, 14, 3),
> +       DIV(none, "div_aclk333", "mout_aclk333", DIV_TOP0, 20, 3),
>         DIV(none, "div_cam_bayer", "mout_cam_bayer", DIV_GSCL, 12, 4),
>         DIV(none, "div_cam0", "mout_cam0", DIV_GSCL, 16, 4),
>         DIV(none, "div_cam1", "mout_cam1", DIV_GSCL, 20, 4),
> @@ -313,19 +338,23 @@ struct samsung_div_clock exynos5250_div_clks[] __initdata = {
>  };
>
>  struct samsung_gate_clock exynos5250_gate_clks[] __initdata = {
> -       GATE(gscl0, "gscl0", "none", GATE_IP_GSCL, 0, 0, 0),
> -       GATE(gscl1, "gscl1", "none", GATE_IP_GSCL, 1, 0, 0),
> -       GATE(gscl2, "gscl2", "aclk266", GATE_IP_GSCL, 2, 0, 0),
> -       GATE(gscl3, "gscl3", "aclk266", GATE_IP_GSCL, 3, 0, 0),
> +       GATE(gscl0, "gscl0", "mout_sub_aclk266", GATE_IP_GSCL, 0, 0, 0),
> +       GATE(gscl1, "gscl1", "mout_sub_aclk266", GATE_IP_GSCL, 1, 0, 0),
> +       GATE(gscl2, "gscl2", "mout_sub_aclk266", GATE_IP_GSCL, 2, 0, 0),
> +       GATE(gscl3, "gscl3", "mout_sub_aclk266", GATE_IP_GSCL, 3, 0, 0),
>         GATE(gscl_wa, "gscl_wa", "div_gscl_wa", GATE_IP_GSCL, 5, 0, 0),
>         GATE(gscl_wb, "gscl_wb", "div_gscl_wb", GATE_IP_GSCL, 6, 0, 0),
> -       GATE(smmu_gscl0, "smmu_gscl0", "aclk266", GATE_IP_GSCL, 7, 0, 0),
> -       GATE(smmu_gscl1, "smmu_gscl1", "aclk266", GATE_IP_GSCL, 8, 0, 0),
> -       GATE(smmu_gscl2, "smmu_gscl2", "aclk266", GATE_IP_GSCL, 9, 0, 0),
> -       GATE(smmu_gscl3, "smmu_gscl3", "aclk266", GATE_IP_GSCL, 10, 0, 0),
> -       GATE(mfc, "mfc", "aclk333", GATE_IP_MFC, 0, 0, 0),
> -       GATE(smmu_mfcl, "smmu_mfcl", "aclk333", GATE_IP_MFC, 1, 0, 0),
> -       GATE(smmu_mfcr, "smmu_mfcr", "aclk333", GATE_IP_MFC, 2, 0, 0),
> +       GATE(smmu_gscl0, "smmu_gscl0", "mout_sub_aclk266",
> +                                               GATE_IP_GSCL, 7, 0, 0),
> +       GATE(smmu_gscl1, "smmu_gscl1", "mout_sub_aclk266",
> +                                               GATE_IP_GSCL, 8, 0, 0),
> +       GATE(smmu_gscl2, "smmu_gscl2", "mout_sub_aclk266",
> +                                               GATE_IP_GSCL, 9, 0, 0),
> +       GATE(smmu_gscl3, "smmu_gscl3", "mout_sub_aclk266",
> +                                               GATE_IP_GSCL, 10, 0, 0),
> +       GATE(mfc, "mfc", "mout_sub_aclk333", GATE_IP_MFC, 0, 0, 0),
> +       GATE(smmu_mfcl, "smmu_mfcl", "mout_sub_aclk333", GATE_IP_MFC, 1, 0, 0),
> +       GATE(smmu_mfcr, "smmu_mfcr", "mout_sub_aclk333", GATE_IP_MFC, 2, 0, 0),
>         GATE(rotator, "rotator", "aclk266", GATE_IP_GEN, 1, 0, 0),
>         GATE(jpeg, "jpeg", "aclk166", GATE_IP_GEN, 2, 0, 0),
>         GATE(mdma1, "mdma1", "aclk266", GATE_IP_GEN, 4, 0, 0),
> --
> 1.7.5.4
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
