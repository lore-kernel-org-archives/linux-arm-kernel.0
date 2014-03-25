From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 25 Mar 2014 19:45:55 -0300
Subject: [PATCH] ARM: machine_power_off should not return
In-Reply-To: <1395684784-12601-1-git-send-email-sebastian.capella@linaro.org>
References: <1395684784-12601-1-git-send-email-sebastian.capella@linaro.org>
Message-ID: <20140325224554.GC12185@arch.cereza>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Let's Cc: LAKML, and To: Russell.

Russell, any comments on this?

Without this patch we got the heartbeat's reboot_notifier called twice while
testing the recent hibernation patches, which was unexpected and produced a
kernel panic: https://lkml.org/lkml/2014/3/19/363

Instead of fixing the heartbeat LED trigger, or the hibernation code, it
seems better to fix the ARM machine_power_off, as it's not supposed to return.

On Mar 24, Sebastian Capella wrote:
> Add loop to prevent return from machine_power_off if
> pm_power_off is null or does not halt the system.
> This caused a panic during hibernation testing on Kirkwood
> Openblocks A6 board.
> 
> Signed-off-by: Sebastian Capella <sebastian.capella@linaro.org>
> Reported-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> ---
>  arch/arm/kernel/process.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
> index f58b723..6ffdc2c 100644
> --- a/arch/arm/kernel/process.c
> +++ b/arch/arm/kernel/process.c
> @@ -217,6 +217,8 @@ void machine_power_off(void)
>  
>  	if (pm_power_off)
>  		pm_power_off();
> +	while (1)
> +		cpu_relax();
>  }
>  
>  /*
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
