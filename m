From: okaya@codeaurora.org (Sinan Kaya)
Date: Mon, 29 Aug 2016 11:30:31 -0400
Subject: [PATCH V3 0/3] dmaengine: qcom_hidma: add error reporting
In-Reply-To: <1471927691-28827-1-git-send-email-okaya@codeaurora.org>
References: <1471927691-28827-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1ebe7070-065e-d5a4-cab0-02aa1d6bb9a4@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

On 8/23/2016 12:48 AM, Sinan Kaya wrote:
> Three changes:
> 1. There is a race condition between data transfer callback and descriptor
>    free code. The callback routine may decide to clear the resources even
>    though the descriptor has not yet been freed.
> 
> 2. DMA Engine framework now supports direct error reporting to the client
> via the callback.
> 
> Pass the DMA errors to the client by passing a result argument. The HW only
> supports a generic error when something goes wrong. That's why, using
> DMA_TRANS_ABORTED all the time.
> 
> 3. The HIDMA driver is capable of error detection. However, the error was
> not being passed back to the client when tx_status API is called.
> 
> ------------------------
> Changes from v2 (https://patchwork.kernel.org/patch/9253379/)
> ------------------------
> - Implement the error passing to the client.
> - Get rid of the reset in the interrupt handler when an error happens and
>   put the HW into disabled state. The only way to recover is for the client to
> terminate the channel.
> 
> Sinan Kaya (3):
>   dmaengine: qcom_hidma: release the descriptor before the callback
>   dmaengine: qcom_hidma: report transfer errors with new interface
>   dmaengine: qcom_hidma: add error reporting for tx_status
> 
>  drivers/dma/qcom/hidma.c    | 50 +++++++++++++++++++++++++++++++++++----------
>  drivers/dma/qcom/hidma.h    |  1 +
>  drivers/dma/qcom/hidma_ll.c | 32 +++++++----------------------
>  3 files changed, 47 insertions(+), 36 deletions(-)
> 

Any feedback here?

Does this implementation look like what you were expecting?

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
