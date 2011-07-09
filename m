From: ccross@android.com (Colin Cross)
Date: Sat, 9 Jul 2011 15:10:56 -0700
Subject: [PATCH 03/17] ARM: gic: Use cpu pm notifiers to save gic state
In-Reply-To: <20110709102100.GJ4812@n2100.arm.linux.org.uk>
References: <1310053830-23779-1-git-send-email-lorenzo.pieralisi@arm.com>
	<1310053830-23779-4-git-send-email-lorenzo.pieralisi@arm.com>
	<20110709102100.GJ4812@n2100.arm.linux.org.uk>
Message-ID: <CAMbhsRTFfv1q0po5CDtRfRBN5pABaKm3C0OR4U9yHmRJiFUOtw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 9, 2011 at 3:21 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Jul 07, 2011 at 04:50:16PM +0100, Lorenzo Pieralisi wrote:
>> From: Colin Cross <ccross@android.com>
>>
>> When the cpu is powered down in a low power mode, the gic cpu
>> interface may be reset, and when the cpu complex is powered
>> down, the gic distributor may also be reset.
>>
>> This patch uses CPU_PM_ENTER and CPU_PM_EXIT notifiers to save
>> and restore the gic cpu interface registers, and the
>> CPU_COMPLEX_PM_ENTER and CPU_COMPLEX_PM_EXIT notifiers to save
>> and restore the gic distributor registers.
>>
>> Signed-off-by: Colin Cross <ccross@android.com>
>
> Lost attributations and original author. ?This is based in part on code
> from Gary King, according to patch 6646/1 in the patch system.

You're right, I'll make sure the attribution goes back in.

> Moreover, how now that we have genirq dealing with the suspend/restore
> issues, how much of this is actually required. ?And should this be
> GIC specific or should there be a way of asking genirq to take care of
> some of this for us?
>
> We need to _reduce_ the amount of code needed to support this stuff, and
> if core code almost-but-not-quite does what we need then we need to talk
> to the maintainers of that code to see whether it can be changed.
>
> Because adding 212 lines to save and restore the state of every interrupt
> controller that we may have just isn't on. ?We need this properly
> abstracted and dealt with in a generic way.

This is necessary for cpuidle states that lose the GIC registers, not
just suspend, because the GIC is in the cpu's power domain.  We could
avoid saving and restoring all the GIC registers in suspend and idle
by reusing the initialization functions, and then having the core irq
code call the unmask, set_type, and set_affinity functions on each irq
to reconfigure it, but that will be very inefficient - it will convert
each register write in the restore functions to a read-modify-write
per interrupt in that register.  Santosh is already complaining that
this commong GIC restore code will be slower than the automatic DMA to
restore the GIC registers that OMAP4 supports.
