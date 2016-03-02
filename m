From: viro@ZenIV.linux.org.uk (Al Viro)
Date: Wed, 2 Mar 2016 17:57:51 +0000
Subject: [PATCH] Change the spin_lock/unlock_irq interface in
 proc_alloc_inum() function
In-Reply-To: <20160302172954.GI17997@ZenIV.linux.org.uk>
References: <1456886879-28128-1-git-send-email-majun258@huawei.com>
 <20160302030941.GH17997@ZenIV.linux.org.uk>
 <56D688FC.9020202@huawei.com>
 <20160302172954.GI17997@ZenIV.linux.org.uk>
Message-ID: <20160302175751.GJ17997@ZenIV.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 02, 2016 at 05:29:54PM +0000, Al Viro wrote:

> And no, it doesn't save the irq state anywhere - both disable and enable
> are unconditional.  schedule() always returns with irqs enabled.

PS: look at it that way: how would you expect a context switch to behave?
Suppose we blocked because we needed to write some dirty pages on disk
to be able to free them; we *can't* keep irqs disabled through all of that,
right?  After all, disk controller needs to be able to tell us it's done
writing; hard to do that with interrupts disabled, not to mention that
keeping them disabled for typical duration of disk write would be rather
antisocial.  So no matter how schedule() behaves wrt irqs, doing it with
irqs disabled would either invite deadlocks, or enable irqs at least for
a while.  Even if it remembered that you used to have them disabled and
re-disabled them when switching back, you would still lose whatever protection
you were getting from having them disabled in the first place.  If e.g.
you call request_irq() before being done setting the things up for
interrupt handler and count on finishing that before reenabling irqs, you
would need irqs to _stay_ disabled through all of that.  And with any
blocking allocations there's no way to guarantee that.
