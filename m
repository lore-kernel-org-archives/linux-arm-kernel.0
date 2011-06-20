From: kishorek.kadiyala@gmail.com (Kishore Kadiyala)
Date: Mon, 20 Jun 2011 20:47:56 +0530
Subject: [PATCH v6 11/11] mmc: add handling for two parallel block
	requests in issue_rw_rq
In-Reply-To: <1308518257-9783-12-git-send-email-per.forlin@linaro.org>
References: <1308518257-9783-1-git-send-email-per.forlin@linaro.org>
	<1308518257-9783-12-git-send-email-per.forlin@linaro.org>
Message-ID: <BANLkTi=+di-5yciD7KVx3LySHVj-L1yfrg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 20, 2011 at 2:47 AM, Per Forlin <per.forlin@linaro.org> wrote:
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
> ?drivers/mmc/card/block.c | ?121 +++++++++++++++++++++++++++++++++-------------
> ?drivers/mmc/card/queue.c | ? 17 +++++--
> ?drivers/mmc/card/queue.h | ? ?1 +
> ?3 files changed, 101 insertions(+), 38 deletions(-)
>
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index 6a84a75..66db77a 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -108,6 +108,7 @@ static DEFINE_MUTEX(open_lock);
>
> ?enum mmc_blk_status {
> ? ? ? ?MMC_BLK_SUCCESS = 0,
> + ? ? ? MMC_BLK_PARTIAL,
> ? ? ? ?MMC_BLK_RETRY,
> ? ? ? ?MMC_BLK_DATA_ERR,
> ? ? ? ?MMC_BLK_CMD_ERR,
> @@ -668,14 +669,16 @@ static inline void mmc_apply_rel_rw(struct mmc_blk_request *brq,
> ? ? ? ?}
> ?}
>
> -static enum mmc_blk_status mmc_blk_err_check(struct mmc_blk_request *brq,
> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?struct request *req,
> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?struct mmc_card *card,
> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?struct mmc_blk_data *md)
> +static int mmc_blk_err_check(struct mmc_card *card,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ?struct mmc_async_req *areq)
> ?{
> ? ? ? ?struct mmc_command cmd;
> ? ? ? ?u32 status = 0;
> ? ? ? ?enum mmc_blk_status ret = MMC_BLK_SUCCESS;
> + ? ? ? struct mmc_queue_req *mq_mrq = container_of(areq, struct mmc_queue_req,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? mmc_active);
> + ? ? ? struct mmc_blk_request *brq = &mq_mrq->brq;
> + ? ? ? struct request *req = mq_mrq->req;
>
> ? ? ? ?/*
> ? ? ? ? * Check for errors here, but don't jump to cmd_err
> @@ -770,7 +773,11 @@ static enum mmc_blk_status mmc_blk_err_check(struct mmc_blk_request *brq,
> ? ? ? ? ? ? ? ?else
> ? ? ? ? ? ? ? ? ? ? ? ?ret = MMC_BLK_DATA_ERR;
> ? ? ? ?}
> -out:
> +
> + ? ? ? if (ret == MMC_BLK_SUCCESS &&
> + ? ? ? ? ? blk_rq_bytes(req) != brq->data.bytes_xfered)
> + ? ? ? ? ? ? ? ret = MMC_BLK_PARTIAL;
> + out:
> ? ? ? ?return ret;
> ?}
>
> @@ -901,27 +908,59 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
> ? ? ? ? ? ? ? ?brq->data.sg_len = i;
> ? ? ? ?}
>
> + ? ? ? mqrq->mmc_active.mrq = &brq->mrq;
> + ? ? ? mqrq->mmc_active.err_check = mmc_blk_err_check;
> +
> ? ? ? ?mmc_queue_bounce_pre(mqrq);
> ?}
>
> -static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *req)
> +static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
> ?{
> ? ? ? ?struct mmc_blk_data *md = mq->data;
> ? ? ? ?struct mmc_card *card = md->queue.card;
> - ? ? ? struct mmc_blk_request *brq = &mq->mqrq_cur->brq;
> - ? ? ? int ret = 1, disable_multi = 0;
> + ? ? ? struct mmc_blk_request *brq;
> + ? ? ? int ret = 1;
> + ? ? ? int disable_multi = 0;
> ? ? ? ?enum mmc_blk_status status;
> + ? ? ? struct mmc_queue_req *mq_rq;
> + ? ? ? struct request *req;
> + ? ? ? struct mmc_async_req *areq;
> +
> + ? ? ? if (!rqc && !mq->mqrq_prev->req)
> + ? ? ? ? ? ? ? goto out;
>
> ? ? ? ?do {
> - ? ? ? ? ? ? ? mmc_blk_rw_rq_prep(mq->mqrq_cur, card, disable_multi, mq);
> - ? ? ? ? ? ? ? mmc_wait_for_req(card->host, &brq->mrq);
> + ? ? ? ? ? ? ? if (rqc) {
> + ? ? ? ? ? ? ? ? ? ? ? mmc_blk_rw_rq_prep(mq->mqrq_cur, card, 0, mq);
> + ? ? ? ? ? ? ? ? ? ? ? areq = &mq->mqrq_cur->mmc_active;
> + ? ? ? ? ? ? ? } else
> + ? ? ? ? ? ? ? ? ? ? ? areq = NULL;
> + ? ? ? ? ? ? ? areq = mmc_start_req(card->host, areq, (int *) &status);

I think 'status' is used uninitialized.
With this struct mmc_async_req *mmc_start_req in your first patch
if (error)
	*error = err;
return data;
condition which always passes.

You can have
enum mmc_blk_status status = MMC_BLK_SUCCESS;

struct mmc_async_req *mmc_start_req  {
err = host->areq->err_check(host->card, host->areq);
		if (err) {
                             ...
                             ...
                             *error = err;
                }

no need to update * error here in success case
return data
}

Regards,
Kishore
