From: peter.chen@freescale.com (Peter Chen)
Date: Tue, 15 Oct 2013 10:18:15 +0800
Subject: [PATCH 01/11] usb: chipidea: Add power management support
In-Reply-To: <20131014110108.GL25034@n2100.arm.linux.org.uk>
References: <1381570513-24927-1-git-send-email-peter.chen@freescale.com>
 <1381570513-24927-2-git-send-email-peter.chen@freescale.com>
 <20131014110108.GL25034@n2100.arm.linux.org.uk>
Message-ID: <20131015021814.GA3254@shlinux1.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 14, 2013 at 12:01:08PM +0100, Russell King - ARM Linux wrote:
> On Sat, Oct 12, 2013 at 05:35:03PM +0800, Peter Chen wrote:
> > This commit adds runtime and system power management support for
> > chipidea core. The runtime pm support is controlled by glue
> > layer, it can be enabled by flag CI_HDRC_SUPPORTS_RUNTIME_PM.
> 
> Let's look at the locking.
> 
> 1. Runtime PM.  These callbacks are locked with a spinlock, which holds
>    dev->power.lock.  This lock is taken either with or without disabling
>    IRQs depending on whether runtime PM is IRQ safe or not.
> 
> 2. Normal PM.  These callbacks are locked by holding dev->mutex.
> 
> Now, there's a little bit of protection between these two operations -
> when normal PM places a device into a low power state, it 'gets' a
> reference on the runtime PM to ensure no runtime PM transitions occur
> while normal PM is active.  (See pm_runtime_get_noresume() in
> device_prepare().)  This is only dropped when the normal PM resumes the
> device.
> 
> Moreover, all runtime PM events are flushed before the suspend callback
> occurs (see the pm_runtime_barrier() in __device_suspend()).
> 
> What that means is that you can't receive any runtime PM events while
> you are in your suspend/resume callbacks.  So, each call is mutually
> exclusive.
> 
> So, runtime PM callbacks vs normal PM callbacks for any single device
> are all called with mutual exclusion - you won't have two running at
> any time.
> 
> Hence, for the reasons stated previously about the non-atomic nature of
> atomic_read()/atomic_set(), there's even more reasons that their use
> here is just mere obfuscation: the accesses to this state tracking
> variable is already guaranteed to be single-threaded by core code, so
> the use of atomic_read()/atomic_set() just adds additional needless
> confusion to this code.
> 

Many Thanks, Russell.

So, the lessons for this topic are:

- If one atomic variable's operation only includes one instruction like
atomic_read and atomic_set, it is not meaningful for using atomic
operation, we can just use bool instead of it.

- The runtime pm itself, normal pm itself, runtime pm and normal pm
are all already exclusion, we don't need protection for variables
who are only used at pm situation.

-- 

Best Regards,
Peter Chen
