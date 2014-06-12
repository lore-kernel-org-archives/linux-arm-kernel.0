From: Wei.Yang@windriver.com (Wei.Yang at windriver.com)
Date: Thu, 12 Jun 2014 13:16:08 +0800
Subject: [PATCH v1] fs2dt: Refine kdump device_tree sort
Message-ID: <1402550168-7826-1-git-send-email-Wei.Yang@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yang Wei <Wei.Yang@windriver.com>

The commit b02d735bf was to rearrange the device-tree entries, and
assumed that these entries are sorted in the ascending order. but
acctually when I was validating kexec and kdump, the order of
serial node still is changed. We should not only compare the length
of directory name, but also compare the directory name, it would
ensure that the order of device node is really in ascending order.

Signed-off-by: Yang Wei <Wei.Yang@windriver.com>
---
 kexec/fs2dt.c |   13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

		It is validated on Freescale t4240qds.

diff --git a/kexec/fs2dt.c b/kexec/fs2dt.c
index 1e5f074..0bffaf5 100644
--- a/kexec/fs2dt.c
+++ b/kexec/fs2dt.c
@@ -479,6 +479,9 @@ static int comparefunc(const struct dirent **dentry1,
 {
 	char *str1 = (*(struct dirent **)dentry1)->d_name;
 	char *str2 = (*(struct dirent **)dentry2)->d_name;
+	char* ptr1 = strchr(str1, '@');
+	char* ptr2 = strchr(str2, '@');
+	int len1, len2;
 
 	/*
 	 * strcmp scans from left to right and fails to idetify for some
@@ -486,9 +489,13 @@ static int comparefunc(const struct dirent **dentry1,
 	 * Therefore, we get the wrong sorted order like memory at 10000000 and
 	 * memory at f000000.
 	 */
-	if (strchr(str1, '@') && strchr(str2, '@') &&
-		(strlen(str1) > strlen(str2)))
-		return 1;
+	if (ptr1 && ptr2) {
+		len1 = ptr1 - str1;
+		len2 = ptr2 - str2;
+		if (!strncmp(str1, str2, len1 >len2 ? len1: len2) &&
+					(strlen(str1) > strlen(str2)))
+				return 1;
+	}
 
 	return strcmp(str1, str2);
 }
-- 
1.7.9.5
