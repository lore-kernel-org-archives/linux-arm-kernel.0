From: agraf@suse.de (Alexander Graf)
Date: Thu, 16 Feb 2017 09:42:11 +0100
Subject: [PATCH 2/2] arch_timer: acpi: add hisi timer erratum data
In-Reply-To: <589D6776.2010400@huawei.com>
References: <1485254391-51551-1-git-send-email-guohanjun@huawei.com>
 <1485254391-51551-3-git-send-email-guohanjun@huawei.com>
 <20170124105717.GB6277@leverpostej>
 <a2ac2a70-09fb-5cec-c090-b8ebde90e24f@arm.com> <589D6776.2010400@huawei.com>
Message-ID: <e2780793-a8ac-4d75-b095-a534e36f8bf7@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/02/2017 08:10, Hanjun Guo wrote:
> Hi Marc,
>
> On 2017/1/24 19:32, Marc Zyngier wrote:
>> On 24/01/17 10:57, Mark Rutland wrote:
>>> On Tue, Jan 24, 2017 at 06:39:51PM +0800, Hanjun Guo wrote:
>>>> From: Hanjun Guo <hanjun.guo@linaro.org>
>>>>
>>>> Add hisilicon timer specific erratum fixes.
>>>>
>>>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>>>> ---
>>>>  drivers/clocksource/arm_arch_timer.c | 22 ++++++++++++++++++++++
>>>>  1 file changed, 22 insertions(+)
>>>>
>>>> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
>>>> index 80d6f76..3e62a09 100644
>>>> --- a/drivers/clocksource/arm_arch_timer.c
>>>> +++ b/drivers/clocksource/arm_arch_timer.c
>>>> @@ -1156,10 +1156,32 @@ struct gtdt_arch_timer_fixup {
>>>>  	void *context;
>>>>  };
>>>>
>>>> +#ifdef CONFIG_HISILICON_ERRATUM_161010101
>>>> +static void __init hisi_erratum_workaroud_enable(void *context)
>>>> +{
>>>> +	int i;
>>>> +
>>>> +	for (i = 0; i < ARRAY_SIZE(ool_workarounds); i++) {
>>>> +		if (!strcmp(context, ool_workarounds[i].id)) {
>>>> +			timer_unstable_counter_workaround = &ool_workarounds[i];
>>>> +			static_branch_enable(&arch_timer_read_ool_enabled);
>>>> +			pr_info("arch_timer: Enabling workaround for %s\n",
>>>> +				timer_unstable_counter_workaround->id);
>>>> +			break;
>>>> +		}
>>>> +	}
>>>> +}
>>>> +#endif
>>>> +
>>>>  /* note: this needs to be updated according to the doc of OEM ID
>>>>   * and TABLE ID for different board.
>>>>   */
>>>>  static struct gtdt_arch_timer_fixup arch_timer_quirks[] __initdata = {
>>>> +#ifdef CONFIG_HISILICON_ERRATUM_161010101
>>>> +	{"HISI  ", "HIP05   ", 0, &hisi_erratum_workaroud_enable, "hisilicon,erratum-161010101"},
>>>> +	{"HISI  ", "HIP06   ", 0, &hisi_erratum_workaroud_enable, "hisilicon,erratum-161010101"},
>>>> +	{"HISI  ", "HIP07   ", 0, &hisi_erratum_workaroud_enable, "hisilicon,erratum-161010101"},
>>>> +#endif
>>>>  };
>>> NAK. This duplicates logic unnecessarily (for enabling the workaround),
>>> and (ab)uses the id, which was intended to be specific to DT (since it
>>> is a DT property name).
>> Agreed, that's properly revolting.
>>
>>> We should split the matching from the particular workaround (and
>>> enabling thereof), so that we can go straight from ACPI match to
>>> workaround (without having to use the DT id in this manner), and don't
>>> have to duplicate the logic to enable the workaround.
>>>
>>> I believe Marc is looking at some rework in this area which may enable
>>> this, so please wait for that to appear.
>> Yeah, I'm implementing a semi-flexible way to add new quirk types, and
>> the last thing I want to see is two (or more) tables describing the same
>> thing.
>
> Kindly ping, if you have patches in hand, I can test against our platforms,
> thank you very much.

Any progress on this? I'm not a big fan of stalling erratum fixes 
upstream because of potential future refactoring.


Alex
