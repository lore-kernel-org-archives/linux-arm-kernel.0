From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 25 Feb 2015 12:56:10 +0000
Subject: [PATCH v2] ARM: Don't use complete() during __cpu_die
In-Reply-To: <20150205161100.GQ8656@n2100.arm.linux.org.uk>
References: <1423131270-24047-1-git-send-email-k.kozlowski@samsung.com>
 <20150205105035.GL8656@n2100.arm.linux.org.uk>
 <20150205142918.GA10634@linux.vnet.ibm.com>
 <20150205161100.GQ8656@n2100.arm.linux.org.uk>
Message-ID: <20150225125610.GY8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 05, 2015 at 04:11:00PM +0000, Russell King - ARM Linux wrote:
> On Thu, Feb 05, 2015 at 06:29:18AM -0800, Paul E. McKenney wrote:
> > Works for me, assuming no hidden uses of RCU in the IPI code.  ;-)
> 
> Sigh... I kind'a new it wouldn't be this simple.  The gic code which
> actually raises the IPI takes a raw spinlock, so it's not going to be
> this simple - there's a small theoretical window where we have taken
> this lock, written the register to send the IPI, and then dropped the
> lock - the update to the lock to release it could get lost if the
> CPU power is quickly cut at that point.
> 
> Also, we _do_ need the second cache flush in place to ensure that the
> unlock is seen to other CPUs.

It's time to start discussing this problem again now that we're the
other side of the merge window.

I've been thinking about the lock in the GIC code.  Do we actually need
this lock in gic_raise_softirq(), or could we move this lock into the
higher level code?

Let's consider the bL switcher.

I think the bL switcher is racy wrt CPU hotplug at the moment.  What
happens if we're sleeping in wait_for_completion(&inbound_alive) and
CPU hotplug unplugs the CPU outgoing CPU?  What protects us against
this scenario?  I can't see anything in bL_switch_to() which ensures
that CPU hotplug can't run.

Let's assume that this rather glaring bug has been fixed, and that CPU
hotplug can't run in parallel with the bL switcher (and hence
gic_migrate_target() can't run concurrently with a CPU being taken
offline.)

If we have that guarantee, then we don't need to take a lock when sending
the completion IPI - we would know that while a CPU is being taken down,
the bL switcher could not run.  What we now need is a lock-less way to
raise an IPI.

Now, is the locking between the normal IPI paths and the bL switcher
something that is specific to the interrupt controller, or should generic
code care about it?  I think it's something generic code should care about
- and I believe that would make life a little easier.

The current bL switcher idea is to bring the new CPU up, disable IRQs
and FIQs on the outgoing CPU, change the IRQ/IPI targets, then read
any pending SGIs and raise them on the new CPU.  But what about any
pending SPIs?  These look like they could be lost.

How about this for an idea instead - the bL switcher code:

- brings the new CPU online.
- disables IRQs and FIQs.
- takes the IPI lock, which prevents new IPIs being raised.
- re-targets IRQs and IPIs onto the new CPU.
- releases the IPI lock.
- re-enables IRQs and FIQs.
- polls the IRQ controller to wait for any remaining IRQs and IPIs
  to be delivered.
- re-disables IRQs and FIQs (which shouldn't be received anyway since
  they're now targetting the new CPU.)
- shuts down the tick device.
- completes the switch

What this means is that we're not needing to have complex code in the
interrupt controllers to re-raise interrupts on other CPUs, and we
don't need a lock in the interrupt controller code synchronising IPI
raising with the bL switcher.

I'd also suggest is that this IPI lock should _not_ be a spinlock - it
should be a read/write spin lock - it's perfectly acceptable to have
multiple CPUs raising IPIs to each other, but it is not acceptable to
have any CPU raising an IPI when the bL switcher is modifying the IRQ
targets.  That fits the rwlock semantics.

What this means is that gic_raise_softirq() should again become a lock-
less function, which opens the door to using an IPI to complete the
CPU hot-unplug operation cleanly.

Thoughts (especially from Nico)?

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
