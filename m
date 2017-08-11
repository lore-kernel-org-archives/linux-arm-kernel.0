From: andrzej.p@samsung.com (Andrzej Pietrasiewicz)
Date: Fri, 11 Aug 2017 13:50:00 +0200
Subject: [PATCH 1/2] media: s5p-jpeg: don't overwrite result's "size" member
In-Reply-To: <1502452201-17171-1-git-send-email-andrzej.p@samsung.com>
References: <1502191352-11595-1-git-send-email-andrzej.p@samsung.com>
 <1502452201-17171-1-git-send-email-andrzej.p@samsung.com>
 <CGME20170811115011eucas1p263bb57512af4ce8cee995ecfe92067ca@eucas1p2.samsung.com>
Message-ID: <1502452201-17171-2-git-send-email-andrzej.p@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Originally the "size" member was modified in a local variable passed to
s5p_jpeg_parse_hdr() but the member was not used by the caller, so it did
not matter. After applying the patch

media: s5p-jpeg: Don't use temporary structure in s5p_jpeg_buf_queue

the unnecessary assignment caused the actually used "size" member of the
passed structure to assume a meaningless value.

Fixes: 6c96dbbc2aa9f5b4a ("[media] s5p-jpeg: add support for 5433")
Fixes: 14a2de14dc0619bf9 ("media: s5p-jpeg: Don't use temporary structure in s5p_jpeg_buf_queue")
Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@samsung.com>
---
 drivers/media/platform/s5p-jpeg/jpeg-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/s5p-jpeg/jpeg-core.c b/drivers/media/platform/s5p-jpeg/jpeg-core.c
index 4cef4b8..c00e3a1 100644
--- a/drivers/media/platform/s5p-jpeg/jpeg-core.c
+++ b/drivers/media/platform/s5p-jpeg/jpeg-core.c
@@ -1264,7 +1264,7 @@ static bool s5p_jpeg_parse_hdr(struct s5p_jpeg_q_data *result,
 	}
 	result->sof = sof;
 	result->sof_len = sof_len;
-	result->size = result->components = components;
+	result->components = components;
 
 	return true;
 }
-- 
1.9.1
