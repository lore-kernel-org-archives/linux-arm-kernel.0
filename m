From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 9 Apr 2013 10:38:56 +0100
Subject: [PATCH 3/4] clocksource: arch_timer: Push the read/write
 wrappers deeper
In-Reply-To: <1365474623-29181-4-git-send-email-sboyd@codeaurora.org>
References: <1365474623-29181-1-git-send-email-sboyd@codeaurora.org>
 <1365474623-29181-4-git-send-email-sboyd@codeaurora.org>
Message-ID: <20130409093855.GU23725@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Apr 09, 2013 at 03:30:22AM +0100, Stephen Boyd wrote:
> We're going to introduce support to read and write the memory
> mapped timer registers in the next patch, so push the cp15
> read/write functions one level deeper. This simplifies the next
> patch and makes it clearer what's going on.
> 
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Marc Zyngier <Marc.Zyngier@arm.com>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  arch/arm/include/asm/arch_timer.h    |  5 ++--
>  arch/arm64/include/asm/arch_timer.h  |  4 ++--
>  drivers/clocksource/arm_arch_timer.c | 44 ++++++++++++++++++++++++------------
>  3 files changed, 34 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/arm/include/asm/arch_timer.h b/arch/arm/include/asm/arch_timer.h
> index 35fea17..560f8a0 100644
> --- a/arch/arm/include/asm/arch_timer.h
> +++ b/arch/arm/include/asm/arch_timer.h
> @@ -18,7 +18,8 @@ int arch_timer_sched_clock_init(void);
>   * nicely work out which register we want, and chuck away the rest of
>   * the code. At least it does so with a recent GCC (4.6.3).
>   */
> -static inline void arch_timer_reg_write(const int access, const int reg, u32 val)
> +static inline void __arch_timer_reg_write(const int access, const int reg,
> +					  u32 val)
>  {
>  	if (access == ARCH_TIMER_PHYS_ACCESS) {
>  		switch (reg) {
> @@ -45,7 +46,7 @@ static inline void arch_timer_reg_write(const int access, const int reg, u32 val
>  	isb();
>  }
>  
> -static inline u32 arch_timer_reg_read(const int access, const int reg)
> +static inline u32 __arch_timer_reg_read(const int access, const int reg)

Rather than prefixing all of these with "__", why not add "cp15" to the names?

I think that'd make the end result more consistent and clearer, as we'd have a
_mem version and a _cp15 version of each function.

Mark.
