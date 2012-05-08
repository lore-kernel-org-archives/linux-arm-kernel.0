From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Tue, 8 May 2012 13:57:09 +0200
Subject: [PATCH 4/8] mmc: mmci: Use ios_handler to save power
In-Reply-To: <20120418134520.GA24211@n2100.arm.linux.org.uk>
References: <1326810867-5346-1-git-send-email-ulf.hansson@stericsson.com>
 <1326810867-5346-5-git-send-email-ulf.hansson@stericsson.com>
 <CAMJBoFOBVXQHpjNyy7LDpXuNUbEyRosOVvuVt_MYeOrWbQutnw@mail.gmail.com>
 <20120418134520.GA24211@n2100.arm.linux.org.uk>
Message-ID: <4FA90A15.8020807@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Sorry for a late reply.

On 04/18/2012 03:45 PM, Russell King - ARM Linux wrote:
> On Wed, Apr 18, 2012 at 01:57:27PM +0200, Vitaly Wool wrote:
>> Hi Ulf,
>>
>> On Tue, Jan 17, 2012 at 3:34 PM, Ulf Hansson<ulf.hansson@stericsson.com>  wrote:
>>> To disable a levelshifter when we are in an idle state will
>>> decrease current consumption. We make use of the ios_handler
>>> at runtime suspend and at regular suspend to accomplish this.
>>>
>>> Of course depending on the used levelshifter the decrease of
>>> current differs. For ST6G3244ME the value is up to ~200 uA.
>>>
>>> Tested-by: Linus Walleij<linus.walleij@linaro.org>
>>> Signed-off-by: Ulf Hansson<ulf.hansson@stericsson.com>
>>> Signed-off-by: Linus Walleij<linus.walleij@linaro.org>
>>> ---
>>>   drivers/mmc/host/mmci.c |   19 ++++++++++++++++++-
>>>   1 files changed, 18 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
>>> index a7c8f8f..76ce2cd 100644
>>> --- a/drivers/mmc/host/mmci.c
>>> +++ b/drivers/mmc/host/mmci.c
>>> @@ -1505,10 +1505,22 @@ static int mmci_save(struct amba_device *dev)
>>>   {
>>>         struct mmc_host *mmc = amba_get_drvdata(dev);
>>>         unsigned long flags;
>>> +       struct mmc_ios ios;
>>> +       int ret = 0;
>>>
>>>         if (mmc) {
>>>                 struct mmci_host *host = mmc_priv(mmc);
>>>
>>> +               /* Let the ios_handler act on a POWER_OFF to save power. */
>>> +               if (host->plat->ios_handler) {
>>> +                       memcpy(&ios,&mmc->ios, sizeof(struct mmc_ios));
>>> +                       ios.power_mode = MMC_POWER_OFF;
>>> +                       ret = host->plat->ios_handler(mmc_dev(mmc),
>>> +&ios);
>>> +                       if (ret)
>>> +                               return ret;
>>> +               }
>>> +
>>>                 spin_lock_irqsave(&host->lock, flags);
>>>
>>>                 /*
>>> @@ -1527,7 +1539,7 @@ static int mmci_save(struct amba_device *dev)
>>>                 amba_vcore_disable(dev);
>>>         }
>>>
>>> -       return 0;
>>> +       return ret;
>>>   }
>>>
>>>   static int mmci_restore(struct amba_device *dev)
>>> @@ -1550,6 +1562,11 @@ static int mmci_restore(struct amba_device *dev)
>>>                 writel(MCI_IRQENABLE, host->base + MMCIMASK0);
>>>
>>>                 spin_unlock_irqrestore(&host->lock, flags);
>>> +
>>> +               /* Restore settings done by the ios_handler. */
>>> +               if (host->plat->ios_handler)
>>> +                       host->plat->ios_handler(mmc_dev(mmc),
>>> +&mmc->ios);
>>>         }
>>>
>>>         return 0;
>>
>> this patch is a disaster because it cuts off the chip's power on
>> suspend regardless of whether MMC_PM_KEEP_POWER flag has been set or
>> not. Simply put: it breaks everything This patch therefore gets a
>> strongest *NACK* from me.

Agree, the ios_handler should not be called like this. In our internal 
code base the ios_handler were only handling the levelshifter, which is 
safe to disable in the runtim_suspend sequence. But of course, and 
ios_handler may control power to the card as well and thus shall not be 
called like this patch does.

>
> Thank you for backing up what I've already said about this patch (which
> is why I stopped applying Ulf's MMC patches at this patch.)
>
> I've also been concerned with the mere saving and restoring of the
> clock and power registers in this patch - something which the ARM version
> of the primecell does not actually support.

The ios_handler is not used for the ARM version so it should not be 
causing any issue I think. But, still, according to input from Vitaly 
above, this patch is not OK.

I will rework this patch. Thanks for your input.

>
> I've said that before...
>

Kind regards
Ulf Hansson
