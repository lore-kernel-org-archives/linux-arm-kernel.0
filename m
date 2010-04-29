From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 29 Apr 2010 14:00:35 +0100
Subject: [PATCH] [ARM] Do not call flush_cache_user_range with mmap_sem
	held
In-Reply-To: <1272439931-12795-1-git-send-email-dima@android.com>
References: <1272439931-12795-1-git-send-email-dima@android.com>
Message-ID: <20100429130035.GB4877@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 28, 2010 at 12:32:11AM -0700, Dima Zavin wrote:
> We can't be holding the mmap_sem while calling flush_cache_user_range
> because the flush can fault. If we fault on a user address, the
> page fault handler will try to take mmap_sem again. Since both places
> acquire the read lock, most of the time it succeeds. However, if another
> thread tries to acquire the write lock on the mmap_sem (e.g. mmap) in
> between the call to flush_cache_user_range and the fault, the down_read
> in do_page_fault will deadlock.

That's a non-issue.  If do_cache_op is holding a read lock, _nothing_
_else_ can be holding that lock in write mode.  So, holding the lock in
read mode ensures that when faults occur, the fault handler can be sure
that its read lock will succeed.

Other threads trying to get a write lock will be prevented from doing
so until the entire cache flush operation has completed, which ensures
that the mapping can not be altered via munmap/mmap - and that is
completely desirable behaviour.

Please explain why you think this leads to a deadlock.
