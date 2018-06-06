From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Wed, 6 Jun 2018 10:33:15 +0200
Subject: [PATCH v4 14/14] coresight: allow the coresight core driver to
 be built as a module
In-Reply-To: <20180605210710.22227-15-kim.phillips@arm.com>
References: <20180605210710.22227-1-kim.phillips@arm.com>
 <20180605210710.22227-15-kim.phillips@arm.com>
Message-ID: <20180606083315.GE19727@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 05, 2018 at 04:07:10PM -0500, Kim Phillips wrote:
> Allow to build coresight as a module.  This enhances
> coresight developer efficiency by allowing the development to
> take place exclusively on the target, and without needing to
> reboot in between changes.
> 
> - Kconfig becomes a tristate, to allow =m
> - append -core to source file name to allow module to
>   be called coresight by the Makefile
> - modules can have only one init/exit, so we add the core bus
>   register/unregister function calls to the etm_perf init/exit
>   functions, since coresight.c does not have etm_pmu defined.
> - add a MODULE_DEVICE_TABLE for autoloading on boot
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Leo Yan <leo.yan@linaro.org>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Suzuki K Poulose <Suzuki.Poulose@arm.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Signed-off-by: Kim Phillips <kim.phillips@arm.com>
> ---
>  drivers/hwtracing/coresight/Kconfig             |  5 ++++-
>  drivers/hwtracing/coresight/Makefile            |  7 +++++--
>  .../coresight/{coresight.c => coresight-core.c} |  6 ------
>  .../hwtracing/coresight/coresight-etm-perf.c    | 17 ++++++++++++++++-
>  4 files changed, 25 insertions(+), 10 deletions(-)
>  rename drivers/hwtracing/coresight/{coresight.c => coresight-core.c} (99%)
> 
> diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
> index 181a44ea2d61..c05b265f7731 100644
> --- a/drivers/hwtracing/coresight/Kconfig
> +++ b/drivers/hwtracing/coresight/Kconfig
> @@ -2,7 +2,7 @@
>  # Coresight configuration
>  #
>  menuconfig CORESIGHT
> -	bool "CoreSight Tracing Support"
> +	tristate "CoreSight Tracing Support"
>  	select ARM_AMBA
>  	select PERF_EVENTS
>  	help
> @@ -12,6 +12,9 @@ menuconfig CORESIGHT
>  	  specification and configure the right series of components when a
>  	  trace source gets enabled.
>  
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called coresight.
> +
>  if CORESIGHT
>  config CORESIGHT_LINKS_AND_SINKS
>  	tristate "CoreSight Link and Sink drivers"
> diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
> index 45d7a0f34170..ed2d4bcb017b 100644
> --- a/drivers/hwtracing/coresight/Makefile
> +++ b/drivers/hwtracing/coresight/Makefile
> @@ -2,8 +2,11 @@
>  #
>  # Makefile for CoreSight drivers.
>  #
> -obj-$(CONFIG_CORESIGHT) += coresight.o coresight-etm-perf.o
> -obj-$(CONFIG_OF) += of_coresight.o
> +obj-$(CONFIG_CORESIGHT) += coresight.o
> +coresight-objs := coresight-core.o  coresight-etm-perf.o

Shouldn't this line be:
	coresight-y := coresight-core.o  coresight-etm-perf.o

> +ifeq ($(CONFIG_OF), y)
> +coresight-objs += of_coresight.o
> +endif

Those 3 lines should be written as 1 line:
	coresight-$(CONFIG_OF) += of_coresight.o

thanks,

greg k-h
