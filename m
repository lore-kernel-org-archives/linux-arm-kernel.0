From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Tue, 06 Jan 2015 21:59:41 +0800
Subject: [PATCH v5 18/18] Documentation: ACPI for ARM64
In-Reply-To: <CAGCh1+neCkwYDc5jA=g1=RWrGc28EqBoYtY23E0dXSvmPXm0GA@mail.gmail.com>
References: <1413553034-20956-1-git-send-email-hanjun.guo@linaro.org>	<1413553034-20956-19-git-send-email-hanjun.guo@linaro.org>	<20141224171815.GD13399@e104818-lin.cambridge.arm.com>	<54A90A4C.60908@linaro.org>	<20150105110533.GA14967@e104818-lin.cambridge.arm.com>	<54ABC2CB.6@linaro.org>	<20150106112929.GB8829@e104818-lin.cambridge.arm.com>	<54ABE82E.30308@linaro.org>
 <CAGCh1+neCkwYDc5jA=g1=RWrGc28EqBoYtY23E0dXSvmPXm0GA@mail.gmail.com>
Message-ID: <54ABEA4D.9020103@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015?01?06? 21:54, G Gregory wrote:
> On 6 January 2015 at 13:50, Hanjun Guo <hanjun.guo@linaro.org> wrote:
>> On 2015?01?06? 19:29, Catalin Marinas wrote:
>>>
>>> On Tue, Jan 06, 2015 at 11:11:07AM +0000, Hanjun Guo wrote:
>>>>
>>>> On 2015?01?05? 19:05, Catalin Marinas wrote:
>>>>>
>>>>> On Sun, Jan 04, 2015 at 09:39:24AM +0000, Hanjun Guo wrote:
>>>>>>
>>>>>> On 2014?12?25? 01:18, Catalin Marinas wrote:
>>>>>> [...]
>>>>>>>
>>>>>>>
>>>>>>> In addition to the above and _DSD requirements/banning, I would also
>>>>>>> add
>>>>>>> some clear statements around:
>>>>>>>
>>>>>>> _OSC: only global/published capabilities are allowed. For
>>>>>>> device-specific _OSC we need a process or maybe we can ban them
>>>>>>> entirely
>>>>>>> and rely on _DSD once we clarify the process.
>>>>>>>
>>>>>>> _OSI: firmware must not check for certain _OSI strings. Here I'm not
>>>>>>> sure what we would have to do for ARM Linux. Reporting "Windows" does
>>>>>>> not make any sense but not reporting anything can, as Matthew Garrett
>>>>>>> pointed out, can be interpreted by firmware as "Linux". In addition to
>>>>>>> any statements in this document, I suggest you patch
>>>>>>> drivers/acpi/acpica/utosi.c accordingly, maybe report "Linux" for ARM
>>>>>>> and print a kernel warning so that we notice earlier.
>>>>>>>
>>>>>>> ACPI_OS_NAME: this is globally defined as "Microsoft Windows NT". It
>>>>>>> doesn't make much sense in the ARM context. Could we change it to
>>>>>>> "Linux" when CONFIG_ARM64?
>>>>
>>>>
>>>> I think we can introduce a Kconfig such as CONFIG_ACPI_OS_NAME_LINUX,
>>>> selected by ARM64 and change ACPI_OS_NAME to "Linux" when
>>>> CONFIG_ACPI_OS_NAME_LINUX defined. (we can not add CONFIG_ARM64 in
>>>> ACPICA code directly since it will be used by windows too)
>>>>
>>>> some code like below:
>>>
>>>
>>> This looks fine for me (with some minor comments below) but I'm not an
>>> ACPI expert to say there wouldn't be any issues.
>>>
>>>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>>>> index b1f9a20..de567a3 100644
>>>> --- a/arch/arm64/Kconfig
>>>> +++ b/arch/arm64/Kconfig
>>>> @@ -1,5 +1,6 @@
>>>>     config ARM64
>>>>            def_bool y
>>>> +       select ACPI_OS_NAME_LINUX if ACPI
>>>>            select ARCH_BINFMT_ELF_RANDOMIZE_PIE
>>>>            select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
>>>>            select ARCH_HAS_GCOV_PROFILE_ALL
>>>> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
>>>> index 8951cef..11a10ac 100644
>>>> --- a/drivers/acpi/Kconfig
>>>> +++ b/drivers/acpi/Kconfig
>>>> @@ -369,6 +369,10 @@ config ACPI_REDUCED_HARDWARE_ONLY
>>>>
>>>>              If you are unsure what to do, do not enable this option.
>>>>
>>>> +config ACPI_OS_NAME_LINUX
>>>> +       bool "Using Linux for _OS method" if EXPERT
>>>> +       def_bool n
>>>
>>>
>>> No need for a default n, it is off by default. Alternatively you could
>>> say:
>>>
>>>          default y if ARM64
>>
>>
>> ok.
>>
>>>
>>>> +
>>>>     source "drivers/acpi/apei/Kconfig"
>>>>
>>>>     config ACPI_EXTLOG
>>>> diff --git a/include/acpi/acconfig.h b/include/acpi/acconfig.h
>>>> index 5a0a3e5..db5e13e 100644
>>>> --- a/include/acpi/acconfig.h
>>>> +++ b/include/acpi/acconfig.h
>>>> @@ -69,7 +69,11 @@
>>>>      * code that will not execute the _OSI method unless _OS matches the
>>>> string
>>>>      * below.  Therefore, change this string at your own risk.
>>>>      */
>>>> +#ifndef ACPI_OS_NAME_USING_LINUX
>>>>     #define ACPI_OS_NAME                    "Microsoft Windows NT"
>>>> +#else
>>>> +#define ACPI_OS_NAME                    "Linux"
>>>> +#endif
>>>
>>>
>>> Can you not use CONFIG_ACPI_OS_NAME_LINUX directly here without
>>> introducing another macro?
>>
>>
>> acconfig.h is part of ACPICA core and will be shared by windows and
>> other OS, so use CONFIG from Linux in this file is not allowed I think.
>>
>
> We could just propse
> #ifndef ACPI_OS_NAME
> #define ACPI_OS_NAME "Microsoft Windows NT"
> #endif
>
> to acpica maintainers. This will not alter Windows or other software usage
> but we can then override it in Linux when/if we want to.

this is better and looks great to me :)

Thanks
Hanjun
