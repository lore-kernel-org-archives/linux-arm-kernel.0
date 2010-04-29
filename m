From: jamie@shareable.org (Jamie Lokier)
Date: Thu, 29 Apr 2010 19:16:36 +0100
Subject: [PATCH] [ARM] Do not call flush_cache_user_range with mmap_sem
	held
In-Reply-To: <20100429130035.GB4877@n2100.arm.linux.org.uk>
References: <1272439931-12795-1-git-send-email-dima@android.com>
	<20100429130035.GB4877@n2100.arm.linux.org.uk>
Message-ID: <20100429181636.GA25894@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> On Wed, Apr 28, 2010 at 12:32:11AM -0700, Dima Zavin wrote:
> > We can't be holding the mmap_sem while calling flush_cache_user_range
> > because the flush can fault. If we fault on a user address, the
> > page fault handler will try to take mmap_sem again. Since both places
> > acquire the read lock, most of the time it succeeds. However, if another
> > thread tries to acquire the write lock on the mmap_sem (e.g. mmap) in
> > between the call to flush_cache_user_range and the fault, the down_read
> > in do_page_fault will deadlock.
> 
> That's a non-issue.  If do_cache_op is holding a read lock, _nothing_
> _else_ can be holding that lock in write mode.  So, holding the lock in
> read mode ensures that when faults occur, the fault handler can be sure
> that its read lock will succeed.

read-write locks will block a reader when there is a already blocked
writer.  Otherwise the writer can be permanently starved due to new
readers always arriving so reader count doesn't reach zero.

In other words, readers queue behind writers if there's a waiting writer.

-- Jamie
