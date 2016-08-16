From: zhengyu.shen@nxp.com (Zhengyu Shen)
Date: Tue, 16 Aug 2016 14:40:43 +0000
Subject: [PATCH v2] Added perf functionality to mmdc driver
In-Reply-To: <20160815165050.GB31080@svinekod>
References: <20160815223035.5429-1-zhengyu.shen@nxp.com>
 <20160815165050.GB31080@svinekod>
Message-ID: <DB5PR04MB14309188D99C35809DDA377B9F130@DB5PR04MB1430.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > 	Added cpumask and migration handling support to driver
> > 	Validated event during event_init
> > 	Added code to properly stop counters
> > 	Used perf_invalid_context instead of perf_sw_context
> > 	Added hrtimer to poll for overflow
> > 	Added better description
> > 	Added support for multiple mmdcs
> 
> As I commented on v1 w.r.t. the above, I would appreciate being Cc'd on
> future versions of this patch.

Sorry about that, I'll be sure to CC you in the future. 

> > +static void mmdc_event_start(struct perf_event *event, int flags) {
> > +	struct mmdc_pmu *pmu_mmdc = to_mmdc_pmu(event->pmu);
> > +	void __iomem *mmdc_base, *reg;
> > +
> > +	local64_set(&event->count, 0);
> > +	mmdc_base = pmu_mmdc->mmdc_base;
> > +	reg = mmdc_base + MMDC_MADPCR0;
> > +	hrtimer_start(&pmu_mmdc->hrtimer, mmdc_timer_period(),
> > +			HRTIMER_MODE_REL_PINNED);
> 
> Why is a hrtimer necessary? Is this just copy-pasted from CCN, or do you
> have similar HW issues?
> 
> Is there no overflow interrupt?

When overflow occurs, a register bit is set to one. There is no overflow
interrupt which is why the timer is needed. 

Thanks a lot for the feedback!
