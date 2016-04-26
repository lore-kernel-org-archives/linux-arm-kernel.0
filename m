From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 26 Apr 2016 21:54:41 +0530
Subject: [PATCH V17 1/3] dmaengine: qcom_hidma: implement lower level
 hardware interface
In-Reply-To: <571F8397.5000803@codeaurora.org>
References: <1460384473-5775-1-git-send-email-okaya@codeaurora.org>
 <1460384473-5775-2-git-send-email-okaya@codeaurora.org>
 <20160426032805.GA2274@localhost> <571F8397.5000803@codeaurora.org>
Message-ID: <20160426162441.GJ2274@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 26, 2016 at 11:04:55AM -0400, Sinan Kaya wrote:
> On 4/25/2016 11:28 PM, Vinod Koul wrote:
> >> +
> >> +			/* reset the channel for recovery */
> >> +			if (hidma_ll_setup(lldev)) {
> > 
> > should this be done in ISR?
> 
> I created a new tasklet called rst_task and posted the code there. 

sounds better

> 
>  /*
> + * Abort all transactions and perform a reset.
> + */
> +static void hidma_ll_abort(unsigned long arg)
> +{
> +       u8 err_code = HIDMA_EVRE_STATUS_ERROR;
> +       u8 err_info = 0xFF;
> +
> +       dev_err(lldev->dev, "error 0x%x, resetting...\n",
> +               cause);

right justify this and others as well please

> >> +int hidma_ll_resume(struct hidma_lldev *lldev)
> >> +{
> >> +	return hidma_ll_enable(lldev);
> >> +}
> > 
> > why do we need this empty function, use hidma_ll_enable.
> 
> hidma_ll_enable is a common function that gets called from multiple places. 
> hidma_ll_resume and hidma_ll_pause is used by the OS interface for pausing
> and resuming the DMA channel. 

is there a reason why we can't have the code in resume and that being called
internally as well as externally?

> >> +/*
> >> + * Note that even though we stop this channel
> >> + * if there is a pending transaction in flight
> >> + * it will complete and follow the callback.
> >> + * This request will prevent further requests
> >> + * to be made.
> > 
> > Why the odd formating?
> 
> aligned to 75 characters.

This seems to be 50 chars!

-- 
~Vinod
