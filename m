From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Sat, 10 May 2014 12:39:52 +0900
Subject: [PATCH 0/4] Add framework to support clkout
In-Reply-To: <1399640410-30957-1-git-send-email-tushar.behera@linaro.org>
References: <1399640410-30957-1-git-send-email-tushar.behera@linaro.org>
Message-ID: <536D9F88.9000505@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tushar,

On 05/09/2014 10:00 PM, Tushar Behera wrote:
> The MUX/GATE register for XCLKOUT doesn't resides within PMU domain,
> this can be accessed through a regmap provided by syscon driver. Adding
> another clock provider to handle regmap based handing of XCLKOUT.
>
> Dependency:
> 1. [PATCH v3] mfd: syscon: Support early initialization
> http://article.gmane.org/gmane.linux.kernel/1679446
>
> Also we need to find a suitable place to call early_syscon_init(), after
> the device tree has been unflattened and before clock initialization.
>
> While testing, I called this before of_clk_init() in arch/arm/kernel/time.c,
> but that place is too generic. Calling anywhere from exynos.c is not
> working ATM.

IMO we do not need to, or if I am not wrong we should not change time.c.

It's possible if we have exynos specific init_time with following changes.
FYI, In my patch series for Exynos PMU [1], currently I am handling this in
exynos_dt_machine_init. But definitely it can be handled as below and it works
without any side effect and I have tested it. Only reason I do not adopted this
as for Exynos PMU patch support I had other options. But if required and if
following change is acceptable I can include this in my next version of Exynos
PMU patch series.

[1]: https://lkml.org/lkml/2014/4/30/18


+static void __init exynos_init_time(void)
+{
+    /* Nothing to do timer specific
+     * as early_syscon_init requires DT to be unflattened and
+     * system should be able to allocate memory we need to
+     * postpone until init_time, but it should be done before
+     * init_machine. Because before init_machine, secondary
+     * core boot starts and it uses PMU registers.
+     */
+
+    exynos_map_pmu();
+
+    of_clk_init(NULL);
+    clocksource_of_init();
+
+}
+
  DT_MACHINE_START(EXYNOS_DT, "SAMSUNG EXYNOS (Flattened Device Tree)")
      /* Maintainer: Thomas Abraham <thomas.abraham@linaro.org> */
      /* Maintainer: Kukjin Kim <kgene.kim@samsung.com> */
      .smp        = smp_ops(exynos_smp_ops),
      .map_io        = exynos_init_io,
      .init_early    = exynos_firmware_init,
+    .init_time    = exynos_init_time,

>
> Tushar Behera (4):
>    clk: samsung: out: Add infrastructure to register CLKOUT
>    clk: samsung: exynos5420: Add xclkout debug clock
>    clk: samsung: exynos5250: Add xclkout debug clock
>    ARM: dts: Add pmu-syscon handle for Exynos5420/Exynos5250 clock
>
>   arch/arm/boot/dts/exynos5250.dtsi      |    1 +
>   arch/arm/boot/dts/exynos5420.dtsi      |    1 +
>   drivers/clk/samsung/Makefile           |    2 +-
>   drivers/clk/samsung/clk-exynos5250.c   |   14 +++
>   drivers/clk/samsung/clk-exynos5420.c   |   14 +++
>   drivers/clk/samsung/clk-out.c          |  181 ++++++++++++++++++++++++++++++++
>   drivers/clk/samsung/clk.h              |   33 ++++++
>   include/dt-bindings/clock/exynos5250.h |    3 +
>   include/dt-bindings/clock/exynos5420.h |    5 +-
>   9 files changed, 252 insertions(+), 2 deletions(-)
>   create mode 100644 drivers/clk/samsung/clk-out.c
>


-- 
Best Regards,
Pankaj Dubey
