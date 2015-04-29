From: tyler.baker@linaro.org (Tyler Baker)
Date: Wed, 29 Apr 2015 13:43:39 -0700
Subject: [PATCH] ARM: imx6: initialize CCM_CLPCR_LPM into RUN mode earlier
In-Reply-To: <1430287119-5268-1-git-send-email-shawn.guo@linaro.org>
References: <1430287119-5268-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <CANMBJr47q9uhdEFgogmdwwbLoFzkcX5SnN6oeaEEkXTnXq3PWg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 April 2015 at 22:58, Shawn Guo <shawn.guo@linaro.org> wrote:
> Commit 4631960d26da ("ARM: imx6: set initial power mode in pm function")
> moves imx6_set_lpm() from clock init function into
> imx6_pm_common_init().  This causes a hang when cpuidle support is
> enabled.  The reason for that is ARM core clock is shut down
> unexpectedly by WAIT mode.  It happens with the following call stack:
>
>     cpuidle_register_governor()
>         cpuidle_switch_governor()
>             cpuidle_uninstall_idle_handler()
>                 synchronize_sched()
>                     wait_rcu_gp()
>                         wait_for_completion()
>
> When wait_for_completion() is called as above, all cores are idle/WFI.
> Hence, the reset value of CCM_CLPCR_LPM - WAIT mode, will trigger a
> hardware shutdown of the ARM core clock.
>
> To fix the regression, we need to ensure that CCM_CLPCR_LPM is
> initialized into RUN mode earlier than cpuidle governor registration,
> which is a postcore_initcall.  This patch creates function
> imx6_pm_ccm_init() to map CCM block and initialize CCM_CLPCR_LPM into
> RUN mode, and have the function called from machine .init_irq hook,
> which should be early enough.
>
> Reported-by: Kevin Hilman <khilman@kernel.org>
> Fixes: 4631960d26da ("ARM: imx6: set initial power mode in pm function")
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Tested-by: Tyler Baker <tyler.baker@linaro.org>

I have applied this patch on top of next-20150429[1] and build/boot
tested it with the kernelci.org farm. With these results[2], I can
confirm the IMX6 boot regression reported is fixed by this patch.

> ---
>  arch/arm/mach-imx/common.h      |  1 +
>  arch/arm/mach-imx/mach-imx6q.c  |  1 +
>  arch/arm/mach-imx/mach-imx6sl.c |  1 +
>  arch/arm/mach-imx/mach-imx6sx.c |  1 +
>  arch/arm/mach-imx/pm-imx6.c     | 28 ++++++++++++++++++----------
>  5 files changed, 22 insertions(+), 10 deletions(-)
>
> diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
> index d1e2873f807e..fbd86f1b7f3b 100644
> --- a/arch/arm/mach-imx/common.h
> +++ b/arch/arm/mach-imx/common.h
> @@ -123,6 +123,7 @@ static inline void v7_cpu_resume(void) {}
>  static inline void imx6_suspend(void __iomem *ocram_vbase) {}
>  #endif
>
> +void imx6_pm_ccm_init(const char *ccm_compat);
>  void imx6q_pm_init(void);
>  void imx6dl_pm_init(void);
>  void imx6sl_pm_init(void);
> diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
> index 3ab61549ce0f..9602cc12d2f1 100644
> --- a/arch/arm/mach-imx/mach-imx6q.c
> +++ b/arch/arm/mach-imx/mach-imx6q.c
> @@ -393,6 +393,7 @@ static void __init imx6q_init_irq(void)
>         imx_init_l2cache();
>         imx_src_init();
>         irqchip_init();
> +       imx6_pm_ccm_init("fsl,imx6q-ccm");
>  }
>
>  static const char * const imx6q_dt_compat[] __initconst = {
> diff --git a/arch/arm/mach-imx/mach-imx6sl.c b/arch/arm/mach-imx/mach-imx6sl.c
> index 12a1b098fc6a..300326373166 100644
> --- a/arch/arm/mach-imx/mach-imx6sl.c
> +++ b/arch/arm/mach-imx/mach-imx6sl.c
> @@ -66,6 +66,7 @@ static void __init imx6sl_init_irq(void)
>         imx_init_l2cache();
>         imx_src_init();
>         irqchip_init();
> +       imx6_pm_ccm_init("fsl,imx6sl-ccm");
>  }
>
>  static const char * const imx6sl_dt_compat[] __initconst = {
> diff --git a/arch/arm/mach-imx/mach-imx6sx.c b/arch/arm/mach-imx/mach-imx6sx.c
> index f17b7004c24b..6a0b0614de29 100644
> --- a/arch/arm/mach-imx/mach-imx6sx.c
> +++ b/arch/arm/mach-imx/mach-imx6sx.c
> @@ -86,6 +86,7 @@ static void __init imx6sx_init_irq(void)
>         imx_init_l2cache();
>         imx_src_init();
>         irqchip_init();
> +       imx6_pm_ccm_init("fsl,imx6sx-ccm");
>  }
>
>  static void __init imx6sx_init_late(void)
> diff --git a/arch/arm/mach-imx/pm-imx6.c b/arch/arm/mach-imx/pm-imx6.c
> index 27bc80dab2d8..b01650d94f91 100644
> --- a/arch/arm/mach-imx/pm-imx6.c
> +++ b/arch/arm/mach-imx/pm-imx6.c
> @@ -89,7 +89,6 @@ struct imx6_pm_base {
>
>  struct imx6_pm_socdata {
>         u32 ddr_type;
> -       const char *ccm_compat;
>         const char *mmdc_compat;
>         const char *src_compat;
>         const char *iomuxc_compat;
> @@ -139,7 +138,6 @@ static const u32 imx6sx_mmdc_io_offset[] __initconst = {
>  };
>
>  static const struct imx6_pm_socdata imx6q_pm_data __initconst = {
> -       .ccm_compat = "fsl,imx6q-ccm",
>         .mmdc_compat = "fsl,imx6q-mmdc",
>         .src_compat = "fsl,imx6q-src",
>         .iomuxc_compat = "fsl,imx6q-iomuxc",
> @@ -149,7 +147,6 @@ static const struct imx6_pm_socdata imx6q_pm_data __initconst = {
>  };
>
>  static const struct imx6_pm_socdata imx6dl_pm_data __initconst = {
> -       .ccm_compat = "fsl,imx6q-ccm",
>         .mmdc_compat = "fsl,imx6q-mmdc",
>         .src_compat = "fsl,imx6q-src",
>         .iomuxc_compat = "fsl,imx6dl-iomuxc",
> @@ -159,7 +156,6 @@ static const struct imx6_pm_socdata imx6dl_pm_data __initconst = {
>  };
>
>  static const struct imx6_pm_socdata imx6sl_pm_data __initconst = {
> -       .ccm_compat = "fsl,imx6sl-ccm",
>         .mmdc_compat = "fsl,imx6sl-mmdc",
>         .src_compat = "fsl,imx6sl-src",
>         .iomuxc_compat = "fsl,imx6sl-iomuxc",
> @@ -169,7 +165,6 @@ static const struct imx6_pm_socdata imx6sl_pm_data __initconst = {
>  };
>
>  static const struct imx6_pm_socdata imx6sx_pm_data __initconst = {
> -       .ccm_compat = "fsl,imx6sx-ccm",
>         .mmdc_compat = "fsl,imx6sx-mmdc",
>         .src_compat = "fsl,imx6sx-src",
>         .iomuxc_compat = "fsl,imx6sx-iomuxc",
> @@ -553,16 +548,11 @@ put_node:
>  static void __init imx6_pm_common_init(const struct imx6_pm_socdata
>                                         *socdata)
>  {
> -       struct device_node *np;
>         struct regmap *gpr;
>         int ret;
>
> -       np = of_find_compatible_node(NULL, NULL, socdata->ccm_compat);
> -       ccm_base = of_iomap(np, 0);
>         WARN_ON(!ccm_base);
>
> -       imx6_set_lpm(WAIT_CLOCKED);
> -
>         if (IS_ENABLED(CONFIG_SUSPEND)) {
>                 ret = imx6q_suspend_init(socdata);
>                 if (ret)
> @@ -583,6 +573,24 @@ static void __init imx6_pm_common_init(const struct imx6_pm_socdata
>                                    IMX6Q_GPR1_GINT);
>  }
>
> +void __init imx6_pm_ccm_init(const char *ccm_compat)
> +{
> +       struct device_node *np;
> +       u32 val;
> +
> +       np = of_find_compatible_node(NULL, NULL, ccm_compat);
> +       ccm_base = of_iomap(np, 0);
> +       BUG_ON(!ccm_base);
> +
> +       /*
> +        * Initialize CCM_CLPCR_LPM into RUN mode to avoid ARM core
> +        * clock being shut down unexpectedly by WAIT mode.
> +        */
> +       val = readl_relaxed(ccm_base + CLPCR);
> +       val &= ~BM_CLPCR_LPM;
> +       writel_relaxed(val, ccm_base + CLPCR);
> +}
> +
>  void __init imx6q_pm_init(void)
>  {
>         imx6_pm_common_init(&imx6q_pm_data);
> --
> 1.9.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


Tyler

[1] https://github.com/EmbeddedAndroid/linux/commits/to-build
[2] http://kernelci.org/boot/all/job/tbaker/kernel/v4.1-rc1-1408-g21b224526cfd/
