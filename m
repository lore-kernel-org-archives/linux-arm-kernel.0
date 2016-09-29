From: rabin@rab.in (Rabin Vincent)
Date: Thu, 29 Sep 2016 10:49:53 +0200
Subject: Crash seen on ARM Juno r1 with 4.8-rc8 when Coresight is enabled
In-Reply-To: <CANLsYkypz383Smuqv3B5K3i9mzGxMdc1OJdc_tWQZ5qHWQCeJw@mail.gmail.com>
References: <CAGhh56EPK0BYbjV_v7cehT+yuB=L3O-AkFR2mLQMDAS66zDgDg@mail.gmail.com>
 <CANLsYkypz383Smuqv3B5K3i9mzGxMdc1OJdc_tWQZ5qHWQCeJw@mail.gmail.com>
Message-ID: <20160929084953.GA24154@lnxartpec.se.axis.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 28, 2016 at 11:41:41AM -0600, Mathieu Poirier wrote:
> On 28 September 2016 at 10:35, Venkatesh Vivekanandan
> <venkatesh.vivekanandan@broadcom.com> wrote:
> > [    5.479353] Unable to handle kernel NULL pointer dereference at
> > virtual address 00000000
> > [    5.487372] pgd = ffff000008db1000
> > [    5.490739] [00000000] *pgd=00000009ffffe003,
> > *pud=00000009ffffd003, *pmd=0000000000000000
> > [    5.498940] Internal error: Oops: 96000004 [#1] PREEMPT SMP
> > [    5.504451] Modules linked in:
> > [    5.507474] CPU: 0 PID: 449 Comm: kworker/0:1 Not tainted 4.8.0-rc8-dirty #1
> > [    5.514447] Hardware name: ARM Juno development board (r1) (DT)
> > [    5.520310] Workqueue: events amba_deferred_retry_func
> > [    5.525394] task: ffff800976bfd780 task.stack: ffff8009760bc000
> > [    5.531253] PC is at strcmp+0x1c/0x160
> > [    5.534962] LR is at coresight_orphan_match+0x78/0xc8
> > [    5.539957] pc : [<ffff00000835f14c>] lr : [<ffff00000870231c>]
> > pstate: 40000145
> > [    5.547272] sp : ffff8009760bfa00
> > [    5.550547] x29: ffff8009760bfa00 x28: ffff8009762c7f00
> > [    5.555807] x27: ffff000008d66e46 x26: 0000000000000000
> > [    5.561066] x25: 0000000000000001 x24: ffff000008702048
> > [    5.566325] x23: 0000000000000000 x22: ffff800973ce5000
> > [    5.571584] x21: ffff800973ce0800 x20: 0000000000000000
> > [    5.576843] x19: ffff800976b08600 x18: 0000000000000000
> > [    5.582101] x17: 0000000000000000 x16: ffff000008e52fff
> > [    5.587360] x15: ffff000008e52fff x14: ffffffffffffffff
> > [    5.592619] x13: ffff000008ca5000 x12: 0000000000000008
> > [    5.597878] x11: 0000000000000020 x10: 0101010101010101
> > [    5.603137] x9 : 0000000000000000 x8 : 7fff7f7f7f7f7f7f
> > [    5.608396] x7 : 0000000000000000 x6 : 000000008008cb22
> > [    5.613655] x5 : 22cb080000000000 x4 : ffff800973ce0828
> > [    5.618914] x3 : 0000000000000000 x2 : 3030303031303032
> > [    5.624173] x1 : 0000000000000000 x0 : ffff8009760f1d08
> > [    5.629432]
> 
> Thanks you for reporting this Vankatesh,
> 
> Sudeep and Suzuki, can you guys help me with this - I don't have an R1
> to test with.

I've seen this too, on other platforms.  This should fix it:

8<-----------
>From a9da7d7b47e67dd6ffcafddadb50e6f97503f296 Mon Sep 17 00:00:00 2001
From: Rabin Vincent <rabinv@axis.com>
Date: Tue, 30 Aug 2016 08:54:21 +0200
Subject: [PATCH] coresight: check for NULL child_name

Connection child names associated to ports can sometimes be NULL, which
is the case when booting a system on QEMU or when the Coresight power
domain isn't switched on.  fadf3a44e974 ("coresight: checking for NULL
string in coresight_name_match()") fixed one place to handle this but
the same check is needed in coresight_orphan_match() to prevent a crash
there.

Signed-off-by: Rabin Vincent <rabinv@axis.com>
---
 drivers/hwtracing/coresight/coresight.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index d08d1ab..ceeaaea 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -725,7 +725,8 @@ static int coresight_orphan_match(struct device *dev, void *data)
 		/* We have found at least one orphan connection */
 		if (conn->child_dev == NULL) {
 			/* Does it match this newly added device? */
-			if (!strcmp(dev_name(&csdev->dev), conn->child_name)) {
+			if (conn->child_name &&
+			    !strcmp(dev_name(&csdev->dev), conn->child_name)) {
 				conn->child_dev = csdev;
 			} else {
 				/* This component still has an orphan */
-- 
2.1.4
