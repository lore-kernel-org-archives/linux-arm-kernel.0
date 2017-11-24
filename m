From: leo.yan@linaro.org (Leo Yan)
Date: Fri, 24 Nov 2017 12:06:48 +0800
Subject: [PATCH v2 4/4] coresight: etm4x: Hook panic dump callback for
 etmv4
In-Reply-To: <CANLsYkzp47dshP_4PfEdEKFfjZD4VsMr7rn5Y=WrKv_RX5dzKw@mail.gmail.com>
References: <1511233724-11867-1-git-send-email-leo.yan@linaro.org>
 <1511233724-11867-5-git-send-email-leo.yan@linaro.org>
 <20171122190905.GB17705@xps15>
 <CANLsYkzp47dshP_4PfEdEKFfjZD4VsMr7rn5Y=WrKv_RX5dzKw@mail.gmail.com>
Message-ID: <20171124040648.GC13184@leoy-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 23, 2017 at 10:03:33AM -0700, Mathieu Poirier wrote:
> On 22 November 2017 at 12:09, Mathieu Poirier
> <mathieu.poirier@linaro.org> wrote:
> > On Tue, Nov 21, 2017 at 11:08:44AM +0800, Leo Yan wrote:
> >> We need to dump etmv4 info as metadata, so the data can be used for
> >> offline checking for configuration and generate 'perf' compatible
> >> file.  This commit hooks etmv4 callback for panic dump.
> >>
> >> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> >> ---
> >>  drivers/hwtracing/coresight/coresight-etm4x.c | 22 ++++++++++++++++++++++
> >>  drivers/hwtracing/coresight/coresight-etm4x.h | 15 +++++++++++++++
> >>  2 files changed, 37 insertions(+)
> >>
> >> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
> >> index cf364a5..bf9608b 100644
> >> --- a/drivers/hwtracing/coresight/coresight-etm4x.c
> >> +++ b/drivers/hwtracing/coresight/coresight-etm4x.c
> >> @@ -418,11 +418,33 @@ static void etm4_disable(struct coresight_device *csdev,
> >>               local_set(&drvdata->mode, CS_MODE_DISABLED);
> >>  }
> >>
> >> +static void etm4_panic_cb(void *data)
> >> +{
> >> +     struct coresight_device *csdev = (struct coresight_device *)data;
> >> +     int cpu = smp_processor_id();
> >> +     struct etmv4_drvdata *drvdata = etmdrvdata[cpu];
> >> +     struct etmv4_config *config = &drvdata->config;
> >> +     struct etmv4_metadata *metadata = &drvdata->metadata;
> >> +
> >> +     metadata->magic = ETM4_METADATA_MAGIC;
> >> +     metadata->cpu = cpu;
> >> +     metadata->trcconfigr = config->cfg;
> >> +     metadata->trctraceidr = drvdata->trcid;
> >> +     metadata->trcidr0 = readl_relaxed(drvdata->base + TRCIDR0);
> >> +     metadata->trcidr1 = readl_relaxed(drvdata->base + TRCIDR1);
> >> +     metadata->trcidr2 = readl_relaxed(drvdata->base + TRCIDR2);
> >> +     metadata->trcidr8 = readl_relaxed(drvdata->base + TRCIDR8);
> >
> > I'm pretty sure this won't work on all architecture.  This tracer may not be
> > powered when this is called and depending on the power domain the TRCIDRx
> > registers are in it may lock.
> >
> > Simply read those at boot time as part of the _probe() function.
> 
> Thinking about this will work when operating from sysFS but
> theoretically inaccurate from perf.  Say we have a 4 CPU system where
> for a perf session only 2 CPUs were used for trace acquisition - the
> process was simply not scheduled on the other 2 CPU.  With the above
> code 2 CPUs (the ones that were actually used) will have the right
> configuration while the other two will have the default tracer
> configuration (since etm4_parse_event_config() was never called on
> them).

This is quite important for how to launch tracing you have reminded me
on IRC and I'd like to list all possible tracer configurations:

- Use sysFS to enable some or all ETM tracers;

- Use perf + '--per-thread' to open one session, as you said the
  session may only use some of CPUs but not all of them;

- Use perf + 'snapshot' mode, this mode now doesn't work but we can
  expect this mode can work later so can enable all tracers;

These three scenarios are what I can think out and panic dump should
handle them correctly, if I miss or misunderstand anything, please feel
free correct me.

> Values in TRCIDR{0, 1, 2, 8} and TRCAUTHSTATUS is RO and won't change.
> So those can be filled at _probe() time when tracers are instantiated.
> Values for trcconfigr ang trctraceidr are trickier.
> 
> When operating from sysFS tracer configuration should be recorded in
> etm4_enable_sysfs(), probably just before smp_call_function_single().
> When operating from perf adding all tracers to the dump list should be
> done in etm_setup_aux() and an update for the configuration in
> etm4_enable_perf(), just before etm4_enable_hw().  When circling
> through tracers to communicate the metadata to the kdump mechanic
> check if buf != NULL, what way we only communicate information about
> tracers that were used.

I'm not sure I catch all your points, so I want check if I can
understand your suggestion as below?

We need allocate dump buffer and save registers value when tracer is
enabled, also add their node into dump list (for sysFS, this is done
in etm4_enable_sysfs() and for perf is in etm_setup_aux() and
etm4_enable_perf()).  After panic happens we iterate all tracer dump
nodes and only update buffer info if (buf != NULL).

> Removal of the tracers from the dump list should be done in etm_free_aux()
> 
> This will need testing :o)

Thanks a lot for the detailed suggestion, will verify them.

[...]

Thanks,
Leo Yan
