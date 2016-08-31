From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Wed, 31 Aug 2016 14:08:31 +0100
Subject: [PATCH v3] Added perf functionality to mmdc driver
In-Reply-To: <20160817194253.16300-1-zhengyu.shen@nxp.com>
References: <20160817194253.16300-1-zhengyu.shen@nxp.com>
Message-ID: <aa4ce6f3-6856-3516-1312-104656c5079d@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/08/16 20:42, Zhengyu Shen wrote:
> MMDC is a multi-mode DDR controller that supports DDR3/DDR3L x16/x32/x64
> and LPDDR2 two channel x16/x32 memory types. MMDC is configurable, high
> performance, and optimized. MMDC is present on i.MX6 Quad and i.MX6
> QuadPlus devices, but this driver only supports i.MX6 Quad at the moment.
> MMDC provides registers for performance counters which read via this
> driver to help debug memory throughput and similar issues.
>
> $ perf stat -a -e mmdc/busy-cycles/,mmdc/read-accesses/,mmdc/read-bytes/,mmdc/total-cycles/,mmdc/write-accesses/,mmdc/write-bytes/ dd if=/dev/zero of=/dev/null bs=1M count=5000
> Performance counter stats for 'dd if=/dev/zero of=/dev/null bs=1M count=5000':
>
>          898021787      mmdc/busy-cycles/
>           14819600      mmdc/read-accesses/
>             471.30 MB   mmdc/read-bytes/
>         2815419216      mmdc/total-cycles/
>           13367354      mmdc/write-accesses/
>             427.76 MB   mmdc/write-bytes/
>
>        5.334757334 seconds time elapsed
>
> Signed-off-by: Zhengyu Shen <zhengyu.shen@nxp.com>
> Signed-off-by: Frank Li <frank.li@nxp.com>
> ---
> Changes from v2 to v3:
> 	Use WARN_ONCE instead of returning generic error values
> 	Replace CPU Notifiers with newer state machine hotplug
> 	Added additional checks on event_init for grouping and sampling
> 	Remove useless mmdc_enable_profiling function
> 	Added comments
> 	Moved start index of events from 0x01 to 0x00
> 	Added a counter to pmu_mmdc to only stop hrtimer after all events are finished
> 	Replace readl_relaxed and writel_relaxed with readl and writel
> 	Removed duplicate update function
> 	Used devm_kasprintf when naming mmdcs probed
>
> Changes from v1 to v2:
> 	Added cpumask and migration handling support to driver
> 	Validated event during event_init
> 	Added code to properly stop counters
> 	Used perf_invalid_context instead of perf_sw_context
> 	Added hrtimer to poll for overflow
> 	Added better description
> 	Added support for multiple mmdcs


Should we move all the PMU specific code under at least CONFIG_PERF_EVENTS ?

Suzuki
