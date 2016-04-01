From: james.morse@arm.com (James Morse)
Date: Fri,  1 Apr 2016 17:53:38 +0100
Subject: [PATCH v7 14/16] PM / Hibernate: Call flush_icache_range() on pages
 restored in-place
In-Reply-To: <1459529620-22150-1-git-send-email-james.morse@arm.com>
References: <1459529620-22150-1-git-send-email-james.morse@arm.com>
Message-ID: <1459529620-22150-15-git-send-email-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some architectures require code written to memory as if it were data to be
'cleaned' from any data caches before the processor can fetch them as new
instructions.

During resume from hibernate, the snapshot code copies some pages directly,
meaning these architectures do not get a chance to perform their cache
maintenance. Modify the read and decompress code to call
flush_icache_range() on all pages that are restored, so that the restored
in-place pages are guaranteed to be executable on these architectures.

Signed-off-by: James Morse <james.morse@arm.com>
Acked-by: Pavel Machek <pavel@ucw.cz>
Acked-by: Rafael J. Wysocki <rjw@rjwysocki.net>
---
 kernel/power/swap.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index 12cd989dadf6..a30645d2e93f 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -37,6 +37,14 @@
 #define HIBERNATE_SIG	"S1SUSPEND"
 
 /*
+ * When reading an {un,}compressed image, we may restore pages in place,
+ * in which case some architectures need these pages cleaning before they
+ * can be executed. We don't know which pages these may be, so clean the lot.
+ */
+bool clean_pages_on_read = false;
+bool clean_pages_on_decompress = false;
+
+/*
  *	The swap map is a data structure used for keeping track of each page
  *	written to a swap partition.  It consists of many swap_map_page
  *	structures that contain each an array of MAP_PAGE_ENTRIES swap entries.
@@ -241,6 +249,9 @@ static void hib_end_io(struct bio *bio)
 
 	if (bio_data_dir(bio) == WRITE)
 		put_page(page);
+	else if (clean_pages_on_read)
+		flush_icache_range((unsigned long)page_address(page),
+				   (unsigned long)page_address(page) + PAGE_SIZE);
 
 	if (bio->bi_error && !hb->error)
 		hb->error = bio->bi_error;
@@ -1049,6 +1060,7 @@ static int load_image(struct swap_map_handle *handle,
 
 	hib_init_batch(&hb);
 
+	clean_pages_on_read = true;
 	printk(KERN_INFO "PM: Loading image data pages (%u pages)...\n",
 		nr_to_read);
 	m = nr_to_read / 10;
@@ -1124,6 +1136,10 @@ static int lzo_decompress_threadfn(void *data)
 		d->unc_len = LZO_UNC_SIZE;
 		d->ret = lzo1x_decompress_safe(d->cmp + LZO_HEADER, d->cmp_len,
 		                               d->unc, &d->unc_len);
+		if (clean_pages_on_decompress)
+			flush_icache_range((unsigned long)d->unc,
+					   (unsigned long)d->unc + d->unc_len);
+
 		atomic_set(&d->stop, 1);
 		wake_up(&d->done);
 	}
@@ -1189,6 +1205,8 @@ static int load_image_lzo(struct swap_map_handle *handle,
 	}
 	memset(crc, 0, offsetof(struct crc_data, go));
 
+	clean_pages_on_decompress = true;
+
 	/*
 	 * Start the decompression threads.
 	 */
-- 
2.8.0.rc3
