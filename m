From: per.forlin@linaro.org (Per Forlin)
Date: Tue, 31 May 2011 22:33:26 +0200
Subject: [PATCH 0/2] sdio: make sdio_single_irq optional due to suprious IRQ
Message-ID: <1306874008-28867-1-git-send-email-per.forlin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel Drake reported an issue in the libertas sdio client that was
triggered by the sdio_single_irq functionality. His SDIO device seems to
raise an interrupt even though there are no bits set in the CCCR_INTx
register. This behaviour is not supported by the sdio_single_irq feature nor
the SDIO spec. The purpose of the sdio_single_irq feature is to avoid the
overhead of checking the CCCR_INTx registers, this result in no error
handling of the case if there is a pending IRQ with none CCCR_INTx bits set.

This patchset intends to resolve the libertas issue by making
sdio_single_irq feature configurable and also report a
warning if an SDIO interrupt is raised but none CCCR_INTx bits are set.

Per Forlin (2):
  sdio: add function to enable and disable sdio_single_irq optimization
  sdio: report error if pending IRQ but none function bits

 drivers/mmc/core/sdio_irq.c |   22 +++++++++++++++++++++-
 include/linux/mmc/card.h    |    1 +
 2 files changed, 22 insertions(+), 1 deletions(-)

-- 
1.7.4.1
