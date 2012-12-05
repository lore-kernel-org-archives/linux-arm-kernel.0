From: frank.rowand@am.sony.com (Frank Rowand)
Date: Tue, 4 Dec 2012 21:05:29 -0800
Subject: [PATCH RT 0/2][RFC] fix RCU stall warning on ARM
In-Reply-To: <50BED1DA.7070907@am.sony.com>
References: <50BED1DA.7070907@am.sony.com>
Message-ID: <50BED619.8060102@am.sony.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/04/12 20:47, Frank Rowand wrote:
> The RCU stall warning functions call trigger_all_cpu_backtrace()
> to print a backtrace on each cpu.  This function is only
> implemented for x86.  Add a version for ARM.
> 
> With CONFIG_PREEMPT_RT_FULL enabled, flushing the output from
> printk() is inhibited in some contexts to avoid increasing
> real time latencies.  The RCU stall warnings are inhibited
> on ARM due to this feature.  (I have not tested whether this
> is also the case on other architectures.)  Add back the
> oops_in_progress flag to allow the RCU stall warnings to
> print immediately.

When I first implemented these patches on a locally modified
3.0.27-rt67, the call to "bust_spinlocks(0)" that I added to
print_cpu_stall() led to LOCKDEP warning of inconsistent
lock state from a trylock in serial_omap_console_write():

        else if (oops_in_progress)
                locked = spin_trylock_irqsave(&up->port.lock, flags);

If I understand correctly, the warning is triggered on the
slow lock path.  Some more of the warning is:

   inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage.
   swapper/1/0 [HC1[1]:SC0[0]:HE0:SE1] takes:
    (&(&(&port->lock)->lock)->wait_lock){?.+...}, at: [<c0478ed0>] rt_spin_trylock_irqsave+0x24/0xe0

   ...

   other info that might help us debug this:
    Possible unsafe locking scenario:

          CPU0
          ----
     lock(&(&(&port->lock)->lock)->wait_lock);
     <Interrupt>
       lock(&(&(&port->lock)->lock)->wait_lock);


I have not been able to trigger the warning on recent versions
of the patches, but I suspect the latent problem might still
exist.

-Frank
