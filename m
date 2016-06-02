From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 2 Jun 2016 17:01:44 +0200
Subject: [PATCH 1/3] mmc: fix mmc mode selection for HS-DDR and higher
In-Reply-To: <CAJKOXPeH_hNutpqzsDWZ09ZrsP_r9A=3p2S63cjJ94VJT_513Q@mail.gmail.com>
References: <1464505484-3661-1-git-send-email-wens@csie.org>
 <1464505484-3661-2-git-send-email-wens@csie.org>
 <CAPDyKFriC7i1DtF5d8eoY0baRoZ2VTfhWJznw9SvOnPNYksU5w@mail.gmail.com>
 <CAJKOXPeH_hNutpqzsDWZ09ZrsP_r9A=3p2S63cjJ94VJT_513Q@mail.gmail.com>
Message-ID: <CAPDyKFq4hAGJDNVFOrU__t33jVDi011EuKPdU=gpsbMUO2uAGQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2 June 2016 at 11:35, Krzysztof Kozlowski <k.kozlowski@samsung.com> wrote:
> On Thu, Jun 2, 2016 at 10:31 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> + Linus
>>
>> On 29 May 2016 at 09:04, Chen-Yu Tsai <wens@csie.org> wrote:
>>> When IS_ERR_VALUE was removed from the mmc core code, it was replaced
>>> with a simple not-zero check. This does not work, as the value checked
>>> is the return value for mmc_select_bus_width, which returns the set
>>> bit width on success. This made eMMC modes higher than HS-DDR unusable.
>>>
>>> Fix this by checking for a positive return value instead.
>>>
>>> Fixes: 287980e49ffc ("remove lots of IS_ERR_VALUE abuses")
>>> Cc: Arnd Bergmann <arnd@arndb.de>
>>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>>> ---
>>>  drivers/mmc/core/mmc.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>>> index c984321d1881..aafb73d080ca 100644
>>> --- a/drivers/mmc/core/mmc.c
>>> +++ b/drivers/mmc/core/mmc.c
>>> @@ -1276,7 +1276,7 @@ static int mmc_select_hs200(struct mmc_card *card)
>>>          * switch to HS200 mode if bus width is set successfully.
>>>          */
>>>         err = mmc_select_bus_width(card);
>>> -       if (!err) {
>>> +       if (err > 0) {
>>>                 val = EXT_CSD_TIMING_HS200 |
>>>                       card->drive_strength << EXT_CSD_DRV_STR_SHIFT;
>>>                 err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>>> @@ -1583,7 +1583,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>>>         } else if (mmc_card_hs(card)) {
>>>                 /* Select the desired bus width optionally */
>>>                 err = mmc_select_bus_width(card);
>>> -               if (!err) {
>>> +               if (err > 0) {
>>
>> As pointed out in the review by Bj?rn, to restore the old behaviour we
>> should check for "err >= 0".
>> No need to send a new patch, I can amend the current version.
>>
>>>                         err = mmc_select_hs_ddr(card);
>>>                         if (err)
>>>                                 goto free_card;
>>> --
>>> 2.8.1
>>>
>>
>> Finally, I am a little concerned about the commit 287980e49ffc
>> ("remove lots of IS_ERR_VALUE abuses") which introduced this
>> regression.
>>
>> Surprisingly the IS_ERR_VALUE():s aren't being replaced by equivalent
>> checks, so perhaps there a more regressions. Moreover, I wonder why I
>> wasn't being on cc/to list when this patch was submitted a few days
>> ago, perhaps my review could prevented the regression from even
>> happen.
>>
>> Anyway, let's fix this now! I will pick up $subject patch as fix asap...
>>
>> and Arnd, can you please double-check that the commit 287980e49ffc
>> doesn?t seems to regress anything else!?
>
> If only the 287980e49ffc could sit in linux-next for few days before
> reaching v4.7-rc1... Could you please pick up the fix soon? Maybe
> directly by Linus?

The fix has already been applied and published through my mmc tree. I
am waiting for reports from kernelci, assuming those will be okay, I
will send a PR tomorrow so it should reach rc2.

Kind regards
Uffe

>
> Best regards,
> Krzysztof
