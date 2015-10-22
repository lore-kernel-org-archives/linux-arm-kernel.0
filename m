From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 22 Oct 2015 12:25:17 +0200 (CEST)
Subject: Problem about CPU stalling in hrtimer_intterrupts()
In-Reply-To: <5628AC58.2030509@huawei.com>
References: <56288585.40204@huawei.com>
 <alpine.DEB.2.11.1510220942010.4012@nanos> <5628AC58.2030509@huawei.com>
Message-ID: <alpine.DEB.2.11.1510221133590.4012@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 22 Oct 2015, Ding Tianhong wrote:
> On 2015/10/22 15:43, Thomas Gleixner wrote:
> >> Jan 01 00:03:32 Linux kernel: i:0 basenow.tv64:4809284991830
> >> hrtimer_get_softexpires_tv64(timer):4440120000000 ccpu0
> >> timer:ffffffdffdec6138, timer->function:ffffffc000129b84
> >> Jan 01 00:03:32 Linux kernel: i:0 basenow.tv64:4809284991830
> >> hrtimer_get_softexpires_tv64(timer):4440120000000 ccpu0

> This problem could only occur on the system with 32 cores, when I
> cut the cores to 16, this problem disappeared, so I think there is
> some parallel problem when the 32 core set clock time together:

> I try to reproduce the scene:
> 
> 1.do_settimeofday64
> 2.update tk time
> 3.update base time offset
> 4.update expires_next
> 
> the 3 and 4 will be called in softirq, but the hrtimer_interrupt may
> break the order and run before 3, I am not sure whether this could
> make the problem, do we need to update base time and expires_next in
> the hrtimer_interrupt?  maybe I miss something, thanks for any
> suggestion.

Base offset is updated in hrtimer_interrupt as
well. hrtimer_update_base() does that. So that's not the problem.

Can you apply the patch below and enable the hrtimer tracepoints and
collect trace data across the point where the problem happens?

Thanks,

	tglx
----

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 44d2cc0436f4..614f8d272cb0 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -575,8 +575,14 @@ static void timekeeping_update(struct timekeeper *tk, unsigned int action)
 	update_fast_timekeeper(&tk->tkr_mono, &tk_fast_mono);
 	update_fast_timekeeper(&tk->tkr_raw,  &tk_fast_raw);
 
-	if (action & TK_CLOCK_WAS_SET)
+	if (action & TK_CLOCK_WAS_SET) {
 		tk->clock_was_set_seq++;
+		trace_printk("TK: Seq: %u R: %lld B: %lld T: %lld\n",
+			     tk->clock_was_set_seq,
+			     tk->offs_real,
+			     tk->offs_boot,
+			     tk->offs_tai);
+	}
 	/*
 	 * The mirroring of the data to the shadow-timekeeper needs
 	 * to happen last here to ensure we don't over-write the
@@ -1954,6 +1960,11 @@ ktime_t ktime_get_update_offsets_now(unsigned int *cwsseq, ktime_t *offs_real,
 		base = ktime_add_ns(base, nsecs);
 
 		if (*cwsseq != tk->clock_was_set_seq) {
+			trace_printk("HR: Seq: %u R: %lld B: %lld T: %lld\n",
+				     tk->clock_was_set_seq,
+				     tk->offs_real,
+				     tk->offs_boot,
+				     tk->offs_tai);
 			*cwsseq = tk->clock_was_set_seq;
 			*offs_real = tk->offs_real;
 			*offs_boot = tk->offs_boot;
