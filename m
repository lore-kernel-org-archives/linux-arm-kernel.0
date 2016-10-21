From: okaya@codeaurora.org (Sinan Kaya)
Date: Fri, 21 Oct 2016 12:37:55 -0400
Subject: [PATCH V7 0/4] dmaengine: qcom_hidma: add MSI interrupt support
Message-ID: <1477067879-23750-1-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The new version of the HW supports MSI interrupts instead of wired
interrupts. The MSI interrupts are especially useful for the guest machine
execution. The wired interrupts usually trap to the hypervisor and then are
relayed to the actual interrupt.

The MSI interrupts can be directly fed into the interrupt controller.

Adding a new OF compat string (qcom,hidma-1.1) and ACPI string (QCOM8062)
to distinguish newer HW from the older ones.

v7:
* rebase on top of Vinod's topic/qcom
* drop first 6 patches as they are already applied

v6:
http://www.spinics.net/lists/devicetree/msg146700.html
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

Sinan Kaya (4):
  dmaengine: qcom_hidma: make pending_tre_count atomic
  dmaengine: qcom_hidma: bring out interrupt cause
  dmaengine: qcom_hidma: protect common data structures
  dmaengine: qcom_hidma: add MSI support for interrupts

 drivers/dma/qcom/hidma.c     | 143 +++++++++++++++++++++++++++++++++++++++++--
 drivers/dma/qcom/hidma.h     |   4 +-
 drivers/dma/qcom/hidma_dbg.c |   3 +-
 drivers/dma/qcom/hidma_ll.c  | 127 ++++++++++++++++++--------------------
 4 files changed, 200 insertions(+), 77 deletions(-)

-- 
1.9.1
