From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Tue, 19 Oct 2010 16:53:52 -0700
Subject: [PATCH 3/3] omap: add hwspinlock device
In-Reply-To: <AANLkTinZ2+ocJCfUpT15Ow3J9XBa-8XWnVC3gDDJ7s-v@mail.gmail.com>
	(Ohad Ben-Cohen's message of "Tue, 19 Oct 2010 23:02:37 +0200")
References: <1287387875-14168-1-git-send-email-ohad@wizery.com>
	<1287387875-14168-4-git-send-email-ohad@wizery.com>
	<87r5fmxghm.fsf@deeprootsystems.com>
	<AANLkTinZ2+ocJCfUpT15Ow3J9XBa-8XWnVC3gDDJ7s-v@mail.gmail.com>
Message-ID: <87bp6pviwf.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ohad Ben-Cohen <ohad@wizery.com> writes:

> On Tue, Oct 19, 2010 at 7:03 PM, Kevin Hilman
> <khilman@deeprootsystems.com> wrote:
>>> +postcore_initcall(hwspinlocks_init);
>>
>> Any reason this needs to be a postcore_initcall? ?Are there users of
>> hwspinlocks this early in boot?
>
> i2c-omap, which is subsys_initcall (the I2C bus is shared between the
> A9 and the M3 on some OMAP4 boards).

Rather than moving towards having more drivers have to be built in (and
depend on their probe order) we need to be moving towards building all
these drivers as modules, including omap-i2c.

> And to allow early board code to reserve specific hwspinlock numbers
> for predefined use-cases, we probably want to be before arch_initcall.

There's no reason for board code to have to do this at initcall time.

This kind of thing needs to be done by platform_data function pointers,
as is done for every other driver that needs platform-specific driver
customization.

Kevin
