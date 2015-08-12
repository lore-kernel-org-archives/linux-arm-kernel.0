From: wxt@rock-chips.com (Caesar Wang)
Date: Wed, 12 Aug 2015 12:42:28 +0800
Subject: [PATCH v16 0/4] ARM: rk3288: Add PM Domain support
Message-ID: <1439354552-20098-1-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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
https://git.kernel.org/cgit/linux/kernel/git/linusw/linux-integrator.git/commit/?h=simple-mfd&id=fcf294c020ff7ee4e3b1e96159e4dc7a17ad59d1

Here is my branch, Tested by chromeos-3.14 and next-kernel.

2b82899 ARM: dts: add RK3288 power-domain node
69d0b5b soc: rockchip: power-domain: support power domain driver for
RK3288 SoCs
66f8758 ARM: power-domain: rockchip: add all the domain type on RK3288
SoCs
c5f12a3 dt-bindings: add document of Rockchip power domain
7a834ba Merge branch 'for-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/jikos/hid
0be0171 HID: wacom: Report correct device resolution when using the
wireless adapater
2b9bea0 Merge tag 'mfd-fixes-4.2' of
git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd
016a9f5 Merge tag 'ntb-4.2-rc7' of git://github.com/jonmason/ntb
a3ca013 Merge branch 'for-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs
......

Caesar Wang (4):
  dt-bindings: add document of Rockchip power domain
  ARM: power-domain: rockchip: add all the domain type on RK3288 SoCs
  soc: rockchip: power-domain: Add power domain driver
  ARM: dts: add the support power-domain node on RK3288 SoCs

 .../bindings/soc/rockchip/power_domain.txt         |  46 ++
 arch/arm/boot/dts/rk3288.dtsi                      |  60 ++-
 drivers/soc/Kconfig                                |   1 +
 drivers/soc/Makefile                               |   1 +
 drivers/soc/rockchip/Kconfig                       |  13 +
 drivers/soc/rockchip/Makefile                      |   4 +
 drivers/soc/rockchip/pm_domains.c                  | 485 +++++++++++++++++++++
 include/dt-bindings/power-domain/rk3288.h          |  31 ++
 8 files changed, 640 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
 create mode 100644 drivers/soc/rockchip/Kconfig
 create mode 100644 drivers/soc/rockchip/Makefile
 create mode 100644 drivers/soc/rockchip/pm_domains.c
 create mode 100644 include/dt-bindings/power-domain/rk3288.h

-- 
1.9.1
