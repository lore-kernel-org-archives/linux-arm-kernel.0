From: greg@kroah.com (Greg KH)
Date: Sun, 27 May 2012 09:07:38 +0900
Subject: [STABLE PATCH] ARM: 7409/1: Do not call flush_cache_user_range
 with mmap_sem held
In-Reply-To: <1337956684-23569-1-git-send-email-will.deacon@arm.com>
References: <1337956684-23569-1-git-send-email-will.deacon@arm.com>
Message-ID: <20120527000738.GF14234@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 25, 2012 at 03:38:04PM +0100, Will Deacon wrote:
> From: Dima Zavin <dima@android.com>
> 
> commit 435a7ef52db7d86e67a009b36cac1457f8972391 upstream
> 
> We can't be holding the mmap_sem while calling flush_cache_user_range
> because the flush can fault. If we fault on a user address, the
> page fault handler will try to take mmap_sem again. Since both places
> acquire the read lock, most of the time it succeeds. However, if another
> thread tries to acquire the write lock on the mmap_sem (e.g. mmap) in
> between the call to flush_cache_user_range and the fault, the down_read
> in do_page_fault will deadlock.
> 
> [will: removed drop of vma parameter as already queued by rmk (7365/1)]
> 
> Cc: <stable@vger.kernel.org> # 2.6.32+: 4542b6a0: ARM: 7365/1
> Cc: <stable@vger.kernel.org> # 2.6.32+
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Dima Zavin <dima@android.com>
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
> 
> Greg: This patch is a candidate for -stable, but its dependency (listed
>       above) wasn't marked as such, hence this retrospective submission.

Both now queued up for 3.0, 3.3, and 3.4-stable trees

greg k-h
