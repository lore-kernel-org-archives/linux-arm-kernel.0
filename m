From: jeremy.linton@arm.com (Jeremy Linton)
Date: Tue,  3 Oct 2017 15:53:24 -0500
Subject: [PATCH v2 0/1] arm64: spinlocks: Fix write starvation with rwlock
Message-ID: <20171003205325.28703-1-jeremy.linton@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARM64 rwlock is unfair in that readers can perpetually
block the writer. This is most noticeable with tests like

`stress-ng --kill $SOMENUMBERLESSTHANCPUS -t $RUNTIME -v`

which can hold the task lock with fairly small counts
(say 4 on thunderx). This can in some circumstances result
in machine deadlocks as kernel tasks get blocked and the
machine gradually falls over.

This patch changes the rwlock behavior so that readers
not in_interrupt() wait for the writer to complete before
acquiring the lock.

Heavily tested on 1S thunderx, further testing the v8.3 fast
model (for LSE). With the thunderx machines the stress-ng
process counts can be larger than the number of cores on the
machine without causing interactivity problems previously seen
at much lower counts.

V1->V2:
  Added additional code to the arch_read_lock() case which
  allows the read lock to bypass a waiting writer when its
  in interrupt context.

Jeremy Linton (1):
  arm64: spinlocks: Fix write starvation with rwlock

 arch/arm64/include/asm/spinlock.h | 67 ++++++++++++++++++++++++++-------------
 1 file changed, 45 insertions(+), 22 deletions(-)

-- 
2.13.5
