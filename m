From: caesar.wang@rock-chips.com (Caesar Wang)
Date: Mon, 17 Nov 2014 17:35:51 +0800
Subject: [PATCH v12 0/3] ARM: rk3288: Add PM Domain support
Message-ID: <1416216954-24488-1-git-send-email-caesar.wang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

    Add power domain drivers based on generic power domain for
    Rockchip platform, and support RK3288.

    https://chromium-review.googlesource.com/#/c/220253/9
    This is the GPU driver, add the following information in DT,
    and it can support the PMDOMAIN

gpu: gpu at ffa30000 {
    compatible = "arm,malit764",
                 "arm,malit76x",
                 "arm,malit7xx",
                 "arm,mali-midgard";
    reg = <0xffa30000 0x10000>;
    interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
                 <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
                 <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
    interrupt-names = "JOB", "MMU", "GPU";
    clocks = <&cru ACLK_GPU>;
    clock-names = "aclk_gpu";
    operating-points = <
                /* KHz uV */
                100000 800000
                200000 850000
                300000 950000
                400000 1000000
                600000 1150000
    >;
    power-domains = <&power RK3288_PD_GPU>;
    status = "disabled";
};

Based on:
    - [PATCH v4 1/3] PM / clock_ops: Add pm_clk_add_clk()
    http://patchwork.kernel.org/patch/5242121/

Changes in v12:
    - fix the title doamin->domain.
    - updated device_attach and device_detach API,otherwise it will compile
      fail on next kernel.
    - Remove essential clocks from rk3288 PD_VIO domain,
      Some clocks are essential for the system health and should not be
      turned down. However there is no owner for them so if they listed as
      belonging to power domain we'll try toggling them up and down during
      power domain transition. As a result we either fail to suspend or resume
      the system.

Changes in v11:
    - fix pm_genpd_init(&pd->genpd, NULL, false);

Changes in v10:
    - this switches over domain infos to use masks instead of recomputing
      them each time and also gets rid of custom domain translator and
      uses standard onecell on.
    - fix missing the #include <dt-bindings/power-domain/rk3288.h>
    - remove the notes

Changes in v9:
    - add document decription
    - fix v8 changes as follows:
    - This reconciles the v2 and v7 code so that we power domain have
      lists of clocks they toggle on and off during power transitions and
      independently from power domains clocks we attach clocks to devices
      comprising power domain and prepare them so they are turn on and off
      by runtime PM.
    - add rockchip_pm_add_one_domain() to control domains.
    - add pd_start/pd_stop interface to control clocks
    - add decription for power-doamin node

Changes in v8:
    - document go back to v2
    - This reconciles the v2 and v7 code so that we power domain have
      lists of clocks they toggle on and off during power transitions and
      independently from power domains clocks we attach clocks to devices
      comprising power domain and prepare them so they are turn on and off
      by runtime PM.
    - DTS go back to v2

Changes in v7:
    - Delete unused variables

Changes in v6:
    - delete pmu_lock
    - modify dev_lock using mutex
    - pm_clk_resume(pd->dev) change to pm_clk_resume(ed->dev)
    - pm_clk_suspend(pd->dev) change to pm_clk_suspend(ed->dev)
    - add devm_kfree(pd->dev, de) in rockchip_pm_domain_detach_dev

Changes in v5:
    - delete idle_lock
    - add timeout in rockchip_pmu_set_idle_request()

Changes in v4:
    - use list storage dev

Changes in v3:
    - DT structure has changed
    - change use pm_clk_resume() and pm_clk_suspend()
    - Decomposition power-controller, changed to multiple controller
    (gpu-power-controller, hevc-power-controller)

Changes in v2:
    - move clocks to "optional"
    - remove the "pd->pd.of_node = np"
    - make pd_vio clocks all one entry per line and alphabetize.
    - power: power-controller move back to pinctrl: pinctrl.

Caesar Wang (3):
  dt-bindings: add document of Rockchip power domain
  power-domain: rockchip: add power domain driver
  ARM: dts: add rk3288 power-domain node

 .../bindings/arm/rockchip/power_domain.txt         |  48 +++
 arch/arm/boot/dts/rk3288.dtsi                      |  59 +++
 arch/arm/mach-rockchip/Kconfig                     |   1 +
 arch/arm/mach-rockchip/Makefile                    |   1 +
 arch/arm/mach-rockchip/pm_domains.c                | 472 +++++++++++++++++++++
 include/dt-bindings/power-domain/rk3288.h          |  11 +
 6 files changed, 592 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/rockchip/power_domain.txt
 create mode 100644 arch/arm/mach-rockchip/pm_domains.c
 create mode 100644 include/dt-bindings/power-domain/rk3288.h

-- 
1.9.1
