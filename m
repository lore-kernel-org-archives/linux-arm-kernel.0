From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 14 Aug 2017 09:25:16 -0700
Subject: [PATCH] ARM: bcm2836: Send event when onlining other cores
In-Reply-To: <1502190295-53391-2-git-send-email-phil@raspberrypi.org>
References: <1502190295-53391-1-git-send-email-phil@raspberrypi.org>
 <1502190295-53391-2-git-send-email-phil@raspberrypi.org>
Message-ID: <fdecf317-d20b-1a5d-046f-56ef40c55d82@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 08/08/2017 04:04 AM, Phil Elwell wrote:
> Secondary cores should enter a low-power idle state when waiting to
> be started. The "wfe" instruction causes a core to wait until an event
> or interrupt arrives before continuing to the next instruction, and
> the "sev" instruction sends a wakeup event to the other cores.
> 
> Add an "sev" (and a memory barrier) to bcm2836_boot_secondary, the
> function that wakes the waiting cores during booting. This is required
> if the secondary cores are sitting in "wfe", and harmless if not.

Eric, should I just pick this up for the upcoming ARM SoC pull requests
that I am preparing, or do you have more changes aside from the two tags
I already merged?

Thanks!

> 
> Signed-off-by: Phil Elwell <phil@raspberrypi.org>
> ---
>  arch/arm/mach-bcm/platsmp.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/mach-bcm/platsmp.c b/arch/arm/mach-bcm/platsmp.c
> index 3fa1a99..7811160 100644
> --- a/arch/arm/mach-bcm/platsmp.c
> +++ b/arch/arm/mach-bcm/platsmp.c
> @@ -312,6 +312,9 @@ static int bcm2836_boot_secondary(unsigned int cpu, struct task_struct *idle)
>  	writel(virt_to_phys(secondary_startup),
>  	       intc_base + LOCAL_MAILBOX3_SET0 + 16 * cpu);
>  
> +	dsb(sy);
> +	sev();
> +
>  	iounmap(intc_base);
>  
>  	return 0;
> 

-- 
Florian
