From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 13 Dec 2017 09:12:45 +0000
Subject: WARNING: suspicious RCU usage
In-Reply-To: <CAOMZO5DBMpCHfgmNND6=qJD+sxOLMPFqEsyz+GiBVhMzN3H+Zg@mail.gmail.com>
References: <20171210113930.zimywmxzsutwzzmz@linux-u7w5.ap.freescale.net>
 <20171210120012.GM10595@n2100.armlinux.org.uk>
 <20171210190727.GJ7829@linux.vnet.ibm.com>
 <20171210193438.GP10595@n2100.armlinux.org.uk>
 <20171210213930.GL7829@linux.vnet.ibm.com>
 <20171212164900.GA6673@linux.vnet.ibm.com>
 <CAOMZO5AftAWz339Sy+oxQ8K9Dr04Jyf8SV0R0JGrcPaL-VQLMQ@mail.gmail.com>
 <20171212173450.GD10595@n2100.armlinux.org.uk>
 <CAOMZO5DBMpCHfgmNND6=qJD+sxOLMPFqEsyz+GiBVhMzN3H+Zg@mail.gmail.com>
Message-ID: <20171213091245.GH10595@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 12, 2017 at 04:11:07PM -0200, Fabio Estevam wrote:
> Hi Russell,
> 
> On Tue, Dec 12, 2017 at 3:34 PM, Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
> 
> > It's fundamentally unsafe.
> >
> > You need to test with CONFIG_BL_SWITCHER enabled - there's spinlocks
> > in smp_call_function_single() path that are conditional on that symbol.
> > If CONFIG_BL_SWITCHER is disabled, then the spinlocks are not present.
> 
> Ok, just tested with CONFIG_BL_SWITCHER=y on a imx6q-cubox-i:
> 
> # echo enabled > /sys/class/tty/ttymxc0/power/wakeup
> # echo mem > /sys/power/state
> [   10.503462] PM: suspend entry (deep)
> [   10.507479] PM: Syncing filesystems ... done.
> [   10.555024] Freezing user space processes ... (elapsed 0.002 seconds) done.
> [   10.564511] OOM killer disabled.
> [   10.567760] Freezing remaining freezable tasks ... (elapsed 0.002 seconds) d.
> [   10.577420] Suspending console(s) (use no_console_suspend to debug)
> [   10.657748] PM: suspend devices took 0.080 seconds
> [   10.669329] Disabling non-boot CPUs ...
> [   10.717049] IRQ17 no longer affine to CPU1
> [   10.837141] Enabling non-boot CPUs ...
> [   10.839386] CPU1 is up
> [   10.840342] CPU2 is up
> [   10.841300] CPU3 is up
> [   11.113735] mmc0: queuing unknown CIS tuple 0x80 (2 bytes)
> [   11.115676] mmc0: queuing unknown CIS tuple 0x80 (3 bytes)
> [   11.117595] mmc0: queuing unknown CIS tuple 0x80 (3 bytes)
> [   11.121014] mmc0: queuing unknown CIS tuple 0x80 (7 bytes)
> [   11.124454] mmc0: queuing unknown CIS tuple 0x80 (7 bytes)
> [   11.177299] ata1: SATA link down (SStatus 0 SControl 300)
> [   11.181930] PM: resume devices took 0.330 seconds
> [   11.243729] OOM killer enabled.
> [   11.246886] Restarting tasks ... done.
> [   11.253012] PM: suspend exit

Right, one test.  What makes this safe, and what does this prove?

It's probably worth quoting a discussion I had with Will Deacon on
this subject back in 2013 - it's on that complete(), but the points
discussed there are entirely relevant to the spinlock in the GIC
code.

imx6 won't see a problem because you have additional synchronisation
between the calling CPU and the dying CPU, so I'm afraid that any
testing done on imx6 is meaningless wrt the safety of Paul's change
from an architecture point of view.

And that's the problem - once that complete() happens, the dying CPU
can have power removed _at any moment_, and that could happen when
the cache line for "cpu_map_lock" in drivers/irqchip/irq-gic.c is
owned by the dying CPU.

If you read the discussion below, that was one of Will's concerns
with using complete() before we nailed down complete() works.  I'm
sorry, but I'm not wrapping this...

18:00 < rmk> wildea01: can you think of any reason not to use flush_cache_louis() in cpu_die() ?
18:20 < wildea01> let me see...
18:20 < rmk> what I'm thinking of is:
18:20 < rmk>         idle_task_exit();
18:20 < rmk>         local_irq_disable();
18:20 < rmk>         flush_cache_louis();
18:20 < rmk>         mb();
18:20 < rmk>         RCU_NONIDLE(complete(&cpu_died));
18:20 < rmk>         mb();
18:20 < rmk>         if (smp_ops.cpu_die)
18:20 < rmk>                 smp_ops.cpu_die(cpu);
18:21 < rmk> and then killing most of the flush_cache_all() calls in smp_ops.cpu_die()
18:22 < rmk> the only thing I haven't worked out is why some places disable the L1 cache and then flush - especially as that can make any dirty data in the L1 cache suddenly vanish from the CPUs visibility
18:22 < wildea01> might need to be careful with the completion
18:23 < rmk> that's why the mb() is there - another CPU will read the cpu_died thing which means it must have become visible to the other CPUs
18:24 < wildea01> but the cacheline could still be exclusive in our L1 I think
18:24 < rmk> how?  surely it must have become shared because another CPU has read from it?
18:25 < wildea01> I'm thinking of the spin lock -- can we guarantee that another core will have read that before we turn off our cache?
18:27 < rmk> well, can we get out of wait_for_completion without the spin lock having been unlocked?
18:27 < rmk> one of the points of completions is that it should be safe for stuff like this
18:59 < rmk> yes, one of the things that wait_for_completion/complete was invented for was for synchronising a kernel thread exit with cleaning up after it
19:01 < rmk> and if you look at the above functions, the spinlock can't be owned by the CPU calling complete() because wait_for_completion() must reacquire it after complete() has woken the wait_for_completion thread u p
19:04 < rmk> well, I just tried it out on omap4430 and it seems to work fine
19:04 < wildea01> rmk: but complete does a spin_unlock_irqrestore(&x->wait.lock, flags);, now if that sits exclusive in our cache and we power-off before the waiting CPU gets the lock, then we're dead
19:04 < rmk> yes it does, but...
19:04 < wildea01> maybe that's so incredibly unlikely that we don't mind
19:04 < rmk> the other CPU must exit wait_for_completion()
19:05 < rmk> which involves reading/writing that lock too
19:05 < rmk>                         spin_lock_irq(&x->wait.lock);
19:05 < rmk>                 } while (!x->done && timeout);
19:05 < rmk>                 __remove_wait_queue(&x->wait, &wait);
19:05 < rmk>         }
19:05 < rmk>         x->done--;
19:05 < rmk>         return timeout ?: 1;
19:05 < rmk>         spin_unlock_irq(&x->wait.lock);
19:06 < wildea01> hmm, where is that code?
19:06 < rmk> will all be executed on another CPU after that spin_unlock
19:06 < rmk> wait_for_completion->wait_for_common->__wait_for_common->do_wait_for_common
19:07 < wildea01> gotcha, I didn't go as far as do_wait_for_common
19:07 * wildea01 scrolls up
19:07 < rmk> the bits I quoted is the exit path from do_wait_for_common back to wait_for_completion
19:15 < wildea01> I guess the only bit I'm missing is why the the other CPU must exit wait_for_completion before we can proceed with the cpu_die
19:16 < rmk> wrong way round.
19:16 < rmk> complete() must exit completely and be visible before wait_for_completion can return
19:17 < rmk> so there's no way that platform_cpu_kill() can end up being called before that complete() has unlocked that spinlock
19:17 < rmk> and as platform_cpu_kill() is what should be removing power to the dead CPU
19:17 < wildea01> but I don't see how we can guarantee that the other guy has read it
19:17 < wildea01> he might be *just* about to read it
19:18 < wildea01> but it might not have happened
19:18 < rmk>         if (!wait_for_completion_timeout(&cpu_died, msecs_to_jiffies(5000))) {
19:18 < rmk>         }
19:18 < rmk>         printk(KERN_NOTICE "CPU%u: shutdown\n", cpu);
19:18 < rmk> you can't get to that printk until complete() has unlocked the completions spinlock.
19:18 < wildea01> agreed
19:18 < rmk> and that unlock has become visible to the CPU executing the above code
19:19 < wildea01> wait a second: I'm assuming that cpu_die is killing the lights, which some people seem to do iirc?
19:20 < wildea01> if that's all done in platform_cpu_kill, then I think we're ok19:20 < wildea01> as you say
19:20 < rmk> indeed.
19:20 < rmk> it actually depends on how the offlining works.
19:20 < wildea01> so the question is: are there smp_ops.cpu_die which hit the power controller?
19:20 < rmk> yes, but weirdly... because the CPU goes into dead mode when it executes the WFI
19:21 < wildea01> yeah, there's some signal that goes high when that happens, so people like to tie that to the power switch
19:22 < rmk> but that is also fine, because if that's what triggers the power off, we will get there anyway (because platform_cpu_kill won't do that)
19:22 < rmk> err, won't kill the power
19:24 < wildea01> hmm, not sure I follow
19:24 < wildea01> highbank does what you're saying, so we could take that as an example
19:25 < wildea01> (pretending that the cache flush isn't there)
19:26 < rmk> ok.
19:26 < rmk> so what will happen is...
19:27 < rmk> one CPU (not the dying CPU) will end up calling __cpu_die()
19:27 < rmk> the dying CPU will call cpu_die()
19:27 < wildea01> yup
19:27 < rmk> lets call the first one the calling CPU (even though it may not be)
19:28 < wildea01> sure -- it's the guy waiting for the offline to happen
19:28 < rmk> the calling CPU calls into wait_for_completion_timeout() and sits there waiting for the dying CPU to call that complete()
19:28 < rmk> meanwhile, the dying CPU does the idle task exit, disables IRQs, and flushes its caches of any dirty data.
19:29 < rmk> now, the calling CPU has had to take the completion's spinlock, check the counter, release the spinlock, and is waiting for the completion...
19:30 < rmk> so, the dying CPU takes the spinlock, increments the counter, and triggers a wakeup of the calling CPU, and then releases the spinlock.
19:30 < wildea01> yep
19:30 < rmk> the dying CPU now has dirty cache lines again which it probably exclusively owns
19:30 < wildea01> at this point, can we assume that the calling CPU goes off to handle an interrupt or something?
19:31 < rmk> it can do, it could even be the scheduler IPI
19:31 < wildea01> good
19:31 < wildea01> so the dying CPU can proceed past the complete(, with the calling CPU occupied somewhere else
19:31 < rmk> it can do, yes.
19:32 < wildea01> and off into smp_ops.cpu_die => highbank_cpu_die
19:32 < rmk> *OH*, I see what you're getting at
19:32 < wildea01> :)
19:33 < rmk> hmm, how can we get around that...
19:34 < wildea01> it's tricky, because platform_cpu_kill runs on the caller cpu
19:34 < rmk> because, in the case where the power is cut from platform_cpu_kill(), the dying CPU can loose power at any point after that complete()
19:34 < wildea01> so we'd need to split up the `next wfi on core n should kill it' from the `here's my wfi'
19:36 < rmk> I think we could do another flush_cache_louis() after it
19:37 < rmk> if, in the case of platform_cpu_kill() doing the killing of the CPU, that should be fine.
19:37 < wildea01> actually... why do we even need the one before it?
19:37 < wildea01> why not just have one after the complete has returned?
19:37 < rmk> because if platform_cpu_kill() is the call which removes the power, we need to ensure the cache contents have been written out
19:38 < wildea01> ah yeah, I was thinking of requiring both the kill and the die in order for the powerdown, but that's not alwasy necessary
19:38 < wildea01> *always
19:38 < wildea01> last time I checked, nobody used plaform_cpu_kill
19:39 < rmk> umm, lots do
19:39 < rmk> and some do use it to do stuff
19:39 < wildea01> damn, I must've been thinking of something else
19:40 < rmk> well, imx and tegra seem to, but they have their own custom waits implemented probably because of the lack of cache handling in the generic code
19:42 < wildea01> I don't know enough about tegra to understand why their kill and die don't race
19:44 < rmk> ok, looking at the locking barrier doc, we don't need the mb() after the complete() call
19:44 < rmk> but I think to address your concern, we must have another flush_cache_louis() there
19:44 < wildea01> yeah, the unlock should give you that mb
19:45 < wildea01> just seems a shame to have two flushes when they're not usually both needed
19:45 < wildea01> (he assumes)
19:45 < wildea01> like I said, the tegra could looks broken to me
19:45 < wildea01> *code
19:45 < rmk> if we had a louis() version which could flush the cpu_died completion...
19:51 < wildea01> do we even need the mb before the complete?
19:52 < rmk> I've been debating about that, and I think not
19:52 < rmk> I'm just augmenting this with comments as well
19:53 < wildea01> good thinking, I think we've established that it's not simple to understand!
19:59 < rmk> http://www.home.arm.linux.org.uk/~rmk/misc/smp-hotplug.diff
19:59 < rmk> new version of it with lots of comments :)
20:03 < wildea01> looks good to me. The additional flush is a pity, but required, and it's hotplug-off anyway, so not exactly speedy
20:03 < wildea01> one typo in a comment: s/loosing/losing/

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
