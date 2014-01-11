From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 11 Jan 2014 22:48:49 +0000
Subject: Mini6410 build fails with confusing CONFIG parameters
In-Reply-To: <201401112220.48693.juergen@kreuzholzen.de>
References: <201401112220.48693.juergen@kreuzholzen.de>
Message-ID: <20140111224848.GN15937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 11, 2014 at 10:20:48PM +0100, Juergen Beisert wrote:
> with PM_GENERIC_DOMAINS=y and CONFIG_PM=N
> 
> [...]
>   CC      drivers/base/power/domain.o
> drivers/base/power/domain.c: In function '__pm_genpd_add_device':
> drivers/base/power/domain.c:1422:2: error: implicit declaration of function 'genpd_acquire_lock' [-Werror=implicit-function-declaration]
> drivers/base/power/domain.c:1466:2: error: implicit declaration of function 'genpd_release_lock' [-Werror=implicit-function-declaration]
> drivers/base/power/domain.c: In function 'pm_genpd_add_subdomain':
> drivers/base/power/domain.c:1649:3: error: implicit declaration of function 'genpd_sd_counter_inc' [-Werror=implicit-function-declaration]
> drivers/base/power/domain.c: In function 'pm_genpd_remove_subdomain':
> drivers/base/power/domain.c:1721:4: error: implicit declaration of function 'genpd_sd_counter_dec' [-Werror=implicit-function-declaration]
> drivers/base/power/domain.c: In function 'pm_genpd_attach_cpuidle':
> drivers/base/power/domain.c:1887:2: error: implicit declaration of function 'genpd_recalc_cpu_exit_latency' [-Werror=implicit-function-declaration]
> 
> How can this happen?
> 
> Symbol: PM_GENERIC_DOMAINS [=y]
>     Type  : boolean
>       Defined at kernel/power/Kconfig:277
>       Depends on: PM [=n]
>       Selected by: ARCH_SHMOBILE [=n] && <choice> && PM [=n] || ARCH_S3C64XX [=y] && <choice> || CPU [...]
> 
> Shouldn't PM_GENERIC_DOMAINS be forced to "n", because it depends on PM?

A select overrides depends on.  If you pay attention to the warnings
when the Kconfig stuff runs, you'll see that it provokes a warning.

This is precisely why ill-considered use of "select" to select things
that are _not_ necessary to boot, but to select random junk is _bad_
_news_ and needs to stop.  Just delete the select PM_GENERIC_DOMAINS
in arch/arm/mach-s3c64xx/Kconfig.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
