From: per.forlin@linaro.org (Per Forlin)
Date: Tue, 28 Jun 2011 11:39:41 +0200
Subject: [PATCH v8 12/12] mmc: block: add handling for two parallel block
	requests in issue_rw_rq
In-Reply-To: <1309248717-14606-13-git-send-email-per.forlin@linaro.org>
References: <1309248717-14606-1-git-send-email-per.forlin@linaro.org>
	<1309248717-14606-13-git-send-email-per.forlin@linaro.org>
Message-ID: <BANLkTikkv+RQKZCX2PeZUDhM1gnVXCKO2w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 June 2011 10:11, Per Forlin <per.forlin@linaro.org> wrote:
> Change mmc_blk_issue_rw_rq() to become asynchronous.
> The execution flow looks like this:
> The mmc-queue calls issue_rw_rq(), which sends the request
> to the host and returns back to the mmc-queue. The mmc-queue calls
> issue_rw_rq() again with a new request. This new request is prepared,
> in isuue_rw_rq(), then it waits for the active request to complete before
> pushing it to the host. When to mmc-queue is empty it will call
> isuue_rw_rq() with req=NULL to finish off the active request
> without starting a new request.
>
> Signed-off-by: Per Forlin <per.forlin@linaro.org>
> ---
> ?drivers/mmc/card/block.c | ? 80 +++++++++++++++++++++++++++++++++++++--------
> ?drivers/mmc/card/queue.c | ? 17 +++++++---
> ?drivers/mmc/card/queue.h | ? ?1 +
> ?3 files changed, 78 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index 7ed2c68..825741e 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
...
> @@ -1066,6 +1085,13 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *req)
> ? ? ? ? ? ? ? ? ? ? ? ?ret = __blk_end_request(req, 0,
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?brq->data.bytes_xfered);
> ? ? ? ? ? ? ? ? ? ? ? ?spin_unlock_irq(&md->lock);
> + ? ? ? ? ? ? ? ? ? ? ? if (status == MMC_BLK_SUCCESS && ret) {
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? /* If this happen it is a bug */
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? printk(KERN_ERR "%s BUG rq_tot %d d_xfer %d\n",
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?__func__, blk_rq_bytes(req),
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?brq->data.bytes_xfered);
+ rqc = NULL
If there is a new request (rqc != NULL)  it will already be started
when reaching this point.
If rqc is set it will be started again at start_new_req.

I wonder if this paranoia check is necessary. If "status ==
MMC_BLK_SUCCESS" all bytes are transferred and no error returned from
mmc layer.
 __blk_end_request would always return 0 in this case, please comment
if you disagree.

...
> + start_new_req:
> + ? ? ? if (rqc) {
> + ? ? ? ? ? ? ? mmc_blk_rw_rq_prep(mq->mqrq_cur, card, 0, mq);
> + ? ? ? ? ? ? ? mmc_start_req(card->host, &mq->mqrq_cur->mmc_active, NULL);
> + ? ? ? }
> +
> ? ? ? ?return 0;
> ?}

/Per
