From: okaya@codeaurora.org (Sinan Kaya)
Date: Thu, 15 Sep 2016 13:22:36 -0400
Subject: [PATCH V3 00/10] dmaengine: qcom_hidma: add MSI interrupt support
Message-ID: <1473960166-30155-1-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The new version of the HW supports MSI interrupts instead of wired
interrupts. The MSI interrupts are especially useful for the guest machine
execution. The wired interrupts usually trap to the hypervisor and then are
relayed to the actual interrupt.

The MSI interrupts can be directly fed into the interrupt controller.

Adding a new OF compat string (qcom,hidma-1.1) and ACPI string (QCOM8062)
to distinguish newer HW from the older ones.

v3:
* day 0 fix for when ACPI is not compiled in

v2:
https://patchwork.kernel.org/patch/9326399/
* Documentation update for DT bindings
* Rebased to slave-next
* Dropped dmaengine: qcom_hidma: eliminate processed variables. Replaced it
  with dmaengine: qcom_hidma: protect common data structures

v1:
http://lists.infradead.org/pipermail/linux-arm-kernel/2016-July/444167.html
* initial implementation

Sinan Kaya (10):
  Documentation: DT: qcom_hidma: update binding for MSI
  Documentation: DT: qcom_hidma: correct spelling mistakes
  of: irq: make of_msi_configure accessible from modules
  dmaengine: qcom_hidma: configure DMA and MSI for OF
  dmaengine: qcom_hidma: make pending_tre_count atomic
  dmaengine: qcom_hidma: make error and success path common
  dmaengine: qcom_hidma: bring out interrupt cause
  dmaengine: qcom_hidma: add a common API to setup the interrupt
  dmaengine: qcom_hidma: protect common data structures
  dmaengine: qcom_hidma: add MSI support for interrupts

 .../devicetree/bindings/dma/qcom_hidma_mgmt.txt    |  17 +-
 drivers/dma/qcom/hidma.c                           | 129 +++++++++-
 drivers/dma/qcom/hidma.h                           |   6 +-
 drivers/dma/qcom/hidma_dbg.c                       |   3 +-
 drivers/dma/qcom/hidma_ll.c                        | 278 ++++++++++-----------
 drivers/dma/qcom/hidma_mgmt.c                      |   5 +-
 drivers/of/irq.c                                   |   1 +
 7 files changed, 280 insertions(+), 159 deletions(-)

-- 
1.9.1
