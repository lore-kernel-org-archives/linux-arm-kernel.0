From: alim.akhtar@gmail.com (Alim Akhtar)
Date: Mon, 17 Aug 2015 20:12:17 +0530
Subject: [PATCH 2/3] mmc: dw_mmc: simplify the SDMMC_CLKEN_LOW_PWR logic
In-Reply-To: <55D1C4CD.4040200@samsung.com>
References: <cover.1439381423.git.hramrach@gmail.com>
 <3d03bfe2c18789eefa038018467c9c63c94ae4a2.1439381423.git.hramrach@gmail.com>
 <55D13F07.70309@samsung.com>
 <CAOMqctQ8DHj6qPg8zR93OGRHXAZDd0yUmG_J8Vz7dGFuDpCgRQ@mail.gmail.com>
 <55D1C4CD.4040200@samsung.com>
Message-ID: <CAGOxZ51oHoX+zQSO8tRp8V5RUmDg8CAnM9HO5FQ5h6JeCy=1og@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI

On Mon, Aug 17, 2015 at 4:56 PM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> On 08/17/2015 02:52 PM, Michal Suchanek wrote:
>> Hello,
>>
>> On 17 August 2015 at 03:55, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>>> Hi, Michal.
>>>
>>> On 08/12/2015 09:23 PM, Michal Suchanek wrote:
>>>> The driver has open-coded test for SDIO cards. Use the mmc core provided
>>>> MMC_QUIRK_BROKEN_CLK_GATING flag instead.
>>>
>>> Did you use the clock-gating for SDIO cards?
>>> Doesn't MMC_CAP_SDIO_IRQ bit set? Which case is broken?
>>> Could you explain to me more?
>>
>> The core flag for disabling power saving is MMC_QUIRK_BROKEN_CLK_GATING.
>
> I understood your intention. And i read the comment into mmc/core/quirks.c
> I will test SDIO card with this patch. Thanks.
>
When you test, please check if SDIO IRQ still works, we need to put
dw_mmc in low_power mode otherwise SDIO IRQ will be not be generated
by dw_mmc host controller.

> Best Regards,
> Jaehoon Chung
>
>>
>> It may coincide with MMC_CAP_SDIO_IRQ but that's different flag for
>> different purpose.
>>
>> MMC_QUIRK_BROKEN_CLK_GATING is currently set for all SDIO cards except
>> for cards on a whitelist.
>>
>> I don't know any particular SDIO card that has problems when the clock
>> is off and does not use an IRQ.
>>
>> Thanks
>>
>> Michal
>>
>>>
>>> Best Regards,
>>> Jaehoon Chung
>>>
>>>>
>>>> As a bonus this may enable clock gating on SDIO cards that are known to
>>>> work with it.
>>>>
>>>> Signed-off-by: Michal Suchanek <hramrach@gmail.com>
>>>> ---
>>>>  drivers/mmc/host/dw_mmc.c | 33 +++++++++++++++------------------
>>>>  1 file changed, 15 insertions(+), 18 deletions(-)
>>>>
>>>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>>>> index 40e9d8e..3bc9fd7 100644
>>>> --- a/drivers/mmc/host/dw_mmc.c
>>>> +++ b/drivers/mmc/host/dw_mmc.c
>>>> @@ -1335,27 +1335,24 @@ static void dw_mci_init_card(struct mmc_host *mmc, struct mmc_card *card)
>>>>        * description of the CLKENA register we should disable low power mode
>>>>        * for SDIO cards if we need SDIO interrupts to work.
>>>>        */
>>>> -     if (mmc->caps & MMC_CAP_SDIO_IRQ) {
>>>> -             const u32 clken_low_pwr = SDMMC_CLKEN_LOW_PWR << slot->id;
>>>> -             u32 clk_en_a_old;
>>>> -             u32 clk_en_a;
>>>> +     const u32 clken_low_pwr = SDMMC_CLKEN_LOW_PWR << slot->id;
>>>> +     u32 clk_en_a_old;
>>>> +     u32 clk_en_a;
>>>>
>>>> -             clk_en_a_old = mci_readl(host, CLKENA);
>>>> +     clk_en_a_old = mci_readl(host, CLKENA);
>>>>
>>>> -             if (card->type == MMC_TYPE_SDIO ||
>>>> -                 card->type == MMC_TYPE_SD_COMBO) {
>>>> -                     set_bit(DW_MMC_CARD_NO_LOW_PWR, &slot->flags);
>>>> -                     clk_en_a = clk_en_a_old & ~clken_low_pwr;
>>>> -             } else {
>>>> -                     clear_bit(DW_MMC_CARD_NO_LOW_PWR, &slot->flags);
>>>> -                     clk_en_a = clk_en_a_old | clken_low_pwr;
>>>> -             }
>>>> +     if (card->quirks & MMC_QUIRK_BROKEN_CLK_GATING) {
>>>> +             set_bit(DW_MMC_CARD_NO_LOW_PWR, &slot->flags);
>>>> +             clk_en_a = clk_en_a_old & ~clken_low_pwr;
>>>> +     } else {
>>>> +             clear_bit(DW_MMC_CARD_NO_LOW_PWR, &slot->flags);
>>>> +             clk_en_a = clk_en_a_old | clken_low_pwr;
>>>> +     }
>>>>
>>>> -             if (clk_en_a != clk_en_a_old) {
>>>> -                     mci_writel(host, CLKENA, clk_en_a);
>>>> -                     mci_send_cmd(slot, SDMMC_CMD_UPD_CLK |
>>>> -                                  SDMMC_CMD_PRV_DAT_WAIT, 0);
>>>> -             }
>>>> +     if (clk_en_a != clk_en_a_old) {
>>>> +             mci_writel(host, CLKENA, clk_en_a);
>>>> +             mci_send_cmd(slot, SDMMC_CMD_UPD_CLK |
>>>> +                             SDMMC_CMD_PRV_DAT_WAIT, 0);
>>>>       }
>>>>  }
>>>>
>>>>
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Regards,
Alim
