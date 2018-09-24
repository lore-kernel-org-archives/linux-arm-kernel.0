From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 24 Sep 2018 18:19:36 +0100
Subject: [PATCH v5 0/6] Move swapper_pg_dir to rodata section.
In-Reply-To: <20180917044333.30051-1-yaojun8558363@gmail.com>
References: <20180917044333.30051-1-yaojun8558363@gmail.com>
Message-ID: <20180924171936.q5bfvczzllmm5lpe@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Sep 17, 2018 at 12:43:27PM +0800, Jun Yao wrote:
> Version 5 changes:
> 	1. Correct spelling and indentation errors[1].
> 	2. Update init_mm.pgd by assembly[2].
> 	3. Simplify set_p?d() by introducing set_swapper_pgd()[3].
> 	4. Reduce unnecessary tlbi for every write to swapper_pg_dir
> 	   during paging_init()[3].
> 
> v4: https://www.spinics.net/lists/arm-kernel/msg672195.html
> v3: https://www.spinics.net/lists/arm-kernel/msg662537.html
> v2: https://patchwork.kernel.org/patch/10485641/
> v1: https://patchwork.kernel.org/patch/10476595/
> 
> [1] https://www.spinics.net/lists/arm-kernel/msg675189.html
> [2] https://www.spinics.net/lists/arm-kernel/msg675193.html
> [3] https://www.spinics.net/lists/arm-kernel/msg675196.html
> 
> Jun Yao (6):
>   arm64/mm: Introduce the init_pg_dir.
>   arm64/mm: Pass ttbr1 as a parameter to __enable_mmu().
>   arm64/mm: Create the initial page table in the init_pg_dir.
>   arm64/mm: Create the final page table directly in swapper_pg_dir.
>   arm64/mm: Populate the swapper_pg_dir by fixmap.
>   arm64/mm: Move {idmap_pg_dir .. swapper_pg_dir} to rodata section.
> 
>  arch/arm64/include/asm/assembler.h | 29 ++++++++++++++++++
>  arch/arm64/include/asm/pgtable.h   | 36 ++++++++++++++++++----
>  arch/arm64/kernel/asm-offsets.c    |  1 +
>  arch/arm64/kernel/head.S           | 48 ++++++++++++++++++++----------
>  arch/arm64/kernel/sleep.S          |  1 +
>  arch/arm64/kernel/vmlinux.lds.S    | 47 +++++++++++++++++++----------
>  arch/arm64/mm/mmu.c                | 45 +++++++++++++---------------
>  7 files changed, 147 insertions(+), 60 deletions(-)

I've pushed a branch with the cleanups I requested [1] folded in.

I'm still a bit worried about the pgd lock, but otherwise I think this
is sound. I intend to throw some testing at it, just in case.

If you're happy with that branch, I'll ask Will and Catalin to consider
picking it up.

Thanks,
Mark.

[1] git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git arm64/ro-swapper
