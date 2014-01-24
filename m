From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Fri, 24 Jan 2014 08:20:46 +0800
Subject: [PATCH 18/20] clocksource / acpi: Add macro
 CLOCKSOURCE_ACPI_DECLARE
In-Reply-To: <20140122114537.GA15591@e106331-lin.cambridge.arm.com>
References: <1389961514-13562-1-git-send-email-hanjun.guo@linaro.org>
 <1389961514-13562-19-git-send-email-hanjun.guo@linaro.org>
 <CACRpkdYKwaH5DX27irzmcTDAMhQMUhuzz6N7mjKWv9tZchv0Ug@mail.gmail.com>
 <20140122114537.GA15591@e106331-lin.cambridge.arm.com>
Message-ID: <52E1B1DE.5050507@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014?01?22? 19:45, Mark Rutland wrote:
> On Wed, Jan 22, 2014 at 08:26:50AM +0000, Linus Walleij wrote:
>> On Fri, Jan 17, 2014 at 1:25 PM, Hanjun Guo <hanjun.guo@linaro.org> wrote:
>>
>>> From: Amit Daniel Kachhap <amit.daniel@samsung.com>
>>>
>>> This macro does the same job as CLOCKSOURCE_OF_DECLARE. The device
>>> name from the ACPI timer table is matched with all the registered
>>> timer controllers and matching initialisation routine is invoked.
>>>
>>> Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
>>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> Actually I have a fat patch renaming CLOCKSOURCE_OF_DECLARE()
>> to TIMER_OF_DECLARE() and I think this macro, if needed, should
>> be named TIMER_ACPI_DECLARE().
>>
>> The reason is that "clocksource" is a Linux-internal name and this
>> macro pertains to the hardware name in respective system
>> description type.
>>
>>> +#ifdef CONFIG_ACPI
>>> +#define CLOCKSOURCE_ACPI_DECLARE(name, compat, fn)                     \
>>> +       static const struct acpi_device_id __clksrc_acpi_table_##name   \
>>> +               __used __section(__clksrc_acpi_table)                   \
>>> +                = { .id = compat,                              \
>>> +                    .driver_data = (kernel_ulong_t)fn }
>>> +#else
>>> +#define CLOCKSOURCE_ACPI_DECLARE(name, compat, fn)
>>> +#endif
>> This hammers down the world to compile one binary for ACPI
>> and one binary for device tree. Maybe that's fine, I don't know.
> How does it do that?
>
> As far as I could tell CONFIG_ACPI and CONFIG_OF are not mutually
> exclusive, and this just means that we only build the datastructures for
> matching from ACPI when CONFIG_ACPI is enabled.
>
> Have I missed something?
>
> I definitely don't want to see mutually exclusive ACPI and DT support.

ACPI and DT did the same job so I think they should mutually exclusive.
if we enable both DT and ACPI in one system, this will leading confusions.

Further more, firmware guys will be happy to present all the devices
in one way, not both of them.

Thanks
Hanjun
