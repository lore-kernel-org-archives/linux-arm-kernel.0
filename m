From: peterz@infradead.org (Peter Zijlstra)
Date: Tue, 27 May 2014 14:48:48 +0200
Subject: [PATCH v2 02/11] sched: remove a wake_affine condition
In-Reply-To: <1400860385-14555-3-git-send-email-vincent.guittot@linaro.org>
References: <1400860385-14555-1-git-send-email-vincent.guittot@linaro.org>
 <1400860385-14555-3-git-send-email-vincent.guittot@linaro.org>
Message-ID: <20140527124848.GQ30445@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 23, 2014 at 05:52:56PM +0200, Vincent Guittot wrote:
> I have tried to understand the meaning of the condition :
>  (this_load <= load &&
>   this_load + target_load(prev_cpu, idx) <= tl_per_task)
> but i failed to find a use case that can take advantage of it and i haven't
> found description of it in the previous commits' log.

commit 2dd73a4f09beacadde827a032cf15fd8b1fa3d48

    int try_to_wake_up():
    
    in this function the value SCHED_LOAD_BALANCE is used to represent the load
    contribution of a single task in various calculations in the code that
    decides which CPU to put the waking task on.  While this would be a valid
    on a system where the nice values for the runnable tasks were distributed
    evenly around zero it will lead to anomalous load balancing if the
    distribution is skewed in either direction.  To overcome this problem
    SCHED_LOAD_SCALE has been replaced by the load_weight for the relevant task
    or by the average load_weight per task for the queue in question (as
    appropriate).

                        if ((tl <= load &&
-                               tl + target_load(cpu, idx) <= SCHED_LOAD_SCALE) ||
-                               100*(tl + SCHED_LOAD_SCALE) <= imbalance*load) {
+                               tl + target_load(cpu, idx) <= tl_per_task) ||
+                               100*(tl + p->load_weight) <= imbalance*load) {


commit a3f21bce1fefdf92a4d1705e888d390b10f3ac6f


+                       if ((tl <= load &&
+                               tl + target_load(cpu, idx) <= SCHED_LOAD_SCALE) ||
+                               100*(tl + SCHED_LOAD_SCALE) <= imbalance*load) {


So back when the code got introduced, it read:

	target_load(prev_cpu, idx) - sync*SCHED_LOAD_SCALE < source_load(this_cpu, idx) &&
	target_load(prev_cpu, idx) - sync*SCHED_LOAD_SCALE + target_load(this_cpu, idx) < SCHED_LOAD_SCALE

So while the first line makes some sense, the second line is still
somewhat challenging.

I read the second line something like: if there's less than one full
task running on the combined cpus.

Now for idx==0 this is hard, because even when sync=1 you can only make
it true if both cpus are completely idle, in which case you really want
to move to the waking cpu I suppose.

One task running will have it == SCHED_LOAD_SCALE.

But for idx>0 this can trigger in all kinds of situations of light load.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140527/a5ffa29b/attachment.sig>
