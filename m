From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 16 May 2011 10:27:40 +0100
Subject: [PATCH] ARM: perf: remove erroneous check on active_events
In-Reply-To: <20110428161242.GE3052@pulham.picochip.com>
References: <1303898236-14263-1-git-send-email-mark.rutland@arm.com>
	<20110428154108.GV17290@n2100.arm.linux.org.uk>
	<20110428161242.GE3052@pulham.picochip.com>
Message-ID: <000001cc13ab$81236e60$836a4b20$@rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Yup, I messed up there.  How about the patch below that eliminates the
> atomic_t's entirely?  This means that we always lock the mutex in event
> destruction rather than just for the last one but that seems acceptable
> to me.

Whilst this solves the race condition, it still leaves behind some of the
problems caused by having the counter in the first place:

- Events which can't actually be armed on the hardware will be initialised,
  but still take a slot that could otherwise be used.

- Events which can be armed on the hardware may be blocked by the above, or
  other events which are currently context-switched out (and are essentially
  independent).

- The maximum number of events we can initialise it that which can be
  supported by one core. As the number of cores scale upwards, we're going
to
  waste the majority of the hardware counters.

By removing the counter, we lazily deny events we cannot allocate in the
worst
case. We can still guarantee schedulability of groups if users are sensible
with them.

By having the counter, we aggressively (possibly erroneously) deny events.
As
we cannot check the possibility of arming single events until they hit the
hardware, this can only be considered a heuristic (and not a great one).

> The MIPS perf events code is based on this so could do with the same 
> change.

Agreed. Deleting 4 lines is an easy patch to port. I'll post the ARM changes
to Russell's patch system.

Mark.
