From: jgg@ziepe.ca (Jason Gunthorpe)
Date: Wed, 21 Mar 2018 14:02:53 -0600
Subject: [PATCH v4 3/6] RDMA/i40iw: Eliminate duplicate barriers on
 weakly-ordered archs
In-Reply-To: <1521514068-8856-4-git-send-email-okaya@codeaurora.org>
References: <1521514068-8856-1-git-send-email-okaya@codeaurora.org>
 <1521514068-8856-4-git-send-email-okaya@codeaurora.org>
Message-ID: <20180321200253.GA21453@ziepe.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 19, 2018 at 10:47:45PM -0400, Sinan Kaya wrote:
> diff --git a/drivers/infiniband/hw/i40iw/i40iw_uk.c b/drivers/infiniband/hw/i40iw/i40iw_uk.c
> index 8afa5a6..7f0ebed 100644
> +++ b/drivers/infiniband/hw/i40iw/i40iw_uk.c
> @@ -723,7 +723,7 @@ static void i40iw_cq_request_notification(struct i40iw_cq_uk *cq,
>  
>  	wmb(); /* make sure WQE is populated before valid bit is set */
>  
> -	writel(cq->cq_id, cq->cqe_alloc_reg);
> +	writel_relaxed(cq->cq_id, cq->cqe_alloc_reg);
>  }

Ah, this one is probably not OK, i40iw_cq_request_notification is
called here:

	spin_lock_irqsave(&iwcq->lock, flags);
	ukcq->ops.iw_cq_request_notification(ukcq, cq_notify);
	spin_unlock_irqrestore(&iwcq->lock, flags);

So this needs to add mmmiomb(); to keep the same semantics.

Generally I think you need to be very careful to ensure that any
conversion to _relaxed isn't contained by a spinlock, or the mmiomb()
is present.

Maybe even do a first series with this obviously correct pattern:

 wmb();
 writel() -> writel_relaxed()
 writel() -> writel_relaxed()
 [..]
 mmiowmb();

Jason
