From: okaya@codeaurora.org (Sinan Kaya)
Date: Wed, 19 Oct 2016 13:51:42 -0400
Subject: [PATCH V6 00/10] dmaengine: qcom_hidma: add MSI interrupt support
Message-ID: <1476899512-20431-1-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The new version of the HW supports MSI interrupts instead of wired
interrupts. The MSI interrupts are especially useful for the guest machine
execution. The wired interrupts usually trap to the hypervisor and then are
relayed to the actual interrupt.

The MSI interrupts can be directly fed into the interrupt controller.

Adding a new OF compat string (qcom,hidma-1.1) and ACPI string (QCOM8062)
to distinguish newer HW from the older ones.

v6:
* rebase 4.9 kernel

v5:
http://www.spinics.net/lists/arm-kernel/msg537014.html
* dmaengine: qcom_hidma: add MSI support for interrupts
** Return MSI interrupts before calling platform_msi_domain_free_irqs.
Also cleanup MSI interrupts on the error path.
** Free the legacy IRQ only if MSI is disabled
* add dmaengine: qcom_hidma: break completion processing on error
in order to break the completions if an error is observed while servicing
completed work.
* drop dmaengine: qcom_hidma: make error and success path common
as the success path assumes that we'll get the number of notifications for
the
jobs queued. This is not true under error conditions.
* simplify dmaengine: qcom_hidma: protect common data structures. We just
need to protect the TRE processed offset. It is the variable that keeps
track
of outstanding requests.

v4:
http://www.spinics.net/lists/devicetree/msg144563.html
* device tree binding update to refer to msi.txt

v3:
* day 0 fix for when ACPI is not compiled in
* https://www.spinics.net/lists/arm-kernel/msg532179.html

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
  dmaengine: qcom_hidma: bring out interrupt cause
  dmaengine: qcom_hidma: add a common API to setup the interrupt
  dmaengine: qcom_hidma: protect common data structures
  dmaengine: qcom_hidma: break completion processing on error
  dmaengine: qcom_hidma: add MSI support for interrupts

 .../devicetree/bindings/dma/qcom_hidma_mgmt.txt    |  12 +-
 drivers/dma/qcom/hidma.c                           | 143 +++++++++++++++++-
 drivers/dma/qcom/hidma.h                           |   6 +-
 drivers/dma/qcom/hidma_dbg.c                       |   3 +-
 drivers/dma/qcom/hidma_ll.c                        | 161 +++++++++++----------
 drivers/dma/qcom/hidma_mgmt.c                      |   9 +-
 drivers/of/irq.c                                   |   1 +
 7 files changed, 250 insertions(+), 85 deletions(-)

-- 
1.9.1
