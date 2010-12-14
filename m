From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 14 Dec 2010 18:18:38 +0000
Subject: [PATCH 4/4] Do not call flush_cache_user_range with mmap_sem held
In-Reply-To: <1292302659-1863-5-git-send-email-john.stultz@linaro.org>
References: <1292302659-1863-1-git-send-email-john.stultz@linaro.org>
	<1292302659-1863-5-git-send-email-john.stultz@linaro.org>
Message-ID: <AANLkTikqza9kdqj_KTMUinX_UmuRYQ+ERpVT-xe8xDJA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 December 2010 04:57, John Stultz <john.stultz@linaro.org> wrote:
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
>
> CC: Nicolas Pitre <nicolas.pitre@linaro.org>
> CC: Russell King <linux@arm.linux.org.uk>
> Signed-off-by: Dima Zavin <dima@android.com>
> Signed-off-by: John Stultz <john.stultz@linaro.org>
