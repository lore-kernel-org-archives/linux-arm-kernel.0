From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 2 Nov 2017 13:47:58 +0530
Subject: [PATCH] dmaengine: dmatest: bug out when dma test times out
In-Reply-To: <1509565797-5219-1-git-send-email-awallis@codeaurora.org>
References: <1509565797-5219-1-git-send-email-awallis@codeaurora.org>
Message-ID: <20171102081758.GD3187@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 01, 2017 at 03:49:57PM -0400, Adam Wallis wrote:
> Commit adfa543e7314 ("dmatest: don't use set_freezable_with_signal()")
> introduced a bug (that is in fact documented by the patch commit text)
> that leaves behind a dangling pointer. Since the done_wait structure is
> allocated on the stack, future invocations to the DMATEST can produce
> undesirable results (e.g., corrupted spinlocks). Ideally, this would be
> cleaned up in the the thread handler, but at the very least, the kernel
> is left in a very precarious scenario that can lead to some long debug
> sessions when the crash comes later.
> 
> This bug has also been captured at
> https://bugzilla.kernel.org/show_bug.cgi?id=197605
> 
> Signed-off-by: Adam Wallis <awallis@codeaurora.org>
> ---
>  drivers/dma/dmatest.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
> index 34ff532..95c662f 100644
> --- a/drivers/dma/dmatest.c
> +++ b/drivers/dma/dmatest.c
> @@ -706,7 +706,7 @@ static int dmatest_func(void *data)
>  			result("test timed out", total_tests, src_off, dst_off,
>  			       len, 0);
>  			failed_tests++;
> -			continue;
> +			BUG();

This will essentially kill the system. People have been trying to remove
usage of BUG(), we should not do that. Complaining violently makes sense..


>  		} else if (status != DMA_COMPLETE) {
>  			dmaengine_unmap_put(um);
>  			result(status == DMA_ERROR ?
> -- 
> Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
> Qualcomm Technologies, Inc. is a member of the
> Code Aurora Forum, a Linux Foundation Collaborative Project.
> 

-- 
~Vinod
