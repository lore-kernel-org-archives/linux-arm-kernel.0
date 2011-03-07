From: rabin@rab.in (Rabin Vincent)
Date: Mon, 7 Mar 2011 20:14:58 +0530
Subject: Question about free_pgd_slow ?
In-Reply-To: <14bf5cc1.490f.12e858767f5.Coremail.bill_carson@126.com>
References: <79b2dce2.4b84.12e5ae30c01.Coremail.bill_carson@126.com>
	<AANLkTi=obVFm=cwDyUCXQvEK3rDYberc9YWRVkv6_qZ=@mail.gmail.com>
	<14bf5cc1.490f.12e858767f5.Coremail.bill_carson@126.com>
Message-ID: <AANLkTikyeE=YEJ03-zewU9i_aMfG=A9kOKdpe4Fywax6@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/3/5 rocky <bill_carson@126.com>:
> But I still dont get it, why is that  low vector mapping must always
> be active even though the task is going to exit?

exit_mmap() is called by the exiting task.  In this case, the page table
that free_pgtables() operates on is the page table which is currently
in use.  Consider what would happen if we remove the vector mapping here
and an interrupt hits immediately after -- the cpu will (recursively)
fault while trying to find the vector page mapping.

pgd_free() on the other hand is safe because it's called when we've
switched away from this mm, and the page table is no longer in use
(mm->mm_count == 0).

Have a look at exit_mm(), which increases the mm_count before calling
mm_put(), and finish_task_switch(), which does the mmdrop().
