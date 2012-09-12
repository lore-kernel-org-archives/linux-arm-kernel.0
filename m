From: rvaswani@codeaurora.org (Rohit Vaswani)
Date: Tue, 11 Sep 2012 20:48:30 -0700
Subject: [PATCH v4 1/2] ARM: arch_timers: enable the use of the virtual
 timer
In-Reply-To: <1346780329-14451-2-git-send-email-marc.zyngier@arm.com>
References: <1346780329-14451-1-git-send-email-marc.zyngier@arm.com>
 <1346780329-14451-2-git-send-email-marc.zyngier@arm.com>
Message-ID: <5050060E.4080504@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On 9/4/2012 10:38 AM, Marc Zyngier wrote:
> At the moment, the arch_timer driver only uses the physical timer,
> which can cause problem if PL2 hasn't enabled PL1 access in CNTHCTL,
> which is likely in a virtualized environment. Instead, the virtual
> timer is always available.
>
> This patch enables the use of the virtual timer, unless no
> interrupt is provided in the DT for it, in which case it falls
> back to the physical timer.
>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>   arch/arm/kernel/arch_timer.c | 343 ++++++++++++++++++++++++++++++-------------
>   1 file changed, 241 insertions(+), 102 deletions(-)
<snip>
>   
> @@ -329,6 +449,7 @@ int __init arch_timer_of_register(void)
>   {
>   	struct device_node *np;
>   	u32 freq;
> +	int i;
>   
>   	np = of_find_matching_node(NULL, arch_timer_of_match);
>   	if (!np) {
> @@ -340,22 +461,40 @@ int __init arch_timer_of_register(void)
>   	if (!of_property_read_u32(np, "clock-frequency", &freq))
>   		arch_timer_rate = freq;
>   
> -	arch_timer_ppi = irq_of_parse_and_map(np, 0);
> -	arch_timer_ppi2 = irq_of_parse_and_map(np, 1);
> -	pr_info("arch_timer: found %s irqs %d %d\n",
> -		np->name, arch_timer_ppi, arch_timer_ppi2);
> +	for (i = PHYS_SECURE_PPI; i < MAX_TIMER_PPI; i++)
> +		arch_timer_ppi[i] = irq_of_parse_and_map(np, i);
> +
> +	/*
> +	 * If no interrupt provided for virtual timer, we'll have to
> +	 * stick to the physical timer. It'd better be accessible...
> +	 */
> +	if (!arch_timer_ppi[VIRT_PPI]) {
> +		arch_timer_use_virtual = false;
> +
> +		if (!arch_timer_ppi[PHYS_SECURE_PPI] ||
> +		    !arch_timer_ppi[PHYS_NONSECURE_PPI]) {
> +			pr_warn("arch_timer: No interrupt available, giving up\n");
> +			return -EINVAL;

Should this be

if (!arch_timer_ppi[PHYS_SECURE_PPI]*&&*
		    !arch_timer_ppi[PHYS_NONSECURE_PPI]) {
...
?

<snip>

Also, I have based my next mm-arch_timer patch on this.

Thanks,
Rohit Vaswani

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, hosted by The Linux Foundation.

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120911/c7d2ed48/attachment-0001.html>
