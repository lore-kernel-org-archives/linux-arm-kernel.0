From: labbott@redhat.com (Laura Abbott)
Date: Tue, 10 Jan 2017 13:35:45 -0800
Subject: [PATCHv7 06/11] mm/usercopy: Switch to using lm_alias
In-Reply-To: <1484084150-1523-1-git-send-email-labbott@redhat.com>
References: <1484084150-1523-1-git-send-email-labbott@redhat.com>
Message-ID: <1484084150-1523-7-git-send-email-labbott@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The usercopy checking code currently calls __va(__pa(...)) to check for
aliases on symbols. Switch to using lm_alias instead.

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Laura Abbott <labbott@redhat.com>
---
 mm/usercopy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/usercopy.c b/mm/usercopy.c
index 3c8da0a..8345299 100644
--- a/mm/usercopy.c
+++ b/mm/usercopy.c
@@ -108,13 +108,13 @@ static inline const char *check_kernel_text_object(const void *ptr,
 	 * __pa() is not just the reverse of __va(). This can be detected
 	 * and checked:
 	 */
-	textlow_linear = (unsigned long)__va(__pa(textlow));
+	textlow_linear = (unsigned long)lm_alias(textlow);
 	/* No different mapping: we're done. */
 	if (textlow_linear == textlow)
 		return NULL;
 
 	/* Check the secondary mapping... */
-	texthigh_linear = (unsigned long)__va(__pa(texthigh));
+	texthigh_linear = (unsigned long)lm_alias(texthigh);
 	if (overlaps(ptr, n, textlow_linear, texthigh_linear))
 		return "<linear kernel text>";
 
-- 
2.7.4
