From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Mon,  6 Jun 2016 10:11:34 +0100
Subject: [PATCH v2 2/9] coresight: Fix tmc_read_unprepare_etr
In-Reply-To: <1465204301-24184-1-git-send-email-suzuki.poulose@arm.com>
References: <1465204301-24184-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1465204301-24184-3-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At the end of the trace capture, we free the allocated memory,
resetting the drvdata->buf to NULL, to indicate that trace data
was collected and the next trace session should allocate the
memory in tmc_enable_etr_sink_sysfs.

The tmc_enable_etr_sink_sysfs, we only allocate memory if drvdata->vaddr
is not NULL (which is not performed at the end of previous session).
This can cause, drvdata->vaddr getting assigned NULL and later we do
memset() which causes a crash as below :

Unable to handle kernel NULL pointer dereference at virtual
 address  00000000
pgd = ffffffc9747f0000
[00000000] *pgd=00000009f402e003, *pud=00000009f402e003,
 *pmd=0000000000000000
Internal error: Oops: 96000046 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 1592 Comm: bash Not tainted 4.7.0-rc1+ #1712
Hardware name: ARM Juno development board (r0) (DT)
task: ffffffc078fe0080 ti: ffffffc974178000 task.ti: ffffffc974178000
PC is at __memset+0x1ac/0x200
LR is at tmc_enable_etr_sink+0xf8/0x304
pc : [<ffffff80083a002c>] lr : [<ffffff800859be44>] pstate: 400001c5
sp : ffffffc97417bc00
x29: ffffffc97417bc00 x28: ffffffc974178000

Call trace:
Exception stack(0xffffffc97417ba40 to 0xffffffc97417bb60)
ba40: 0000000000000001 ffffffc974a5d098 ffffffc97417bc00 ffffff80083a002c
ba60: ffffffc974a5d118 0000000000000000 0000000000000000 0000000000000000
ba80: 0000000000000001 0000000000000000 ffffff800859bdec 0000000000000040
baa0: ffffff8008b45b58 00000000000001c0 ffffffc97417baf0 ffffff80080eddb4
bac0: 0000000000000003 ffffffc078fe0080 ffffffc078fe0960 ffffffc078fe0940
bae0: 0000000000000000 0000000000000000 00000000007fffc0 0000000000000004
bb00: 0000000000000000 0000000000000040 000000000000003f 0000000000000000
bb20: 0000000000000000 0000000000000000 0000000000000000 0000000000000001
bb40: ffffffc078fe0960 0000000000000018 ffffffffffffffff 0008669628000000
[<ffffff80083a002c>] __memset+0x1ac/0x200
[<ffffff8008599814>] coresight_enable_path+0xa8/0x1dc
[<ffffff8008599b10>] coresight_enable+0x88/0x1b8
[<ffffff8008599d88>] enable_source_store+0x3c/0x6c
[<ffffff800845eaf4>] dev_attr_store+0x18/0x28
[<ffffff80082829e8>] sysfs_kf_write+0x54/0x64
[<ffffff8008281c30>] kernfs_fop_write+0x148/0x1d8
[<ffffff8008200128>] __vfs_write+0x28/0x110
[<ffffff8008200e88>] vfs_write+0xa0/0x198
[<ffffff80082021b0>] SyS_write+0x44/0xa0
[<ffffff8008084e70>] el0_svc_naked+0x24/0x28
Code: 91010108 54ffff4a 8b040108 cb050042 (d50b7428)

This patch fixes the issue by clearing the drvdata->vaddr while we free
the allocated buffer at the end of a session, so that we allocate the
memory again.

Cc: mathieu.poirier at linaro.org
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 847d1b5..3369d7a 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -315,7 +315,7 @@ int tmc_read_unprepare_etr(struct tmc_drvdata *drvdata)
 		 */
 		vaddr = drvdata->vaddr;
 		paddr = drvdata->paddr;
-		drvdata->buf = NULL;
+		drvdata->buf = drvdata->vaddr = NULL;
 	}
 
 	drvdata->reading = false;
-- 
1.9.1
