From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 14 Dec 2010 09:30:02 +0000
Subject: [PATCH 4/4] Do not call flush_cache_user_range with mmap_sem held
In-Reply-To: <1292302659-1863-5-git-send-email-john.stultz@linaro.org>
References: <1292302659-1863-1-git-send-email-john.stultz@linaro.org>
	<1292302659-1863-5-git-send-email-john.stultz@linaro.org>
Message-ID: <20101214093002.GA18425@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 13, 2010 at 08:57:39PM -0800, John Stultz wrote:
> From: Dima Zavin <dima@android.com>
> 
> We can't be holding the mmap_sem while calling flush_cache_user_range
> because the flush can fault. If we fault on a user address, the
> page fault handler will try to take mmap_sem again. Since both places
> acquire the read lock, most of the time it succeeds. However, if another
> thread tries to acquire the write lock on the mmap_sem (e.g. mmap) in
> between the call to flush_cache_user_range and the fault, the down_read
> in do_page_fault will deadlock.
> 
> Also, since we really can't be holding the mmap_sem while calling
> flush_cache_user_range AND vma is actually unused by the flush itself,
> get rid of vma as an argument.

Holding the mmap sem prevents a concurrent munmap, mremap or other change
to the VMA while the flush operation is in progress.  There is no other
lock which will do this for us.

Well, it looks like we can't do this flushing of userspace safely... so
I suggest we disable this interface, thereby preventing userspace from
a whole host of actions requiring cache maintainence.  Unless someone can
come up with a better fix.
