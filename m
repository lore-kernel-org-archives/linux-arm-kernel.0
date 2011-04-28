From: jamie@jamieiles.com (Jamie Iles)
Date: Thu, 28 Apr 2011 17:12:42 +0100
Subject: [PATCH] ARM: perf: remove erroneous check on active_events
In-Reply-To: <20110428154108.GV17290@n2100.arm.linux.org.uk>
References: <1303898236-14263-1-git-send-email-mark.rutland@arm.com>
	<20110428154108.GV17290@n2100.arm.linux.org.uk>
Message-ID: <20110428161242.GE3052@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 28, 2011 at 04:41:08PM +0100, Russell King - ARM Linux wrote:
> On Wed, Apr 27, 2011 at 10:57:16AM +0100, Mark Rutland wrote:
> > diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
> > index fd6403c..29a0cf8 100644
> > --- a/arch/arm/kernel/perf_event.c
> > +++ b/arch/arm/kernel/perf_event.c
> > @@ -560,11 +560,6 @@ static int armpmu_event_init(struct perf_event *event)
> >  	event->destroy = hw_perf_event_destroy;
> >  
> >  	if (!atomic_inc_not_zero(&active_events)) {
> > -		if (atomic_read(&active_events) > armpmu->num_events) {
> > -			atomic_dec(&active_events);
> 
> Yuck.  This is a good example of atomic_* abuse.  The above does nothing
> to deal with the situation where two threads are running thusly:
> 
> CPU0					CPU1
> atomic_inc_not_zero(&active_events)
> 					atomic_inc_not_zero(&active_events)
> atomic_read(&active_events)
> 					atomic_read(&active_events)
> atomic_dec(&active_events)
> 					atomic_dec(&active_events)
> return -ENOSPC
> 					return -ENOSPC
> 
> when one of those two should have succeeded.  I do wish people would
> get out of the habbit of using atomic variables - they seem to be ripe
> for this kind of abuse.

Yup, I messed up there.  How about the patch below that eliminates the 
atomic_t's entirely?  This means that we always lock the mutex in event 
destruction rather than just for the last one but that seems acceptable 
to me.

The MIPS perf events code is based on this so could do with the same 
change.

Jamie

8<---

diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index 69cfee0..439f006 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -458,16 +458,16 @@ armpmu_release_hardware(void)
 	pmu_device = NULL;
 }
 
-static atomic_t active_events = ATOMIC_INIT(0);
-static DEFINE_MUTEX(pmu_reserve_mutex);
+static int active_events;
+static DEFINE_MUTEX(active_event_lock);
 
 static void
 hw_perf_event_destroy(struct perf_event *event)
 {
-	if (atomic_dec_and_mutex_lock(&active_events, &pmu_reserve_mutex)) {
+	mutex_lock(&active_event_lock);
+	if (--active_events == 0)
 		armpmu_release_hardware();
-		mutex_unlock(&pmu_reserve_mutex);
-	}
+	mutex_unlock(&active_event_lock);
 }
 
 static int
@@ -559,22 +559,18 @@ static int armpmu_event_init(struct perf_event *event)
 
 	event->destroy = hw_perf_event_destroy;
 
-	if (!atomic_inc_not_zero(&active_events)) {
-		if (atomic_read(&active_events) > armpmu->num_events) {
-			atomic_dec(&active_events);
-			return -ENOSPC;
-		}
+	mutex_lock(&active_event_lock);
 
-		mutex_lock(&pmu_reserve_mutex);
-		if (atomic_read(&active_events) == 0) {
-			err = armpmu_reserve_hardware();
-		}
-
-		if (!err)
-			atomic_inc(&active_events);
-		mutex_unlock(&pmu_reserve_mutex);
+	if (++active_events > armpmu->num_events) {
+		--active_events;
+		err = -ENOSPC;
 	}
 
+	if (!err && active_events == 1)
+		err = armpmu_reserve_hardware();
+
+	mutex_unlock(&active_event_lock);
+
 	if (err)
 		return err;
 
