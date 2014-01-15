From: zhangfei.gao@linaro.org (zhangfei)
Date: Wed, 15 Jan 2014 20:10:03 +0800
Subject: [PATCH] mmc: dw_mmc: fix dw_mci_get_cd
In-Reply-To: <001701cf11e9$25b5fe50$7121faf0$%jun@samsung.com>
References: <1389770159-21125-1-git-send-email-zhangfei.gao@linaro.org>
 <1389780469-32633-1-git-send-email-zhangfei.gao@linaro.org>
 <001701cf11e9$25b5fe50$7121faf0$%jun@samsung.com>
Message-ID: <52D67A9B.4090607@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 01/15/2014 07:58 PM, Seungwon Jeon wrote:
> On Wed, January 15, 2014, Zhangfei Gao wrote:
>> Introduced from commit bf626e5550f24aec24975a0e85ad8e572ca76a6b
>> CDETECT is ignored since negated return value of mmc_gpio_get_cd(mmc)
>> can not be checked by IS_ERR_VALUE.
>> Add spin_lock_bh(&host->lock) for atomic accessing DW_MMC_CARD_PRESENT,
>> otherwise sd detect may occasionally fail.
>>
>> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
>> Reported-by: Kevin Hilman <khilman@linaro.org>
>> Reviewed-by: Sachin Kamat <sachin.kamat@linaro.org>
>> Tested-by: Sachin Kamat <sachin.kamat@linaro.org>
>> ---
>>   drivers/mmc/host/dw_mmc.c |    9 ++++++---
>>   1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index a776f24f4311..9ded62c8225e 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -1033,7 +1033,8 @@ static int dw_mci_get_cd(struct mmc_host *mmc)
>>   	int present;
>>   	struct dw_mci_slot *slot = mmc_priv(mmc);
>>   	struct dw_mci_board *brd = slot->host->pdata;
>> -	int gpio_cd = !mmc_gpio_get_cd(mmc);
>> +	struct dw_mci *host = slot->host;
>> +	int gpio_cd = mmc_gpio_get_cd(mmc);
>>
>>   	/* Use platform get_cd function, else try onboard card detect */
>>   	if (brd->quirks & DW_MCI_QUIRK_BROKEN_CARD_DETECTION)
>> @@ -1041,11 +1042,12 @@ static int dw_mci_get_cd(struct mmc_host *mmc)
>>   	else if (brd->get_cd)
>>   		present = !brd->get_cd(slot->id);
>>   	else if (!IS_ERR_VALUE(gpio_cd))
>> -		present = !!gpio_cd;
>> +		present = !gpio_cd;
> !!gpio_cd or gpio_cd is correct, isn't it?
>

No, mmc_gpio_get_cd(mmc) has to revert.
!!gpio_cd is used before since gpio_cd = !mmc_gpio_get_cd(mmc) is used
before.

Thanks
