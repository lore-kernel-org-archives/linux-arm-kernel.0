From: andreyknvl@google.com (Andrey Konovalov)
Date: Mon,  6 Aug 2018 18:40:43 +0200
Subject: [PATCH v5 08/10] usb, arm64: untag user addresses in devio
In-Reply-To: <cover.1533573460.git.andreyknvl@google.com>
References: <cover.1533573460.git.andreyknvl@google.com>
Message-ID: <39bbae2c9d880bd3c27ac3ee03d4be72e161491c.1533573460.git.andreyknvl@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

devio allows to mmap memory regions and keeps them in a list. It also
accepts a user address through an ioctl call and searches the memory
region list for the region that contains this address. Since the addresses
provided to mmap must not be tagged, and the addresses provided to ioctl
might be tagged, we might compare tagged and untagged addresses during the
search.

Untag the provided addresses before searching.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 drivers/usb/core/devio.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
index 476dcc5f2da3..357c2e7b87b8 100644
--- a/drivers/usb/core/devio.c
+++ b/drivers/usb/core/devio.c
@@ -1404,7 +1404,7 @@ find_memory_area(struct usb_dev_state *ps, const struct usbdevfs_urb *uurb)
 {
 	struct usb_memory *usbm = NULL, *iter;
 	unsigned long flags;
-	unsigned long uurb_start = (unsigned long)uurb->buffer;
+	unsigned long uurb_start = (unsigned long)untagged_addr(uurb->buffer);
 
 	spin_lock_irqsave(&ps->lock, flags);
 	list_for_each_entry(iter, &ps->memory_list, memlist) {
@@ -1633,7 +1633,8 @@ static int proc_do_submiturb(struct usb_dev_state *ps, struct usbdevfs_urb *uurb
 		}
 	} else if (uurb->buffer_length > 0) {
 		if (as->usbm) {
-			unsigned long uurb_start = (unsigned long)uurb->buffer;
+			unsigned long uurb_start =
+				(unsigned long)untagged_addr(uurb->buffer);
 
 			as->urb->transfer_buffer = as->usbm->mem +
 					(uurb_start - as->usbm->vm_start);
@@ -1712,7 +1713,8 @@ static int proc_do_submiturb(struct usb_dev_state *ps, struct usbdevfs_urb *uurb
 	as->ps = ps;
 	as->userurb = arg;
 	if (as->usbm) {
-		unsigned long uurb_start = (unsigned long)uurb->buffer;
+		unsigned long uurb_start =
+			(unsigned long)untagged_addr(uurb->buffer);
 
 		as->urb->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
 		as->urb->transfer_dma = as->usbm->dma_handle +
-- 
2.18.0.597.ga71716f1ad-goog
