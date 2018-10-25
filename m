From: hal@halemmerich.com (Hal Emmerich)
Date: Thu, 25 Oct 2018 15:43:26 -0500
Subject: [BUG] clk: rockchip: rk3288: rockchip_mmc_get_phase: invalid clk rate
Message-ID: <c8030f3d-c579-650c-89d5-6227aacea346@halemmerich.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello everyone,

When booting a veyron-speedy device with the rk3288 and kernel 4.19 I get the following errors regarding the mmc and invalid clk rates:


[??? 0.000000] NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
[??? 0.000000] rockchip_mmc_get_phase: invalid clk rate
[??? 0.000000] rockchip_mmc_get_phase: invalid clk rate
[??? 0.000000] rockchip_mmc_get_phase: invalid clk rate
[??? 0.000000] rockchip_mmc_get_phase: invalid clk rate
[??? 0.000000] rockchip_mmc_get_phase: invalid clk rate
[??? 0.000000] rockchip_mmc_get_phase: invalid clk rate
[??? 0.000000] rockchip_mmc_get_phase: invalid clk rate
[??? 0.000000] rockchip_mmc_get_phase: invalid clk rate
[??? 0.000000] arch_timer: cp15 timer(s) running at 24.00MHz (phys).

commit c420c1e4db229a5d18faed4b58c01ef89027d5b7 added these error messages.

Adding a call to clk_hw_get_name reveals the clocks throwing these errors are:
sdmmc_drv
sdmmv_sample
sdio0_drv
sdio0_sample
sdio1_drv
sdio1_sample
emmc_drv
emmc_sample


Looking at the git logs, other platforms just need to change what closks the sdio and emmc used
in the respective clk-rk3XXX.c so I'm assuming something in this section of clk-rk3288.c is wrong:

??? COMPOSITE(SCLK_SDMMC, "sclk_sdmmc", mux_mmc_src_p, 0,
??? ??? ??? RK3288_CLKSEL_CON(11), 6, 2, MFLAGS, 0, 6, DFLAGS,
??? ??? ??? RK3288_CLKGATE_CON(13), 0, GFLAGS),
??? COMPOSITE(SCLK_SDIO0, "sclk_sdio0", mux_mmc_src_p, 0,
??? ??? ??? RK3288_CLKSEL_CON(12), 6, 2, MFLAGS, 0, 6, DFLAGS,
??? ??? ??? RK3288_CLKGATE_CON(13), 1, GFLAGS),
??? COMPOSITE(SCLK_SDIO1, "sclk_sdio1", mux_mmc_src_p, 0,
??? ??? ??? RK3288_CLKSEL_CON(34), 14, 2, MFLAGS, 8, 6, DFLAGS,
??? ??? ??? RK3288_CLKGATE_CON(13), 2, GFLAGS),
??? COMPOSITE(SCLK_EMMC, "sclk_emmc", mux_mmc_src_p, 0,
??? ??? ??? RK3288_CLKSEL_CON(12), 14, 2, MFLAGS, 8, 6, DFLAGS,
??? ??? ??? RK3288_CLKGATE_CON(13), 3, GFLAGS),

??? MMC(SCLK_SDMMC_DRV,??? "sdmmc_drv",??? "sclk_sdmmc", RK3288_SDMMC_CON0, 1),
??? MMC(SCLK_SDMMC_SAMPLE, "sdmmc_sample", "sclk_sdmmc", RK3288_SDMMC_CON1, 0),

??? MMC(SCLK_SDIO0_DRV,??? "sdio0_drv",??? "sclk_sdio0", RK3288_SDIO0_CON0, 1),
??? MMC(SCLK_SDIO0_SAMPLE, "sdio0_sample", "sclk_sdio0", RK3288_SDIO0_CON1, 0),

??? MMC(SCLK_SDIO1_DRV,??? "sdio1_drv",??? "sclk_sdio1", RK3288_SDIO1_CON0, 1),
??? MMC(SCLK_SDIO1_SAMPLE, "sdio1_sample", "sclk_sdio1", RK3288_SDIO1_CON1, 0),

??? MMC(SCLK_EMMC_DRV,???? "emmc_drv",???? "sclk_emmc",? RK3288_EMMC_CON0,? 1),
??? MMC(SCLK_EMMC_SAMPLE,? "emmc_sample",? "sclk_emmc",? RK3288_EMMC_CON1,? 0),

Should sclk_* be clk_*?

Thanks all.
