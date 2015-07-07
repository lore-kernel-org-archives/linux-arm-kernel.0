From: will.deacon@arm.com (Will Deacon)
Date: Tue,  7 Jul 2015 18:24:18 +0100
Subject: [PATCH 2/9] locking/qrwlock: avoid redundant atomic_add_return on
 read_lock_slowpath
In-Reply-To: <1436289865-2331-1-git-send-email-will.deacon@arm.com>
References: <1436289865-2331-1-git-send-email-will.deacon@arm.com>
Message-ID: <1436289865-2331-3-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When a slow-path reader gets to the front of the wait queue outside of
interrupt context, it waits for any writers to drain, increments the
reader count and again waits for any additional writers that may have
snuck in between the initial check and the increment.

Given that this second check is performed with acquire semantics, there
is no need to perform the increment using atomic_add_return, which acts
as a full barrier.

This patch changes the slow-path code to use smp_load_acquire and
atomic_add instead of atomic_add_return. Since the check only involves
the writer count, we can perform the acquire after the add.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 kernel/locking/qrwlock.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/qrwlock.c b/kernel/locking/qrwlock.c
index 96b77d1e0545..4e29bef688ac 100644
--- a/kernel/locking/qrwlock.c
+++ b/kernel/locking/qrwlock.c
@@ -98,7 +98,8 @@ void queued_read_lock_slowpath(struct qrwlock *lock, u32 cnts)
 	while (atomic_read(&lock->cnts) & _QW_WMASK)
 		cpu_relax_lowlatency();
 
-	cnts = atomic_add_return(_QR_BIAS, &lock->cnts) - _QR_BIAS;
+	atomic_add(_QR_BIAS, &lock->cnts);
+	cnts = smp_load_acquire((u32 *)&lock->cnts);
 	rspin_until_writer_unlock(lock, cnts);
 
 	/*
-- 
2.1.4
