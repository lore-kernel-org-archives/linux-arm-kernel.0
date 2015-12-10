From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 10 Dec 2015 15:47:56 +0000
Subject: [PATCHv3 3/5] arm-cci: Add routines to enable/disable all counters
In-Reply-To: <56699D71.3070006@arm.com>
References: <1447783407-18027-1-git-send-email-suzuki.poulose@arm.com>
 <1447783407-18027-4-git-send-email-suzuki.poulose@arm.com>
 <20151210153222.GE495@leverpostej> <56699D71.3070006@arm.com>
Message-ID: <20151210154756.GJ495@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 10, 2015 at 03:42:41PM +0000, Suzuki K. Poulose wrote:
> On 10/12/15 15:32, Mark Rutland wrote:
> >On Tue, Nov 17, 2015 at 06:03:25PM +0000, Suzuki K. Poulose wrote:
> 
> 
> >>+static void __maybe_unused
> >>+pmu_disable_counters(struct cci_pmu *cci_pmu, unsigned long *mask)
> >>+{
> >>+	int i;
> >>+
> >>+	for (i = 0; i < cci_pmu->num_cntrs; i++) {
> >>+		if (pmu_counter_is_enabled(cci_pmu, i)) {
> >>+			set_bit(i, mask);
> >>+			pmu_disable_counter(cci_pmu, i);
> >>+		} else
> >>+			clear_bit(i, mask);
> >
> >Can we not assume a clean mask to begin with?
> 
> If we force the caller to pass a clean mask, yes we could. I am fine
> with either approach.
> 
> >
> >>+	}
> >>+}
> >>+
> >>+/*
> >>+ * Restore the status of the counters. Reversal of the pmu_disable_counters().
> >>+ * For each counter set in the mask, enable the counter back.
> >>+ */
> >>+static void __maybe_unused
> >>+pmu_restore_counters(struct cci_pmu *cci_pmu, unsigned long *mask)
> >
> >This would probably be better with s/restore/enable/ for consistency
> >with pmu_disable_counters.
> 
> I had thought as well, but then chose restore as we don't enable all the
> counters. Given that we pass a mask argument, it is fine to change it to
> enable and will do that in the next one.

How about s/disable/save/ instead, following local_irq_{save,restore} ?

It just felt odd having disable/restore as a pairing.

Mark
