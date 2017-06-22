From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 22 Jun 2017 19:18:25 +0100
Subject: [PATCH v3 3/3] perf: xgene: Add support for SoC PMU version 3
In-Reply-To: <20170622175255.GD25967@leverpostej>
References: <1496772146-11084-1-git-send-email-hotran@apm.com>
 <1496772146-11084-4-git-send-email-hotran@apm.com>
 <20170622175255.GD25967@leverpostej>
Message-ID: <20170622181825.GG25967@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 22, 2017 at 06:52:56PM +0100, Mark Rutland wrote:
> Hi Hoan,
> 
> This largely looks good; I have one minor comment.
> 
> On Tue, Jun 06, 2017 at 11:02:26AM -0700, Hoan Tran wrote:
> >  static inline void
> > +xgene_pmu_write_counter64(struct xgene_pmu_dev *pmu_dev, int idx, u64 val)
> > +{
> > +	u32 cnt_lo, cnt_hi;
> > +
> > +	cnt_hi = upper_32_bits(val);
> > +	cnt_lo = lower_32_bits(val);
> > +
> > +	/* v3 has 64-bit counter registers composed by 2 32-bit registers */
> > +	xgene_pmu_write_counter32(pmu_dev, 2 * idx, cnt_lo);
> > +	xgene_pmu_write_counter32(pmu_dev, 2 * idx + 1, cnt_hi);
> > +}
> 
> For this to be atomic, we need to disable the counters for the duration
> of the IRQ handler, which we don't do today.
> 
> Regardless, we should do that to ensure that groups are self-consistent.
> 
> i.e. in xgene_pmu_isr() we should call ops->stop_counters() just after
> taking the pmu lock, and we should call ops->start_counters() just
> before releasing it.
> 
> With that:
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>

Actually, that should be in _xgene_pmu_isr, given we have to do it for each
pmu_dev.

I'll apply the diff below; this also avoids a race on V1 where an
overflow could be lost (as we clear the whole OVSR rather than only the
set bits).

Thanks,
Mark.

diff --git a/drivers/perf/xgene_pmu.c b/drivers/perf/xgene_pmu.c
index 84c32e0..a9659cb 100644
--- a/drivers/perf/xgene_pmu.c
+++ b/drivers/perf/xgene_pmu.c
@@ -1217,13 +1217,15 @@ static void _xgene_pmu_isr(int irq, struct xgene_pmu_dev *pmu_dev)
        u32 pmovsr;
        int idx;
 
+       xgene_pmu->ops->stop_counters(pmu_dev);
+
        if (xgene_pmu->version == PCP_PMU_V3)
                pmovsr = readl(csr + PMU_PMOVSSET) & PMU_OVERFLOW_MASK;
        else
                pmovsr = readl(csr + PMU_PMOVSR) & PMU_OVERFLOW_MASK;
 
        if (!pmovsr)
-               return;
+               goto out;
 
        /* Clear interrupt flag */
        if (xgene_pmu->version == PCP_PMU_V1)
@@ -1243,6 +1245,9 @@ static void _xgene_pmu_isr(int irq, struct xgene_pmu_dev *pmu_dev)
                xgene_perf_event_update(event);
                xgene_perf_event_set_period(event);
        }
+
+out:
+       xgene_pmu->ops->start_counters(pmu_dev);
 }
 
 static irqreturn_t xgene_pmu_isr(int irq, void *dev_id)
