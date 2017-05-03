From: mnipxh@hotmail.com (pan xinhui)
Date: Wed, 3 May 2017 18:59:19 +0000
Subject: =?gb2312?B?tPC4tDogW1BBVENIIDAvM10gYXJtNjQ6IHF1ZXVlZCBzcGlubG9ja3MgYW5k?=
 =?gb2312?Q?_rw-locks?=
In-Reply-To: <20170503145141.4966-1-ynorov@caviumnetworks.com>
References: <20170503145141.4966-1-ynorov@caviumnetworks.com>
Message-ID: <SIXPR0199MB0604CF9C101455F7D7417FF7C5160@SIXPR0199MB0604.apcprd01.prod.exchangelabs.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2017/5/3 22:51, Yury Norov ??:> The patch 3 adds implementation for queued-based locking on
> ARM64, and the option in kernel config to enable it. Patches
> 1 and 2 fix some mess in header files to apply patch 3 smoothly.
>
> Tested on QDF2400 with huge improvements with these patches on
> the torture tests, by Adam Wallis.
>
> Tested on ThunderX, by Andrew Pinski:
> 120 thread (30 core - 4 thread/core) CN99xx (single socket):
>
> benchmark               Units	qspinlocks vs ticket locks
> sched/messaging		s	73.91%
> sched/pipe		ops/s	104.18%
> futex/hash		ops/s	103.87%
> futex/wake		ms	71.04%
> futex/wake-parallel	ms	93.88%
> futex/requeue		ms	96.47%
> futex/lock-pi		ops/s	118.33%
>
> Notice, there's the queued locks implementation for the Power PC introduced
> by Pan Xinhui. He largely tested it and also found significant performance
> gain. In arch part it is very similar to this patch though.
> https://lwn.net/Articles/701137/Hi, Yury
    Glad to know you will join locking development :)
I have left IBM. However I still care about the queued-spinlock anyway.

> RFC: https://www.spinics.net/lists/arm-kernel/msg575575.htmlI notice you raised one question about the performance degradation in the acquisition of rw-lock for read on qemu.
This is strange indeed. I once enabled qrwlock on ppc too.

I paste your test reseults below.  Is this a result of
qspinlock + qrwlock VS qspinlock + normal rwlock or
qspinlock + qrwlock VS normal spinlock + normal rwlock?

                          Before           After
spin_lock-torture:      38957034        37076367         -4.83
rw_lock-torture W:       5369471        18971957        253.33
rw_lock-torture R:       6413179         3668160        -42.80


I am not sure how that should happen. I make one RFC patch below(not based on latest kernel), you could apply it to check if ther is any performance improvement.
The idea is that.
In queued_write_lock_slowpath(), we did not unlock the ->wait_lock.
Because the writer hold the rwlock, all readers are still waiting anyway.
And in queued_read_lock_slowpath(), calling rspin_until_writer_unlock() looks like introduce a little overhead, say, spinning at the rwlock.

But in the end, queued_read_lock_slowpath() is too heavy, compared with the normal rwlock. such result maybe is somehow reasonable?

diff --git a/include/asm-generic/qrwlock.h b/include/asm-generic/qrwlock.h
index 54a8e65..28ee01d 100644
--- a/include/asm-generic/qrwlock.h
+++ b/include/asm-generic/qrwlock.h
@@ -28,8 +28,9 @@
  * Writer states & reader shift and bias
  */
 #define	_QW_WAITING	1		/* A writer is waiting	   */
-#define	_QW_LOCKED	0xff		/* A writer holds the lock */
-#define	_QW_WMASK	0xff		/* Writer mask		   */
+#define _QW_KICK	0x80		/* need unlock the spinlock*/
+#define	_QW_LOCKED	0x7f		/* A writer holds the lock */
+#define	_QW_WMASK	0x7f		/* Writer mask		   */
 #define	_QR_SHIFT	8		/* Reader count shift	   */
 #define _QR_BIAS	(1U << _QR_SHIFT)
 
@@ -139,7 +140,10 @@ static inline void queued_read_unlock(struct qrwlock *lock)
  */
 static inline void queued_write_unlock(struct qrwlock *lock)
 {
-	smp_store_release((u8 *)&lock->cnts, 0);
+	u32 v = atomic_read(&lock->cnts) & (_QW_WMASK | _QW_KICK);
+	if (v & _QW_KICK)
+		arch_spin_unlock(&lock->wait_lock);
+	(void)atomic_sub_return_release(v, &lock->cnts);
 }
 
 /*
diff --git a/kernel/locking/qrwlock.c b/kernel/locking/qrwlock.c
index fec0823..1f0ea02 100644
--- a/kernel/locking/qrwlock.c
+++ b/kernel/locking/qrwlock.c
@@ -116,7 +116,7 @@ void queued_write_lock_slowpath(struct qrwlock *lock)
 
 	/* Try to acquire the lock directly if no reader is present */
 	if (!atomic_read(&lock->cnts) &&
-	    (atomic_cmpxchg_acquire(&lock->cnts, 0, _QW_LOCKED) == 0))
+	    (atomic_cmpxchg_acquire(&lock->cnts, 0, _QW_LOCKED|_QW_KICK) == 0))
 		goto unlock;
 
 	/*
@@ -138,12 +138,13 @@ void queued_write_lock_slowpath(struct qrwlock *lock)
 		cnts = atomic_read(&lock->cnts);
 		if ((cnts == _QW_WAITING) &&
 		    (atomic_cmpxchg_acquire(&lock->cnts, _QW_WAITING,
-					    _QW_LOCKED) == _QW_WAITING))
+					    _QW_LOCKED|_QW_KICK) == _QW_WAITING))
 			break;
 
 		cpu_relax_lowlatency();
 	}
 unlock:
-	arch_spin_unlock(&lock->wait_lock);
+	return;
 }
 EXPORT_SYMBOL(queued_write_lock_slowpath);
-- 
2.4.11


thanks
xinhui

> v1:
>   - queued_spin_unlock_wait() and queued_spin_is_locked() are
>     re-implemented in arch part to add additional memory barriers;
>   - queued locks are made optional, ticket locks are enabled by default.
>
> Jan Glauber (1):
>    arm64/locking: qspinlocks and qrwlocks support
>
> Yury Norov (2):
>    kernel/locking: #include <asm/spinlock.h> in qrwlock.c
>    asm-generic: don't #include <linux/atomic.h> in qspinlock_types.h
>
>   arch/arm64/Kconfig                      | 24 +++++++++++++++++++
>   arch/arm64/include/asm/qrwlock.h        |  7 ++++++
>   arch/arm64/include/asm/qspinlock.h      | 42 +++++++++++++++++++++++++++++++++
>   arch/arm64/include/asm/spinlock.h       | 12 ++++++++++
>   arch/arm64/include/asm/spinlock_types.h | 14 ++++++++---
>   arch/arm64/kernel/Makefile              |  1 +
>   arch/arm64/kernel/qspinlock.c           | 34 ++++++++++++++++++++++++++
>   include/asm-generic/qspinlock.h         |  1 +
>   include/asm-generic/qspinlock_types.h   |  8 -------
>   kernel/locking/qrwlock.c                |  1 +
>   10 files changed, 133 insertions(+), 11 deletions(-)
>   create mode 100644 arch/arm64/include/asm/qrwlock.h
>   create mode 100644 arch/arm64/include/asm/qspinlock.h
>   create mode 100644 arch/arm64/kernel/qspinlock.c
>
