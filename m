From: vinmenon@codeaurora.org (Vinayak Menon)
Date: Wed, 6 Dec 2017 23:01:46 +0530
Subject: [PATCH 0/2] Fixes for SW PAN
In-Reply-To: <1512558968-28980-1-git-send-email-will.deacon@arm.com>
References: <1512558968-28980-1-git-send-email-will.deacon@arm.com>
Message-ID: <5ee0b1f1-c7fc-af92-2b34-4555e59d7a20@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/6/2017 4:46 PM, Will Deacon wrote:
> Hi all,
>
> After lots of collective head scratching in response to Vinayak's mail
> here:
>
>   http://lists.infradead.org/pipermail/linux-arm-kernel/2017-December/545641.html
>
> It turns out that we have a problem with SW PAN and kernel threads, where
> the saved ttbr0 value for a kernel thread can be stale and subsequently
> inherited by other kernel threads over a fork.
>
> These two patches attempt to fix that. We've not be able to reproduce
> the exact failure reported above, but I added some assertions to the
> uaccess routines to check for discrepancies between the active_mm pgd
> and the saved ttbr0 value (ignoring the zero page) and these no longer
> fire with these changes, but do fire without them if EFI runtime services
> are enabled on my Seattle board.

Thanks Will. So these 2 patches fix the case of kthreads having a stale saved ttbr0. The callstack I had shared
in the original issue description was not of a kthread (its user task with PF_KTHREAD not set. The tsk->mm was
set to NULL by exit_mm I think). So do you think this could be a different problem ?
I had a look at the dumps again and what I see is that, the PA part of the saved ttbr0
(from thread_info) is not the same as the pa(tsk->active_mm->pgd). The PA derived from saved ttbr0 actually
points to a page which is "now" owned by slab.
>
> Cheers,
>
> Will
>
> --->8
>
> Will Deacon (2):
>   arm64: SW PAN: Point saved ttbr0 at the zero page when switching to
>     init_mm
>   arm64: SW PAN: Update saved ttbr0 value on enter_lazy_tlb
>
>  arch/arm64/include/asm/efi.h         |  4 +---
>  arch/arm64/include/asm/mmu_context.h | 46 ++++++++++++++++++------------------
>  2 files changed, 24 insertions(+), 26 deletions(-)
>
