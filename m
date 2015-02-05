From: paulmck@linux.vnet.ibm.com (Paul E. McKenney)
Date: Thu, 5 Feb 2015 09:02:28 -0800
Subject: [PATCH v2] ARM: Don't use complete() during __cpu_die
In-Reply-To: <20150205161100.GQ8656@n2100.arm.linux.org.uk>
References: <1423131270-24047-1-git-send-email-k.kozlowski@samsung.com>
 <20150205105035.GL8656@n2100.arm.linux.org.uk>
 <20150205142918.GA10634@linux.vnet.ibm.com>
 <20150205161100.GQ8656@n2100.arm.linux.org.uk>
Message-ID: <20150205170228.GZ5370@linux.vnet.ibm.com>
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
> 
> We could work around that by taking and releasing the lock in the IPI
> processing function... but this is starting to look less attractive
> as the lock is private to irq-gic.c.
> 
> Well, we're very close to 3.19, we're too close to be trying to sort
> this out, so I'm hoping that your changes which cause this RCU error
> are *not* going in during this merge window, because we seem to have
> something of a problem right now which needs more time to resolve.

Most likely into the 3.20 merge window.  But please keep in mind that
RCU is just the messenger here -- the current code will break if any
CPU for whatever reason takes more than a jiffy to get from its
_stop_machine() handler to the end of its last RCU read-side critical
section on its way out.  A jiffy may sound like a lot, but it is not
hard to exceed this limit, especially in virtualized environments.

So not like to go into v3.19, but it does need to be resolved.

							Thanx, Paul
