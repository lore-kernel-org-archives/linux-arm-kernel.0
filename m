From: computersforpeace@gmail.com (Brian Norris)
Date: Mon, 18 Aug 2014 17:02:34 -0700
Subject: [PATCH v8 01/11] ARM: brcmstb: add infrastructure for ARM-based
 Broadcom STB SoCs
In-Reply-To: <20140813234706.GC18411@ld-irv-0074>
References: <1405976886-27807-1-git-send-email-computersforpeace@gmail.com>
 <1405976886-27807-2-git-send-email-computersforpeace@gmail.com>
 <CAL_Jsq+Nbk7m9KXhG+Chdpvurp75RrvhFR2oE_LGxV444GSe9Q@mail.gmail.com>
 <20140731022320.GM3711@ld-irv-0074>
 <20140731084315.GJ30282@n2100.arm.linux.org.uk>
 <20140731220642.GQ3711@ld-irv-0074>
 <20140802092756.GZ30282@n2100.arm.linux.org.uk>
 <20140813234706.GC18411@ld-irv-0074>
Message-ID: <20140819000234.GM18411@ld-irv-0074>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Wed, Aug 13, 2014 at 04:47:06PM -0700, Brian Norris wrote:
> Picking up this thread again, as things are now set for dropping this
> patch and resubmitting SMP support for 3.18.

Any further comment on this? I'd like to submit v10 of this patch soon.
As of now, my patch will still look essentially the same (with only
minor changes for some of the review comments), since I'm convinced
neither that my current per-cpu flag-based solution is unsound nor that
a delayed work queue can solve all of the same problems.

> On Sat, Aug 02, 2014 at 10:27:56AM +0100, Russell King wrote:
> > On Thu, Jul 31, 2014 at 03:06:42PM -0700, Brian Norris wrote:
> > > Yes, I noticed this. What I meant is that smp_ops.cpu_die() and
> > > smp_ops.cpu_kill() are not synchronized.
> > ...
> > > We're not relying on the L1 cache, though. Don't sync_cache_{r,w}()
> > > ensure all reads/writes reach at least the L2?
> > 
> > What exactly are you trying to achieve here?
> 
> Synchronization between v7_exit_coherency_flush() (on the dying CPU) and
> yanking the power (brcmstb_cpu_kill(), on the murderous CPU). The core
> completion-based synchronization is not sufficient, since it allows
> brcmstb_smp_ops.smp_kill and brcmstb_smp_ops.smp_die to race.
> 
> Am I somehow not achieving what I intend here?
> 
> > > How does that ensure that the CPU is down by the time the work is
> > > scheduled? It seems like this would just defer the work long enough that
> > > it *most likely* has quiesced, but I don't see how this gives us a
> > > better guarantee. Or maybe I'm missing something. (If so, please do
> > > enlighten!)
> > 
> > Note that I said a delayed work queue.  The dying CPU runs a predictable
> > sequence once cpu_die() has been entered - interrupts at the GIC have
> > been programmed to be routed to other CPUs, interrupts at the CPU are
> > masked, so the CPU isn't going to be doing anything else except executing
> > that code path.  So, it's going to be a predictable number of CPU cycles.
> > 
> > That allows you to arrange a delayed workqueue (or a timer) to fire
> > after a period of time that you can guarantee that the dying CPU has
> > reached that wfi().
> 
> OK, that sounds workable for the active hotplug case.
> 
> But what about for the suspend case? CPUs are hot-unplugged during
> disable_nonboot_cpus(), and I don't see that this would guarantee the
> workqueue will complete before we enter suspend.
> 
> > Another point which raises itself in your patch is this:
> > 
> > +       /* Settle-time from Broadcom-internal DVT reference code */
> > +       udelay(7);
> > 
[...]
> I'm looking into this specific delay. [...]

BTW, I think this delay can be dropped. It was retained from an early
non-production release of this CPU.

Brian
