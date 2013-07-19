From: fweisbec@gmail.com (Frederic Weisbecker)
Date: Fri, 19 Jul 2013 18:29:04 +0200
Subject: [PATCH 1/3] nohz: Kconfig: remove redundant 64-bit dependency
In-Reply-To: <1372876601-23881-2-git-send-email-khilman@linaro.org>
References: <1372876601-23881-1-git-send-email-khilman@linaro.org>
 <1372876601-23881-2-git-send-email-khilman@linaro.org>
Message-ID: <20130719162903.GC21752@somewhere>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 03, 2013 at 11:36:39AM -0700, Kevin Hilman wrote:
> The current 64-bit dependency is on VIRT_CPU_ACCOUNTING_GEN, which already
> has its own dependency on 64-bit.  Remove it from NO_HZ_FULL.

It's not exactly redundant. It's a necessary dependency inheritance.
When we select NO_HZ_FULL, TICK_CPU_ACCOUNTING and VIRT_CPU_ACCOUNTING_NATIVE
disappear such that only VIRT_CPU_ACCOUNTING_GEN can be selected. But if we
don't have CONFIG_64bits, then VIRT_CPU_ACCOUNTING_GEN is not possible either.
So we end up with nothing for the accounting (or whatever random reaction
from Kconfig against that situation) and that's a bug. So we need to inherit the
64 bits dependency on NO_HZ_FULL to prevent that.

We can remove this dependency from NO_HZ_FULL, but only once we remove it
from VIRT_CPU_ACCOUNTING_GEN, not the other way around otherwise this
breaks bisection.

> 
> Cc: Frederic Weisbecker <fweisbec@gmail.com>
> Signed-off-by: Kevin Hilman <khilman@linaro.org>
> ---
>  kernel/time/Kconfig | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/kernel/time/Kconfig b/kernel/time/Kconfig
> index 70f27e8..b78760f 100644
> --- a/kernel/time/Kconfig
> +++ b/kernel/time/Kconfig
> @@ -99,8 +99,6 @@ config NO_HZ_FULL
>  	depends on SMP
>  	# RCU_USER_QS dependency
>  	depends on HAVE_CONTEXT_TRACKING
> -	# VIRT_CPU_ACCOUNTING_GEN dependency
> -	depends on 64BIT
>  	select NO_HZ_COMMON
>  	select RCU_USER_QS
>  	select RCU_NOCB_CPU
> -- 
> 1.8.3
> 
