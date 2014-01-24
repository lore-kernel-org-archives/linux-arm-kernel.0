From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Fri, 24 Jan 2014 23:53:34 +0800
Subject: [PATCH 18/20] clocksource / acpi: Add macro
 CLOCKSOURCE_ACPI_DECLARE
In-Reply-To: <20140124151513.GD19052@arm.com>
References: <1389961514-13562-1-git-send-email-hanjun.guo@linaro.org>
 <1389961514-13562-19-git-send-email-hanjun.guo@linaro.org>
 <CACRpkdYKwaH5DX27irzmcTDAMhQMUhuzz6N7mjKWv9tZchv0Ug@mail.gmail.com>
 <20140122114537.GA15591@e106331-lin.cambridge.arm.com>
 <52E1B1DE.5050507@linaro.org>
 <20140124120815.GH814@e106331-lin.cambridge.arm.com>
 <20140124151513.GD19052@arm.com>
Message-ID: <52E28C7E.5070509@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014?01?24? 23:15, Catalin Marinas wrote:
> On Fri, Jan 24, 2014 at 12:08:15PM +0000, Mark Rutland wrote:
>> On Fri, Jan 24, 2014 at 12:20:46AM +0000, Hanjun Guo wrote:
>>> On 2014?01?22? 19:45, Mark Rutland wrote:
>>>> On Wed, Jan 22, 2014 at 08:26:50AM +0000, Linus Walleij wrote:
>>>>> On Fri, Jan 17, 2014 at 1:25 PM, Hanjun Guo <hanjun.guo@linaro.org> wrote:
>>>>>
>>>>>> From: Amit Daniel Kachhap <amit.daniel@samsung.com>
>>>>>>
>>>>>> This macro does the same job as CLOCKSOURCE_OF_DECLARE. The device
>>>>>> name from the ACPI timer table is matched with all the registered
>>>>>> timer controllers and matching initialisation routine is invoked.
>>>>>>
>>>>>> Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
>>>>>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>>>>> Actually I have a fat patch renaming CLOCKSOURCE_OF_DECLARE()
>>>>> to TIMER_OF_DECLARE() and I think this macro, if needed, should
>>>>> be named TIMER_ACPI_DECLARE().
>>>>>
>>>>> The reason is that "clocksource" is a Linux-internal name and this
>>>>> macro pertains to the hardware name in respective system
>>>>> description type.
>>>>>
>>>>>> +#ifdef CONFIG_ACPI
>>>>>> +#define CLOCKSOURCE_ACPI_DECLARE(name, compat, fn)                     \
>>>>>> +       static const struct acpi_device_id __clksrc_acpi_table_##name   \
>>>>>> +               __used __section(__clksrc_acpi_table)                   \
>>>>>> +                = { .id = compat,                              \
>>>>>> +                    .driver_data = (kernel_ulong_t)fn }
>>>>>> +#else
>>>>>> +#define CLOCKSOURCE_ACPI_DECLARE(name, compat, fn)
>>>>>> +#endif
>>>>> This hammers down the world to compile one binary for ACPI
>>>>> and one binary for device tree. Maybe that's fine, I don't know.
>>>> How does it do that?
>>>>
>>>> As far as I could tell CONFIG_ACPI and CONFIG_OF are not mutually
>>>> exclusive, and this just means that we only build the datastructures for
>>>> matching from ACPI when CONFIG_ACPI is enabled.
>>>>
>>>> Have I missed something?
>>>>
>>>> I definitely don't want to see mutually exclusive ACPI and DT support.
>>> ACPI and DT did the same job so I think they should mutually exclusive.
>>> if we enable both DT and ACPI in one system, this will leading confusions.
>> ACPI and DT do similar jobs, and we should be mutually exclusive at
>> runtime. However, they should not be mutually exclusive at compile-time.
>>
>> Being mutually exclusive at compile-time is just broken. It creates more
>> work for distributions (who need to ship double the number of kernels),
>> it increases the number of configurations requiring testing, and it
>> makes it easier for bugs to be introduced. It's just painful, and
>> there's no reason for it.
> I fully agree (IOW, I'll NAK patches that break this assumption; we want
> single kernel image whether it uses DT or ACPI).

I will not break this in next version, because I totally agree with Mark 
too :)

>
>> At boot time the kernel needs to decide which to use for hardware
>> description, and completely ignore the other (which should not be
>> present, but lets not assume that or inevitably someone will break that
>> assumption for a quick hack).
>>
>> The same kernel should boot on a system that has a DTB or a system that
>> has ACPI tables. On a system that's provided both it should use one or
>> the other, but not both.
> Do we still need the chosen node to be passed via DT for command line,
> even if the kernel uses ACPI?

It depends, but I would prefer not. I prefer UEFI+ACPI and then we don't 
need

the chosen node to be passed via DT.

Thanks
Hanjun
