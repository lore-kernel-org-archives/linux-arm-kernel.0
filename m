From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 06 May 2010 16:08:50 +0100
Subject: [PATCH] [ARM] Do not call flush_cache_user_range with mmap_sem
	held
In-Reply-To: <1272439931-12795-1-git-send-email-dima@android.com>
References: <1272439931-12795-1-git-send-email-dima@android.com>
Message-ID: <1273158530.2094.34.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-04-28 at 08:32 +0100, Dima Zavin wrote:
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
> 
> Signed-off-by: Dima Zavin <dima@android.com>
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> Cc: Arve Hj?nnev?g <arve@android.com>

FWIW (and since I added the USER() macros to the *_coherent_user_range()
functions - commit 32cfb1b1), my view is that this is a safe patch (of
course, Russell has to agree with this as well):

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

-- 
Catalin
