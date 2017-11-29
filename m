From: volodymyr_babchuk@epam.com (Volodymyr Babchuk)
Date: Wed, 29 Nov 2017 14:48:30 +0200
Subject: [RESEND PATCH v2 06/14] tee: optee: add page list manipulation
 functions
In-Reply-To: <1511959718-5421-1-git-send-email-volodymyr_babchuk@epam.com>
References: <1507923164-12796-1-git-send-email-volodymyr_babchuk@epam.com>
 <1511959718-5421-1-git-send-email-volodymyr_babchuk@epam.com>
Message-ID: <1511959718-5421-7-git-send-email-volodymyr_babchuk@epam.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Volodymyr Babchuk <vlad.babchuk@gmail.com>

These functions will be used to pass information about shared
buffers to OP-TEE. ABI between Linux and OP-TEE is defined
in optee_msg.h and optee_smc.h.

optee_msg.h defines OPTEE_MSG_ATTR_NONCONTIG attribute
for shared memory references and describes how such references
should be passed. Note that it uses 64-bit page addresses even
on 32 bit systems. This is done to support LPAE and to unify
interface.

Signed-off-by: Volodymyr Babchuk <vlad.babchuk@gmail.com>
---
 drivers/tee/optee/call.c          | 91 +++++++++++++++++++++++++++++++++++++++
 drivers/tee/optee/optee_private.h |  5 +++
 2 files changed, 96 insertions(+)

diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
index f7b7b40..4db52fe 100644
--- a/drivers/tee/optee/call.c
+++ b/drivers/tee/optee/call.c
@@ -11,6 +11,7 @@
  * GNU General Public License for more details.
  *
  */
+#include <asm/pgtable.h>
 #include <linux/arm-smccc.h>
 #include <linux/device.h>
 #include <linux/err.h>
@@ -442,3 +443,93 @@ void optee_disable_shm_cache(struct optee *optee)
 	}
 	optee_cq_wait_final(&optee->call_queue, &w);
 }
+
+#define PAGELIST_ENTRIES_PER_PAGE				\
+	((OPTEE_MSG_NONCONTIG_PAGE_SIZE / sizeof(u64)) - 1)
+
+/**
+ * optee_fill_pages_list() - write list of user pages to given shared
+ * buffer.
+ *
+ * @dst: page-aligned buffer where list of pages will be stored
+ * @pages: array of pages that represents shared buffer
+ * @num_pages: number of entries in @pages
+ * @page_offset: offset of user buffer from page start
+ *
+ * @dst should be big enough to hold list of user page addresses and
+ *	links to the next pages of buffer
+ */
+void optee_fill_pages_list(u64 *dst, struct page **pages, int num_pages,
+			   size_t page_offset)
+{
+	int n = 0;
+	phys_addr_t optee_page;
+	/*
+	 * Refer to OPTEE_MSG_ATTR_NONCONTIG description in optee_msg.h
+	 * for details.
+	 */
+	struct {
+		uint64_t pages_list[PAGELIST_ENTRIES_PER_PAGE];
+		uint64_t next_page_data;
+	} *pages_data;
+
+	/*
+	 * Currently OP-TEE uses 4k page size and it does not looks
+	 * like this will change in the future.  On other hand, there are
+	 * no know ARM architectures with page size < 4k.
+	 * Thus the next built assert looks redundant. But the following
+	 * code heavily relies on this assumption, so it is better be
+	 * safe than sorry.
+	 */
+	BUILD_BUG_ON(PAGE_SIZE < OPTEE_MSG_NONCONTIG_PAGE_SIZE);
+
+	pages_data = (void *)dst;
+	/*
+	 * If linux page is bigger than 4k, and user buffer offset is
+	 * larger than 4k/8k/12k/etc this will skip first 4k pages,
+	 * because they bear no value data for OP-TEE.
+	 */
+	optee_page = page_to_phys(*pages) +
+		round_down(page_offset, OPTEE_MSG_NONCONTIG_PAGE_SIZE);
+
+	while (true) {
+		pages_data->pages_list[n++] = optee_page;
+
+		if (n == PAGELIST_ENTRIES_PER_PAGE) {
+			pages_data->next_page_data =
+				virt_to_phys(pages_data + 1);
+			pages_data++;
+			n = 0;
+		}
+
+		optee_page += OPTEE_MSG_NONCONTIG_PAGE_SIZE;
+		if (!(optee_page & ~PAGE_MASK)) {
+			if (!--num_pages)
+				break;
+			pages++;
+			optee_page = page_to_phys(*pages);
+		}
+	}
+}
+
+/*
+ * The final entry in each pagelist page is a pointer to the next
+ * pagelist page.
+ */
+static size_t get_pages_list_size(size_t num_entries)
+{
+	int pages = DIV_ROUND_UP(num_entries, PAGELIST_ENTRIES_PER_PAGE);
+
+	return pages * OPTEE_MSG_NONCONTIG_PAGE_SIZE;
+}
+
+u64 *optee_allocate_pages_list(size_t num_entries)
+{
+	return alloc_pages_exact(get_pages_list_size(num_entries), GFP_KERNEL);
+}
+
+void optee_free_pages_list(void *list, size_t num_entries)
+{
+	free_pages_exact(list, get_pages_list_size(num_entries));
+}
+
diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
index c374cd5..b63213d 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -165,6 +165,11 @@ int optee_from_msg_param(struct tee_param *params, size_t num_params,
 int optee_to_msg_param(struct optee_msg_param *msg_params, size_t num_params,
 		       const struct tee_param *params);
 
+u64 *optee_allocate_pages_list(size_t num_entries);
+void optee_free_pages_list(void *array, size_t num_entries);
+void optee_fill_pages_list(u64 *dst, struct page **pages, int num_pages,
+			   size_t page_offset);
+
 /*
  * Small helpers
  */
-- 
2.7.4
