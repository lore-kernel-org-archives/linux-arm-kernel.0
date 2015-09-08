From: wxt@rock-chips.com (Caesar Wang)
Date: Tue,  8 Sep 2015 14:18:19 +0800
Subject: [PATCH v18 0/4] ARM: rk3288: Add PM Domain support
Message-ID: <1441693103-26712-1-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thank you all for providing inputs and comments on previous versions of
this patchset.
Especially thanks to the (Kevin, Heiko, Dmitry, Doug, ULF, Michael....).

Add power domain drivers based on generic power domain for
Rockchip platform, and support RK3288 SoCs.

Verified on url =
    https://chromium.googlesource.com/chromiumos/third_party/kernel/+/v3.14
    localhost / # cat /sys/kernel/debug/pm_genpd/pm_genpd_summary
    domain                      status         slaves
    /device                      runtime        status
    ----------------------------------------------------------------------
    pd_video                        off
    /devices/ff9a0800.iommu                     suspended
    /devices/ff9a0000.video-codec               suspended
    pd_vio                          on
    /devices/ff930300.iommu                     suspended
    /devices/ff940300.iommu                     suspended
    /devices/ff930000.vop                       suspended
    /devices/ff940000.vop                       suspended
    /devices/ff980000.hdmi                      unsupported
    /devices/rockchip-edp                       unsupported
    pd_hevc                         off
    pd_gpu                          off
    /devices/ffa30000.gpu                       suspended

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

    Others, we can verify this driver for the EDP.
    We can apply the following these patchs.

    6967631 New          [v2,1/8] drm: exynos/dp: fix code style
    6967741 New          [v2,2/8] drm: exynos/dp: convert to drm bridge mode
    6967801 New          [v2,3/8] drm: bridge: analogix_dp: split exynos dp driver to bridge dir
    6967791 New          [v2,4/8] drm: rockchip/dp: add rockchip platform dp driver
    6968031 New          [v2,5/8] drm: bridge/analogix_dp: add platform device type support
    6968141 New          [v2,6/8] drm: bridge: analogix_dp: add some rk3288 special registers setting
    6967941 New          [v2,7/8] drm: bridge: analogix_dp: try force hpd after plug in lookup failed
    6967971 New          [v2,8/8] drm: bridge/analogix_dp: expand the delay time for hpd detect

    There is a recent addition from Linus Walleij,
    called simple-mfd [a] that is supposed to get added real early for kernel 4.2

    [a]:
    https://git.kernel.org/cgit/linux/kernel/git/linusw/linux-integrator.git/commit/?id=fcf294c020ff7ee4e3b1e96159e4dc7a17ad5

    Here is my branch, Tested by chromeos-3.14 and next-kernel.

    e81a4d2 ARM: dts: add the support power-domain node on RK3288 SoCs
    38eec06 soc: rockchip: power-domain: Add power domain driver
    086d4f3 ARM: power-domain: rockchip: add all the domain type on RK3288 SoCs
    498fd14 dt-bindings: add document of Rockchip power domains
    4e4adb2 Merge tag 'nfs-for-4.3-1' of git://git.linux-nfs.org/projects/trondmy/linux-nfs
    77a7880 Merge tag 'xfs-for-linus-4.3' of git://git.kernel.org/pub/scm/linux/kernel/git/dgc/linux-xfs
    5445b1f NFSv4: Respect the server imposed limit on how many changes we may cache
    7d160a6 NFSv4: Express delegation limit in units of pages
    7d9071a Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs
    bd77966 Merge tag 'for-linus-4.3-merge-window-part-1' of git://git.kernel.org/pub/scm/linux/kernel/git/ericvh/v9fs
    9cfcc65 Merge tag 'media/v4.3-1' of git://git.kernel.org/pub/scm/li
    ......


Changes in v18:
- remove the notes of domains from dt-binding.
- As Kevin suggestion, set pd->num_clks = 0 in
  rockchip_pm_remove_one_domain() ans add the mutex for protect
- assign the order in rk3288_pm_domains[] in pm-domain driver.
- Change the index order in the dts on PATCH [4/4] .
- Add some notes for domains in the dts on PATCH [4/4].

Changes in v17:
- add the decription in detail for RK3288 SoCs.
- delete the ugly chart in the commit.
- (re)defining config for ROCKCHIP.
- remove clocks of the HDMI ctrl.
- update the description.
- add Reviewed-by: Michale.

Changes in v16:
- remove the pmu node.
- Add more domain decription.
- the driver type from tristate to bool.
- Letter misspelled.
- As Ulf suggestion, remove #include <linux/clk-provider.h>,
  use "%pC" as the formatting string for the dev_dbg().
- As the Ulf suggestion, set the genpd->flags to assign the
  ->stop|start() callbacks.
- Manually copy the problem in patch v15.
- rebase the description.

Changes in v15:
- change the comment.
- As the kevin suggestion, put the power-domain driver into driver/soc/vendor.
- As Heiko suggestion, Patch 1: binding doc, 2: binding-header, 3: driver,
  4: dts-changes.
- return -ENXIO --> return -ENODEV.
- As Tomasz remarked previously the dts should represent the hardware
  and the power-domains are part of the pmu.

Changes in v14:
- does not need to set an owner,remove the "THIS_MODULE".
- Remove essential clocks from rk3288 PD_VIO domain, Some clocks are
  essential for the system health and should not be turned down.
  However there is no owner for them so if they listed as belonging to power
  domain we'll try toggling them up and down during power domain transition.
  As a result we either fail to suspend or resume the system.

Changes in v13:
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

Changes in v12:
- fix the title doamin->domain.
- updated device_attach and device_detach API,otherwise it will
  compile fail on next kernel.

Changes in v11:
- fix pm_genpd_init(&pd->genpd, NULL, false).

Changes in v10:
- this switches over domain infos to use masks instead of recomputing
  them each time and also gets rid of custom domain translator and
  uses standard onecell on.
- fix missing the #include <dt-bindings/power-domain/rk3288.h>.
- remove the notes.

Changes in v9:
- add document decription.
- fix v8 changes as follows:
- This reconciles the v2 and v7 code so that we power domain have lists of clocks
  they trigger on and off during power transitions and independently from power
  domains clocks. We attach clocks to devices comprising power domain and prepare
  them so they are turn on and off by runtime PM.
- add rockchip_pm_add_one_domain() to control domains.
- add pd_start/pd_stop interface to control clocks.
- add decription for power-doamin node.

Changes in v8:
- document go back to v2.
- This reconciles the v2 and v7 code so that we power domain have
  lists of clocks they toggle on and off during power transitions
  and independently from power domains clocks we attach clocks to
  devices comprising power domain and prepare them so they are
  turn on and off by runtime PM.
- DTS go back to v2.

Changes in v7:
 - Delete unused variables

Changes in v6:
- delete pmu_lock.
- modify dev_lock using mutex.
- pm_clk_resume(pd->dev) change to pm_clk_resume(ed->dev).
- pm_clk_suspend(pd->dev) change to pm_clk_suspend(ed->dev).
- add devm_kfree(pd->dev, de) in rockchip_pm_domain_detach_dev.

Changes in v5:
- delete idle_lock.
- add timeout in rockchip_pmu_set_idle_request().

Changes in v4:
- use list storage dev.

Changes in v3:
- DT structure has changed.
- change use pm_clk_resume() and pm_clk_suspend().
- Decomposition power-controller, changed to multiple controller
  (gpu-power-controller, hevc-power-controller).

Changes in v2:
- move clocks to "optional".
- remove the "pd->pd.of_node = np".
- make pd_vio clocks all one entry per line and alphabetize.
- power: power-controller move back to pinctrl: pinctrl.

Caesar Wang (4):
  dt-bindings: add document of Rockchip power domains
  ARM: power-domain: rockchip: add all the domain type on RK3288 SoCs
  soc: rockchip: power-domain: Add power domain driver
  ARM: dts: add the support power-domain node on RK3288 SoCs

 .../bindings/soc/rockchip/power_domain.txt         |  46 ++
 arch/arm/boot/dts/rk3288.dtsi                      |  93 +++-
 drivers/soc/Kconfig                                |   1 +
 drivers/soc/Makefile                               |   1 +
 drivers/soc/rockchip/Kconfig                       |  14 +
 drivers/soc/rockchip/Makefile                      |   4 +
 drivers/soc/rockchip/pm_domains.c                  | 490 +++++++++++++++++++++
 include/dt-bindings/power-domain/rk3288.h          |  31 ++
 8 files changed, 679 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
 create mode 100644 drivers/soc/rockchip/Kconfig
 create mode 100644 drivers/soc/rockchip/Makefile
 create mode 100644 drivers/soc/rockchip/pm_domains.c
 create mode 100644 include/dt-bindings/power-domain/rk3288.h

-- 
1.9.1
