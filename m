From: will.deacon@arm.com (Will Deacon)
Date: Thu, 4 Jan 2018 11:40:28 +0000
Subject: [PATCH] arm64: asid: Do not replace active_asids if already 0
In-Reply-To: <20180104111721.33834-1-catalin.marinas@arm.com>
References: <20180104111721.33834-1-catalin.marinas@arm.com>
Message-ID: <20180104114028.GA10756@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

This is really awesome work!

On Thu, Jan 04, 2018 at 11:17:21AM +0000, Catalin Marinas wrote:
> Under some uncommon timing conditions, a generation check and
> xchg(active_asids, A1) in check_and_switch_context() on P1 can race with
> an ASID roll-over on P2. If P2 has not seen the update to
> active_asids[P1], it can re-allocate A1 to a new task T2 on P2. P1 ends
> up waiting on the spinlock since the xchg() returned 0 while P2 can go
> through a second ASID roll-over with (T2,A1,G2) active on P2. This
> roll-over copies active_asids[P1] == A1,G1 into reserved_asids[P1] and
> active_asids[P2] == A1,G2 into reserved_asids[P2]. A subsequent
> scheduling of T1 on P1 and T2 on P2 would match reserved_asids and get
> their generation bumped to G3:
> 
> P1					P2
> --                                      --
> TTBR0.BADDR = T0
> TTBR0.ASID = A0
> asid_generation = G1
> check_and_switch_context(T1,A1,G1)
>   generation match
> 					check_and_switch_context(T2,A0,G0)
>  				          new_context()
> 					    ASID roll-over
> 					    asid_generation = G2
> 					    flush_context()
> 					      active_asids[P1] = 0
> 					      asid_map[A1] = 0
> 					      reserved_asids[P1] = A0,G0
>   xchg(active_asids, A1)
>     active_asids[P1] = A1,G1
>     xchg returns 0
>   spin_lock_irqsave()
> 					    allocated ASID (T2,A1,G2)
> 					    asid_map[A1] = 1
> 					  active_asids[P2] = A1,G2
> 					...
> 					check_and_switch_context(T3,A0,G0)
> 					  new_context()
> 					    ASID roll-over
> 					    asid_generation = G3
> 					    flush_context()
> 					      active_asids[P1] = 0
> 					      asid_map[A1] = 1
> 					      reserved_asids[P1] = A1,G1
> 					      reserved_asids[P2] = A1,G2
> 					    allocated ASID (T3,A2,G3)
> 					    asid_map[A2] = 1
> 					  active_asids[P2] = A2,G3
>   new_context()
>     check_update_reserved_asid(A1,G1)
>       matches reserved_asid[P1]
>       reserved_asid[P1] = A1,G3
>   updated T1 ASID to (T1,A1,G3)
> 					check_and_switch_context(T2,A1,G2)
> 					  new_context()
> 					    check_and_switch_context(A1,G2)
> 					      matches reserved_asids[P2]
> 					      reserved_asids[P2] = A1,G3
> 					  updated T2 ASID to (T2,A1,G3)
> 
> At this point, we have two tasks, T1 and T2 both using ASID A1 with the
> latest generation G3. Any of them is allowed to be scheduled on the
> other CPU leading to two different tasks with the same ASID on the same
> CPU.
> 
> This patch changes the xchg to cmpxchg so that the active_asids is only
> updated if non-zero to avoid a race with an ASID roll-over on a
> different CPU.
> 
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
> 
> We could add a cc stable as the patch is not invasive but I doubt one
> could trigger this under normal circumstances. I would say the (still
> small) probability is slightly increased under virtualisation when a
> vCPU could be scheduled out for a longer time allowing other vCPUs to go
> through a new roll-over.
> 
> An arm32 patch will follow as well.
> 
> (and we now have a formally verified ASID allocator ;))

It would be cool to mention the verifier in the commit message; potentially
even including the code somewhere so that it can be used to test future
changes. For example, I did something similar for the qrwlock and pushed
the changes here:

https://git.kernel.org/pub/scm/linux/kernel/git/will/qrwlock-rmem.git/

Anyway, for the patch:

Acked-by: Will Deacon <will.deacon@arm.com>
Reviewed-by: Will Deacon <will.deacon@arm.com>

I don't see the need for stable; this race isn't going to occur in
practice.

Will
