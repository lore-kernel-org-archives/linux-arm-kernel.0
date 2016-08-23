From: okaya@codeaurora.org (Sinan Kaya)
Date: Tue, 23 Aug 2016 00:48:08 -0400
Subject: [PATCH V3 0/3] dmaengine: qcom_hidma: add error reporting
Message-ID: <1471927691-28827-1-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Three changes:
1. There is a race condition between data transfer callback and descriptor
   free code. The callback routine may decide to clear the resources even
   though the descriptor has not yet been freed.

2. DMA Engine framework now supports direct error reporting to the client
via the callback.

Pass the DMA errors to the client by passing a result argument. The HW only
supports a generic error when something goes wrong. That's why, using
DMA_TRANS_ABORTED all the time.

3. The HIDMA driver is capable of error detection. However, the error was
not being passed back to the client when tx_status API is called.

------------------------
Changes from v2 (https://patchwork.kernel.org/patch/9253379/)
------------------------
- Implement the error passing to the client.
- Get rid of the reset in the interrupt handler when an error happens and
  put the HW into disabled state. The only way to recover is for the client to
terminate the channel.

Sinan Kaya (3):
  dmaengine: qcom_hidma: release the descriptor before the callback
  dmaengine: qcom_hidma: report transfer errors with new interface
  dmaengine: qcom_hidma: add error reporting for tx_status

 drivers/dma/qcom/hidma.c    | 50 +++++++++++++++++++++++++++++++++++----------
 drivers/dma/qcom/hidma.h    |  1 +
 drivers/dma/qcom/hidma_ll.c | 32 +++++++----------------------
 3 files changed, 47 insertions(+), 36 deletions(-)

-- 
1.8.2.1
