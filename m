From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 20 Jun 2014 15:00:52 -0400
Subject: [PATCH v2 2/2] ARM: mvebu: Use system controller to get the
 soc id when possible
In-Reply-To: <1403274953-21790-3-git-send-email-gregory.clement@free-electrons.com>
References: <1403274953-21790-1-git-send-email-gregory.clement@free-electrons.com>
 <1403274953-21790-3-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20140620190052.GD21711@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 20, 2014 at 04:35:53PM +0200, Gregory CLEMENT wrote:
> On Armada 38x it is possible to get the SoC Id and the revision
> without using the PCI register. Accessing the PCI registers implies
> enabling its clock and, because of the initialization issue, not
> keeping them enable. So if possible it is better to avoid it.
> 
> Armada 370 and Armada XP provides the SoC ID values from the system
> controller but not the revision.
> 
> Armada 375 provides both but the SoC ID value looks buggy (0x6660
> instead of 0x6720).
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  arch/arm/mach-mvebu/common.h            |  1 +
>  arch/arm/mach-mvebu/mvebu-soc-id.c      | 20 +++++++++++++++++++-
>  arch/arm/mach-mvebu/system-controller.c | 19 +++++++++++++++++++
>  3 files changed, 39 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-mvebu/common.h b/arch/arm/mach-mvebu/common.h
> index b67fb7a10d8b..927d88627a6e 100644
> --- a/arch/arm/mach-mvebu/common.h
> +++ b/arch/arm/mach-mvebu/common.h
> @@ -21,6 +21,7 @@ void mvebu_restart(enum reboot_mode mode, const char *cmd);
>  int mvebu_cpu_reset_deassert(int cpu);
>  void mvebu_pmsu_set_cpu_boot_addr(int hw_cpu, void *boot_addr);
>  void mvebu_system_controller_set_cpu_boot_addr(void *boot_addr);
> +int mvebu_system_controller_get_soc_id(u32 *dev, u32 *rev);
>  
>  void armada_xp_cpu_die(unsigned int cpu);
>  
> diff --git a/arch/arm/mach-mvebu/mvebu-soc-id.c b/arch/arm/mach-mvebu/mvebu-soc-id.c
> index 12c66cac967d..922b1380b0be 100644
> --- a/arch/arm/mach-mvebu/mvebu-soc-id.c
> +++ b/arch/arm/mach-mvebu/mvebu-soc-id.c
> @@ -25,8 +25,10 @@
>  #include <linux/of_address.h>
>  #include <linux/slab.h>
>  #include <linux/sys_soc.h>
> +#include "common.h"
>  #include "mvebu-soc-id.h"
>  
> +
>  #define PCIE_DEV_ID_OFF		0x0

whitespace?

>  #define PCIE_DEV_REV_OFF	0x8
>  
> @@ -54,7 +56,7 @@ int mvebu_get_soc_id(u32 *dev, u32 *rev)
>  		return -ENODEV;
>  }
>  
> -static int __init mvebu_soc_id_init(void)
> +static int __init get_soc_id_by_pci(void)
>  {
>  	struct device_node *np;
>  	int ret = 0;
> @@ -129,6 +131,22 @@ clk_err:
>  
>  	return ret;
>  }
> +
> +static int __init mvebu_soc_id_init(void)
> +{
> +
> +	/*
> +	 * First try to get the ID and the revision by the system
> +	 * regsiter and use PCI registers only if it is not possible

s/regsiter/register/

> +	 */
> +	if (!mvebu_system_controller_get_soc_id(&soc_dev_id, &soc_rev)) {
> +		is_id_valid = true;
> +		pr_info("MVEBU SoC ID=0x%X, Rev=0x%X\n", soc_dev_id, soc_rev);
> +		return 0;
> +	}
> +
> +	return get_soc_id_by_pci();
> +}
>  early_initcall(mvebu_soc_id_init);
>  
>  static int __init mvebu_soc_device(void)
> diff --git a/arch/arm/mach-mvebu/system-controller.c b/arch/arm/mach-mvebu/system-controller.c
> index 0c5524ac75b7..de90821129da 100644
> --- a/arch/arm/mach-mvebu/system-controller.c
> +++ b/arch/arm/mach-mvebu/system-controller.c
> @@ -39,6 +39,9 @@ struct mvebu_system_controller {
>  	u32 system_soft_reset;
>  
>  	u32 resume_boot_addr;
> +
> +	u32 dev_id;
> +	u32 rev_id;
>  };
>  static struct mvebu_system_controller *mvebu_sc;
>  
> @@ -47,6 +50,8 @@ static const struct mvebu_system_controller armada_370_xp_system_controller = {
>  	.system_soft_reset_offset = 0x64,
>  	.rstoutn_mask_reset_out_en = 0x1,
>  	.system_soft_reset = 0x1,
> +	.dev_id = 0x38,
> +	.rev_id = 0x3c,
>  };
>  
>  static const struct mvebu_system_controller armada_375_system_controller = {
> @@ -55,6 +60,8 @@ static const struct mvebu_system_controller armada_375_system_controller = {
>  	.rstoutn_mask_reset_out_en = 0x1,
>  	.system_soft_reset = 0x1,
>  	.resume_boot_addr = 0xd4,
> +	.dev_id = 0x38,
> +	.rev_id = 0x3c,
>  };
>  
>  static const struct mvebu_system_controller orion_system_controller = {
> @@ -101,6 +108,18 @@ void mvebu_restart(enum reboot_mode mode, const char *cmd)
>  		;
>  }
>  
> +int mvebu_system_controller_get_soc_id(u32 *dev, u32 *rev)
> +{
> +	if (of_machine_is_compatible("marvell,armada38x") &&

As Sergei commented on your documentation patch, we try to avoid
wildcards in compatible strings.  Perhaps a match list would be more
appropriate?

> +		system_controller_base) {
> +		*dev = readl(system_controller_base + mvebu_sc->dev_id) >> 16;
> +		*rev = (readl(system_controller_base + mvebu_sc->rev_id) >> 8)
> +			& 0xF;
> +		return 0;
> +	} else
> +		return -ENODEV;
> +}
> +
>  #ifdef CONFIG_SMP
>  void mvebu_system_controller_set_cpu_boot_addr(void *boot_addr)
>  {
> -- 
> 1.8.1.2
> 

thx,

Jason.
