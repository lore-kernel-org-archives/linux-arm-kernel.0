From: okaya@codeaurora.org (Sinan Kaya)
Date: Wed, 31 Aug 2016 11:10:26 -0400
Subject: [PATCH V4 0/3] dmaengine: qcom_hidma: add error reporting
Message-ID: <1472656229-12955-1-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Three changes in the error handling area:

1. There is a race condition between data transfer callback and descriptor
   free code. The callback routine may decide to clear the resources even
   though the descriptor has not yet been freed.

2. DMA Engine framework now supports direct error reporting to the client
   via the callback.

   Pass the DMA errors to the client by passing a result argument. The HW
   only supports a generic error when something goes wrong. That's why,
   using DMA_TRANS_ABORTED all the time.

3. The HIDMA driver is capable of error detection. However, the error was
   not being passed back to the client when tx_status API is called.

------------------------
Changes from v3 (http://www.spinics.net/lists/dmaengine/msg10742.html)
------------------------
- Clarify that the reset task is gone and also the reset behavior has
changed. The driver will no longer recover the HW automatically. The
driver depends on the client to call terminate_channel.


Sinan Kaya (3):
  dmaengine: qcom_hidma: release the descriptor before the callback
  dmaengine: qcom_hidma: report transfer errors with new interface
  dmaengine: qcom_hidma: add error reporting for tx_status

 drivers/dma/qcom/hidma.c    | 50 +++++++++++++++++++++++++++++++++++----------
 drivers/dma/qcom/hidma.h    |  2 +-
 drivers/dma/qcom/hidma_ll.c | 32 +++++++----------------------
 3 files changed, 47 insertions(+), 37 deletions(-)

-- 
1.9.1
