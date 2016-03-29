From: rklein@nvidia.com (Rhyland Klein)
Date: Tue, 29 Mar 2016 11:05:52 -0400
Subject: [PATCH] sbs-battery: fix power status when battery is dry
In-Reply-To: <1459216353.16645.20.camel@mtksdaap41>
References: <1458726794-48298-1-git-send-email-yh.huang@mediatek.com>
 <CAGS+omDTmJDkJYsf=gDJMrmAos+30enoAa2xfTPyirXUd37=9g@mail.gmail.com>
 <1458801832.16645.7.camel@mtksdaap41>
 <CAGS+omDhFP+_shCqEWasLDsHf-ab0-OWJJ-gZZkgihAgrZwBHA@mail.gmail.com>
 <1459132330.16645.14.camel@mtksdaap41>
 <CAGS+omBVStB3mfXtDHdbsOK+y2UesGYtZBtYm=ctcpBfm88VEg@mail.gmail.com>
 <56F95451.5040607@nvidia.com> <1459216353.16645.20.camel@mtksdaap41>
Message-ID: <56FA99D0.1010004@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/28/2016 9:52 PM, YH Huang wrote:
> On Mon, 2016-03-28 at 11:57 -0400, Rhyland Klein wrote:
>> On 3/28/2016 6:05 AM, Daniel Kurtz wrote:
>>> +Rhyland Klein who original wrote this code...
>>>
>>> On Mon, Mar 28, 2016 at 10:32 AM, YH Huang <yh.huang@mediatek.com> wrote:
>>>>
>>>> On Fri, 2016-03-25 at 11:06 +0800, Daniel Kurtz wrote:
>>>>> On Thu, Mar 24, 2016 at 2:43 PM, YH Huang <yh.huang@mediatek.com> wrote:
>>>>>>
>>>>>> Hi Daniel,
>>>>>>
>>>>>> On Thu, 2016-03-24 at 12:01 +0800, Daniel Kurtz wrote:
>>>>>>> Hi YH,
>>>>>>>
>>>>>>> On Wed, Mar 23, 2016 at 5:53 PM, YH Huang <yh.huang@mediatek.com> wrote:
>>>>>>>> When the battery is dry and BATTERY_FULL_DISCHARGED is set,
>>>>>>>> we should check BATTERY_DISCHARGING to decide the power status.
>>>>>>>> If BATTERY_DISCHARGING is set, the power status is not charging.
>>>>>>>> Or the power status should be charging.
>>>>>>>>
>>>>>>>> Signed-off-by: YH Huang <yh.huang@mediatek.com>
>>>>>>>> ---
>>>>>>>>  drivers/power/sbs-battery.c |   22 ++++++++++++----------
>>>>>>>>  1 file changed, 12 insertions(+), 10 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/power/sbs-battery.c b/drivers/power/sbs-battery.c
>>>>>>>> index d6226d6..d86db0e 100644
>>>>>>>> --- a/drivers/power/sbs-battery.c
>>>>>>>> +++ b/drivers/power/sbs-battery.c
>>>>>>>> @@ -382,11 +382,12 @@ static int sbs_get_battery_property(struct i2c_client *client,
>>>>>>>>
>>>>>>>>                 if (ret & BATTERY_FULL_CHARGED)
>>>>>>>>                         val->intval = POWER_SUPPLY_STATUS_FULL;
>>>>>>>> -               else if (ret & BATTERY_FULL_DISCHARGED)
>>>>>>>> -                       val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
>>>>>>>> -               else if (ret & BATTERY_DISCHARGING)
>>>>>>>> -                       val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
>>>>>>>> -               else
>>>>>>>> +               else if (ret & BATTERY_DISCHARGING) {
>>>>>>>> +                       if (ret & BATTERY_FULL_DISCHARGED)
>>>>>>>> +                               val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
>>>>>>>> +                       else
>>>>>>>> +                               val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
>>>>>>>> +               } else
>>>>>>>
>>>>>>>
>>>>>>> I think (BATTERY_DISCHARGING && BATTERY_FULL_DISCHARGED) is still
>>>>>>> POWER_SUPPLY_STATUS_DISCHARGING.
>>>>>>> So, let's just report what the battery says and do:
>>>>>>>
>>>>>>>                else if (ret & BATTERY_DISCHARGING)
>>>>>>>                                val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
>>>>>>>
>>>>>> So we just ignore the special situation (BATTERY_DISCHARGING &&
>>>>>> BATTERY_FULL_DISCHARGED).
>>>>>> Isn't POWER_SUPPLY_STATUS_NOT_CHARGING a useful information?
>>>>>
>>>>> The battery is discharging.  The fact that it is also reporting that
>>>>> it is already "discharged" just seems premature.   I would expect to
>>>>> only see NOT_CHARGING if completely discharged *and* not discharging.
>>>>
>>>> I check the "Smart Battery Data Specification Revision 1.1".
>>>> And there are some words about FULLY_DISCHARGED.
>>>> "Discharge should be stopped soon."
>>>> "This status bit may be set prior to the
>>>> ?TERMINATE_DISCHARGE_ALARM? as an early or first level warning of end of
>>>> battery charge."
>>>> It looks like the FULLY_DISCHARGED status is used to announce the
>>>> warning of battery charge and it is still discharging if there is no one
>>>> takes care of it.
>>
>>
>> The only difference I see in the patch above is that in the case where
>> DISCHARGING isn't set, it won't check FULL_DISCHARGE. Nothing seems to
>> be changed in the case where FULL_DISCHARGE & DISCHARGING are set.
> 
> If battery is dry(FULLY_DISCHARGED) and is charging(No
> BATTERY_DISCHARGING) by AC at the same time,
> I think it is better to mark as POWER_SUPPLY_STATUS_CHARGING.
> Is this right?
>

Hmm. I can see where you patch would address that situation. From the
spec, it looks like its expected that the flags should look something
like this:

capacity (in the course of running from fully_charged to dry to
recharging...)

full: FULLY_CHARGED
<unplug>
high->low: DISCHARGING
~0%: (DISCHARGING & FULLY_DISCHARGED)
<plug in>
->~20%: FULLY_DISCHARGED
>~20%: <nothing> = charging

>From this understanding, it seems like we can't expect FULLY_DISCHARGED
to ever be the only flag, nor can we expect it to go away when the
system is initially plugged in. In light of this, I can see why your
patch is preferable to the existing code, as the existing code could
imply that the system is either still near 0% when it is in fact
charging. Of course, ideally the status returned would be "LOW BUT
CHARGING" but I can see how CHARGING seems like a better option.

I think this patch would be fine if we wanted to cover that case, though
if we do merge this, we should probably flush out the patch description
better to clarify why we have to treat FULLY_DISCHARGED as only
applicable while DISCHARGING. This, IMHO, isn't because the
FULLY_DISCHARGED flag comes on early, but rather because it doesn't turn
off until ~20%.

-rhyland

-- 
nvpublic
