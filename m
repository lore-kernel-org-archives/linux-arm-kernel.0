From: kishorek.kadiyala@gmail.com (Kishore Kadiyala)
Date: Tue, 21 Jun 2011 19:22:11 +0530
Subject: [PATCH v6 11/11] mmc: add handling for two parallel block
	requests in issue_rw_rq
In-Reply-To: <BANLkTikkjhjmv8oJ-coGSzPwQjZ_eUurqA@mail.gmail.com>
References: <1308518257-9783-1-git-send-email-per.forlin@linaro.org>
	<1308518257-9783-12-git-send-email-per.forlin@linaro.org>
	<BANLkTi=+di-5yciD7KVx3LySHVj-L1yfrg@mail.gmail.com>
	<BANLkTimp1cu36uaky+zSWua+Civg_uQF+w@mail.gmail.com>
	<BANLkTikkjhjmv8oJ-coGSzPwQjZ_eUurqA@mail.gmail.com>
Message-ID: <BANLkTi=Xb=-umFpWdE7Gt8wad1guKtrWqA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Per,

<snip>

>>>> --- a/drivers/mmc/card/block.c
>>>> +++ b/drivers/mmc/card/block.c
>>>> @@ -108,6 +108,7 @@ static DEFINE_MUTEX(open_lock);
>>>>
>>>> ?enum mmc_blk_status {
>>>> ? ? ? ?MMC_BLK_SUCCESS = 0,
>>>> + ? ? ? MMC_BLK_PARTIAL,
>>>> ? ? ? ?MMC_BLK_RETRY,
>>>> ? ? ? ?MMC_BLK_DATA_ERR,
>>>> ? ? ? ?MMC_BLK_CMD_ERR,

<snip>

>>>> -static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *req)
>>>> +static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
>>>> ?{
>>>> ? ? ? ?struct mmc_blk_data *md = mq->data;
>>>> ? ? ? ?struct mmc_card *card = md->queue.card;
>>>> - ? ? ? struct mmc_blk_request *brq = &mq->mqrq_cur->brq;
>>>> - ? ? ? int ret = 1, disable_multi = 0;
>>>> + ? ? ? struct mmc_blk_request *brq;
>>>> + ? ? ? int ret = 1;
>>>> + ? ? ? int disable_multi = 0;
>>>> ? ? ? ?enum mmc_blk_status status;
Can initialize here
                enum mmc_blk_status = MMC_BLK_SUCCESS

>>>> + ? ? ? struct mmc_queue_req *mq_rq;
>>>> + ? ? ? struct request *req;
>>>> + ? ? ? struct mmc_async_req *areq;
>>>> +
>>>> + ? ? ? if (!rqc && !mq->mqrq_prev->req)
>>>> + ? ? ? ? ? ? ? goto out;
>>>>
<snip>

I meant doing initialization in block.c itself and not core.c as above.

> The intention is to make this function available for SDIO as well.

Totally agree, having the API access to SDIO

> "int err = 0;" is set at the top of mmc_start_req(). Default err condition is 0.
>
> What do you think about the following changes?
>
> ?* ? ? @areq: async request to start
> - * ? ? @error: non zero in case of error
> + * ? ? @error: out parameter returns 0 for success, otherwise non zero
> ?*
> ?* ? ? Start a new MMC custom command request for a host.
> ?* ? ? If there is on ongoing async request wait for completion
> @@ -334,9 +334,7 @@ struct mmc_async_req *mmc_start_req(struct mmc_host *host,
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?mmc_post_req(host, areq->mrq, -EINVAL);
>
> ? ? ? ? ? ? ? ? ? ? ? ?host->areq = NULL;
> - ? ? ? ? ? ? ? ? ? ? ? if (error)
> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? *error = err;
> - ? ? ? ? ? ? ? ? ? ? ? return data;
> + ? ? ? ? ? ? ? ? ? ? ? goto out;
> ? ? ? ? ? ? ? ?}
> ? ? ? ?}
>
> @@ -347,6 +345,7 @@ struct mmc_async_req *mmc_start_req(struct mmc_host *host,
> ? ? ? ? ? ? ? ?mmc_post_req(host, host->areq->mrq, 0);
>
> ? ? ? ?host->areq = areq;
> + out:
> ? ? ? ?if (error)
> ? ? ? ? ? ? ? ?*error = err;
> ? ? ? ?return data;
>

The above change reduced the code size but still since 'error' is
pointer to the 'status' which is uninitialized,
so if(error) will be always true.
If you want to update *error in success/failure case [based on 'err'
]then can remove the if(error) check
else to update the error case only can look at the way proposed in my
previous mail.

Regards,
Kishore
