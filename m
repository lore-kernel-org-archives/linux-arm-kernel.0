From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Fri, 10 Jun 2016 11:31:28 +0100
Subject: [PATCH] coresight: Fix erroneous memset in tmc_read_unprepare_etr
In-Reply-To: <1465204301-24184-1-git-send-email-suzuki.poulose@arm.com>
References: <1465204301-24184-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1465554688-28241-1-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At the end of a trace collection, we try to clear the entire buffer
and enable the ETR back if it was already enabled. But, we would have
adjusted the drvdata->buf to point to the beginning of the trace data
in the trace buffer @drvdata->vaddr. So, the following code which
clears the buffer is dangerous and can cause crashes, like below :

	memset(drvdata->buf, 0, drvdata->size);

 Unable to handle kernel paging request at virtual address ffffff800a145000
 pgd = ffffffc974726000
 *pgd=00000009f3e91003, *pud=00000009f3e91003, *pmd=0000000000000000
 PREEMPT SMP
 Modules linked in:
 CPU: 4 PID: 1692 Comm: dd Not tainted 4.7.0-rc2+ #1721
 Hardware name: ARM Juno development board (r0) (DT)
 task: ffffffc9734a0080 ti: ffffffc974460000 task.ti: ffffffc974460000
 PC is at __memset+0x1ac/0x200
 LR is at tmc_read_unprepare_etr+0x144/0x1bc
 pc : [<ffffff80083a05ac>] lr : [<ffffff800859c984>] pstate: 200001c5
 ...
 [<ffffff80083a05ac>] __memset+0x1ac/0x200
 [<ffffff800859b2e4>] tmc_release+0x90/0x94
 [<ffffff8008202f58>] __fput+0xa8/0x1ec
 [<ffffff80082030f4>] ____fput+0xc/0x14
 [<ffffff80080c3ef8>] task_work_run+0xb0/0xe4
 [<ffffff8008088bf4>] do_notify_resume+0x64/0x6c
 [<ffffff8008084d5c>] work_pending+0x10/0x14
 Code: 91010108 54ffff4a 8b040108 cb050042 (d50b7428)

Since we clear the buffer anyway in the following call to
tmc_etr_enable_hw(), remove the erroneous memset().

Fixes: commit de5461970b3e9e1 ("coresight: tmc: allocating memory when needed")
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---

Mathieu,

I think this should go to 4.7. Please push it.

---
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 69e104b..24d99ed 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -306,13 +306,10 @@ int tmc_read_unprepare_etr(struct tmc_drvdata *drvdata)
 	if (local_read(&drvdata->mode) == CS_MODE_SYSFS) {
 		/*
 		 * The trace run will continue with the same allocated trace
-		 * buffer. As such zero-out the buffer so that we don't end
-		 * up with stale data.
-		 *
-		 * Since the tracer is still enabled drvdata::buf
-		 * can't be NULL.
+		 * buffer. The trace buffer is cleared in tmc_etr_enable_hw(),
+		 * so we don't have to explicitly clear it. Also, since the
+		 * tracer is still enabled drvdata::buf can't be NULL.
 		 */
-		memset(drvdata->buf, 0, drvdata->size);
 		tmc_etr_enable_hw(drvdata);
 	} else {
 		/*
-- 
1.9.1
