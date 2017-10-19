From: will.deacon@arm.com (Will Deacon)
Date: Thu, 19 Oct 2017 16:28:35 +0100
Subject: [PATCH v6 0/6] Add HiSilicon SoC uncore Performance Monitoring
 Unit driver
In-Reply-To: <20171019122918.mk6wnnwn26krkre4@lakrids.cambridge.arm.com>
References: <1508411121-125691-1-git-send-email-zhangshaokun@hisilicon.com>
 <20171019122918.mk6wnnwn26krkre4@lakrids.cambridge.arm.com>
Message-ID: <20171019152834.GB30652@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 19, 2017 at 01:29:18PM +0100, Mark Rutland wrote:
> Will, are you happy to queue this?
> 
> There's a minor fixup [1] needed in patch 2, but otherwise this looks
> good to me, and builds cleanly.
> 
> I've pushed out a branch [2] with that fix folded in, in case that's
> easier for you. Otherwise, feel free to pick these up with my Ack.

I'm just running some build tests on these. I also tweaked your fix slightly
-- can you check the diff below please?

Will

--->8

diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.c b/drivers/perf/hisilicon/hisi_uncore_pmu.c
index 2bff43f0736b..c74542af4acf 100644
--- a/drivers/perf/hisilicon/hisi_uncore_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_pmu.c
@@ -69,15 +69,18 @@ static bool hisi_validate_event_group(struct perf_event *event)
 	/* Include count for the event */
 	int counters = 1;
 
-	/*
-	 * We must NOT create groups containing mixed PMUs, although
-	 * software events are acceptable
-	 */
-	if (leader->pmu != event->pmu && !is_software_event(leader))
-		return false;
+	if (!is_software_event(leader)) {
+		/*
+		 * We must NOT create groups containing mixed PMUs, although
+		 * software events are acceptable
+		 */
+		if (leader->pmu != event->pmu)
+			return false;
 
-	/* Increment counter for the leader */
-	counters++;
+		/* Increment counter for the leader */
+		if (leader != event)
+			counters++;
+	}
 
 	list_for_each_entry(sibling, &event->group_leader->sibling_list,
 			    group_entry) {
