From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Tue,  7 Jun 2016 09:47:39 -0700
Subject: [RESEND/PATCHv4 v4 1/3] firmware: Consolidate kmap/read/write logic
In-Reply-To: <20160607164741.31849-1-stephen.boyd@linaro.org>
References: <20160607164741.31849-1-stephen.boyd@linaro.org>
Message-ID: <20160607164741.31849-2-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We use similar structured code to read and write the kmapped
firmware pages. The only difference is read copies from the kmap
region and write copies to it. Consolidate this into one function
to reduce duplication.

Cc: Vikram Mulukutla <markivx@codeaurora.org>
Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---
 drivers/base/firmware_class.c | 57 ++++++++++++++++++++-----------------------
 1 file changed, 26 insertions(+), 31 deletions(-)

diff --git a/drivers/base/firmware_class.c b/drivers/base/firmware_class.c
index 773fc3099769..01d55723d82c 100644
--- a/drivers/base/firmware_class.c
+++ b/drivers/base/firmware_class.c
@@ -691,6 +691,29 @@ out:
 
 static DEVICE_ATTR(loading, 0644, firmware_loading_show, firmware_loading_store);
 
+static void firmware_rw(struct firmware_buf *buf, char *buffer,
+			loff_t offset, size_t count, bool read)
+{
+	while (count) {
+		void *page_data;
+		int page_nr = offset >> PAGE_SHIFT;
+		int page_ofs = offset & (PAGE_SIZE-1);
+		int page_cnt = min_t(size_t, PAGE_SIZE - page_ofs, count);
+
+		page_data = kmap(buf->pages[page_nr]);
+
+		if (read)
+			memcpy(buffer, page_data + page_ofs, page_cnt);
+		else
+			memcpy(page_data + page_ofs, buffer, page_cnt);
+
+		kunmap(buf->pages[page_nr]);
+		buffer += page_cnt;
+		offset += page_cnt;
+		count -= page_cnt;
+	}
+}
+
 static ssize_t firmware_data_read(struct file *filp, struct kobject *kobj,
 				  struct bin_attribute *bin_attr,
 				  char *buffer, loff_t offset, size_t count)
@@ -715,21 +738,8 @@ static ssize_t firmware_data_read(struct file *filp, struct kobject *kobj,
 
 	ret_count = count;
 
-	while (count) {
-		void *page_data;
-		int page_nr = offset >> PAGE_SHIFT;
-		int page_ofs = offset & (PAGE_SIZE-1);
-		int page_cnt = min_t(size_t, PAGE_SIZE - page_ofs, count);
-
-		page_data = kmap(buf->pages[page_nr]);
-
-		memcpy(buffer, page_data + page_ofs, page_cnt);
+	firmware_rw(buf, buffer, offset, count, true);
 
-		kunmap(buf->pages[page_nr]);
-		buffer += page_cnt;
-		offset += page_cnt;
-		count -= page_cnt;
-	}
 out:
 	mutex_unlock(&fw_lock);
 	return ret_count;
@@ -809,24 +819,9 @@ static ssize_t firmware_data_write(struct file *filp, struct kobject *kobj,
 		goto out;
 
 	retval = count;
+	firmware_rw(buf, buffer, offset, count, false);
 
-	while (count) {
-		void *page_data;
-		int page_nr = offset >> PAGE_SHIFT;
-		int page_ofs = offset & (PAGE_SIZE - 1);
-		int page_cnt = min_t(size_t, PAGE_SIZE - page_ofs, count);
-
-		page_data = kmap(buf->pages[page_nr]);
-
-		memcpy(page_data + page_ofs, buffer, page_cnt);
-
-		kunmap(buf->pages[page_nr]);
-		buffer += page_cnt;
-		offset += page_cnt;
-		count -= page_cnt;
-	}
-
-	buf->size = max_t(size_t, offset, buf->size);
+	buf->size = max_t(size_t, offset + count, buf->size);
 out:
 	mutex_unlock(&fw_lock);
 	return retval;
-- 
2.9.0-rc1
