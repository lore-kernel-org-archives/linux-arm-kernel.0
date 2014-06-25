From: dianders@chromium.org (Doug Anderson)
Date: Tue, 24 Jun 2014 21:00:34 -0700
Subject: [PATCH 1/3] mmc: dw_mmc: use mmc_regulator_get_supply to handle
 regulators
In-Reply-To: <53AA3F78.3080804@samsung.com>
References: <1403520321-2431-1-git-send-email-yuvaraj.cd@samsung.com>
 <1403520321-2431-2-git-send-email-yuvaraj.cd@samsung.com>
 <CAD=FV=UGjm9y3XoBgWKjw9kp9W=ZrwB-S6Lh7T_LBUgCQZn1ag@mail.gmail.com>
 <53AA3F78.3080804@samsung.com>
Message-ID: <CAD=FV=WXWttq294yn+eB5x3N0ztoMhpwacqdLB3OfRk+UK+Abg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jaehoon,

On Tue, Jun 24, 2014 at 8:18 PM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> On 06/25/2014 03:00 AM, Doug Anderson wrote:
>> Yuvaraj,
>>
>> On Mon, Jun 23, 2014 at 3:45 AM, Yuvaraj Kumar C D <yuvaraj.cd@gmail.com> wrote:
>>> This patch makes use of mmc_regulator_get_supply() to handle
>>> the vmmc and vqmmc regulators.Also it moves the code handling
>>> the these regulators to dw_mci_set_ios().It turned on the vmmc
>>> and vqmmc during MMC_POWER_UP and MMC_POWER_ON,and turned off
>>> during MMC_POWER_OFF.
>>>
>>> Signed-off-by: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
>>> ---
>>>  drivers/mmc/host/dw_mmc.c |   71 ++++++++++++++++++++++-----------------------
>>>  drivers/mmc/host/dw_mmc.h |    2 ++
>>>  2 files changed, 36 insertions(+), 37 deletions(-)
>>
>> Perhaps you could CC me on the whole series for the next version since
>> I was involved in privately reviewing previous versions?
>>
>> Overall caveat for my review is that I'm nowhere near an SD/MMC expert.
>>
>>
>>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>>> index 1ac227c..f5cabce 100644
>>> --- a/drivers/mmc/host/dw_mmc.c
>>> +++ b/drivers/mmc/host/dw_mmc.c
>>> @@ -937,6 +937,7 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>>>         struct dw_mci_slot *slot = mmc_priv(mmc);
>>>         const struct dw_mci_drv_data *drv_data = slot->host->drv_data;
>>>         u32 regs;
>>> +       int ret;
>>>
>>>         switch (ios->bus_width) {
>>>         case MMC_BUS_WIDTH_4:
>>> @@ -975,16 +976,41 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>>>
>>>         switch (ios->power_mode) {
>>>         case MMC_POWER_UP:
>>> +               if ((!IS_ERR(mmc->supply.vmmc)) &&
>>> +                               !test_bit(DW_MMC_CARD_POWERED, &slot->flags)) {
>>> +                       ret = regulator_enable(mmc->supply.vmmc);
>>> +                       if (!ret)
>>> +                               set_bit(DW_MMC_CARD_POWERED, &slot->flags);
>
> MMC_CARD_POWERED? I didn't know why it needs.

I think the idea was to make sure that regulator enables/disables were
balanced.  ...but if the mmc core does this for us then we probably
don't need to worry.


>>> +               }
>>
>> As per below, I'm not sure why you'd want to turn on vqmmc and vmmc at
>> different times.
> In my case, in order to prevent the H/W mis-operation, it turns on vqmmc and vmmc at different times.

OK!  Can you explain more?  What instance is one powered but not the other?

I know that we talked to an SD Card manufacturer who told us that
powering their IO lines without their main power rail was a bad thing
(and we in fact saw this causing problems on SD cards).  I would guess
that means that you're either powering vmmc before vqmmc or that vqmmc
somehow doesn't directly enable pullups for IO lines.

If you need vmmc before vqmmc then I'm curious about why...

-Doug
