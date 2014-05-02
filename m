From: gautam.vivek@samsung.com (Vivek Gautam)
Date: Fri,  2 May 2014 18:17:31 +0530
Subject: [PATCH v5 0/4] usb: ehci/ohci-exynos: Move to generic phy framework
Message-ID: <1399034855-9686-1-git-send-email-gautam.vivek@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Based and tested on 'usb-next' branch of Greg's usb tree, with relevant
device tree patches[1]

Hi Alan,
 I have included your Acked-by in all the four patches, but there has been
 some amount of restructuring as suggested by Tomasz Figa.
 Please let me know if you have some comments on this patch-series.

Changes from v4:
 - Addressed review comments for restructuring exynos_ohci_get_phy()
   and exynos_ehci_get_phy(); and thereby adding proper checks in
   exynos_ohci_phy_enable()/disable() as well as exynos_ehci_phy_enable()/
   disable().

Changes from v3:
 - Calling usb_phy_shutdown() when exynos_o/ehci_phy_enable() is failing.
 - Made exynos_o/ehci_phy_disable() return void, since its return value
   did not serve any purpose.
 - Calling clk_disable_unprepare() in exynos_o/ehci_resume() when
   exynos_o/ehci_phy_enable() is failed.

Changes from v2:
 - Added two patches in the series for some cleanup.
   usb: ohci-exynos: Use struct device instead of platform_device
   usb: ehci-exynos: Use struct device instead of platform_device
 - Addressed review comments.
   -- Moved exynos_ohci_phyg_on()/off routines inside
      exynos_ohci_phy_enable()/disable.
   -- Added functions exynos_ehci_phy_enable() and exynos_ehci_phy_disable()
      and moved exynos_ehci_phyg_on()/off routines respectively in them.
   -- Added necessary checks.

[1]: [PATCH 0/4] dts: Add usb2phy to Exynos 5250/5420
     https://lkml.org/lkml/2014/4/30/119

Kamil Debski (1):
  usb: ehci-exynos: Change to use phy provided by the generic phy
    framework

Vivek Gautam (3):
  usb: ohci-exynos: Use struct device instead of platform_device
  usb: ehci-exynos: Use struct device instead of platform_device
  usb: ohci-exynos: Add facility to use phy provided by the generic phy
    framework

 .../devicetree/bindings/usb/exynos-usb.txt         |   31 +++++
 drivers/usb/host/ehci-exynos.c                     |  136 ++++++++++++++++----
 drivers/usb/host/ohci-exynos.c                     |  134 +++++++++++++++----
 3 files changed, 254 insertions(+), 47 deletions(-)

-- 
1.7.10.4
