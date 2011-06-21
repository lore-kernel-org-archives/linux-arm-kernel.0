From: per.forlin@linaro.org (Per Forlin)
Date: Tue, 21 Jun 2011 08:51:08 +0200
Subject: [PATCH v6 02/11] omap_hsmmc: add support for pre_req and post_req
In-Reply-To: <BANLkTi=+o496k8Uz_k33AH=Zr8+MaFOEig@mail.gmail.com>
References: <1308518257-9783-1-git-send-email-per.forlin@linaro.org>
	<1308518257-9783-3-git-send-email-per.forlin@linaro.org>
	<BANLkTi=+o496k8Uz_k33AH=Zr8+MaFOEig@mail.gmail.com>
Message-ID: <BANLkTinNG2h747MggWfoJfMp4wOSTaTKSg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21 June 2011 07:41, Kishore Kadiyala <kishorek.kadiyala@gmail.com> wrote:
> <snip>
>
>> +
>> +static void omap_hsmmc_pre_req(struct mmc_host *mmc, struct mmc_request *mrq,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?bool is_first_req)
>
> I don't see the usage of "is_first_req" below.
> Is it required?
>
It is not required. It is only an indication that this request is the
first in a series of request. The host driver may do various
optimisations based on this information. The first request in a series
of jobs can't be prepared in parallel to the previous job. The host
driver can do the following to minimise latency for the first job.
 * Preparing the cache while the MMC read/write cmd is being
processed. In this case the pre_req could do nothing and the job is
instead run in parallel to the read/write cmd being sent. If the
is_first_req is false pre_req will run in parallel to an active
transfer, in this case it is more efficient to prepare the request in
pre_req.
 * Run PIO mode instead of DMA
 * Maybe there can be power related optimisations based on if it is
one single transfer or multiple ones.

>> +{
>> + ? ? ? struct omap_hsmmc_host *host = mmc_priv(mmc);
>> +
>> + ? ? ? if (mrq->data->host_cookie) {
>> + ? ? ? ? ? ? ? mrq->data->host_cookie = 0;
>> + ? ? ? ? ? ? ? return ;
>> + ? ? ? }
>> +
>> + ? ? ? if (host->use_dma)
>> + ? ? ? ? ? ? ? if (omap_hsmmc_pre_dma_transfer(host, mrq->data,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? &host->next_data))
>> + ? ? ? ? ? ? ? ? ? ? ? mrq->data->host_cookie = 0;
>> +}
>> +
>> ?/*
>

Thanks for your comments,
Per
