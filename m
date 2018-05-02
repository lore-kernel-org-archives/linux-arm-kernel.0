From: labbott@redhat.com (Laura Abbott)
Date: Wed,  2 May 2018 13:33:25 -0700
Subject: [PATCH 1/2] stackleak: Update for arm64
In-Reply-To: <20180502203326.9491-1-labbott@redhat.com>
References: <20180502203326.9491-1-labbott@redhat.com>
Message-ID: <20180502203326.9491-2-labbott@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arm64 has another layer of indirection in the RTL.
Account for this in the plugin.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
Fixed from previous version to be a vector expression.
---
 scripts/gcc-plugins/stackleak_plugin.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/gcc-plugins/stackleak_plugin.c b/scripts/gcc-plugins/stackleak_plugin.c
index 6ac2a055ec61..0a55ecaf44df 100644
--- a/scripts/gcc-plugins/stackleak_plugin.c
+++ b/scripts/gcc-plugins/stackleak_plugin.c
@@ -253,6 +253,10 @@ static unsigned int stackleak_cleanup_execute(void)
 		 * that insn.
 		 */
 		body = PATTERN(insn);
+		/* arm64 is different */
+		if (GET_CODE(body) == PARALLEL)
+			body = XVECEXP(body, 0, 0);
+
 		if (GET_CODE(body) != CALL)
 			continue;
 
-- 
2.14.3
