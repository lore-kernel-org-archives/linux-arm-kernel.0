From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Tue, 14 Mar 2017 08:18:23 -0700
Subject: [PATCH v6 0/4] i.MX7 PCI support
Message-ID: <20170314151827.31248-1-andrew.smirnov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello, everyone:

This is a sixth iteration of the code that adds PCI-subsystem bits
necessary for enabling PCI support on i.MX7.

Chagnes since v5:

	- Collected ACKs from Lee and Rob

Changes since v4 (can be found at [version4]):

	- Dropped typo-fix patch (originally patch #1 of the
          series). Bjorn, I am assuming that patch from v4 survived
          and stayed in your tree, let me know if that is not true.

	- Added patch with workaround to address speed change false
          failures (I kept it as a separate patch to better document
          exchange with NXP/Freescale that lead to that patch)

	- Added patch to avoid speed change on links configured Gen1
          only (Let me know if that is a terrible idea)

	- Addressed section mismatch problem by moving call to
          hook_fault_code to happend before driver registration.

Changes since v3 (can be found at [version3]):
	- Move all of the reset_control_assert's into imx6_pcie_assert_core_reset
	- Documented required reset and power domain DT bindings

Changes since v2 (can be found at [version2]):

	- Collected Reviewed-by for patch #2 from Lucas
	- Reset logic implementation moved out into a reset controller
          driver (see [reset1])
	- Removed unused leftover code

Changes since v1 (can be found at [version1]):

	- All GPC related code moved into a separate driver (see [gpc1])
	- Removed GPIO probe deferral logging
	- Fixed section mismatch warning
	- Minor reformatting of fsl,imx6q-pcie.txt(as per Rob
          Herring's request)

[version5] https://lkml.org/lkml/2017/2/20/376
[version4] https://lkml.org/lkml/2017/2/7/478
[version3] https://lkml.org/lkml/2017/2/6/565
[version2] https://lkml.org/lkml/2017/2/1/510
[version1] https://lkml.org/lkml/2017/1/19/488
[gpc1] https://lkml.org/lkml/2017/2/6/551
[reset1] https://lkml.org/lkml/2017/2/6/554

Andrey Smirnov (4):
  PCI: imx6: Add code to support i.MX7D
  PCI: imx6: Do not wait for speed change on i.MX7
  PCI: imx6: Do not switch speed if Gen2 is disabled
  PCI: imx6: Allow probe deferal by reset GPIO

 .../devicetree/bindings/pci/fsl,imx6q-pcie.txt     |  13 +-
 drivers/pci/host/pci-imx6.c                        | 199 +++++++++++++++------
 include/linux/mfd/syscon/imx7-iomuxc-gpr.h         |   4 +
 3 files changed, 161 insertions(+), 55 deletions(-)

-- 
2.9.3
