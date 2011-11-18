From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 18 Nov 2011 16:56:24 +0000
Subject: [PATCH 4/4] ARM: idmap: use idmap_pgd when setting up mm for
 reboot
In-Reply-To: <1321462094-6647-5-git-send-email-will.deacon@arm.com>
References: <1321462094-6647-1-git-send-email-will.deacon@arm.com>
 <1321462094-6647-5-git-send-email-will.deacon@arm.com>
Message-ID: <CAHkRjk4c1Q7+q9-fc+KXc3ySwnVPXbfBGJbqL2QvpHCqtNK_Tw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 November 2011 16:48, Will Deacon <will.deacon@arm.com> wrote:
> For soft-rebooting a system, it is necessary to map the MMU-off code
> with an identity mapping so that execution can continue safely once the
> MMU has been switched off.
>
> Currently, switch_mm_for_reboot takes out a 1:1 mapping from 0x0 to
> TASK_SIZE during reboot in the hope that the reset code lives at a
> physical address corresponding to a userspace virtual address.
>
> This patch modifies the code so that we switch to the idmap_pgd tables,
> which contain a 1:1 mapping of the cpu_reset code. This has the
> advantage of only remapping the code that we need and also means we
> don't need to worry about allocating a pgd from an atomic context in the
> case that the physical address of the cpu_reset code aliases with the
> virtual space used by the kernel.
>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
> ?arch/arm/mm/idmap.c | ? 19 ++++++++++---------
> ?1 files changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/arch/arm/mm/idmap.c b/arch/arm/mm/idmap.c
> index 8c1230a..0f96fb2 100644
> --- a/arch/arm/mm/idmap.c
> +++ b/arch/arm/mm/idmap.c
> @@ -104,17 +104,18 @@ static int __init init_static_idmap(void)
> ?arch_initcall(init_static_idmap);
>
> ?/*
> - * In order to soft-boot, we need to insert a 1:1 mapping in place of
> - * the user-mode pages. ?This will then ensure that we have predictable
> - * results when turning the mmu off
> + * In order to soft-boot, we need to switch to a 1:1 mapping for the
> + * cpu_reset functions. This will then ensure that we have predictable
> + * results when turning off the mmu.
> ?*/
> ?void setup_mm_for_reboot(char mode)
> ?{
> - ? ? ? /*
> - ? ? ? ?* We need to access to user-mode page tables here. For kernel threads
> - ? ? ? ?* we don't have any user-mode mappings so we use the context that we
> - ? ? ? ?* "borrowed".
> - ? ? ? ?*/
> - ? ? ? identity_mapping_add(current->active_mm->pgd, 0, TASK_SIZE);
> + ? ? ? /* Clean and invalidate L1. */
> + ? ? ? flush_cache_all();

Is the cache flushing needed here? The setup_mm_for_reboot callers do
it after this function anyway (unless this is needed for VIVT
caches?).

-- 
Catalin
