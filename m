From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Tue, 12 Jan 2016 11:03:58 -0300
Subject: [PATCH 1/2] power: act8945a: add charger driver for ACT8945A
In-Reply-To: <B256D81BAE5131468A838E5D7A243641D63E880D@penmbx01>
References: <1452219225-10510-1-git-send-email-wenyou.yang@atmel.com>
 <1452219225-10510-2-git-send-email-wenyou.yang@atmel.com>
 <CABxcv=mQoDxb7oHh0DdC_t1_m-j=4Hp-sPNoq4Apy4c7CneSng@mail.gmail.com>
 <B256D81BAE5131468A838E5D7A243641D63E880D@penmbx01>
Message-ID: <CABxcv=mZfch6XwshXCTzdsSs2RR-4EMwf2jO1n=oPQ_epP8LQw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Wenyou,

On Tue, Jan 12, 2016 at 5:23 AM, Yang, Wenyou <Wenyou.Yang@atmel.com> wrote:
> Hi Javier,
>
> Thank you for your review.
>
>> -----Original Message-----
>> From: Javier Martinez Canillas [mailto:javier at dowhile0.org]
>> Sent: 2016?1?8? 23:00
>> To: Yang, Wenyou <Wenyou.Yang@atmel.com>
>> Cc: Sebastian Reichel <sre@kernel.org>; Dmitry Eremin-Solenikov
>> <dbaryshkov@gmail.com>; David Woodhouse <dwmw2@infradead.org>; Rob
>> Herring <robh+dt@kernel.org>; Pawel Moll <pawel.moll@arm.com>; Mark
>> Rutland <mark.rutland@arm.com>; Ian Campbell <ijc+devicetree@hellion.org.uk>;
>> Kumar Gala <galak@codeaurora.org>; Ferre, Nicolas
>> <Nicolas.FERRE@atmel.com>; linux-arm-kernel at lists.infradead.org; Linux
>> Kernel <linux-kernel@vger.kernel.org>; linux-pm at vger.kernel.org
>> Subject: Re: [PATCH 1/2] power: act8945a: add charger driver for ACT8945A
>>
>> Hello Wenyou,
>>
>> On Thu, Jan 7, 2016 at 11:13 PM, Wenyou Yang <wenyou.yang@atmel.com>
>> wrote:
>> > This patch adds new driver for Active-semi ACT8945A ActivePath charger
>> > (part of ACT8945A MFD driver) providing power supply class information
>> > to userspace.
>> >
>> > The driver is configured through DTS (battery and system related
>> > settings) and sysfs entries (timers and input over-voltage threshold).
>> >
>> > Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
>> > ---
>> >
>>
>> [snip]
>>
>> > +
>> > +static struct platform_driver act8945a_charger_driver = {
>> > +       .driver = {
>> > +               .name = "act8945a-charger",
>> > +       },
>> > +       .probe  = act8945a_charger_probe,
>> > +       .remove = act8945a_charger_remove, };
>> > +
>>
>> The driver is missing an OF match table (and also a platform ID match table if
>> non-DT is supported) so this means that module autoloading will be broken for this
>> driver since the platform uevent function will report a MODALIAS=of:N*T*Cactive-
>> semi,act8945a-charger
>
> This is an MFD device, it compatible is declared in the ../mfd/act8945a.c file.
>
>         .of_compatible = "active-semi,act8945a-charger".
>

I know that the device is instantiated from a MFD driver but having a
.of_compatible property in the MFD cell, it only means that the
pdev->dev.of_node field will be filled by the mfd-core [0]. It has
nothing to do with how the platform device is matched to the platform
driver.

The mfd-core calls platform_device_add() to add the device so the
platform bus_type .match function callback [1] will be used to match
the device with the driver and since the driver doesn't have a OF
device ID table to match, it means that this function will fallback to
match the device name with the platform driver name.

Also, you didn't answer my question about module auto-loading. The
platform bus_type .uevent callback calls of_device_uevent_modalias()
and since the device has an .of_node filled by the mfd-core (since you
provided an .of_compatible for the MFD cell), this means that an OF
modalias will be reported but since the driver doesn't have neither a
.of_match_table nor a MODULE_DEVICE_TABLE(of,...) so udev/kmod won't
be able to load the driver's module based on the modalias uevent
reported by the kernel.

> The non-DT  is not supported in this patch. So a platform ID match table is not included.
>

Ok, I just asked for completeness.

[0]: http://lxr.free-electrons.com/source/drivers/mfd/mfd-core.c#L177
[1]: http://lxr.free-electrons.com/source/drivers/base/platform.c#L833
[2]: http://lxr.free-electrons.com/source/drivers/base/platform.c#L787

Best regards,
Javier
