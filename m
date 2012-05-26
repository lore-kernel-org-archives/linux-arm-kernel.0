From: ben@decadent.org.uk (Ben Hutchings)
Date: Sat, 26 May 2012 21:19:09 +0100
Subject: [STABLE PATCH] ARM: 7409/1: Do not call flush_cache_user_range
 with mmap_sem held
In-Reply-To: <1337956684-23569-1-git-send-email-will.deacon@arm.com>
References: <1337956684-23569-1-git-send-email-will.deacon@arm.com>
Message-ID: <1338063549.20487.20.camel@deadeye>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-05-25 at 15:38 +0100, Will Deacon wrote:
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
[...]

Both queued up for 3.2.y, thanks.

Ben.

-- 
Ben Hutchings
You can't have everything.  Where would you put it?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 828 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120526/98eb634a/attachment.sig>
