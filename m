From: julien.grall@citrix.com (Julien Grall)
Date: Wed, 30 Sep 2015 11:45:28 +0100
Subject: [PATCH v5 13/22] xen/events: fifo: Make it running on 64KB granularity
In-Reply-To: <1443609937-25278-1-git-send-email-julien.grall@citrix.com>
References: <1443609937-25278-1-git-send-email-julien.grall@citrix.com>
Message-ID: <1443609937-25278-14-git-send-email-julien.grall@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Only use the first 4KB of the page to store the events channel info. It
means that we will waste 60KB every time we allocate page for:
     * control block: a page is allocating per CPU
     * event array: a page is allocating everytime we need to expand it

I think we can reduce the memory waste for the 2 areas by:

    * control block: sharing between multiple vCPUs. Although it will
    require some bookkeeping in order to not free the page when the CPU
    goes offline and the other CPUs sharing the page still there

    * event array: always extend the array event by 64K (i.e 16 4K
    chunk). That would require more care when we fail to expand the
    event channel.

Signed-off-by: Julien Grall <julien.grall@citrix.com>
Reviewed-by: David Vrabel <david.vrabel@citrix.com>
Reviewed-by: Stefano Stabellini <stefano.stabellini@citrix.com>

---
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>

    Note I haven't updated the suggestion to reduce the memory waste
    after David's email [1]. I can do it if necessary.

    Changes in v3:
        - Add David and Stefano's reviewed-by

    [1] http://lists.xen.org/archives/html/xen-devel/2015-07/msg04596.html
---
 drivers/xen/events/events_base.c | 2 +-
 drivers/xen/events/events_fifo.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
index 6cd5e65..849500e 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -40,11 +40,11 @@
 #include <asm/idle.h>
 #include <asm/io_apic.h>
 #include <asm/xen/pci.h>
-#include <xen/page.h>
 #endif
 #include <asm/sync_bitops.h>
 #include <asm/xen/hypercall.h>
 #include <asm/xen/hypervisor.h>
+#include <xen/page.h>
 
 #include <xen/xen.h>
 #include <xen/hvm.h>
diff --git a/drivers/xen/events/events_fifo.c b/drivers/xen/events/events_fifo.c
index 1d4baf5..e3e9e3d 100644
--- a/drivers/xen/events/events_fifo.c
+++ b/drivers/xen/events/events_fifo.c
@@ -54,7 +54,7 @@
 
 #include "events_internal.h"
 
-#define EVENT_WORDS_PER_PAGE (PAGE_SIZE / sizeof(event_word_t))
+#define EVENT_WORDS_PER_PAGE (XEN_PAGE_SIZE / sizeof(event_word_t))
 #define MAX_EVENT_ARRAY_PAGES (EVTCHN_FIFO_NR_CHANNELS / EVENT_WORDS_PER_PAGE)
 
 struct evtchn_fifo_queue {
-- 
2.1.4
