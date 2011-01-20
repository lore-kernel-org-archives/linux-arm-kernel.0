From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 20 Jan 2011 14:08:11 +0000
Subject: [PATCH] ARM: TWD: fix the clock calculation for TWD
In-Reply-To: <1295505237-5735-1-git-send-email-chao.xie@marvell.com>
References: <1295505237-5735-1-git-send-email-chao.xie@marvell.com>
Message-ID: <20110120140811.GE6335@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 20, 2011 at 02:33:57PM +0800, Chao Xie wrote:
> The original code will do count * (HZ /5). It will make the twd
> timer rate decreased if HZ can not be excatly divided. For
> example HZ=128.
> 
> Signed-off-by: Chao Xie <chao.xie@marvell.com>
> ---
>  arch/arm/kernel/smp_twd.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
> index 35882fb..ca6405b 100644
> --- a/arch/arm/kernel/smp_twd.c
> +++ b/arch/arm/kernel/smp_twd.c
> @@ -111,7 +111,8 @@ static void __cpuinit twd_calibrate_rate(void)
>  
>  		count = __raw_readl(twd_base + TWD_TIMER_COUNTER);
>  
> -		twd_timer_rate = (0xFFFFFFFFU - count) * (HZ / 5);
> +		twd_timer_rate = ((unsigned long)(0xFFFFFFFFU - count))
> +			* HZ / 5;
>  
>  		printk("%lu.%02luMHz.\n", twd_timer_rate / 1000000,
>  			(twd_timer_rate / 100000) % 100);

I don't think this patch has any effect what so ever, so I just tried:

#define HZ      128
unsigned long twd_timer_rate;
void calc1(unsigned long count)
{
        twd_timer_rate = (0xffffffffU - count) * (HZ / 5);
}
void calc2(unsigned long count)
{
        twd_timer_rate = ((unsigned long)(0xffffffffU - count)) * (HZ / 5);
}

calc1:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	mvn	r0, r0
	add	r0, r0, r0, asl #2
	ldr	r3, .L2
	add	r0, r0, r0, asl #2
	@ lr needed for prologue
	str	r0, [r3, #0]
	mov	pc, lr
calc2:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	mvn	r0, r0
	add	r0, r0, r0, asl #2
	ldr	r3, .L5
	add	r0, r0, r0, asl #2
	@ lr needed for prologue
	str	r0, [r3, #0]
	mov	pc, lr

The code looks identical to me, so the patch appears to have no effect.
