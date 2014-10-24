From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Fri, 24 Oct 2014 13:18:39 +0300
Subject: [PATCH v2 1/4] mm: cma: Don't crash on allocation if CMA area can't
 be activated
In-Reply-To: <1414145922-26042-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1414145922-26042-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1414145922-26042-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If activation of the CMA area fails its mutex won't be initialized,
leading to an oops at allocation time when trying to lock the mutex. Fix
this by setting the cma area count field to 0 when activation fails,
leading to allocation returning NULL immediately.

Cc: <stable@vger.kernel.org>  # v3.17
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Michal Nazarewicz <mina86@mina86.com>
---
 mm/cma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/cma.c b/mm/cma.c
index 963bc4add9af..5aa1a6f74dec 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -124,6 +124,7 @@ static int __init cma_activate_area(struct cma *cma)
 
 err:
 	kfree(cma->bitmap);
+	cma->count = 0;
 	return -EINVAL;
 }
 
-- 
2.0.4
