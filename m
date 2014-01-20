From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Mon, 20 Jan 2014 22:08:41 +0800
Subject: [PATCH 1/3] ACPI / idle: Move idle_boot_override out of the arch
 directory
In-Reply-To: <5375666.26CZK1LlZA@vostro.rjw.lan>
References: <1389924207-7360-1-git-send-email-hanjun.guo@linaro.org>
 <52D9F8E8.8030602@linaro.org> <52D9FA72.5020505@linaro.org>
 <5375666.26CZK1LlZA@vostro.rjw.lan>
Message-ID: <52DD2DE9.9060202@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014?01?18? 21:47, Rafael J. Wysocki wrote:
> On Saturday, January 18, 2014 11:52:18 AM Hanjun Guo wrote:
>> On 2014-1-18 11:45, Hanjun Guo wrote:
>>> On 2014-1-17 20:06, Sudeep Holla wrote:
>>>> On 17/01/14 02:03, Hanjun Guo wrote:
>>>>> Move idle_boot_override out of the arch directory to be a single enum
>>>>> including both platforms values, this will make it rather easier to
>>>>> avoid ifdefs around which definitions are for which processor in
>>>>> generally used ACPI code.
>>>>>
>>>>> IDLE_FORCE_MWAIT for IA64 is not used anywhere, so romove it.
>>>>>
>>>>> No functional change in this patch.
>>>>>
>>>>> Suggested-by: Alan <gnomes@lxorguk.ukuu.org.uk>
>>>>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>>>>> ---
>> [...]
>>>>> diff --git a/include/linux/cpu.h b/include/linux/cpu.h
>>>>> index 03e235ad..e324561 100644
>>>>> --- a/include/linux/cpu.h
>>>>> +++ b/include/linux/cpu.h
>>>>> @@ -220,6 +220,14 @@ void cpu_idle(void);
>>>>>   
>>>>>   void cpu_idle_poll_ctrl(bool enable);
>>>>>   
>>>>> +enum idle_boot_override {
>>>>> +	IDLE_NO_OVERRIDE = 0,
>>>>> +	IDLE_HALT,
>>>>> +	IDLE_NOMWAIT,
>>>>> +	IDLE_POLL,
>>>>> +	IDLE_POWERSAVE_OFF
>>>>> +};
>>>>> +
>>>> I do understand the idea behind this change, but IMO HALT and MWAIT are x86
>>>> specific and may not make sense for other architectures.
>>> yes, this is the strange part, the value is arch-dependent.
>>>
>>>> It will also require every architecture using ACPI to export
>>>> boot_option_idle_override which may not be really required.
>>> so, how about forget this patch and move boot_option_idle_override
>>> related code into arch directory such as arch/x86/acpi/boot.c for
>>> x86?
>> The general idea is that we can move all the arch-dependent codes
>> in ACPI driver to arch directory, then make codes in drivers/acpi/
>> arch independent.
> Well, MWAIT is arch-dependent, so I'm not sure how IDLE_NOMWAIT fits into
> include/linux/cpu.h?

So you will not happy with this patch and should find another solution?

Thanks
Hanjun
