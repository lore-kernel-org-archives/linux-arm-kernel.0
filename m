From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Tue, 10 Mar 2015 14:05:23 +0000
Subject: [PATCH 1/3] arm/pmu: Reject groups spanning multiple hardware PMUs
In-Reply-To: <20150310130041.GC11574@worktop.ger.corp.intel.com>
References: <1425905192-10509-1-git-send-email-suzuki.poulose@arm.com>
 <1425905192-10509-2-git-send-email-suzuki.poulose@arm.com>
 <20150310112723.GY2896@worktop.programming.kicks-ass.net>
 <20150310120521.GD28168@leverpostej>
 <20150310125351.GD2896@worktop.programming.kicks-ass.net>
 <20150310130041.GC11574@worktop.ger.corp.intel.com>
Message-ID: <54FEFA23.7050307@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/03/15 13:00, Peter Zijlstra wrote:
> On Tue, Mar 10, 2015 at 01:53:51PM +0100, Peter Zijlstra wrote:
>>> It would be nicer if we could prevent this in the core so we're not
>>> reliant on every PMU driver doing the same verification. My initial
>>> thought was that seemed like unnecessary duplication of the ctx checking
>>> above, but if we're going to end up shoving it into several drivers
>>> anyway perhaps it's the lesser evil.
>>
>> Again, agreed, that would be better and less error prone. But I'm not
>> entirely sure how to go about doing it :/ I'll have to go think about
>> that; and conferences are not the best place for that.
>>
>> Suggestions on that are welcome of course ;)
>
> So the problem is that event_init() is what will return the pmu, so we
> cannot make decisions on it until after that returns.
>
> Maybe we can pull out the validate step into its own funciton;
> pmu->validate() or whatnot, to be called slightly later.
>
I think we could still solve this problem by deferring the 'context'
validation to the core. The PMUs could validate the group, within its
context. i.e, if it can accommodate its events as a group, during 
event_init.  The problem we face now, is encountering an event from a 
different PMU, which we could leave it to the core as we do already.

i.e the fix could look like (and similarly for other cases):

diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index 557e128..b3af19b 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -259,20 +259,28 @@ out:
  }

  static int
-validate_event(struct pmu_hw_events *hw_events,
-	       struct perf_event *event)
+validate_event(struct pmu *pmu, struct pmu_hw_events *hw_events,
+			       struct perf_event *event)
  {
-	struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
+	struct arm_pmu *armpmu;

  	if (is_software_event(event))
  		return 1;

+	/*
+	 * We are only worried if we can accommodate the events
+	 * from this pmu in this group.
+	 */
+	if (event->pmu != pmu)
+		return 1;
+
  	if (event->state < PERF_EVENT_STATE_OFF)
  		return 1;

  	if (event->state == PERF_EVENT_STATE_OFF && !event->attr.enable_on_exec)
  		return 1;

+	armpmu = to_arm_pmu(event->pmu);
  	return armpmu->get_event_idx(hw_events, event) >= 0;
  }

@@ -288,15 +296,15 @@ validate_group(struct perf_event *event)
  	 */
  	memset(&fake_pmu.used_mask, 0, sizeof(fake_pmu.used_mask));

-	if (!validate_event(&fake_pmu, leader))
+	if (!validate_event(event->pmu, &fake_pmu, leader))
  		return -EINVAL;

  	list_for_each_entry(sibling, &leader->sibling_list, group_entry) {
-		if (!validate_event(&fake_pmu, sibling))
+		if (!validate_event(event->pmu, &fake_pmu, sibling))
  			return -EINVAL;
  	}

-	if (!validate_event(&fake_pmu, event))
+	if (!validate_event(event->pmu, &fake_pmu, event))
  		return -EINVAL;

  	return 0;

Thoughts ?

Suzuki
