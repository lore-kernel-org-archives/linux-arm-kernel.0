From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 22 May 2018 11:31:40 -0600
Subject: [PATCH 1/6] coresight: remove CORESIGHT_LINKS_AND_SINKS
 dependencies and selections
In-Reply-To: <20180518012024.22645-1-kim.phillips@arm.com>
References: <20180517070643.GC13919@kroah.com>
 <20180518012024.22645-1-kim.phillips@arm.com>
Message-ID: <20180522173140.GA25658@xps15>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 17, 2018 at 08:20:19PM -0500, Kim Phillips wrote:
> A coresight topology doesn't need to include links, i.e., a source can
> be directly connected to a sink.  As such, selecting and/or depending on
> LINKS_AND_SINKS is no longer needed.

I'm good with this patch but now the help text for CORESIGHT_LINKS_AND_SINKS no
longer match what the config does.  I see two ways to fix this:

1) Rework the help text.

2) Rework CORESIGHT_LINKS_AND_SINKS to be CORESIGHT_FUNNEL and move
coresight-replicator.o under CORESIGHT_DYNAMIC_REPLICATOR in the Makefile. I
really liked your idea of making the replicator driver intelligent enough to
deal with both DT and platform declaration, which merges two driver into one.

I'm obviously favouring the second option but recognise it doesn't have to be
part of this patchet.  So for this set please rework the help text for
CORESIGHT_LINKS_AND_SINKS.  Once we've dealt with this topic we can refactor the
replicator driver.

Thanks,
Mathieu 

> 
> Suggested-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Signed-off-by: Kim Phillips <kim.phillips@arm.com>
> ---
>  drivers/hwtracing/coresight/Kconfig | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
> index ef9cb3c164e1..83fb78651ef9 100644
> --- a/drivers/hwtracing/coresight/Kconfig
> +++ b/drivers/hwtracing/coresight/Kconfig
> @@ -23,7 +23,6 @@ config CORESIGHT_LINKS_AND_SINKS
>  
>  config CORESIGHT_LINK_AND_SINK_TMC
>  	bool "Coresight generic TMC driver"
> -	depends on CORESIGHT_LINKS_AND_SINKS
>  	help
>  	  This enables support for the Trace Memory Controller driver.
>  	  Depending on its configuration the device can act as a link (embedded
> @@ -33,7 +32,6 @@ config CORESIGHT_LINK_AND_SINK_TMC
>  
>  config CORESIGHT_SINK_TPIU
>  	bool "Coresight generic TPIU driver"
> -	depends on CORESIGHT_LINKS_AND_SINKS
>  	help
>  	  This enables support for the Trace Port Interface Unit driver,
>  	  responsible for bridging the gap between the on-chip coresight
> @@ -44,7 +42,6 @@ config CORESIGHT_SINK_TPIU
>  
>  config CORESIGHT_SINK_ETBV10
>  	bool "Coresight ETBv1.0 driver"
> -	depends on CORESIGHT_LINKS_AND_SINKS
>  	help
>  	  This enables support for the Embedded Trace Buffer version 1.0 driver
>  	  that complies with the generic implementation of the component without
> @@ -53,7 +50,6 @@ config CORESIGHT_SINK_ETBV10
>  config CORESIGHT_SOURCE_ETM3X
>  	bool "CoreSight Embedded Trace Macrocell 3.x driver"
>  	depends on !ARM64
> -	select CORESIGHT_LINKS_AND_SINKS
>  	help
>  	  This driver provides support for processor ETM3.x and PTM1.x modules,
>  	  which allows tracing the instructions that a processor is executing
> @@ -63,7 +59,6 @@ config CORESIGHT_SOURCE_ETM3X
>  config CORESIGHT_SOURCE_ETM4X
>  	bool "CoreSight Embedded Trace Macrocell 4.x driver"
>  	depends on ARM64
> -	select CORESIGHT_LINKS_AND_SINKS
>  	help
>  	  This driver provides support for the ETM4.x tracer module, tracing the
>  	  instructions that a processor is executing. This is primarily useful
> @@ -72,7 +67,6 @@ config CORESIGHT_SOURCE_ETM4X
>  
>  config CORESIGHT_DYNAMIC_REPLICATOR
>  	bool "CoreSight Programmable Replicator driver"
> -	depends on CORESIGHT_LINKS_AND_SINKS
>  	help
>  	  This enables support for dynamic CoreSight replicator link driver.
>  	  The programmable ATB replicator allows independent filtering of the
> @@ -81,7 +75,6 @@ config CORESIGHT_DYNAMIC_REPLICATOR
>  config CORESIGHT_STM
>  	bool "CoreSight System Trace Macrocell driver"
>  	depends on (ARM && !(CPU_32v3 || CPU_32v4 || CPU_32v4T)) || ARM64
> -	select CORESIGHT_LINKS_AND_SINKS
>  	select STM
>  	help
>  	  This driver provides support for hardware assisted software
> -- 
> 2.17.0
> 
