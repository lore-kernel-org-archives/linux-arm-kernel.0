From: olof@lixom.net (Olof Johansson)
Date: Mon, 8 Sep 2014 02:30:51 -0700
Subject: [PATCH] arm64: LLVMLinux: Fix inline arm64 assembly for use with
 clang
In-Reply-To: <1409959460-15989-1-git-send-email-behanw@converseincode.com>
References: <1409959460-15989-1-git-send-email-behanw@converseincode.com>
Message-ID: <20140908093051.GA12657@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 05, 2014 at 04:24:20PM -0700, behanw at converseincode.com wrote:
> From: Mark Charlebois <charlebm@gmail.com>
> 
> Fix variable types for 64-bit inline assembly.
> 
> This patch now works with both gcc and clang.
> 
> Signed-off-by: Mark Charlebois <charlebm@gmail.com>
> Signed-off-by: Behan Webster <behanw@converseincode.com>
> ---
>  arch/arm64/include/asm/arch_timer.h | 26 +++++++++++++++-----------
>  arch/arm64/include/asm/uaccess.h    |  2 +-
>  arch/arm64/kernel/debug-monitors.c  |  8 ++++----
>  arch/arm64/kernel/perf_event.c      | 34 +++++++++++++++++-----------------
>  arch/arm64/mm/mmu.c                 |  2 +-
>  5 files changed, 38 insertions(+), 34 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arch_timer.h
> index 9400596..c1f87e0 100644
> --- a/arch/arm64/include/asm/arch_timer.h
> +++ b/arch/arm64/include/asm/arch_timer.h
> @@ -37,19 +37,23 @@ void arch_timer_reg_write_cp15(int access, enum arch_timer_reg reg, u32 val)
>  	if (access == ARCH_TIMER_PHYS_ACCESS) {
>  		switch (reg) {
>  		case ARCH_TIMER_REG_CTRL:
> -			asm volatile("msr cntp_ctl_el0,  %0" : : "r" (val));
> +			asm volatile("msr cntp_ctl_el0,  %0"
> +				: : "r" ((u64)val));

Ick. Care to elaborate in the patch description why this is needed with
LLVM? It's really messy and very annoying having to cast register values
every time they're passed in, instead of the compiler handling it for you.

Is there a way to catch this with GCC? If not, I expect you to get broken
all the time on this by people who don't notice.



-Olof
