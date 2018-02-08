From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 8 Feb 2018 16:13:16 +0000
Subject: [PATCH] coresight replicator: set default y after Kconfig rename
In-Reply-To: <20180207150351.ce930e929bc0d7f6cfb1aa56@arm.com>
References: <20180207150351.ce930e929bc0d7f6cfb1aa56@arm.com>
Message-ID: <4ed2bf14-206a-20c6-40a6-3ab9a2ec07b4@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/02/18 21:03, Kim Phillips wrote:
> Commit 1c8859848dbb ("coresight replicator: Cleanup programmable
> replicator naming") changed the Kconfig symbol name from
> QCOM_REPLICATOR, which, whilst not in the single arm64 defconfig,
> was being set in my juno build script, which left the new symbol unset,
> causing the following unexpected grief:
> 
>   # ./perf record -vvv -C 0 -e cs_etm/@20070000.etr/ --per-thread true
>   ..<snip>..
>   sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 5
>   mmap size 528384B
>   AUX area mmap length 4194304
>   perf event ring buffer mmapped per cpu
>   failed to mmap AUX area
>   failed to mmap with 12 (Cannot allocate memory)
> 
> Make it default y to help not surprise unsuspecting users.

How many users are there relying on your Juno build script? :P

> Fixes: 1c8859848dbb ("coresight replicator: Cleanup programmable replicator naming")

Before that commit, CORESIGHT_QCOM_REPLICATOR was not "default y", nor 
selected by any in-tree configs, so whatever the problem may be this is 
clearly not the correct fix.

> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Kim Phillips <kim.phillips@arm.com>
> ---
>   drivers/hwtracing/coresight/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
> index ef9cb3c164e1..b94bbd95efa6 100644
> --- a/drivers/hwtracing/coresight/Kconfig
> +++ b/drivers/hwtracing/coresight/Kconfig
> @@ -73,6 +73,7 @@ config CORESIGHT_SOURCE_ETM4X
>   config CORESIGHT_DYNAMIC_REPLICATOR
>   	bool "CoreSight Programmable Replicator driver"
>   	depends on CORESIGHT_LINKS_AND_SINKS
> +	default y

CORESIGHT_LINKS_AND_SINKS is "default n" (as indeed is CORESIGHT), and 
not selected by any defconfigs, so in general this doesn't really help 
anyway.

Robin.

>   	help
>   	  This enables support for dynamic CoreSight replicator link driver.
>   	  The programmable ATB replicator allows independent filtering of the
> 
