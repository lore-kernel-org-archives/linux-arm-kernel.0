From: kgene@kernel.org (Kukjin Kim)
Date: Wed, 24 Jul 2013 21:13:38 +0900
Subject: [RESEND PATCH 1/3] ARM: EXYNOS: Move arm core power down clock to
 exynos5250 common clock
In-Reply-To: <CADGdYn5owUyCMzJSJQgzR6N0inLpm5Te09BvX0rvBZ1bx=bv=Q@mail.gmail.com>
References: <1363240979-1939-2-git-send-email-amit.daniel@samsung.com>
 <1370501833-9196-1-git-send-email-amit.daniel@samsung.com>
 <CADGdYn5owUyCMzJSJQgzR6N0inLpm5Te09BvX0rvBZ1bx=bv=Q@mail.gmail.com>
Message-ID: <0eb301ce8867$3b12f430$b138dc90$@org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

amit daniel kachhap wrote:
> 
> Hi Mike,
> 
> If possible please ack this patch or merge this via your tree.
> 
> Thanks,
> Amit Daniel
> 
> On Thu, Jun 6, 2013 at 12:27 PM, Amit Daniel Kachhap
> <amit.daniel@samsung.com> wrote:
> > Now with common clock support added for exynos5250 it is necessary to
> move
> > this code to exynos5250 common clock driver as clock registers should be
> > handled there. This change is tested in exynos5250 based arndale
> platform.
> >
> > Cc: Abhilash Kesavan <a.kesavan@samsung.com>
> > Cc: Thomas Abraham <thomas.abraham@linaro.org>
> > Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>

Acked-by: Kukjin Kim <kgene.kim@samsung.com>

Mike, if you have any concerns on this, please let me know.

Thanks,
Kukjin

> > ---
> > Re-based against linux for-next branch.
> >
> >  arch/arm/mach-exynos/cpuidle.c       |   35
----------------------------
> >  drivers/clk/samsung/clk-exynos5250.c |   42
> ++++++++++++++++++++++++++++++++++
> >  2 files changed, 42 insertions(+), 35 deletions(-)
> >
> > diff --git a/arch/arm/mach-exynos/cpuidle.c b/arch/arm/mach-
> exynos/cpuidle.c
> > index 17a18ff..4667907 100644
> > --- a/arch/arm/mach-exynos/cpuidle.c
> > +++ b/arch/arm/mach-exynos/cpuidle.c
> > @@ -159,46 +159,11 @@ static int exynos4_enter_lowpower(struct
> cpuidle_device *dev,
> >                 return exynos4_enter_core0_aftr(dev, drv, new_index);
> >  }
> >
> > -static void __init exynos5_core_down_clk(void)
> > -{
> > -       unsigned int tmp;
> > -
> > -       /*
> > -        * Enable arm clock down (in idle) and set arm divider
> > -        * ratios in WFI/WFE state.
> > -        */
> > -       tmp = PWR_CTRL1_CORE2_DOWN_RATIO | \
> > -             PWR_CTRL1_CORE1_DOWN_RATIO | \
> > -             PWR_CTRL1_DIV2_DOWN_EN     | \
> > -             PWR_CTRL1_DIV1_DOWN_EN     | \
> > -             PWR_CTRL1_USE_CORE1_WFE    | \
> > -             PWR_CTRL1_USE_CORE0_WFE    | \
> > -             PWR_CTRL1_USE_CORE1_WFI    | \
> > -             PWR_CTRL1_USE_CORE0_WFI;
> > -       __raw_writel(tmp, EXYNOS5_PWR_CTRL1);
> > -
> > -       /*
> > -        * Enable arm clock up (on exiting idle). Set arm divider
> > -        * ratios when not in idle along with the standby duration
> > -        * ratios.
> > -        */
> > -       tmp = PWR_CTRL2_DIV2_UP_EN       | \
> > -             PWR_CTRL2_DIV1_UP_EN       | \
> > -             PWR_CTRL2_DUR_STANDBY2_VAL | \
> > -             PWR_CTRL2_DUR_STANDBY1_VAL | \
> > -             PWR_CTRL2_CORE2_UP_RATIO   | \
> > -             PWR_CTRL2_CORE1_UP_RATIO;
> > -       __raw_writel(tmp, EXYNOS5_PWR_CTRL2);
> > -}
> > -
> >  static int __init exynos4_init_cpuidle(void)
> >  {
> >         int cpu_id, ret;
> >         struct cpuidle_device *device;
> >
> > -       if (soc_is_exynos5250())
> > -               exynos5_core_down_clk();
> > -
> >         ret = cpuidle_register_driver(&exynos4_idle_driver);
> >         if (ret) {
> >                 printk(KERN_ERR "CPUidle failed to register driver\n");
> > diff --git a/drivers/clk/samsung/clk-exynos5250.c
> b/drivers/clk/samsung/clk-exynos5250.c
> > index 5c97e75..89f51e9 100644
> > --- a/drivers/clk/samsung/clk-exynos5250.c
> > +++ b/drivers/clk/samsung/clk-exynos5250.c
> > @@ -21,6 +21,8 @@
> >
> >  #define SRC_CPU                        0x200
> >  #define DIV_CPU0               0x500
> > +#define PWR_CTRL1              0x1020
> > +#define PWR_CTRL2              0x1024
> >  #define SRC_CORE1              0x4204
> >  #define SRC_TOP0               0x10210
> >  #define SRC_TOP2               0x10218
> > @@ -63,6 +65,23 @@
> >  #define PLL_DIV2_SEL           0x20a24
> >  #define GATE_IP_DISP1          0x10928
> >
> > +/*Below definitions are used for PWR_CTRL settings*/
> > +#define PWR_CTRL1_CORE2_DOWN_RATIO             (7 << 28)
> > +#define PWR_CTRL1_CORE1_DOWN_RATIO             (7 << 16)
> > +#define PWR_CTRL1_DIV2_DOWN_EN                 (1 << 9)
> > +#define PWR_CTRL1_DIV1_DOWN_EN                 (1 << 8)
> > +#define PWR_CTRL1_USE_CORE1_WFE                        (1 << 5)
> > +#define PWR_CTRL1_USE_CORE0_WFE                        (1 << 4)
> > +#define PWR_CTRL1_USE_CORE1_WFI                        (1 << 1)
> > +#define PWR_CTRL1_USE_CORE0_WFI                        (1 << 0)
> > +
> > +#define PWR_CTRL2_DIV2_UP_EN                   (1 << 25)
> > +#define PWR_CTRL2_DIV1_UP_EN                   (1 << 24)
> > +#define PWR_CTRL2_DUR_STANDBY2_VAL             (1 << 16)
> > +#define PWR_CTRL2_DUR_STANDBY1_VAL             (1 << 8)
> > +#define PWR_CTRL2_CORE2_UP_RATIO               (1 << 4)
> > +#define PWR_CTRL2_CORE1_UP_RATIO               (1 << 0)
> > +
> >  /*
> >   * Let each supported clock get a unique id. This id is used to lookup
> the clock
> >   * for device tree based platforms. The clocks are categorized into
> three
> > @@ -110,6 +129,8 @@ enum exynos5250_clks {
> >  static __initdata unsigned long exynos5250_clk_regs[] = {
> >         SRC_CPU,
> >         DIV_CPU0,
> > +       PWR_CTRL1,
> > +       PWR_CTRL2,
> >         SRC_CORE1,
> >         SRC_TOP0,
> >         SRC_TOP2,
> > @@ -474,6 +495,7 @@ void __init exynos5250_clk_init(struct device_node
> *np)
> >  {
> >         void __iomem *reg_base;
> >         struct clk *apll, *mpll, *epll, *vpll, *bpll, *gpll, *cpll;
> > +       unsigned int tmp;
> >
> >         if (np) {
> >                 reg_base = of_iomap(np, 0);
> > @@ -516,6 +538,26 @@ void __init exynos5250_clk_init(struct device_node
> *np)
> >         samsung_clk_register_gate(exynos5250_gate_clks,
> >                         ARRAY_SIZE(exynos5250_gate_clks));
> >
> > +       /*
> > +        * Enable arm clock down (in idle) and set arm divider
> > +        * ratios in WFI/WFE state.
> > +        */
> > +       tmp = (PWR_CTRL1_CORE2_DOWN_RATIO | PWR_CTRL1_CORE1_DOWN_RATIO |
> > +               PWR_CTRL1_DIV2_DOWN_EN | PWR_CTRL1_DIV1_DOWN_EN |
> > +               PWR_CTRL1_USE_CORE1_WFE | PWR_CTRL1_USE_CORE0_WFE |
> > +               PWR_CTRL1_USE_CORE1_WFI | PWR_CTRL1_USE_CORE0_WFI);
> > +       __raw_writel(tmp, reg_base + PWR_CTRL1);
> > +
> > +       /*
> > +        * Enable arm clock up (on exiting idle). Set arm divider
> > +        * ratios when not in idle along with the standby duration
> > +        * ratios.
> > +        */
> > +       tmp = (PWR_CTRL2_DIV2_UP_EN | PWR_CTRL2_DIV1_UP_EN |
> > +               PWR_CTRL2_DUR_STANDBY2_VAL | PWR_CTRL2_DUR_STANDBY1_VAL
|
> > +               PWR_CTRL2_CORE2_UP_RATIO | PWR_CTRL2_CORE1_UP_RATIO);
> > +       __raw_writel(tmp, reg_base + PWR_CTRL2);
> > +
> >         pr_info("Exynos5250: clock setup completed, armclk=%ld\n",
> >                         _get_rate("armclk"));
> >  }
> > --
> > 1.7.1
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-samsung-
> soc" in
> > the body of a message to majordomo at vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
