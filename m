From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 9 Jul 2011 23:33:15 +0100
Subject: [PATCH 03/17] ARM: gic: Use cpu pm notifiers to save gic state
In-Reply-To: <CAMbhsRTFfv1q0po5CDtRfRBN5pABaKm3C0OR4U9yHmRJiFUOtw@mail.gmail.com>
References: <1310053830-23779-1-git-send-email-lorenzo.pieralisi@arm.com>
	<1310053830-23779-4-git-send-email-lorenzo.pieralisi@arm.com>
	<20110709102100.GJ4812@n2100.arm.linux.org.uk>
	<CAMbhsRTFfv1q0po5CDtRfRBN5pABaKm3C0OR4U9yHmRJiFUOtw@mail.gmail.com>
Message-ID: <20110709223315.GO4812@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 09, 2011 at 03:10:56PM -0700, Colin Cross wrote:
> This is necessary for cpuidle states that lose the GIC registers, not
> just suspend, because the GIC is in the cpu's power domain.  We could
> avoid saving and restoring all the GIC registers in suspend and idle
> by reusing the initialization functions, and then having the core irq
> code call the unmask, set_type, and set_affinity functions on each irq
> to reconfigure it, but that will be very inefficient - it will convert
> each register write in the restore functions to a read-modify-write
> per interrupt in that register.  Santosh is already complaining that
> this commong GIC restore code will be slower than the automatic DMA to
> restore the GIC registers that OMAP4 supports.

Well, we need to come up with something sensible - a way of doing this
which doesn't require every interrupt controller driver (of which we as
an architecture have many) to have lots of support added.

If the current way is inefficient and is noticably so, then let's talk
to Thomas about finding a way around that - maybe having the generic
code make one suspend/resume callback per irq gc chip rather than doing
it per-IRQ.  We can then reuse the same paths for suspend/resume as for
idle state saving.
