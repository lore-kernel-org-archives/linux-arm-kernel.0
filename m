From: gregkh@linuxfoundation.org (gregkh at linuxfoundation.org)
Date: Thu, 13 Sep 2018 14:53:47 +0200
Subject: Patch "irqchip/gic-v3-its: Recompute the number of pages on page size
 change" has been added to the 4.4-stable tree
Message-ID: <153684322722249@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This is a note to let you know that I've just added the patch titled

    irqchip/gic-v3-its: Recompute the number of pages on page size change

to the 4.4-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     irqchip-gic-v3-its-recompute-the-number-of-pages-on-page-size-change.patch
and it can be found in the queue-4.4 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


>From 18aa60ce2751c95d3412ed06a58b8b6cfb6f88f2 Mon Sep 17 00:00:00 2001
From: Marc Zyngier <marc.zyngier@arm.com>
Date: Tue, 26 Jan 2016 14:24:15 +0000
Subject: irqchip/gic-v3-its: Recompute the number of pages on page size change

From: Marc Zyngier <marc.zyngier@arm.com>

commit 18aa60ce2751c95d3412ed06a58b8b6cfb6f88f2 upstream.

When the programming of a GITS_BASERn register fails because of
an unsupported ITS page size, we retry it with a smaller page size.
Unfortunately, we don't recompute the number of allocated ITS pages,
indicating the wrong value computed in the original allocation.

A convenient fix is to free the pages we allocated, update the
page size, and restart the allocation. This will ensure that
we always allocate the right amount in the case of a device
table, specially if we have to reduce the allocation order
to stay within the boundaries of the ITS maximum allocation.

Reported-and-tested-by: Ma Jun <majun258@huawei.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: Jason Cooper <jason@lakedaemon.net>
Link: http://lkml.kernel.org/r/1453818255-1289-1-git-send-email-marc.zyngier at arm.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/irqchip/irq-gic-v3-its.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -884,6 +884,7 @@ static int its_alloc_tables(const char *
 		}
 
 		alloc_size = (1 << order) * PAGE_SIZE;
+retry_alloc_baser:
 		alloc_pages = (alloc_size / psz);
 		if (alloc_pages > GITS_BASER_PAGES_MAX) {
 			alloc_pages = GITS_BASER_PAGES_MAX;
@@ -947,13 +948,16 @@ retry_baser:
 			 * size and retry. If we reach 4K, then
 			 * something is horribly wrong...
 			 */
+			free_pages((unsigned long)base, order);
+			its->tables[i] = NULL;
+
 			switch (psz) {
 			case SZ_16K:
 				psz = SZ_4K;
-				goto retry_baser;
+				goto retry_alloc_baser;
 			case SZ_64K:
 				psz = SZ_16K;
-				goto retry_baser;
+				goto retry_alloc_baser;
 			}
 		}
 


Patches currently in stable-queue which might be from marc.zyngier at arm.com are

queue-4.4/irqchip-gicv3-its-avoid-cache-flush-beyond-its_basern-memory-size.patch
queue-4.4/irqchip-gic-make-interrupt-id-1020-invalid.patch
queue-4.4/irqchip-bcm7038-l1-hide-cpu-offline-callback-when-building-for-smp.patch
queue-4.4/irqchip-gic-v3-add-missing-barrier-to-32bit-version-of-gic_read_iar.patch
queue-4.4/irqchip-gicv3-its-fix-memory-leak-in-its_free_tables.patch
queue-4.4/irqchip-gic-v3-its-recompute-the-number-of-pages-on-page-size-change.patch
queue-4.4/genirq-delay-incrementing-interrupt-count-if-it-s-disabled-pending.patch
