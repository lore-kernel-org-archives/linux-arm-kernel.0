From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 22 Jun 2017 18:52:56 +0100
Subject: [PATCH v3 3/3] perf: xgene: Add support for SoC PMU version 3
In-Reply-To: <1496772146-11084-4-git-send-email-hotran@apm.com>
References: <1496772146-11084-1-git-send-email-hotran@apm.com>
 <1496772146-11084-4-git-send-email-hotran@apm.com>
Message-ID: <20170622175255.GD25967@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hoan,

This largely looks good; I have one minor comment.

On Tue, Jun 06, 2017 at 11:02:26AM -0700, Hoan Tran wrote:
>  static inline void
> +xgene_pmu_write_counter64(struct xgene_pmu_dev *pmu_dev, int idx, u64 val)
> +{
> +	u32 cnt_lo, cnt_hi;
> +
> +	cnt_hi = upper_32_bits(val);
> +	cnt_lo = lower_32_bits(val);
> +
> +	/* v3 has 64-bit counter registers composed by 2 32-bit registers */
> +	xgene_pmu_write_counter32(pmu_dev, 2 * idx, cnt_lo);
> +	xgene_pmu_write_counter32(pmu_dev, 2 * idx + 1, cnt_hi);
> +}

For this to be atomic, we need to disable the counters for the duration
of the IRQ handler, which we don't do today.

Regardless, we should do that to ensure that groups are self-consistent.

i.e. in xgene_pmu_isr() we should call ops->stop_counters() just after
taking the pmu lock, and we should call ops->start_counters() just
before releasing it.

With that:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.
