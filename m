From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Sun, 27 Sep 2015 13:56:52 +0200
Subject: [PATCH v2] soc: mediatek: Move the initial setting of pmic wrap
 interrupt before requesting irq.
In-Reply-To: <20150923134506.GA7825@pengutronix.de>
References: <1441976720-43568-1-git-send-email-henryc.chen@mediatek.com>
 <20150923134506.GA7825@pengutronix.de>
Message-ID: <5607D984.50203@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 23/09/15 15:45, Sascha Hauer wrote:
> On Fri, Sep 11, 2015 at 09:05:20PM +0800, Henry Chen wrote:
>> The watchdog may not be initialized by the bootloader, even if the rest
>> of the pwrap is. Move the watchdog initialization out of pwrap_init() to
>> make sure the watchdog is always initialized and not only when the pwrap
>> is uninitialized.
>>
>> Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
>
> Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Applied, thanks.

>
>
>> ---
>> Chandes since v1:
>> Modify the commit log and code comments to make it easy to understand
>> the issue and solution.
>> ---
>>   drivers/soc/mediatek/mtk-pmic-wrap.c | 10 ++++++----
>>   1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
>> index f432291..1a49b09 100644
>> --- a/drivers/soc/mediatek/mtk-pmic-wrap.c
>> +++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
>> @@ -725,10 +725,6 @@ static int pwrap_init(struct pmic_wrapper *wrp)
>>   	pwrap_writel(wrp, 0x1, PWRAP_WACS2_EN);
>>   	pwrap_writel(wrp, 0x5, PWRAP_STAUPD_PRD);
>>   	pwrap_writel(wrp, 0xff, PWRAP_STAUPD_GRPEN);
>> -	pwrap_writel(wrp, 0xf, PWRAP_WDT_UNIT);
>> -	pwrap_writel(wrp, 0xffffffff, PWRAP_WDT_SRC_EN);
>> -	pwrap_writel(wrp, 0x1, PWRAP_TIMER_EN);
>> -	pwrap_writel(wrp, ~((1 << 31) | (1 << 1)), PWRAP_INT_EN);
>>
>>   	if (pwrap_is_mt8135(wrp)) {
>>   		/* enable pwrap events and pwrap bridge in AP side */
>> @@ -896,6 +892,12 @@ static int pwrap_probe(struct platform_device *pdev)
>>   		return -ENODEV;
>>   	}
>>
>> +	/* Initialize watchdog, may not be done by the bootloader */
>> +	pwrap_writel(wrp, 0xf, PWRAP_WDT_UNIT);
>> +	pwrap_writel(wrp, 0xffffffff, PWRAP_WDT_SRC_EN);
>> +	pwrap_writel(wrp, 0x1, PWRAP_TIMER_EN);
>> +	pwrap_writel(wrp, ~((1 << 31) | (1 << 1)), PWRAP_INT_EN);
>> +
>>   	irq = platform_get_irq(pdev, 0);
>>   	ret = devm_request_irq(wrp->dev, irq, pwrap_interrupt, IRQF_TRIGGER_HIGH,
>>   			"mt-pmic-pwrap", wrp);
>> --
>> 1.8.1.1.dirty
>>
>>
>
