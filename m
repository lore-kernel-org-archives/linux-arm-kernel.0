From: javi.merino@arm.com (Javi Merino)
Date: Fri, 13 Jan 2012 13:48:16 +0000
Subject: [PATCH] ARM: pl330: fix null pointer dereference in
 pl330_chan_ctrl()
In-Reply-To: <1326458191-23492-1-git-send-email-mans.rullgard@linaro.org>
References: <1326458191-23492-1-git-send-email-mans.rullgard@linaro.org>
Message-ID: <4F103620.8070504@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/01/12 12:36, Mans Rullgard wrote:
> This fixes the thrd->req_running field being accessed before thrd
> is checked for null.  The error was introduced in abb959f.
> 
> Signed-off-by: Mans Rullgard <mans.rullgard@linaro.org>
> ---
>  arch/arm/common/pl330.c |    3 ++-

As Russell points out, the s5p tree has merged this file with
drivers/dma/pl330.c so this bug is now in that file.  Please rebase the
patch on top of linux-next.

Other than that, yes, that's my fault.

Acked-by: Javi Merino <javi.merino@arm.com>

>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/common/pl330.c b/arch/arm/common/pl330.c
> index 8d8df74..67abef5 100644
> --- a/arch/arm/common/pl330.c
> +++ b/arch/arm/common/pl330.c
> @@ -1496,12 +1496,13 @@ int pl330_chan_ctrl(void *ch_id, enum pl330_chan_op op)
>  	struct pl330_thread *thrd = ch_id;
>  	struct pl330_dmac *pl330;
>  	unsigned long flags;
> -	int ret = 0, active = thrd->req_running;
> +	int ret = 0, active;
>  
>  	if (!thrd || thrd->free || thrd->dmac->state == DYING)
>  		return -EINVAL;
>  
>  	pl330 = thrd->dmac;
> +	active = thrd->req_running;
>  
>  	spin_lock_irqsave(&pl330->lock, flags);
>  
