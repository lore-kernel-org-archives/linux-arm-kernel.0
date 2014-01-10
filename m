From: msalter@redhat.com (Mark Salter)
Date: Fri, 10 Jan 2014 17:29:05 -0500
Subject: [PATCH 1/6] efi: create memory map iteration helper
In-Reply-To: <1389392950-22457-1-git-send-email-msalter@redhat.com>
References: <1389392950-22457-1-git-send-email-msalter@redhat.com>
Message-ID: <1389392950-22457-2-git-send-email-msalter@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are a lot of places in the kernel which iterate through an
EFI memory map. Most of these places use essentially the same
for-loop code. This patch adds a for_each_efi_memory_desc()
helper to clean up all of the existing duplicate code and avoid
more in the future.

Signed-off-by: Mark Salter <msalter@redhat.com>
---
 include/linux/efi.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/efi.h b/include/linux/efi.h
index 11ce678..9dc5b05 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -618,6 +618,12 @@ extern int efi_set_rtc_mmss(const struct timespec *now);
 extern void efi_reserve_boot_services(void);
 extern struct efi_memory_map memmap;
 
+/* Iterate through an efi_memory_map */
+#define for_each_efi_memory_desc(m, md)					   \
+	for ((md) = (m)->map;						   \
+	     (md) <= (efi_memory_desc_t *)((m)->map_end - (m)->desc_size); \
+	     (md) = (void *)(md) + (m)->desc_size)
+
 /**
  * efi_range_is_wc - check the WC bit on an address range
  * @start: starting kvirt address
-- 
1.8.3.1
