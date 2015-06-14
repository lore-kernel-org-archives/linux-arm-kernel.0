From: wxt@rock-chips.com (Caesar Wang)
Date: Sun, 14 Jun 2015 13:13:35 +0800
Subject: [PATCH v15 0/4] ARM: rk3288: Add PM Domain support
Message-ID: <1434258820-26779-1-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add power domain drivers based on generic power domain for
Rockchip platform, and support RK3288.

Verified on url =
https://chromium.googlesource.com/chromiumos/third_party/kernel/+/v3.14

The following is the easy example.

vopb: vop at ff930000 {
    compatible = "rockchip,rk3288-vop";
    ...
    iommus = <&vopb_mmu>;
    power-domains = <&power RK3288_PD_VIO>;
    status = "disabled";
    ...
};

vopb_mmu: iommu at ff930300 {
    compatible = "rockchip,iommu";
    ...
    interrupt-names = "vopb_mmu";
    power-domains = <&power RK3288_PD_VIO>;
    #iommu-cells = <0>;
    status = "disabled";
    ...
};

vopl: vop at ff940000 {
    compatible = "rockchip,rk3288-vop";
    reg = <0xff940000 0x19c>;
    ...
    iommus = <&vopl_mmu>;
    power-domains = <&power RK3288_PD_VIO>;
    status = "disabled";
    ...
};

vopl_mmu: iommu at ff940300 {
    compatible = "rockchip,iommu";
    ...
    interrupt-names = "vopl_mmu";
    power-domains = <&power RK3288_PD_VIO>;
    #iommu-cells = <0>;
    status = "disabled";
};

There is a recent addition from Linus Walleij,
called simple-mfd [a] that is supposed to get added real early for kernel 4.2

[a]:
https://git.kernel.org/cgit/linux/kernel/git/linusw/linux-integrator.git/commit/?h=simple-mfd&id=fcf294c020ff7ee4e3b1e96159e4dc7a17ad59d1

Here is my branch:

9c402ee ARM: dts: add RK3288 power-domain node
b1469c4 power-domain: rockchip: add power domain driver
ce13318 ARM: power-domain: rockchip: add the support type for the rk3288
9824091 dt-bindings: add document of Rockchip power domain
0ff0e5b MFD/OF: document MFD devices and handle simple-mfd
2bfc60d Merge tag 'misc-for-linus-4.1-rc8' of git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging
...

Note:

Sorry for long no any update.

As I known, there are somethings needed to do.
(1) about all the device clocks being listed in the power-domains itself,
Someone wish was to get the clocks by reading the clocks from the device nodes,

Perhaps, this series patchs are hard to be accepted or need to do more
can be accepted.

At the moment, I send the patch v15 to discuss the issue, This patch no
any sloved the pervious issue.


Changes in v15:
- change the comment.
- As the kevin suggestion, put the power-doamin driver into driver/soc/vendor.
- As Heiko suggestion, Patch 1: binding doc, 2: binding-header, 3: driver,
  4: dts-changes.
- return -ENXIO --> return -ENODEV.
Series-changes: 14
- does not need to set an owner,remove the "THIS_MODULE".
Series-changes: 13
- Remove essential clocks from rk3288 PD_VIO domain Some clocks are essential
  for the system health and should not be turned down. However there is no owner
  for them so if they listed as belonging to power domain we'll try toggling them
  up and down during power domain.
- Device drivers expect their devices to be powered on before their
  probing code is invoked. To achieve that we should start with
  power domains powered on (we may turn them off later once all devices enable
  runtime powermanagment and go idle).
- This change switches Rockchip power domain driver to use updated
  device_attach and device_detach API.
- set the gpu/core power domain power delay time.
- fix enumerating PM clocks for devices.
- fix use after free We can't use clk after we did clk_put(clk).
Series-changes: 12
- fix the title doamin->domain.
- updated device_attach and device_detach API,otherwise it will
  compile fail on next kernel.
Series-changes: 11
- fix pm_genpd_init(&pd->genpd, NULL, false).
Series-changes: 10
- this switches over domain infos to use masks instead of recomputing
  them each time and also gets rid of custom domain translator and
  uses standard onecell on.
Series-changes: 9
- fix v8 changes as follows:
- This reconciles the v2 and v7 code so that we power domain have lists of clocks
  they trigger on and off during power transitions and independently from power
  domains clocks. We attach clocks to devices comprising power domain and prepare
  them so they are turn on and off by runtime PM.
- add rockchip_pm_add_one_domain() to control domains.
- add pd_start/pd_stop interface to control clocks.
Series-changes: 8
- This reconciles the v2 and v7 code so that we power domain have
  lists of clocks they toggle on and off during power transitions
  and independently from power domains clocks we attach clocks to
  devices comprising power domain and prepare them so they are
  turn on and off by runtime PM.
Series-changes: 7
 - Delete unused variables
Series-changes: 6
- delete pmu_lock.
- modify dev_lock using mutex.
- pm_clk_resume(pd->dev) change to pm_clk_resume(ed->dev).
- pm_clk_suspend(pd->dev) change to pm_clk_suspend(ed->dev).
- add devm_kfree(pd->dev, de) in rockchip_pm_domain_detach_dev.
Series-changes: 5
- delete idle_lock.
- add timeout in rockchip_pmu_set_idle_request().
Series-changes: 4
- use list storage dev.
Series-changes: 3
- change use pm_clk_resume() and pm_clk_suspend().
Series-changes: 2
- remove the "pd->pd.of_node = np".
- As Tomasz remarked previously the dts should represent the hardware
  and the power-domains are part of the pmu.
Series-changes: 12
- Remove essential clocks from rk3288 PD_VIO domain, Some clocks are
  essential for the system health and should not be turned down.
  However there is no owner for them so if they listed as belonging to power
  domain we'll try toggling them up and down during power domain transition.
  As a result we either fail to suspend or resume the system.
Series-changes: 10
- fix missing the #include <dt-bindings/power-domain/rk3288.h>.
- remove the notes.
Series-changes: 9
- add decription for power-doamin node.
Series-changes: 8
- DTS go back to v2.
Series-changes: 3
- Decomposition power-controller, changed to multiple controller
  (gpu-power-controller, hevc-power-controller).
Series-changes: 2
- make pd_vio clocks all one entry per line and alphabetize.
- power: power-controller move back to pinctrl: pinctrl.

Changes in v9:
- add document decription.
Series-changes:8
- document go back to v2.
Series-changes:3
- DT structure has changed.
Series-changes:2
- move clocks to "optional".

Caesar Wang (4):
  dt-bindings: add document of Rockchip power domain
  ARM: power-domain: rockchip: add the support type on RK3288
  soc: rockchip: power-domain: add power domain driver
  ARM: dts: add RK3288 power-domain node

 .../bindings/soc/rockchip/power_domain.txt         |  48 ++
 arch/arm/boot/dts/rk3288.dtsi                      |  62 +++
 drivers/soc/Kconfig                                |   1 +
 drivers/soc/Makefile                               |   1 +
 drivers/soc/rockchip/Kconfig                       |  13 +
 drivers/soc/rockchip/Makefile                      |   4 +
 drivers/soc/rockchip/pm_domains.c                  | 506 +++++++++++++++++++++
 include/dt-bindings/power-domain/rk3288.h          |  11 +
 8 files changed, 646 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
 create mode 100644 drivers/soc/rockchip/Kconfig
 create mode 100644 drivers/soc/rockchip/Makefile
 create mode 100644 drivers/soc/rockchip/pm_domains.c
 create mode 100644 include/dt-bindings/power-domain/rk3288.h

-- 
1.9.1
