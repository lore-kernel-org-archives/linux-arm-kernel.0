From: ccross@android.com (Colin Cross)
Date: Sat, 9 Jul 2011 16:24:23 -0700
Subject: [PATCH 03/17] ARM: gic: Use cpu pm notifiers to save gic state
In-Reply-To: <20110709230544.GP4812@n2100.arm.linux.org.uk>
References: <1310053830-23779-1-git-send-email-lorenzo.pieralisi@arm.com>
	<1310053830-23779-4-git-send-email-lorenzo.pieralisi@arm.com>
	<20110709102100.GJ4812@n2100.arm.linux.org.uk>
	<CAMbhsRTFfv1q0po5CDtRfRBN5pABaKm3C0OR4U9yHmRJiFUOtw@mail.gmail.com>
	<20110709223315.GO4812@n2100.arm.linux.org.uk>
	<CAMbhsRR0XCJ3-6DznCAmEk1AywpFhr70-1mH=cy9YBpZa978pw@mail.gmail.com>
	<20110709230544.GP4812@n2100.arm.linux.org.uk>
Message-ID: <CAMbhsRR64d6kYvUaCn7gU+anQOiAxhnYXZSbXQwJ+Ot=TG6RRQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 9, 2011 at 4:05 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sat, Jul 09, 2011 at 04:01:19PM -0700, Colin Cross wrote:
>> On Sat, Jul 9, 2011 at 3:33 PM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> > On Sat, Jul 09, 2011 at 03:10:56PM -0700, Colin Cross wrote:
>> >> This is necessary for cpuidle states that lose the GIC registers, not
>> >> just suspend, because the GIC is in the cpu's power domain. ?We could
>> >> avoid saving and restoring all the GIC registers in suspend and idle
>> >> by reusing the initialization functions, and then having the core irq
>> >> code call the unmask, set_type, and set_affinity functions on each irq
>> >> to reconfigure it, but that will be very inefficient - it will convert
>> >> each register write in the restore functions to a read-modify-write
>> >> per interrupt in that register. ?Santosh is already complaining that
>> >> this commong GIC restore code will be slower than the automatic DMA to
>> >> restore the GIC registers that OMAP4 supports.
>> >
>> > Well, we need to come up with something sensible - a way of doing this
>> > which doesn't require every interrupt controller driver (of which we as
>> > an architecture have many) to have lots of support added.
>> >
>> > If the current way is inefficient and is noticably so, then let's talk
>> > to Thomas about finding a way around that - maybe having the generic
>> > code make one suspend/resume callback per irq gc chip rather than doing
>> > it per-IRQ. ?We can then reuse the same paths for suspend/resume as for
>> > idle state saving.
>> >
>>
>> Are you referring to moving the gic driver to be gc chip? ?Otherwise,
>> I don't understand your suggestion - how is callback per chip any
>> different than what this patch implements? ?It just gets it's
>> notification through a cpu_pm notifier, which works in idle and
>> suspend, instead of a syscore op like the gc driver does.
>>
>> This patch does save and restore some registers that are never
>> modified after init, so they don't need to be saved.
>
> The point is that we should aim to get to the point where, if an
> interrupt controller supports PM, then it supports _all_ PM out the
> box and doesn't require additional code for cpu idle PM vs system
> suspend PM.

I agree 100%, and everything added in this patch is used for both idle
and suspend on Tegra, through a single entry point - cpu_pm notifiers.

> In other words, all we should need to do is provide genirq with a
> couple of functions for 'save state' and 'restore state'.

It's not so simple.

genirq doesn't know anything about idle.  The PM states in idle are
very SoC specific, so the SoC idle code would need to tell genirq that
the irq chip is going idle - using something like cpu_pm notiifers.
genirq would then just call the 'save state' and 'restore state'
functions, so what's the point?

The gic is very tightly bound to both a cpu and a cpu cluster.  There
are parts (the gic cpu interface) that must be saved and restored when
a single cpu powers down, and can only be accessed from that cpu.
Then there are parts (the gic distributor interface) that can only be
saved and restored when all cpus in a cluster power down, as well as
the cluster itself.  And then to make things more complicated, there
are per-cpu banked registers in the gic distributor, so no single cpu
can save and restore the entire gic distributor.  A single pair of
save restore functions is not sufficient for the gic, and putting the
complexity of save and restore for the gic into genirq, when all it
would be doing is passing through to the gic driver, seems
unnecessary.

Since the SoC cpu idle and suspend code generally ends up in the same
final function, it would call the same cpu_pm notifier for both idle
and suspend, and there is no duplication of code.
