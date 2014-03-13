From: leif.lindholm@linaro.org (Leif Lindholm)
Date: Thu, 13 Mar 2014 22:46:56 +0000
Subject: [PATCH v2 03/15] efi: create memory map iteration helper
In-Reply-To: <1394750828-16351-1-git-send-email-leif.lindholm@linaro.org>
References: <1394750828-16351-1-git-send-email-leif.lindholm@linaro.org>
Message-ID: <1394750828-16351-4-git-send-email-leif.lindholm@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Salter <msalter@redhat.com>

There are a lot of places in the kernel which iterate through an
EFI memory map. Most of these places use essentially the same
for-loop code. This patch adds a for_each_efi_memory_desc()
helper to clean up all of the existing duplicate code and avoid
more in the future.

Signed-off-by: Mark Salter <msalter@redhat.com>
Signed-off-by: Leif Lindholm <leif.lindholm@linaro.org>
---
 include/linux/efi.h |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/efi.h b/include/linux/efi.h
index 64d532c..a3276da 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -622,6 +622,12 @@ extern int efi_set_rtc_mmss(const struct timespec *now);
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
1.7.10.4
