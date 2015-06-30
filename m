From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 30 Jun 2015 17:18:37 +0100
Subject: [PATCH] ARM: psci: boot_secondary: replace __pa with virt_to_idmap
In-Reply-To: <1435661062-4127-1-git-send-email-grygorii.strashko@ti.com>
References: <1435661062-4127-1-git-send-email-grygorii.strashko@ti.com>
Message-ID: <20150630161836.GC28372@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jun 30, 2015 at 11:44:22AM +0100, Grygorii Strashko wrote:
> On some PAE systems (e.g. TI Keystone), memory is above the 32-bit
> addressable limit, and the interconnect provides an aliased view of
> parts of physical memory in the 32-bit addressable space. This alias
> is strictly for boot time usage, and is not otherwise usable because
> of coherency limitations.
> 
> On such systems, the idmap mechanism has to be used to pass correct
> boot address of secondary CPU to FW.
> virt_to_idmap() will fall-back to existing virt_to_phys() macro if
> such conversation is not required.
> 
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Nicolas Pitre <nico@linaro.org>
> Cc: Santosh Shilimkar <ssantosh@kernel.org>
> Cc: Vitaly Andrianov <vitalya@ti.com>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---
>  arch/arm/kernel/psci_smp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

The code itself looks sane to me, though the commit message would be
better with Russell's suggested rewording.

This will also conflict with my migration to a common PSCI client
implementation [1,2] (especially given the absence of virt_to_idmap on
arm64), but I'm happy to fold it in or rebase atop of it.

Russell, are you able to take a look at the migration patch [2]? How
would you prefer for the two patches to be taken?

Thanks,
Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-May/346492.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-May/346503.html

> 
> diff --git a/arch/arm/kernel/psci_smp.c b/arch/arm/kernel/psci_smp.c
> index 28a1db4..244aadd 100644
> --- a/arch/arm/kernel/psci_smp.c
> +++ b/arch/arm/kernel/psci_smp.c
> @@ -51,7 +51,7 @@ static int psci_boot_secondary(unsigned int cpu, struct task_struct *idle)
>  {
>  	if (psci_ops.cpu_on)
>  		return psci_ops.cpu_on(cpu_logical_map(cpu),
> -				       __pa(secondary_startup));
> +					virt_to_idmap(&secondary_startup));
>  	return -ENODEV;
>  }
>  
> -- 
> 2.4.5
> 
