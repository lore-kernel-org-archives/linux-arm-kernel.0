From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon, 23 Jul 2018 10:50:41 -0600
Subject: [PATCH v2 08/10] coresight: perf: Add helper to retrieve sink
 configuration
In-Reply-To: <ed621d62-a1d2-abe1-3763-60ea6e5f615f@arm.com>
References: <1531847501-22226-1-git-send-email-suzuki.poulose@arm.com>
 <1531847501-22226-9-git-send-email-suzuki.poulose@arm.com>
 <20180719200739.GB9421@xps15> <ed621d62-a1d2-abe1-3763-60ea6e5f615f@arm.com>
Message-ID: <CANLsYkyX0AtVQHG4sCMS2uVZR83hFQYKzyBK_RHYAtS+OnyqPg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 20 Jul 2018 at 02:43, Suzuki K Poulose <Suzuki.Poulose@arm.com> wrote:
>
> On 19/07/18 21:07, Mathieu Poirier wrote:
> > On Tue, Jul 17, 2018 at 06:11:39PM +0100, Suzuki K Poulose wrote:
> >> We can always find the sink configuration for a given perf_output_handle.
> >> Add a helper to retrieve the sink configuration for a given
> >> perf_output_handle. This will be used to get rid of the set_buffer()
> >> call back.
> >>
> >> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> >> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> >> ---
> >>   drivers/hwtracing/coresight/coresight-etm-perf.c | 14 -------------
> >>   drivers/hwtracing/coresight/coresight-etm-perf.h | 26 ++++++++++++++++++++++++
> >>   2 files changed, 26 insertions(+), 14 deletions(-)
> >>
> >> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> >> index 6a4252b..3cc4a0b 100644
> >> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> >> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> >> @@ -23,20 +23,6 @@
> >>   static struct pmu etm_pmu;
> >>   static bool etm_perf_up;
> >>
> >> -/**
> >> - * struct etm_event_data - Coresight specifics associated to an event
> >> - * @work:           Handle to free allocated memory outside IRQ context.
> >> - * @mask:           Hold the CPU(s) this event was set for.
> >> - * @snk_config:             The sink configuration.
> >> - * @path:           An array of path, each slot for one CPU.
> >> - */
> >> -struct etm_event_data {
> >> -    struct work_struct work;
> >> -    cpumask_t mask;
> >> -    void *snk_config;
> >> -    struct list_head * __percpu *path;
> >> -};
> >> -
> >
> > If this is moved to coresight-etm-perf.h, the #include <linux/percpu-defs.h> can
> > be removed.
>
> Actually, we do have the PER_CPU variables in the file already, which is why I left
> them there.  See the next line.

Of course...

> >
> >>   static DEFINE_PER_CPU(struct perf_output_handle, ctx_handle);
> >>   static DEFINE_PER_CPU(struct coresight_device *, csdev_src);
> >>
>
>
> >> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.h b/drivers/hwtracing/coresight/coresight-etm-perf.h
> >> index 4197df4..da7d933 100644
> >> --- a/drivers/hwtracing/coresight/coresight-etm-perf.h
> >> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.h
> >> @@ -7,6 +7,7 @@
> >>   #ifndef _CORESIGHT_ETM_PERF_H
> >>   #define _CORESIGHT_ETM_PERF_H
> >>
> >> +#include <linux/percpu-defs.h>
> >>   #include "coresight-priv.h"
> >>
> >>   struct coresight_device;
> >> @@ -42,14 +43,39 @@ struct etm_filters {
> >>      bool                    ssstatus;
> >>   };
> >>
> >> +/**
> >> + * struct etm_event_data - Coresight specifics associated to an event
> >> + * @work:           Handle to free allocated memory outside IRQ context.
> >> + * @mask:           Hold the CPU(s) this event was set for.
> >> + * @snk_config:             The sink configuration.
> >> + * @path:           An array of path, each slot for one CPU.
> >> + */
> >> +struct etm_event_data {
> >> +    struct work_struct work;
> >> +    cpumask_t mask;
> >> +    void *snk_config;
> >> +    struct list_head * __percpu *path;
> >> +};
> >>
> >>   #ifdef CONFIG_CORESIGHT
> >>   int etm_perf_symlink(struct coresight_device *csdev, bool link);
> >> +static inline void *etm_perf_sink_config(struct perf_output_handle *handle)
> >> +{
> >> +    struct etm_event_data *data = perf_get_aux(handle);
> >>
> >> +    if (data)
> >> +            return data->snk_config;
> >> +    return NULL;
> >> +}
> >>   #else
> >>   static inline int etm_perf_symlink(struct coresight_device *csdev, bool link)
> >>   { return -EINVAL; }
> >>
> >> +static inline void *etm_perf_sink_config(struct perf_output_handle *handle)
> >> +{
> >> +    return NULL;
> >> +}
> >> +
> >
> > I think we can do without those... See my comment in the next patch.
>
> Sure
