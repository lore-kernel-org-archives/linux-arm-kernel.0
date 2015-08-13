From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 13 Aug 2015 14:14:33 +0200
Subject: [PATCH 1/2] drivers: PL061: add support for platform driver
 probing
In-Reply-To: <1438614811.2338188.346456017.5D258EC5@webmail.messagingengine.com>
References: <1438585198-8764-1-git-send-email-zhaoshenglong@huawei.com>
 <1438585198-8764-2-git-send-email-zhaoshenglong@huawei.com>
 <CACRpkdY6ZfB-gnnr49He+BYELy4fhiV0g5jkEHhyVsJOc_SBFw@mail.gmail.com>
 <1438614811.2338188.346456017.5D258EC5@webmail.messagingengine.com>
Message-ID: <CACRpkdYmeXvXCrJPxCJCDfCG_=MmopmyAe5mgCPoB_S02ERTLg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 3, 2015 at 5:13 PM, Graeme Gregory <gg@slimlogic.co.uk> wrote:
> On Mon, 3 Aug 2015, at 01:40 PM, Linus Walleij wrote:
>> On Mon, Aug 3, 2015 at 8:59 AM, Shannon Zhao <zhaoshenglong@huawei.com>
>> wrote:
>>
>> > From: Shannon Zhao <shannon.zhao@linaro.org>
>> >
>> > Since PL061 currently only supports AMBA driver, to support using GPIO
>> > PL061 by DT or ACPI, it needs to add support for platform driver.
>> > A DT binding is provided with this patch, ACPI support is added in a
>> > separate one.
>> >
>> > Signed-off-by: Shannon Zhao <zhaoshenglong@huawei.com>
>> > Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
>>
>> I already stated in 0/2 what the problem is with this, and it's obviously
>> adding
>> a huge codechunk, very similar to the AMBA probe path.
>>
>> We need to investigate if ACPI can just spawn AMBA/PrimeCell type devices
>> instead.
>
> AMBA DT support is a hideous hack, we had kind of hoped to avoid doing
> that in ACPI.

Define what you mean with "hideous hack".

I think it is elegant. It combines the DT aspect of telling where the
device is with the Plug-and-play aspect of reading the 0xB105F00D
magic in the PrimeCells very nicely. With an optional override
mechanism. It's nice.

The runtime PM stuff and pclk handling that Russell and also Ulf
has worked on is very helpful and takes out a lot of codelines
in a lot of drivers. Also very nice.

> If you notice ARM already updated pl011 driver to support platform
> device type probing this seems to be the way to go.

Just because there is a precedent does not mean it is good.

Continuing with this adds 100+ lines of hairy initialization to
every AMBA driver.

What needs to happen is stop this and make ACPI spawn
AMBA devices for PrimeCells, and move the serial port over
to that.

A compromise may be to have something that probes a list
of these platform devices in drivers/acpi/ and spawn a
corresponding AMBA device for it. It will still save codelines in
all other subsystems and lower maintenance for the
subsystem maintainers.

Yours,
Linus Walleij
