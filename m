From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 11 Jan 2013 18:57:44 +0530
Subject: [PATCHv2 05/11] arm: arch_timer: split cntfrq accessor
In-Reply-To: <1357747640-18594-6-git-send-email-mark.rutland@arm.com>
References: <1357747640-18594-1-git-send-email-mark.rutland@arm.com>
 <1357747640-18594-6-git-send-email-mark.rutland@arm.com>
Message-ID: <50F01350.4040107@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 09 January 2013 09:37 PM, Mark Rutland wrote:
> The CNTFRQ register is not duplicated for physical and virtual timers,
> and accessing it as if it were is confusing.
>
> Instead, use a separate accessor which doesn't take the access type
> as a parameter.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>   arch/arm/kernel/arch_timer.c |   17 +++++++++--------
>   1 files changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm/kernel/arch_timer.c b/arch/arm/kernel/arch_timer.c
> index 0d2681c..fc87d3d 100644
> --- a/arch/arm/kernel/arch_timer.c
> +++ b/arch/arm/kernel/arch_timer.c
> @@ -51,8 +51,7 @@ static bool arch_timer_use_virtual = true;
>   #define ARCH_TIMER_CTRL_IT_STAT		(1 << 2)
>
>   #define ARCH_TIMER_REG_CTRL		0
> -#define ARCH_TIMER_REG_FREQ		1
> -#define ARCH_TIMER_REG_TVAL		2
> +#define ARCH_TIMER_REG_TVAL		1
>
>   #define ARCH_TIMER_PHYS_ACCESS		0
>   #define ARCH_TIMER_VIRT_ACCESS		1
> @@ -101,9 +100,6 @@ static inline u32 arch_timer_reg_read(const int access, const int reg)
>   		case ARCH_TIMER_REG_TVAL:
>   			asm volatile("mrc p15, 0, %0, c14, c2, 0" : "=r" (val));
>   			break;
> -		case ARCH_TIMER_REG_FREQ:
> -			asm volatile("mrc p15, 0, %0, c14, c0, 0" : "=r" (val));
> -			break;
>   		}
>   	}
>
> @@ -121,6 +117,13 @@ static inline u32 arch_timer_reg_read(const int access, const int reg)
>   	return val;
>   }
>
> +static inline u32 arch_timer_get_cntfrq(void)
> +{
> +	u32 val;
> +	asm volatile("mrc p15, 0, %0, c14, c0, 0" : "=r" (val));
> +	return val;
> +}
> +
>   static inline u64 arch_counter_get_cntpct(void)
>   {
>   	u64 cval;
> @@ -253,9 +256,7 @@ static int arch_timer_available(void)
>   	u32 freq;
>
>   	if (arch_timer_rate == 0) {
> -		freq = arch_timer_reg_read(ARCH_TIMER_PHYS_ACCESS,
> -					   ARCH_TIMER_REG_FREQ);
> -
> +		freq = arch_timer_get_cntfrq();
Not related to this patch a new line here will be good.
>   		/* Check the timer frequency. */
>   		if (freq == 0) {
>   			pr_warn("Architected timer frequency not available\n");
>
Otherwise patch looks fine to me.
Acked-by: Santosh Shilimkar<santosh.shilimkar@ti.com>
