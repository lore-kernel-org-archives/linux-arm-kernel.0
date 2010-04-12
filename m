From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 13 Apr 2010 07:04:01 +0800
Subject: [PATCH] mach-pxa/viper: Fix timeout usage for I2C
In-Reply-To: <20100412215326.GD6148@shareable.org>
References: <20100412193943.GP3048@n2100.arm.linux.org.uk>
	<20100412215326.GD6148@shareable.org>
Message-ID: <l2jf17812d71004121604l403639bfr321d9e46050e037a@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 13, 2010 at 5:53 AM, Jamie Lokier <jamie@shareable.org> wrote:
> Russell King - ARM Linux wrote:
>> On Mon, Apr 12, 2010 at 09:32:35PM +0200, Jean Delvare wrote:
>> > On Mon, 12 Apr 2010 20:20:10 +0100, Russell King - ARM Linux wrote:
>> > > On Mon, Apr 12, 2010 at 09:13:19PM +0200, Jean Delvare wrote:
>> > > > On Tue, 13 Apr 2010 01:57:51 +0800, Eric Miao wrote:
>> > > > > One other better and cleaner approach to such inconsistency issue is
>> > > > > to have a timeout_ms field, and having i2c-gpio.c driver to convert this
>> > > > > to jiffies using msec_to_jiffies() at run-time.
>> > > >
>> > > > With what benefit? Expressing time values in units of HZ is very
>> > > > frequent in the kernel code and shouldn't actually surprise anyone.
>> > >
>> > > Actually, this patch shows there is confusion.
>> > >
>> > > "Assume '100' means 100ms here and adapt accordingly."
>> > >
>> > > Since this patch is for ARM, where HZ=100, the above patch is not a
>> > > simple "convert how we derive this constant" patch - it's a functional
>> > > change, reducing the timeouts by a factor of 10.
>> > >
>> > > Could that be because the patch author misinterpreted the HZ-based
>> > > values?
>> >
>> > I admit I would have assumed 100 -> HZ, as hard-coded HZ-dependent
>> > value typically assume HZ=100.
>> >
>> > > I suspect I'm not the only one who thinks that the latter of "HZ / 10"
>> > > "100ms" is easier to read and comprehend without mistake.
>> >
>> > OTOH, converting from ms to jiffies each time you need the value has a
>> > cost.
>>
>> True; what I did for MMC stuff is converted it from ms to jiffies at
>> initialization time when copying it in from platform data in the
>> driver's probe function.
>>
>> I'm not saying that I care either way, I'm merely showing that dealing
>> with HZ-based values can be (maybe unexpectedly) more error prone.
>
> HZ is used a lot in kernel timeouts, so even though it's confusing, it
> is something everyone ought to get used to.

I don't understand why people has to live with confusions where there is
apparently a cleaner way to go. HZ is everywhere, and as long as they
live within their own driver code, that's OK.

>
> But I agree it is too confusing. ?An obvious remedy is:
>
> #define milliseconds(ms) (((ms) * HZ + 999) / 1000)
> #define seconds(s) ? ? ? ((s) * HZ)
>

This is to reinvent the wheel as there are already msecs_to_jiffies()
and usecs_to_jiffies(), and vice versa. The only benefit of using macros
instead of a function is for constants. This, however, can be worked
around as Russell suggested. The additional run-time cost by this
function, compared with a unit of jiffies, is insignificant.

> -- Jamie
>
