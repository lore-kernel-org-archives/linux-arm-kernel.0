From: gabriel.fernandez@linaro.org (Gabriel Fernandez)
Date: Wed, 16 Sep 2015 09:42:57 +0200
Subject: [RESEND PATCH 0/2] ST PLL fixes for 4.3-rc2
Message-ID: <1442389379-9298-1-git-send-email-gabriel.fernandez@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set fixes a kernel crash :

[    2.433152] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.2.0-rc7-next-20150821 #134
[    2.440713] Hardware name: STiH415/416 SoC with Flattened Device Tree
[    2.447173] [<c00183ac>] (unwind_backtrace) from [<c0013cac>] (show_stack+0x10/0x14)
[    2.454914] [<c0013cac>] (show_stack) from [<c0284f80>] (dump_stack+0x8c/0x9c)
[    2.462145] [<c0284f80>] (dump_stack) from [<c0283a54>] (Ldiv0+0x8/0x10)
[    2.468845] [<c0283a54>] (Ldiv0) from [<c0690e90>] (flexgen_round_rate+0x54/0x68)
[    2.476327] [<c0690e90>] (flexgen_round_rate) from [<c06791f4>] (clk_calc_new_rates+0x1bc/0x22c)
[    2.485109] [<c06791f4>] (clk_calc_new_rates) from [<c0679804>] (clk_core_set_rate_nolock+0x44/0xac)
[    2.494235] [<c0679804>] (clk_core_set_rate_nolock) from [<c0679890>] (clk_set_rate+0x24/0x34)
[    2.502845] [<c0679890>] (clk_set_rate) from [<c064f848>] (st_mmcss_cconfig+0x5c/0xfc)
[    2.510763] [<c064f848>] (st_mmcss_cconfig) from [<c064fab0>] (sdhci_st_probe+0xec/0x1fc)
[    2.518946] [<c064fab0>] (sdhci_st_probe) from [<c04334c8>] (platform_drv_probe+0x44/0xa4)
[    2.527209] [<c04334c8>] (platform_drv_probe) from [<c0431bf4>] (driver_probe_device+0x204/0x2f0)
[    2.536077] [<c0431bf4>] (driver_probe_device) from [<c0431d6c>] (__driver_attach+0x8c/0x90)
[    2.544510] [<c0431d6c>] (__driver_attach) from [<c0430098>] (bus_for_each_dev+0x68/0x9c)
[    2.552682] [<c0430098>] (bus_for_each_dev) from [<c0431320>] (bus_add_driver+0x19c/0x214)
[    2.560941] [<c0431320>] (bus_add_driver) from [<c0432574>] (driver_register+0x78/0xf8)
[    2.568941] [<c0432574>] (driver_register) from [<c000ab90>] (do_one_initcall+0x8c/0x1d4)
[    2.577115] [<c000ab90>] (do_one_initcall) from [<c0b98ddc>] (kernel_init_freeable+0x158/0x1f8)
[    2.585818] [<c0b98ddc>] (kernel_init_freeable) from [<c07b9350>] (kernel_init+0x8/0xe8)
[    2.593905] [<c07b9350>] (kernel_init) from [<c00108a8>] (ret_from_fork+0x14/0x2c)
[    2.601467] Division by zero in kernel.

This kernel crash is due to a broken compatibility with this commit:
commit 5eb26c605909 ("ARM: STi: DT: Rename st_pll3200c32_407_c0_x into st_pll3200c32_cx_x")

Gabriel Fernandez (2):
  dt-bindings: Fix tipo in st,clkgen-pll documentation
  drivers: clk: st: Rename st_pll3200c32_407_c0_x into
    st_pll3200c32_cx_x

 Documentation/devicetree/bindings/clock/st/st,clkgen-pll.txt |  4 ++--
 drivers/clk/st/clkgen-fsyn.c                                 |  8 ++++----
 drivers/clk/st/clkgen-pll.c                                  | 12 ++++++------
 3 files changed, 12 insertions(+), 12 deletions(-)

-- 
1.9.1
