From: peterz@infradead.org (Peter Zijlstra)
Date: Fri, 11 Dec 2015 08:33:01 +0100
Subject: FW: Commit 81a43adae3b9 (locking/mutex: Use acquire/release
 semantics) causing failures on arm64 (ThunderX)
In-Reply-To: <CA+=Sn1miWYhH5ddMmLGYWknzcw3d1k4S6QyK9O_ofdJKJDQxmg@mail.gmail.com>
References: <5669D5F2.5050004@caviumnetworks.com>
 <SN1PR07MB21577C72379C8440A208D6BC9EEA0@SN1PR07MB2157.namprd07.prod.outlook.com>
 <CA+=Sn1miWYhH5ddMmLGYWknzcw3d1k4S6QyK9O_ofdJKJDQxmg@mail.gmail.com>
Message-ID: <20151211073301.GD6356@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 10, 2015 at 07:29:34PM -0800, Andrew Pinski wrote:
> On Thu, Dec 10, 2015 at 11:44 AM, David Danny wrote:
> >
> > Hi,
> >
> > We are getting soft lockup OOPs on Cavium CN88XX (A.K.A. ThunderX), which is an arm64 implementation.
> 
> I get a slightly different OOPs and reverting
> c55a6ffa6285e29f874ed403979472631ec70bff I was able to boot.
> What I saw with osq_lock.c was that osq_wait_next is called for both
> lock and unlock case so it might need both barriers.
> The other question comes does atomic_cmpxchg_release have release
> semantics when the compare fails?  Right now it does not.
> 

Out cmpxchg primites imply no barrier on failure, this is documented
somewhere.. /me searches..

---

commit ed2de9f74ecbbf3063d29b2334e7b455d7f35189
Author: Will Deacon <will.deacon@arm.com>
Date:   Thu Jul 16 16:10:06 2015 +0100

    locking/Documentation: Clarify failed cmpxchg() memory ordering semantics
    
    A failed cmpxchg does not provide any memory ordering guarantees, a
    property that is used to optimise the cmpxchg implementations on Alpha,
    PowerPC and arm64.
    
    This patch updates atomic_ops.txt and memory-barriers.txt to reflect
    this.
    
    Signed-off-by: Will Deacon <will.deacon@arm.com>
    Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
    Cc: Andrew Morton <akpm@linux-foundation.org>
    Cc: Davidlohr Bueso <dave@stgolabs.net>
    Cc: Douglas Hatch <doug.hatch@hp.com>
    Cc: H. Peter Anvin <hpa@zytor.com>
    Cc: Jonathan Corbet <corbet@lwn.net>
    Cc: Linus Torvalds <torvalds@linux-foundation.org>
    Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: Scott J Norton <scott.norton@hp.com>
    Cc: Thomas Gleixner <tglx@linutronix.de>
    Cc: Waiman Long <waiman.long@hp.com>
    Link: http://lkml.kernel.org/r/20150716151006.GH26390 at arm.com
    Signed-off-by: Ingo Molnar <mingo@kernel.org>

diff --git a/Documentation/atomic_ops.txt b/Documentation/atomic_ops.txt
index dab6da3382d9..b19fc34efdb1 100644
--- a/Documentation/atomic_ops.txt
+++ b/Documentation/atomic_ops.txt
@@ -266,7 +266,9 @@ with the given old and new values. Like all atomic_xxx operations,
 atomic_cmpxchg will only satisfy its atomicity semantics as long as all
 other accesses of *v are performed through atomic_xxx operations.
 
-atomic_cmpxchg must provide explicit memory barriers around the operation.
+atomic_cmpxchg must provide explicit memory barriers around the operation,
+although if the comparison fails then no memory ordering guarantees are
+required.
 
 The semantics for atomic_cmpxchg are the same as those defined for 'cas'
 below.
diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index 13feb697271f..18fc860df1be 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -2383,9 +2383,7 @@ about the state (old or new) implies an SMP-conditional general memory barrier
 explicit lock operations, described later).  These include:
 
 	xchg();
-	cmpxchg();
 	atomic_xchg();			atomic_long_xchg();
-	atomic_cmpxchg();		atomic_long_cmpxchg();
 	atomic_inc_return();		atomic_long_inc_return();
 	atomic_dec_return();		atomic_long_dec_return();
 	atomic_add_return();		atomic_long_add_return();
@@ -2398,7 +2396,9 @@ about the state (old or new) implies an SMP-conditional general memory barrier
 	test_and_clear_bit();
 	test_and_change_bit();
 
-	/* when succeeds (returns 1) */
+	/* when succeeds */
+	cmpxchg();
+	atomic_cmpxchg();		atomic_long_cmpxchg();
 	atomic_add_unless();		atomic_long_add_unless();
 
 These are used for such things as implementing ACQUIRE-class and RELEASE-class
