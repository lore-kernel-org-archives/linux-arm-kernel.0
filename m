From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 5 Nov 2015 17:27:57 +0000
Subject: [PATCHv2 3/4] arm-cci: Add routines to enable/disable all counters
In-Reply-To: <563B2C01.80701@arm.com>
References: <1445346326-30820-1-git-send-email-suzuki.poulose@arm.com>
 <1445346326-30820-4-git-send-email-suzuki.poulose@arm.com>
 <20151104182854.GH23860@leverpostej> <563B2C01.80701@arm.com>
Message-ID: <20151105172756.GH32247@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >>+static void pmu_disable_counters_ctrl(struct cci_pmu *cci_pmu, unsigned long *mask)
> >>+{
> >>+	int i;
> >>+
> >>+	for (i = 0; i < cci_pmu->num_cntrs; i++) {
> >>+		clear_bit(i, mask);
> >>+		if (pmu_get_counter_ctrl(cci_pmu, i)) {
> >>+			set_bit(i, mask);
> >>+			pmu_disable_counter(cci_pmu, i);
> >>+		}
> >>+	}
> >>+}
> >
> >I don't understand what's going on with the mask here. Why do we clear
> >ieach bit when the only user (introduced in the next patch) explicitly
> >clears the mask anyway?
> 
> To be more precise, it should have been :
> 
> 	if (pmu_get_counter_ctrl(cci_pmu, i)) {
> 		set_bit(i, mask);
> 		pmu_disable_counter(cci_pmu, i);
> 	} else
> 		clear_bit(i, mask);
> 
> >
> >Can we not get rid of the mask entirely? The combination of used_mask
> >and each event's hwc->state tells us which counters are actually in use.
> 
> The problem is that neither hwc->state nor the cci_pmu->hw_events->events is
> protected by pmu_lock, while enable/disable counter is. So we cannot really
> rely on ((struct perf_event *)(cci_pmu->hw_events->events[counter]))->hw->state.

They must be protected somehow, or we'd have races against cross-calls
and/or the interrupt handler.

Are we protected due to being cpu-affine with interrupts disabled when
modifying these, is there some other mechanism that protects us, or do
we have additional problems here?

Thanks,
Mark.
