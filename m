From: khilman@kernel.org (Kevin Hilman)
Date: Wed, 10 Jun 2015 16:32:07 -0700
Subject: [PATCH 00/15] Kill off set_irq_flags
In-Reply-To: <CAL_JsqK9MrwPS5zPhMDRS3BqhC0esZiR9YPZaMaT0=VAD4gaSw@mail.gmail.com>
 (Rob Herring's message of "Tue, 9 Jun 2015 16:23:04 -0500")
References: <1433874401-27161-1-git-send-email-robh@kernel.org>
 <20150609202834.GH7557@n2100.arm.linux.org.uk>
 <CAL_JsqK9MrwPS5zPhMDRS3BqhC0esZiR9YPZaMaT0=VAD4gaSw@mail.gmail.com>
Message-ID: <7hoakni1hk.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rob Herring <robh@kernel.org> writes:

> On Tue, Jun 9, 2015 at 3:28 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
>> On Tue, Jun 09, 2015 at 01:26:26PM -0500, Rob Herring wrote:
>>> This series converts all users of ARM specific set_irq_flags to use
>>> common genirq functions. In many cases where irqdomains are used, the
>>> set_irq_flags calls were redundant, so I've removed them.
>>>
>>> This is not intended for 4.2, but if any subsystem maintainers want to
>>> pick up their subsystem's change that is fine. All but the last 2
>>> patches stand on their own. Any new drivers going into 4.2 may need a
>>> similar change, but I'm sure people are told not to use set_irq_flags in
>>> reviews. ;)
>>
>> So what are you doing about the initial state of IRQs on legacy ARM where
>> IRQs start off being un-requestable, and need the set_irq_flags() to make
>> them requestable.  I think you could be introducing a massive regression
>> by making this change.
>
> None of that changes. The initial state is set by ARCH_IRQ_INIT_FLAGS
> which I've not changed:
>
> #define ARCH_IRQ_INIT_FLAGS     (IRQ_NOREQUEST | IRQ_NOPROBE)
>
>> Unless you can prove that this isn't the case, you shouldn't be removing
>> this stuff, especially not from legacy platforms.
>
> set_irq_flags() only does a translation from custom ARM IRQF_* flags
> to standard flags and then calls irq_modify_status(). This only
> removes the translation and users set/clear standard flags directly.
> It is a straight-forward removal of a wrapper function.
>
> I *would* like to get rid of ARCH_IRQ_INIT_FLAGS and have the same
> defaults across arches, but yes that would likely cause regressions.

For some reason, I don't have  00/15 in my inbox or list folders, so
replying here...

I gave this series a spin through the kernelci.org build/boot bot where
it was booted on ~20 different ARM SoC families and mulitple different
defconfigs, and there were no boot failures, so it at least passes a
basic boot sanity check.

If you think it's appropriate, feel free to add :

Tested-by: Kevin Hilman <khilman@linaro.org>

Kevin

[1] http://kernelci.org/boot/all/job/khilman/kernel/v4.1-rc7-15-g64b9a5c929f7/
