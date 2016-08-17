From: kid.jin@hisilicon.com (Jinguojun)
Date: Wed, 17 Aug 2016 14:11:26 +0800
Subject: [PATCH V4]mmc: dw_mmc-k3: UHS-SD card for Hisilicon Hikey
In-Reply-To: <1b724dde-863d-fa28-fa58-595c34c1bef2@samsung.com>
References: <1470276973-41683-1-git-send-email-kid.jin@hisilicon.com>
 <74c80b1c-5570-0ee0-4132-ff703d8d5eb4@hisilicon.com>
 <CGME20160808091030epcas1p4e868c5412d08f0ed737e85714442e801@epcas1p4.samsung.com>
 <06f63a26-251d-5ba8-f877-dae75aa8e362@rock-chips.com>
 <1b724dde-863d-fa28-fa58-595c34c1bef2@samsung.com>
Message-ID: <5d5551f4-e49c-d005-eb0b-9ca472a8d249@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On 2016/8/8 18:46, Jaehoon Chung wrote:
> Hi,
> 
> On 08/08/2016 06:10 PM, Shawn Lin wrote:
>> Hi guy,
>>
>> On 2016/8/8 15:10, Jinguojun wrote:
>>> Hi,maintainers
>>>
>>> Pls help to review code,this is the newest patch after your advise
> 
> Subject..
> 
> s/UHS-SD/UHS-I/
> 
>>>
>>
>> Please give Jaehoon more time to review your patch before sending a
>> ping or resending one(~2 weeks), as it's only four days(weekend
>> included) since v4 was done....IMHO, it's quite bold...
>>
>>> Thx
I apologize for my rudeness.
>>> On 2016/8/4 10:16, Jin Guojun wrote:
>>>> mmc: dw_mmc-k3: Hisilicon Hikey have no tuning function in
>>>> dw_mmc-k3.c,so we must do the tuning function stub when we init UHS card.
>>>>
>>
>> Hrmmm....  remove "mmc: dw_mmc-k3:" from the meat of commit msg?
>>
>> And you do nothing for dw_mci_hi6220_execute_tuning, why?
>> Could you elaborate more..
>>
>>
OK I'll remove the mmc: dw_mmc-k3:,Then Hikey can't support SDR104,so we only support SDR12 SDR25 SD50,and we do not need to do tuning for these modes.
>>>> V1:add .prepare_command in dw_mmc.c
>>>> V2:delete .prepare_command, add err = 0 in dw_mci_execute_tuning
>>>> V3:delete err = 0 in dw_mci_execute_tuning,add .execute_tuning in
>>>> dw_mmc-k3.c
>>>> V4:add "linux-mmc at vger.kernel.org", patch version, Changelog, etc..
>>
>> The changelog is totally wrong, namely it should not be listed in the
>> commit msg...
>>
OK I'll delete this part
>>>>
>>>> Signed-off-by: Jin Guojun <kid.jin@hisilicon.com>
>>>> ---
>>>>  drivers/mmc/host/dw_mmc-k3.c | 6 ++++++
>>>>  1 file changed, 6 insertions(+)
>>>>
>>>> diff --git a/drivers/mmc/host/dw_mmc-k3.c b/drivers/mmc/host/dw_mmc-k3.c
>>>> index 8e9d886..6247894 100644
>>>> --- a/drivers/mmc/host/dw_mmc-k3.c
>>>> +++ b/drivers/mmc/host/dw_mmc-k3.c
>>>> @@ -131,11 +131,17 @@ static void dw_mci_hi6220_set_ios(struct dw_mci *host, struct mmc_ios *ios)
>>>>      host->bus_hz = clk_get_rate(host->biu_clk);
>>>>  }
>>>>
>>>> +static int dw_mci_hi6220_execute_tuning(struct dw_mci_slot *slot, u32 opcode)
>>>> +{
>>>> +    return 0;
>>>> +}
> 
> 
> All of UHS-I cards didn't need to do tuning sequence on your SoC? it's strange.
> 
> I think we can fix more exactly in dw_mmc.c
> As i know, some UHS cards don't need to send the tuning sequence.
> (If i know wrong, let me know plz.)
> 
> But just skipping execute_tuning..I think it's not correct.
> 
> Best Regards,
> Jaehoon Chung
> 
We cant support SDR104 currently.We only turn on SDR12 SDR25 SDR50.
>>>> +
>>>>  static const struct dw_mci_drv_data hi6220_data = {
>>>>      .caps            = dw_mci_hi6220_caps,
>>>>      .switch_voltage        = dw_mci_hi6220_switch_voltage,
>>>>      .set_ios        = dw_mci_hi6220_set_ios,
>>>>      .parse_dt        = dw_mci_hi6220_parse_dt,
>>>> +    .execute_tuning        = dw_mci_hi6220_execute_tuning,
>>>>  };
>>>>
>>>>  static const struct of_device_id dw_mci_k3_match[] = {
>>>>
>>>
>>> -- 
>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>>> the body of a message to majordomo at vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>>
> 
> 
> .
> 
