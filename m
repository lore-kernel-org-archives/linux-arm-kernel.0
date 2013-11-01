From: Vineet.Gupta1@synopsys.com (Vineet Gupta)
Date: Fri, 1 Nov 2013 10:41:54 +0530
Subject: [PATCH 04/11] MIPS: use the common machine reset handling
In-Reply-To: <20131031062959.169063871@linux.com>
References: <20131031062708.520968323@linux.com>
 <20131031062959.169063871@linux.com>
Message-ID: <5273381A.9020103@synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/31/2013 11:57 AM, Domenico Andreoli wrote:
> From: Domenico Andreoli <domenico.andreoli@linux.com>
> 
> Proof of concept: MIPS as a consumer of the machine reset hooks.
> 
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-arch at vger.kernel.org
> Cc: linux-mips at vger.kernel.org
> Signed-off-by: Domenico Andreoli <domenico.andreoli@linux.com>
> ---
>  arch/mips/kernel/reset.c |    7 +++++++
>  kernel/power/Kconfig     |    2 +-
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> Index: b/arch/mips/kernel/reset.c
> ===================================================================
> --- a/arch/mips/kernel/reset.c
> +++ b/arch/mips/kernel/reset.c
> @@ -11,6 +11,7 @@
>  #include <linux/pm.h>
>  #include <linux/types.h>
>  #include <linux/reboot.h>
> +#include <linux/machine_reset.h>
>  
>  #include <asm/reboot.h>
>  
> @@ -29,16 +30,22 @@ void machine_restart(char *command)
>  {
>  	if (_machine_restart)
>  		_machine_restart(command);
> +	else
> +		default_restart(reboot_mode, command);
>  }
>  
>  void machine_halt(void)
>  {
>  	if (_machine_halt)
>  		_machine_halt();
> +	else
> +		default_halt();
>  }
>  
>  void machine_power_off(void)
>  {
>  	if (pm_power_off)
>  		pm_power_off();
> +	else
> +		default_power_off();
>  }
> Index: b/kernel/power/Kconfig
> ===================================================================
> --- a/kernel/power/Kconfig
> +++ b/kernel/power/Kconfig
> @@ -297,4 +297,4 @@ config CPU_PM
>  config MACHINE_RESET
>  	bool
>  	default n
> -	depends on ARM || ARM64
> +	depends on ARM || ARM64 || MIPS

This particular idiom is frowned upon for new code. As new arches get added this
list keeps getting bigger and then those who don't need the feature need to add
the anti dependency. Also in this particular case the dependency is trivial so you
can just "select" it in arch/*/Kconfig
