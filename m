From: per.forlin@stericsson.com (Per Forlin)
Date: Wed, 1 Jun 2011 10:48:31 +0200
Subject: [PATCH v2 0/2] sdio: add quirk for spurious SDIO IRQ
Message-ID: <1306918113-23872-1-git-send-email-per.forlin@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Per Forlin <per.forlin@linaro.org>

Daniel Drake reported an issue in the libertas sdio client that was
triggered by the sdio_single_irq functionality. His SDIO device seems to
raise an interrupt even though there are no bits set in the CCCR_INTx
register. This behaviour is not supported by the sdio_single_irq feature nor
the SDIO spec. The purpose of the sdio_single_irq feature is to avoid the
overhead of checking the CCCR_INTx registers, this result in no error
handling of the case if there is a pending IRQ with none CCCR_INTx bits set.

This patchset adds a quirk to support this spurious IRQ issue and also report
a warning if an SDIO interrupt is raised but none CCCR_INTx bits are set.

Changes since v1:
 * Replace public sdio function to enable disable SDIO single IRQ function
   with a quirk

Per Forlin (2):
  sdio: add quirk to handle pending IRQ in case of none CCCR_INTx bits
  sdio: report error if pending IRQ but none CCCR_INTx bits

 drivers/mmc/core/sdio_irq.c |    9 +++++++--
 include/linux/mmc/card.h    |    1 +
 2 files changed, 8 insertions(+), 2 deletions(-)

-- 
1.7.4.1
