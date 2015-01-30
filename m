From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Fri, 30 Jan 2015 14:03:33 +0100
Subject: [PATCH v3 4/6] mmc: pwrseq_simple: Add optional reference clock
 support
In-Reply-To: <CAPDyKFp5tGogzjU27jTDcHviUUwnTSgq4EP484_OprV_nPBsOg@mail.gmail.com>
References: <1422543608-24704-1-git-send-email-javier.martinez@collabora.co.uk>	<1422543608-24704-5-git-send-email-javier.martinez@collabora.co.uk>
 <CAPDyKFp5tGogzjU27jTDcHviUUwnTSgq4EP484_OprV_nPBsOg@mail.gmail.com>
Message-ID: <54CB8125.7030107@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Ulf,

On 01/30/2015 12:17 PM, Ulf Hansson wrote:
>>  };
>> @@ -39,6 +42,11 @@ static void mmc_pwrseq_simple_pre_power_on(struct mmc_host *host)
>>         struct mmc_pwrseq_simple *pwrseq = container_of(host->pwrseq,
>>                                         struct mmc_pwrseq_simple, pwrseq);
>>
>> +       if (!IS_ERR(pwrseq->ext_clk)) {
> 
> This should be:
> 
> if (!IS_ERR(pwrseq->ext_clk) && !pwrseq->clk_enabled) {
> 
>

Oh, I thought that it was not possible to enter mmc_pwrseq_pre_power_on()
twice without a prior call to mmc_pwrseq_power_off() but I guess I didn't
read the MMC core code carefully...
 
>> +               clk_prepare_enable(pwrseq->ext_clk);
>> +               pwrseq->clk_enabled = true;
>> +       }
>> +
>>         mmc_pwrseq_simple_set_gpios_value(pwrseq, 1);
>>  }
>>
>> @@ -50,6 +58,19 @@ static void mmc_pwrseq_simple_post_power_on(struct mmc_host *host)
>>         mmc_pwrseq_simple_set_gpios_value(pwrseq, 0);
>>  }
>>
>> +static void mmc_pwrseq_simple_power_off(struct mmc_host *host)
>> +{
>> +       struct mmc_pwrseq_simple *pwrseq = container_of(host->pwrseq,
>> +                                       struct mmc_pwrseq_simple, pwrseq);
>> +
>> +       mmc_pwrseq_simple_set_gpios_value(pwrseq, 1);
>> +
>> +       if (pwrseq->clk_enabled) {
> 
> I changed this as well, but that was just to make code clearer.
> 
> if (!IS_ERR(pwrseq->ext_clk) && pwrseq->clk_enabled) {
> 
>

Yeah, if IS_ERR(pwrseq->ext_clk) then clk_enabled will always be false but I
agree that the change makes the code to be more consistent.

>>
> 
> As I stated in the response to he coverletter for the patchset, this
> patch is applied for next with above changes.
> 
> Thanks!
>

Thanks a lot for your help and for fixing these things!

> Kind regards
> Uffe
>

Best regards,
Javier
