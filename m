From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 3 Sep 2013 13:56:11 +0200
Subject: [PATCH V3 3/4] mmc: mmci: Adapt to register write restrictions
In-Reply-To: <5225B0EF.7030006@linaro.org>
References: <1378200576-13413-1-git-send-email-ulf.hansson@linaro.org>
 <1378200576-13413-4-git-send-email-ulf.hansson@linaro.org>
 <5225B0EF.7030006@linaro.org>
Message-ID: <CAPDyKFrDxGgd4Z_RDSSfSxB6VYq2dXSMS9cFYimqLSDfaTuSjQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3 September 2013 11:50, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> On 09/03/2013 11:29 AM, Ulf Hansson wrote:
>> After a write to the MMCICLOCK register data cannot be written to this
>> register for three feedback clock cycles. Writes to the MMCIPOWER
>> register must be separated by three MCLK cycles. Previously no issues
>> has been observered, but using higher ARM clock frequencies on STE-
>> platforms has triggered this problem.
>>
>> The MMCICLOCK register is written to in .set_ios and for some data
>> transmissions for SDIO. We do not need a delay at the data transmission
>> path, because sending and receiving data will require more than three
>> clock cycles. Then we use a simple logic to only delay in .set_ios and
>> thus we don't affect throughput performance.
>>
>> Signed-off-by: Johan Rudholm <jrudholm@gmail.com>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> Acked-by: Rickard Andersson <rickard.andersson@stericsson.com>
>> ---
>
> Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>
> + two questions below.
>
>>  drivers/mmc/host/mmci.c |   16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
>>
>> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
>> index c550b3e..82afcd3 100644
>> --- a/drivers/mmc/host/mmci.c
>> +++ b/drivers/mmc/host/mmci.c
>> @@ -189,6 +189,21 @@ static int mmci_validate_data(struct mmci_host *host,
>>       return 0;
>>  }
>>
>> +static void mmci_reg_delay(struct mmci_host *host)
>> +{
>> +     /*
>> +      * According to the spec, at least three feedback clock cycles
>> +      * of max 52 MHz must pass between two writes to the MMCICLOCK reg.
>> +      * Three MCLK clock cycles must pass between two MMCIPOWER reg writes.
>> +      * Worst delay time during card init is at 100 kHz => 30 us.
>> +      * Worst delay time when up and running is at 25 MHz => 120 ns.
>> +      */
>> +     if (host->cclk < 20000000)
>
> Shouldn't it be 25000000 ?

You are right! Thanks for spotting this! I resend a new version.

>
> What about using macros ?
>
> #define MMC_CLOCK 25000000
> #define MMCINIT_DELAY 30
> #define MMCUP_DELAY 120

These values wont be used anywhere else but here. Additionally, mmci
is already having other hard-coded values around. Unless you feel it
is important too you, I would prefer keeping this as is.

Thanks for review Daniel!

Kind regards
Ulf Hansson

>
>> +             udelay(30);
>> +     else
>> +             ndelay(120);
>> +}
>> +
>>  /*
>>   * This must be called with host->lock held
>>   */
>> @@ -1264,6 +1279,7 @@ static void mmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>>
>>       mmci_set_clkreg(host, ios->clock);
>>       mmci_write_pwrreg(host, pwr);
>> +     mmci_reg_delay(host);
>>
>>       spin_unlock_irqrestore(&host->lock, flags);
>>
>>
>
>
> --
>  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>
