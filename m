From: will.deacon@arm.com (Will Deacon)
Date: Tue, 29 May 2018 16:30:14 +0100
Subject: [PATCH] ARM: mcpm, perf/arm-cci: export mcpm_is_available
In-Reply-To: <20180528154448.2494709-1-arnd@arndb.de>
References: <20180528154448.2494709-1-arnd@arndb.de>
Message-ID: <20180529153013.GH17159@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Russell, [+Nico and Robin]

On Mon, May 28, 2018 at 05:44:36PM +0200, Arnd Bergmann wrote:
> Now that the ARM CCI PMU driver can be built as a loadable module,
> we get a link failure when MCPM is enabled:
> 
> ERROR: "mcpm_is_available" [drivers/perf/arm-cci.ko] undefined!
> 
> The simplest fix is to export that helper function.
> 
> Fixes: 8b0c93c20ef7 ("perf/arm-cci: Allow building as a module")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> The patch that caused this is currently part of the arm-perf/for-next/perf
> branch, it would be good to have the fix there as well.
> ---
>  arch/arm/common/mcpm_entry.c | 2 ++
>  1 file changed, 2 insertions(+)

I'm happy to take this via the arm perf tree if others are ok with that.
Alternatively, I can revert the offending commit if there are objections
to exporting the symbol.

Russell: do you any preference?

Thanks,

Will

> diff --git a/arch/arm/common/mcpm_entry.c b/arch/arm/common/mcpm_entry.c
> index ed9e87ddbb06..037a4479b8c3 100644
> --- a/arch/arm/common/mcpm_entry.c
> +++ b/arch/arm/common/mcpm_entry.c
> @@ -9,6 +9,7 @@
>   * published by the Free Software Foundation.
>   */
>  
> +#include <linux/export.h>
>  #include <linux/kernel.h>
>  #include <linux/init.h>
>  #include <linux/irqflags.h>
> @@ -174,6 +175,7 @@ bool mcpm_is_available(void)
>  {
>  	return (platform_ops) ? true : false;
>  }
> +EXPORT_SYMBOL_GPL(mcpm_is_available);
>  
>  /*
>   * We can't use regular spinlocks. In the switcher case, it is possible
> -- 
> 2.9.0
> 
