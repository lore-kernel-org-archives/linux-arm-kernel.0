From: lauri.hintsala@bluegiga.com (Lauri Hintsala)
Date: Wed, 11 Jul 2012 09:08:26 +0300
Subject: mmc: mxs: DEADLOCK
In-Reply-To: <20120711060607.GE14060@S2101-09.ap.freescale.net>
References: <4FFC367A.8020100@bluegiga.com>
 <20120711060607.GE14060@S2101-09.ap.freescale.net>
Message-ID: <4FFD185A.8010501@bluegiga.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/11/2012 09:06 AM, Shawn Guo wrote:
>> --- a/drivers/mmc/host/mxs-mmc.c
>> +++ b/drivers/mmc/host/mxs-mmc.c
>> @@ -278,11 +278,11 @@ static irqreturn_t mxs_mmc_irq_handler(int
>> irq, void *dev_id)
>>   	writel(stat & MXS_MMC_IRQ_BITS,
>>   	       host->base + HW_SSP_CTRL1(host) + STMP_OFFSET_REG_CLR);
>>
>> +	spin_unlock(&host->lock);
>> +
>>   	if ((stat & BM_SSP_CTRL1_SDIO_IRQ) && (stat & BM_SSP_CTRL1_SDIO_IRQ_EN))
>>   		mmc_signal_sdio_irq(host->mmc);
>>
>> -	spin_unlock(&host->lock);
>> -
>>   	if (stat & BM_SSP_CTRL1_RESP_TIMEOUT_IRQ)
>>   		cmd->error = -ETIMEDOUT;
>>   	else if (stat & BM_SSP_CTRL1_RESP_ERR_IRQ)
>>
>>
>> Is there any reason to keep mmc_signal_sdio_irq inside the spinlock?
>> mmc_signal_sdio_irq calls mxs_mmc_enable_sdio_irq and it tries to
>> acquire lock while it is already acquired.
>>
> The fix looks right to me.  You can have my ack when you send a patch
> for it.
>
> Acked-by: Shawn Guo <shawn.guo@linaro.org>

OK, I'll send a patch. Thanks!

Lauri
