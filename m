From: treding@nvidia.com (Thierry Reding)
Date: Tue, 6 Oct 2015 10:21:08 +0200
Subject: [PATCH v2 2/2] ARM: tegra: Disable cpuidle driver if PSCI is
 present
In-Reply-To: <5151ffebe8611545c55f8cc499cf2368b1b789c4.1442990383.git.jan.kiszka@siemens.com>
References: <cover.1442990383.git.jan.kiszka@siemens.com>
 <5151ffebe8611545c55f8cc499cf2368b1b789c4.1442990383.git.jan.kiszka@siemens.com>
Message-ID: <20151006082106.GB21527@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 23, 2015 at 08:39:44AM +0200, Jan Kiszka wrote:
> The firmware takes over the ownership of the flow controller when it
> provides PSCI support. To avoid clashes, disable the Tegra cpuidle
> driver if PSCI was detected.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  arch/arm/mach-tegra/Kconfig | 1 +
>  arch/arm/mach-tegra/tegra.c | 4 +++-
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
> index 0fa4c5f..373768c 100644
> --- a/arch/arm/mach-tegra/Kconfig
> +++ b/arch/arm/mach-tegra/Kconfig
> @@ -4,6 +4,7 @@ menuconfig ARCH_TEGRA
>  	select ARCH_SUPPORTS_TRUSTED_FOUNDATIONS
>  	select ARM_AMBA
>  	select ARM_GIC
> +	select ARM_PSCI
>  	select CLKSRC_MMIO
>  	select HAVE_ARM_SCU if SMP
>  	select HAVE_ARM_TWD if SMP
> diff --git a/arch/arm/mach-tegra/tegra.c b/arch/arm/mach-tegra/tegra.c
> index 2378fa56..d97c961 100644
> --- a/arch/arm/mach-tegra/tegra.c
> +++ b/arch/arm/mach-tegra/tegra.c
> @@ -44,6 +44,7 @@
>  #include <asm/mach-types.h>
>  #include <asm/setup.h>
>  #include <asm/trusted_foundations.h>
> +#include <asm/psci.h>
>  
>  #include "board.h"
>  #include "common.h"
> @@ -136,7 +137,8 @@ static void __init tegra_dt_init_late(void)
>  	int i;
>  
>  	tegra_init_suspend();
> -	tegra_cpuidle_init();
> +	if (!psci_smp_available())
> +		tegra_cpuidle_init();
>  
>  	for (i = 0; i < ARRAY_SIZE(board_init_funcs); i++) {
>  		if (of_machine_is_compatible(board_init_funcs[i].machine)) {

The equivalent of this part is already in cpuidle-tegra114.c and I'm not
sure this adds anything. cpuidle-tegra114.c is the same code that is
used on Tegra124. Anything before Tegra114 is now unlikely to gain PSCI
support. Given that they're Cortex-A9 and lack virtualization extensions
I don't think it's even possible to support PSCI on them. Anything after
Tegra124 will very likely be 64-bit and hence require firmware support
(such as PSCI) for CPU idle anyway.

That still leaves the select ARM_PSCI which we don't have in mainline
yet. I'm also not sure if select ARM_PSCI is the right approach here. It
means that everyone will be forced to have PSCI support in the kernel.
But what if for some reason you want to disable PSCI (and instead use
the kernel's cpuidle support)? Maybe it'd be better to add this to the
tegra_defconfig instead.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151006/1816c6a9/attachment.sig>
