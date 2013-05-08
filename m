From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Wed, 08 May 2013 02:26:34 +0200
Subject: [PATCH,
 RFC 02/22] cpufreq: ARM_DT_BL_CPUFREQ needs ARM_CPU_TOPOLOGY
In-Reply-To: <CAKohponuYRm+D-FU5_7Ny1PPmwUhFLm9DkAR9iHURur+GFq_kA@mail.gmail.com>
References: <1367507786-505303-1-git-send-email-arnd@arndb.de>
 <1367507786-505303-3-git-send-email-arnd@arndb.de>
 <CAKohponuYRm+D-FU5_7Ny1PPmwUhFLm9DkAR9iHURur+GFq_kA@mail.gmail.com>
Message-ID: <2500374.5Hpjds0B3f@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday, May 04, 2013 12:09:40 PM Viresh Kumar wrote:
> On 2 May 2013 20:46, Arnd Bergmann <arnd@arndb.de> wrote:
> > The big.LITTLE cpufreq driver uses the CPU topology API, which
> > needs to be reflected in Kconfig to prevent broken configurations.
> >
> > warning: (ARM_DT_BL_CPUFREQ) selects ARM_BIG_LITTLE_CPUFREQ which
> > has unmet direct dependencies (ARCH_HAS_CPUFREQ && CPU_FREQ && ARM && ARM_CPU_TOPOLOGY)
> >
> > Cc: Rafael J. Wysocki <rjw@sisk.pl>
> > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> > Cc: cpufreq at vger.kernel.org
> > Cc: linux-pm at vger.kernel.org
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  drivers/cpufreq/Kconfig.arm | 1 +
> >  1 file changed, 1 insertion(+)
> 
> With all the discussions we had, please see if you can replace your
> patch with this one (Attached too for applying, copy/paste in gmail
> will break it):
> 
> From: Viresh Kumar <viresh.kumar@linaro.org>
> Date: Sat, 4 May 2013 12:03:54 +0530
> Subject: [PATCH] cpufreq: ARM big LITTLE: Fix Kconfig entries
> 
> This fixes usage of "depends on" and "select" options in Kconfig for ARM big
> LITTLE cpufreq driver. Otherwise we get these warnings:
> 
> warning: (ARM_DT_BL_CPUFREQ) selects ARM_BIG_LITTLE_CPUFREQ which
> has unmet direct dependencies (ARCH_HAS_CPUFREQ && CPU_FREQ && ARM &&
> ARM_CPU_TOPOLOGY)
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Queued up as a fix for v3.10.

Thanks,
Rafael


> ---
>  drivers/cpufreq/Kconfig.arm | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index 634e992..a924408 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -3,17 +3,17 @@
>  #
> 
>  config ARM_BIG_LITTLE_CPUFREQ
> -	tristate
> -	depends on ARM_CPU_TOPOLOGY
> -	select PM_OPP
> +	tristate "Generic ARM big LITTLE CPUfreq driver"
> +	depends on ARM_CPU_TOPOLOGY && PM_OPP && HAVE_CLK
> +	help
> +	  This enables the Generic CPUfreq driver for ARM big.LITTLE platforms.
> 
>  config ARM_DT_BL_CPUFREQ
> -	tristate "Generic ARM big LITTLE CPUfreq driver probed via DT"
> -	select ARM_BIG_LITTLE_CPUFREQ
> -	depends on OF && HAVE_CLK
> +	tristate "Generic probing via DT for ARM big LITTLE CPUfreq driver"
> +	depends on ARM_BIG_LITTLE_CPUFREQ && OF
>  	help
> -	  This enables the Generic CPUfreq driver for ARM big.LITTLE platform.
> -	  This gets frequency tables from DT.
> +	  This enables probing via DT for Generic CPUfreq driver for ARM
> +	  big.LITTLE platform. This gets frequency tables from DT.
> 
>  config ARM_EXYNOS_CPUFREQ
>  	bool "SAMSUNG EXYNOS SoCs"
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
