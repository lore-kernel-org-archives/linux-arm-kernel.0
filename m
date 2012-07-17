From: cov@codeaurora.org (Christopher Covington)
Date: Tue, 17 Jul 2012 12:57:54 -0400
Subject: [RFC PATCH 3/4] ARM: arch_timers: give the virtual timer its
 own interrupt handler
In-Reply-To: <1341566422-20368-4-git-send-email-marc.zyngier@arm.com>
References: <1341566422-20368-1-git-send-email-marc.zyngier@arm.com>
 <1341566422-20368-4-git-send-email-marc.zyngier@arm.com>
Message-ID: <50059992.9020904@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On 07/06/2012 05:20 AM, Marc Zyngier wrote:
> In order to prepare for the timer interrupt offloading to the hypervisor,
> give the virtual timer its own interrupt handler.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm/kernel/arch_timer.c |    8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/kernel/arch_timer.c b/arch/arm/kernel/arch_timer.c
> index 2b5da66..4473f66 100644
> --- a/arch/arm/kernel/arch_timer.c
> +++ b/arch/arm/kernel/arch_timer.c

[...]

> @@ -408,6 +413,9 @@ static int __init arch_timer_register(void)
>  		if (!arch_timer_ppi[i])
>  			continue;
>  
> +		if (i == VIRT_PPI)
> +			handler = arch_timer_virt_handler;
> +

Again, it seems awkward to do this sort of thing inside the loop as
you're only keying off of one value with a known index in the array.

>  		err = request_percpu_irq(arch_timer_ppi[i], handler,
>  					 "arch_timer", arch_timer_evt);
>  		if (err) {

Regards,
Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
