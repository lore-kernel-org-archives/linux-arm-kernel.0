From: keescook@chromium.org (Kees Cook)
Date: Wed, 4 May 2016 10:20:01 -0700
Subject: [PATCH] arm64: Make arch_randomize_brk avoid stack area
In-Reply-To: <1462370994.2895.11.camel@linaro.org>
References: <1461848638.2848.19.camel@linaro.org>
 <1462370994.2895.11.camel@linaro.org>
Message-ID: <CAGXu5jKDh+B7ZzecHtqqHCqGbqs9fXvNAAw7kpTjPCdmQTd7KA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 4, 2016 at 7:09 AM, Jon Medhurst (Tixy) <tixy@linaro.org> wrote:
> When a process is created, various address randomisations could end up
> colluding to place the address of brk in the stack memory. This would
> mean processes making small heap based memory allocations are in danger
> of having them overwriting, or overwritten by, the stack.
>
> Another consequence, is that even for processes that make no use of
> brk, the output of /proc/*/maps may show the stack area listed as
> '[heap]' rather than '[stack]'. Apart from being misleading this causes
> fatal errors with the Android run-time like:
> "No [stack] line found in /proc/self/task/*/maps"
>
> To prevent this problem pick a limit for brk that allows for the stack's
> memory. At the same time we remove randomize_base() as that was only
> used by arch_randomize_brk().
>
> Note, in practice, since commit d1fd836dcf00 ("mm: split ET_DYN ASLR
> from mmap ASLR") this problem shouldn't occur because the address chosen
> for loading binaries is well clear of the stack, however, prior to that
> the problem does occur because of the following...
>
> The memory layout of a task is determined by arch_pick_mmap_layout. If
> address randomisation is enabled (task has flag PF_RANDOMIZE) this sets
> mmap_base to a random address at the top of task memory just below a
> region calculated to allow for a stack which itself may have a random
> base address. Any mmap operations that then happen which require an
> address allocating will use the topdown allocation method, i.e. the
> first allocated memory will be at the top of memory, just below the
> area set aside for the stack.
>
> When a relocatable binary is loaded into a new process by
> load_elf_binary and randomised address are enabled, it uses a
> 'load_bias' of zero, so that when mmap is called to create a memory
> region for it, a new address is picked (address zero not being
> available). As this is the first memory region in the task, it gets the
> region just below the stack, as described previously.
>
> The loader then set's brk to the end of the elf data section, which will
> be near the end of the loaded binary and then it calls
> arch_randomize_brk. As this currently stands, this adds a random amount
> to brk, which unfortunately may take it into the address range where the
> stack lies.
>
> Testing:
>
> These changes have been tested on Linux v4.6-rc4 using 100000
> invocations of a program [1] that can display the offset of a process's
> brk...
>
> $for i in $(seq 100000); do ./aslr --report brk ; done
>
> This shows values of brk are evenly distributed over a 1GB range, both
> before and after this change.
>
> With Linux version 3.18 (where the collision of brk and stack can happen
> and this change limits brk to avoid that) the distribution of brk values
> after the change shows a slope where lower values for brk are more
> common and upper values have about half the frequency of those.
>
> [1] http://bazaar.launchpad.net/~ubuntu-bugcontrol/qa-regression-testing/master/files/2499/scripts/kernel-security/aslr/
>
> Signed-off-by: Jon Medhurst <tixy@linaro.org>
> Cc: <stable@vger.kernel.org> # 4.0 and earlier

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

>
> ---
>
> Changes since RFC.
> - Fixed compilation errors (finger trouble preparing original email)
> - Updated commit message to included notes on testing
> - Added CC stable for Linux '4.0 and earlier'
>
>  arch/arm64/kernel/process.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index 8062482..26429a0 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -382,13 +382,25 @@ unsigned long arch_align_stack(unsigned long sp)
>         return sp & ~0xf;
>  }
>
> -static unsigned long randomize_base(unsigned long base)
> +unsigned long arch_randomize_brk(struct mm_struct *mm)
>  {
> +       unsigned long base = mm->brk;
>         unsigned long range_end = base + (STACK_RND_MASK << PAGE_SHIFT) + 1;
> -       return randomize_range(base, range_end, 0) ? : base;
> -}
> +       unsigned long max_stack, range_limit;
>
> -unsigned long arch_randomize_brk(struct mm_struct *mm)
> -{
> -       return randomize_base(mm->brk);
> +       /*
> +        * Determine how much room we need to leave available for the stack.
> +        * We limit this to a reasonable value, because extremely large or
> +        * unlimited stacks are always going to bump up against brk at some
> +        * point and we don't want to fail to randomise brk in those cases.
> +        */
> +       max_stack = rlimit(RLIMIT_STACK);
> +       if (max_stack > SZ_128M)
> +               max_stack = SZ_128M;
> +
> +       range_limit = mm->start_stack - max_stack - 1;
> +       if (range_end > range_limit)
> +               range_end = range_limit;
> +
> +       return randomize_range(base, range_end, 0) ? : base;
>  }
> --
> 2.1.4
>
>



-- 
Kees Cook
Chrome OS & Brillo Security
