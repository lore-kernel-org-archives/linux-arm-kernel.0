From: markivx@codeaurora.org (Vikram Mulukutla)
Date: Thu, 17 Nov 2016 18:22:25 -0800
Subject: spin_lock behavior with ARM64 big.Little/HMP
Message-ID: <400ab4b8b2354c5b9283f6ed657363a0@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This isn't really a bug report, but just a description of a 
frequency/IPC
dependent behavior that I'm curious if we should worry about. The 
behavior
is exposed by questionable design so I'm leaning towards don't-care.

Consider these threads running in parallel on two ARM64 CPUs running 
mainline
Linux:

(Ordering of lines between the two columns does not indicate a sequence 
of
execution. Assume flag=0 initially.)

LittleARM64_CPU @ 300MHz (e.g.A53)   |  BigARM64_CPU @ 1.5GHz (e.g. A57)
-------------------------------------+----------------------------------
spin_lock_irqsave(s)                 |  local_irq_save()
/* critical section */
flag = 1                             |  spin_lock(s)
spin_unlock_irqrestore(s)            |  while (!flag) {
                                      |      spin_unlock(s)
                                      |      cpu_relax();
                                      |      spin_lock(s)
                                      |  }
                                      |  spin_unlock(s)
                                      |  local_irq_restore()

I see a livelock occurring where the LittleCPU is never able to acquire 
the
lock, and the BigCPU is stuck forever waiting on 'flag' to be set.

Even with ticket spinlocks, this bit of code can cause a livelock (or 
very
long delays) if BigCPU runs fast enough. Afaics this can only happen if 
the
LittleCPU is unable to put its ticket in the queue (i.e, increment the 
next
field) since the store-exclusive keeps failing.

The problem is not present on SMP, and is mitigated by adding enough
additional clock cycles between the unlock and lock in the loop running
on the BigCPU. On big.Little, if both threads are scheduled on the same
cluster within the same clock domain, the problem is avoided.

Now the infinite loop may seem like questionable design but the problem
isn't entirely hypothetical; if BigCPU calls hrtimer_cancel with
interrupts disabled, this scenario can result if the hrtimer is about
to run on a littleCPU. It's of course possible that there's just enough
intervening code for the problem to not occur. At the very least it 
seems
that loops like the one running in the BigCPU above should come with a
WARN_ON(irqs_disabled) or with a sufficient udelay() instead of the 
cpu_relax.

Thoughts?

Thanks,
Vikram
