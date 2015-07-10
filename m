From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 10 Jul 2015 11:19:40 -0700
Subject: [PATCH] ARM: BCM63xx: fix parameter to of_get_cpu_node in
 bcm63138_smp_boot_secondary
In-Reply-To: <1436549771-6097-1-git-send-email-sudeep.holla@arm.com>
References: <1436549771-6097-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <55A00CBC.1050706@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/07/15 10:36, Sudeep Holla wrote:
> of_get_cpu_node provides the device node associated with the given
> logical CPU and cpu_logical_map contains the physical id for each CPU
> in the logical ordering. Passing cpu_logical_map(cpu) to of_get_cpu_node
> is incorrect.
> 
> This patch fixes the issue by passing the logical CPU number to
> of_get_cpu_node
> 
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: bcm-kernel-feedback-list at broadcom.com
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

Tested-by: Florian Fainelli <f.fainelli@gmail.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>

> ---
>  arch/arm/mach-bcm/bcm63xx_smp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Hi,
> 
> I found this accidentally when searching for cpu_logical_map. It's
> clearly a bug, it seem to be working fine as the physical and the
> logical CPU ordering is same most of the time.

Good catch! Kevin, Arnd, Olof, if you have any "late late" fixes for
4.2-rcX, can you pick this one directly?

Thanks!

> 
> Regards,
> Sudeep
> 
> diff --git a/arch/arm/mach-bcm/bcm63xx_smp.c b/arch/arm/mach-bcm/bcm63xx_smp.c
> index 3f014f18cea5..b8e18cc8f237 100644
> --- a/arch/arm/mach-bcm/bcm63xx_smp.c
> +++ b/arch/arm/mach-bcm/bcm63xx_smp.c
> @@ -127,7 +127,7 @@ static int bcm63138_smp_boot_secondary(unsigned int cpu,
>  	}
>  
>  	/* Locate the secondary CPU node */
> -	dn = of_get_cpu_node(cpu_logical_map(cpu), NULL);
> +	dn = of_get_cpu_node(cpu, NULL);
>  	if (!dn) {
>  		pr_err("SMP: failed to locate secondary CPU%d node\n", cpu);
>  		ret = -ENODEV;
> 


-- 
Florian
