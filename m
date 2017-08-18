From: vviswana@codeaurora.org (Vijay Viswanath)
Date: Fri, 18 Aug 2017 10:49:37 +0530
Subject: [PATCH 0/5] mmc: sdhci-msm: Corrections to implementation of power irq
Message-ID: <1503033582-48703-1-git-send-email-vviswana@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Register writes which change voltage of IO lines or turn the IO bus on/off
require sdhc controller to be ready before progressing further. Once a
register write which affects IO lines is done, the driver should wait for
power irq from controller. Once the irq comes, the driver should acknowledge
the irq by writing to power control register. If the acknowledgement is not
given to controller, the controller may not complete the corresponding
register write action and this can mess up the controller if drivers proceeds
without power irq completing. 

Sahitya Tummala (2):
  mmc: sdhci-msm: Fix HW issue with power IRQ handling during reset
  mmc: sdhci-msm: Add support to wait for power irq

Subhash Jadavani (1):
  mmc: sdhci-msm: fix issue with power irq

Vijay Viswanath (2):
  mmc: sdhci-msm: Add ops to do sdhc register write
  defconfig: msm: Enable CONFIG_MMC_SDHCI_IO_ACCESSORS

 arch/arm64/configs/defconfig |   1 +
 drivers/mmc/host/sdhci-msm.c | 233 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 229 insertions(+), 5 deletions(-)

-- 
 Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc. 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
