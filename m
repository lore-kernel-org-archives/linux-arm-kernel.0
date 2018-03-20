From: Michal.Kalderon@cavium.com (Kalderon, Michal)
Date: Tue, 20 Mar 2018 07:38:48 +0000
Subject: [PATCH v4 6/6] RDMA/qedr: eliminate duplicate barriers on
 weakly-ordered archs #2
In-Reply-To: <1521514068-8856-7-git-send-email-okaya@codeaurora.org>
References: <1521514068-8856-1-git-send-email-okaya@codeaurora.org>
 <1521514068-8856-7-git-send-email-okaya@codeaurora.org>
Message-ID: <CY1PR0701MB20128974717898F2D399431688AB0@CY1PR0701MB2012.namprd07.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> From: Sinan Kaya [mailto:okaya at codeaurora.org]
> Sent: Tuesday, March 20, 2018 4:48 AM
> 
> Code includes wmb() followed by writel() in multiple places. writel() already
> has a barrier on some architectures like arm64.
> 
> This ends up CPU observing two barriers back to back before executing the
> register write.
> 
> Since code already has an explicit barrier call, changing writel() to
> writel_relaxed().
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  drivers/infiniband/hw/qedr/verbs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/qedr/verbs.c
> b/drivers/infiniband/hw/qedr/verbs.c
> index ccd55f4..db60360 100644
> --- a/drivers/infiniband/hw/qedr/verbs.c
> +++ b/drivers/infiniband/hw/qedr/verbs.c
> @@ -860,7 +860,7 @@ static void doorbell_cq(struct qedr_cq *cq, u32 cons,
> u8 flags)
>  	wmb();
>  	cq->db.data.agg_flags = flags;
>  	cq->db.data.value = cpu_to_le32(cons);
> -	writeq(cq->db.raw, cq->db_addr);
> +	writeq_relaxed(cq->db.raw, cq->db_addr);
> 
>  	/* Make sure write would stick */
>  	mmiowb();
> @@ -3338,7 +3338,7 @@ int qedr_post_recv(struct ib_qp *ibqp, struct
> ib_recv_wr *wr,
> 
>  		qp->rq.db_data.data.value++;
> 
> -		writel(qp->rq.db_data.raw, qp->rq.db);
> +		writel_relaxed(qp->rq.db_data.raw, qp->rq.db);
> 
>  		/* Make sure write sticks */
>  		mmiowb();
> --
> 2.7.4
Acked-by: Michal Kalderon <Michal.Kalderon@cavium.com>
