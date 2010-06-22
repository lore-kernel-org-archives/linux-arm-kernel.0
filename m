From: ext-mika.1.westerberg@nokia.com (Mika Westerberg)
Date: Tue, 22 Jun 2010 09:59:11 +0300
Subject: [PATCH 2/3] page_to_pfn(): use ULONGLONG_MAX to for invalid pfn
In-Reply-To: <cover.1277188127.git.ext-mika.1.westerberg@nokia.com>
References: <cover.1277188127.git.ext-mika.1.westerberg@nokia.com>
Message-ID: <c9fc6b9efa07b4e203d9c4bf13c94e84e9d0bb40.1277188128.git.ext-mika.1.westerberg@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some architectures define PHYS_PFN_OFFSET to be != 0 (ARM for example). This
means that mem_map[0] is actually first page in kernel direct mapped view (which
is a valid page).

Change invalid pfn to be ULONGLONG_MAX instead of 0 to handle such cases.

Signed-off-by: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
---
 makedumpfile.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index a33bab6..89360bd 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -4383,7 +4383,8 @@ unsigned long long
 page_to_pfn(unsigned long page)
 {
 	unsigned int num;
-	unsigned long long pfn = 0, index = 0;
+	unsigned long long pfn = ULONGLONG_MAX;
+	unsigned long long index = 0;
 	struct mem_map_data *mmd;
 
 	mmd = info->mem_map_data;
@@ -4398,7 +4399,7 @@ page_to_pfn(unsigned long page)
 		pfn = mmd->pfn_start + index;
 		break;
 	}
-	if (!pfn) {
+	if (pfn == ULONGLONG_MAX) {
 		ERRMSG("Can't convert the address of page descriptor (%lx) to pfn.\n", page);
 		return ULONGLONG_MAX;
 	}
-- 
1.5.6.5
