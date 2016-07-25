From: will.deacon@arm.com (Will Deacon)
Date: Mon, 25 Jul 2016 16:31:19 +0100
Subject: [PATCH v9 4/9] clocksource/drivers/arm_arch_timer: use readq to
 get 64-bit CNTVCT
In-Reply-To: <1469460427-8643-5-git-send-email-fu.wei@linaro.org>
References: <1469460427-8643-1-git-send-email-fu.wei@linaro.org>
 <1469460427-8643-5-git-send-email-fu.wei@linaro.org>
Message-ID: <20160725153118.GD19209@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 25, 2016 at 11:27:02PM +0800, fu.wei at linaro.org wrote:
> From: Fu Wei <fu.wei@linaro.org>
> 
> This patch simplify arch_counter_get_cntvct_mem function by
> using readq to get 64-bit CNTVCT value instead of readl_relaxed.
> 
> Signed-off-by: Fu Wei <fu.wei@linaro.org>
> ---
>  drivers/clocksource/arm_arch_timer.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> index e6fd42d..483d2f9 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -418,15 +418,7 @@ u32 arch_timer_get_rate(void)
>  
>  static u64 arch_counter_get_cntvct_mem(void)
>  {
> -	u32 vct_lo, vct_hi, tmp_hi;
> -
> -	do {
> -		vct_hi = readl_relaxed(arch_counter_base + CNTVCT_HI);
> -		vct_lo = readl_relaxed(arch_counter_base + CNTVCT_LO);
> -		tmp_hi = readl_relaxed(arch_counter_base + CNTVCT_HI);
> -	} while (vct_hi != tmp_hi);
> -
> -	return ((u64) vct_hi << 32) | vct_lo;
> +	return readq(arch_counter_base + CNTVCT_LO);

Please drop this patch. It doesn't work.

http://lists.infradead.org/pipermail/linux-arm-kernel/2016-July/445369.html

Will
