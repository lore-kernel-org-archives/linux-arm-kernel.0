From: jinkun.hong@rock-chips.com (jinkun.hong)
Date: Wed, 22 Oct 2014 00:53:41 -0700
Subject: [PATCH v6 0/3] ARM: rk3288 : Add PM Domain support
Message-ID: <1413964424-7599-1-git-send-email-jinkun.hong@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "jinkun.hong" <jinkun.hong@rock-chips.com>

Add power domain drivers based on generic power domain for Rockchip platform,
and support RK3288.

https://chromium-review.googlesource.com/#/c/220253/9
This is the GPU driver, add the following information in DT,
and it can support the PMDOMAIN.

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
	power-domains = <&gpu_power>;
	status = "disabled";
};

Based on:
- [PATCH v1 1/4] PM / clock_ops: Add pm_clk_add_clk()
  http://www.mail-archive.com/linux-kernel at vger.kernel.org/msg735599.html

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
- change use pm_clk_resume() and pm_clk_suspend()
- DT structure has changed
- Decomposition power-controller, changed to multiple controller
   (gpu-power-controller, hevc-power-controller)

Changes in v2:
- remove the "pd->pd.of_node = np"
- move clocks to "optional"
- make pd_vio clocks all one entry per line and alphabetize.
- power: power-controller move back to pinctrl: pinctrl.

jinkun.hong (3):
  power-domain: add power domain drivers for Rockchip platform
  dt-bindings: add document of Rockchip power domain
  ARM: dts: add rk3288 power-domain node

 .../bindings/arm/rockchip/power_domain.txt         |   46 +++
 arch/arm/boot/dts/rk3288.dtsi                      |   24 ++
 arch/arm/mach-rockchip/Kconfig                     |    1 +
 arch/arm/mach-rockchip/Makefile                    |    1 +
 arch/arm/mach-rockchip/pm_domains.c                |  358 ++++++++++++++++++++
 5 files changed, 430 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/rockchip/power_domain.txt
 create mode 100644 arch/arm/mach-rockchip/pm_domains.c

-- 
1.7.9.5
