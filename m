From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Tue, 8 Nov 2016 14:00:07 -0500
Subject: [PATCH 1/1 v7] ARM: imx: Added perf functionality to mmdc driver
In-Reply-To: <1474307267-3081-1-git-send-email-Frank.Li@nxp.com>
References: <1474307267-3081-1-git-send-email-Frank.Li@nxp.com>
Message-ID: <CAP=VYLo_p3ZmOFcyM9om_31-=5O3ZiRLCBkJDDtj84JxAA7h8Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 19, 2016 at 1:47 PM, Frank Li <Frank.Li@nxp.com> wrote:
> From: Zhengyu Shen <zhengyu.shen@nxp.com>
>
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
> Changes from v6 to v7
>     use mmdc_pmu prefix
>     remove unnecessary check
>     improve group event check according to mark's feedback.
>     check pmu_mmdc->mmdc_events[cfg] at event_add
>     only check == 0 at event_del
>
> Changes from v5 to v6
>     Improve group event error handle
>
> Changes from v4 to v5
>     Remove mmdc_pmu:irq
>     remove static variable cpuhp_mmdc_pmu
>     remove spin_lock
>     check is_sampling_event(event)
>     remove unnecessary cast
>     use hw_perf_event::prev_count
>
> Changes from v3 to v4:
>     Tested and fixed crash relating to removing events with perf fuzzer
>     Adjusted formatting
>     Moved all perf event code under CONFIG_PERF_EVENTS
>         Switched cpuhp_setup_state to cpuhp_setup_state_nocalls
>
> Changes from v2 to v3:
>     Use WARN_ONCE instead of returning generic error values
>     Replace CPU Notifiers with newer state machine hotplug
>     Added additional checks on event_init for grouping and sampling
>     Remove useless mmdc_enable_profiling function
>     Added comments
>     Moved start index of events from 0x01 to 0x00
>     Added a counter to pmu_mmdc to only stop hrtimer after all events are finished
>     Replace readl_relaxed and writel_relaxed with readl and writel
>     Removed duplicate update function
>     Used devm_kasprintf when naming mmdcs probed
>
> Changes from v1 to v2:
>     Added cpumask and migration handling support to driver
>     Validated event during event_init
>     Added code to properly stop counters
>     Used perf_invalid_context instead of perf_sw_context
>     Added hrtimer to poll for overflow
>     Added better description
>     Added support for multiple mmdcs
>
>  arch/arm/mach-imx/mmdc.c | 459 ++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 457 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-imx/mmdc.c b/arch/arm/mach-imx/mmdc.c
> index db9621c..1f70376 100644
> --- a/arch/arm/mach-imx/mmdc.c
> +++ b/arch/arm/mach-imx/mmdc.c
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright 2011 Freescale Semiconductor, Inc.
> + * Copyright 2011,2016 Freescale Semiconductor, Inc.
>   * Copyright 2011 Linaro Ltd.
>   *
>   * The code contained herein is licensed under the GNU General Public
> @@ -10,12 +10,16 @@
>   * http://www.gnu.org/copyleft/gpl.html
>   */
>
> +#include <linux/hrtimer.h>
>  #include <linux/init.h>
> +#include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
>  #include <linux/of_device.h>
> +#include <linux/perf_event.h>
> +#include <linux/slab.h>
>
>  #include "common.h"
>
> @@ -27,8 +31,458 @@
>  #define BM_MMDC_MDMISC_DDR_TYPE        0x18
>  #define BP_MMDC_MDMISC_DDR_TYPE        0x3
>
> +#define TOTAL_CYCLES           0x0
> +#define BUSY_CYCLES            0x1
> +#define READ_ACCESSES          0x2
> +#define WRITE_ACCESSES         0x3
> +#define READ_BYTES             0x4
> +#define WRITE_BYTES            0x5
> +
> +/* Enables, resets, freezes, overflow profiling*/
> +#define DBG_DIS                        0x0
> +#define DBG_EN                 0x1
> +#define DBG_RST                        0x2
> +#define PRF_FRZ                        0x4
> +#define CYC_OVF                        0x8
> +
> +#define MMDC_MADPCR0   0x410
> +#define MMDC_MADPSR0   0x418
> +#define MMDC_MADPSR1   0x41C
> +#define MMDC_MADPSR2   0x420
> +#define MMDC_MADPSR3   0x424
> +#define MMDC_MADPSR4   0x428
> +#define MMDC_MADPSR5   0x42C
> +
> +#define MMDC_NUM_COUNTERS      6
> +
> +#define to_mmdc_pmu(p) container_of(p, struct mmdc_pmu, pmu)
> +
>  static int ddr_type;
>
> +#ifdef CONFIG_PERF_EVENTS
> +
> +static DEFINE_IDA(mmdc_ida);
> +
> +PMU_EVENT_ATTR_STRING(total-cycles, mmdc_pmu_total_cycles, "event=0x00")
> +PMU_EVENT_ATTR_STRING(busy-cycles, mmdc_pmu_busy_cycles, "event=0x01")
> +PMU_EVENT_ATTR_STRING(read-accesses, mmdc_pmu_read_accesses, "event=0x02")
> +PMU_EVENT_ATTR_STRING(write-accesses, mmdc_pmu_write_accesses, "config=0x03")
> +PMU_EVENT_ATTR_STRING(read-bytes, mmdc_pmu_read_bytes, "event=0x04")
> +PMU_EVENT_ATTR_STRING(read-bytes.unit, mmdc_pmu_read_bytes_unit, "MB");
> +PMU_EVENT_ATTR_STRING(read-bytes.scale, mmdc_pmu_read_bytes_scale, "0.000001");
> +PMU_EVENT_ATTR_STRING(write-bytes, mmdc_pmu_write_bytes, "event=0x05")
> +PMU_EVENT_ATTR_STRING(write-bytes.unit, mmdc_pmu_write_bytes_unit, "MB");
> +PMU_EVENT_ATTR_STRING(write-bytes.scale, mmdc_pmu_write_bytes_scale, "0.000001");
> +
> +struct mmdc_pmu {
> +       struct pmu pmu;
> +       void __iomem *mmdc_base;
> +       cpumask_t cpu;
> +       struct hrtimer hrtimer;
> +       unsigned int active_events;
> +       struct device *dev;
> +       struct perf_event *mmdc_events[MMDC_NUM_COUNTERS];
> +       struct hlist_node node;
> +};
> +
> +/*
> + * Polling period is set to one second, overflow of total-cycles (the fastest
> + * increasing counter) takes ten seconds so one second is safe
> + */
> +static unsigned int mmdc_pmu_poll_period_us = 1000000;
> +
> +module_param_named(pmu_pmu_poll_period_us, mmdc_pmu_poll_period_us, uint,
> +               S_IRUGO | S_IWUSR);

I just noticed this commit now that linux-next is back after the week off.

This should probably use core_param or setup_param since the Kconfig
for this is bool and not tristate.  Similarly, that means that the .remove
function you've added is dead code -- unless you envision a case where
the user needs to forcibly unbind the driver...

Do you want to redo the existing commit or do you want me to submit
a follow-up fixup patch?

Thanks
Paul.
--

> +
> +static ktime_t mmdc_pmu_timer_period(void)
> +{
> +       return ns_to_ktime((u64)mmdc_pmu_poll_period_us * 1000);
> +}
> +
