From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Thu, 23 Feb 2012 21:32:30 +0800
Subject: [PATCH 0/7] share sa1100 rtc driver to arch-mmp
In-Reply-To: <20120223104937.GP22562@n2100.arm.linux.org.uk>
References: <201202221239.54321.arnd@arndb.de>
 <CAN1soZwgtxR7pNGBQuMHZS0URXM7U6ZABD4disNmvRarZnjwxA@mail.gmail.com>
 <201202221350.00100.arnd@arndb.de>
 <CAN1soZxTutYQ=uU0y_AvBTn37es+8tBU=1L6eKtJDUNONgwHFw@mail.gmail.com>
 <87r4xmygb7.fsf@free.fr>
 <CAN1soZx84dmAVz-Kyv18+fjOJyzvun7fpbXA+rYb6xeEhQbXtQ@mail.gmail.com>
 <87booqx771.fsf@free.fr>
 <CAN1soZxbDKHjMxjNjDOXk8Ko9AyJEDGFV1XpqpiJCaL9ikNEdg@mail.gmail.com>
 <20120223100019.GK22562@n2100.arm.linux.org.uk>
 <CAN1soZwBSHJcFWojPXTY7mDdD4vw85ABoXCk5uufcTNiQzh6_A@mail.gmail.com>
 <20120223104937.GP22562@n2100.arm.linux.org.uk>
Message-ID: <CAN1soZyL=659A2gLp_tLKaUTnBkLi1w0NgVq4SD4in1JE1v4VA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 23, 2012 at 6:49 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Feb 23, 2012 at 06:22:23PM +0800, Haojian Zhuang wrote:
>> On Thu, Feb 23, 2012 at 6:00 PM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> > On Thu, Feb 23, 2012 at 05:45:20PM +0800, Haojian Zhuang wrote:
>> >> On Thu, Feb 23, 2012 at 4:52 PM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
>> >> > The behaviour should be as before, the config should be able to choose between
>> >> > rtc-pxa and rtc-sa1100 for a pxa27x based board. For sharpsl_pm, I suppose the
>> >> > rtc-sa1100 will be chosen in the .config, and for mioa701, it will be
>> >> > rtc-pxa.
>> >> >
>> >> > Just to clear, I'm against removing "resources, clock" from pxa27x platform code
>> >> > which would break rtc-pxa driver on pxa27x. Now I don't care if you're talking
>> >> > about changing some "defconfigs".
>> >> >
>> >>
>> >> How about to move the rtc-sa1100 or rtc-pxa device register from
>> >> pxa27x.c to board file? Then we'll be both happy.
>> >
>> > How about stopping thinking about "one or other" and start thinking "both" ?
>> > The RTC library can and does cope with more than one RTC, and each RTC is
>> > exposed uniquely to userspace. ?So there shouldn't be any problem in keeping
>> > both around, or even registering both together.
>> >
>> > You just have to make sure you don't use both of them together as their
>> > open functions will want to claim the same IRQ. ?That's not really a
>> > problem because that should provide exclusivity between the two.
>>
>> Resource is bind with platform device. We'll meet resource conflict if
>> we register them both.
>
> Ok, in that case we need patch 3 split up such that we can move forward
> and get some of the build errors fixed.
>
> That probably means that the first half of patch 3 should be providing the
> IRQs and only the IRQs to the driver, and the driver making use of that
> information. ?Nothing more than that - not even the differing register
> offsets.
>
> The next stage would be to introduce the different device names, and use
> that to chose the different register layouts - but still using a hard coded
> base address. ?That will involve adding a new define for this to both
> arch/arm/mach-sa1100/include/mach/SA-1100.h and
> arch/arm/mach-pxa/include/mach/regs-rtc.h. ?At the same time, this patch
> should move the register definitions from those headers into the sa1100 RTC
> driver, and get rid of the virtual address definitions for these registers.

OK. I can keep the hard coded register definition and format patch right now.
The rtc register base of arch-sa1100, arch-pxa, arch-mmp are
different. It means
that I need use #ifdef CONFIG_ARCH to distinguish different arch. But I have a
question that removing #ifdef CONFIG_ARCH in driver code is our
target, isn't it?

>
> The clocking issues can also be sorted out as well without solving the base
> address issue - and that gets most of this patch set ready for merging
> without causing Robert any problems.
>
> I would like to see this ASAP so that the current build regression with
> PXA can be fixed.

OK. I'll move the clock operation in open()/close() function.
