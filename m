From: riel@redhat.com (Rik van Riel)
Date: Wed, 24 May 2017 12:34:46 -0400
Subject: [PATCH 5/5] sh64: ascii armor the sh64 boot init stack canary
In-Reply-To: <20170524155751.424-1-riel@redhat.com>
References: <20170524155751.424-1-riel@redhat.com>
Message-ID: <20170524123446.78510066@annuminas.surriel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the ascii-armor canary to prevent unterminated C string overflows
from being able to successfully overwrite the canary, even if they
somehow obtain the canary value.

Inspired by execshield ascii-armor and Daniel Micay's linux-hardened tree.

Signed-off-by: Rik van Riel <riel@redhat.com>
---
 arch/sh/include/asm/stackprotector.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sh/include/asm/stackprotector.h b/arch/sh/include/asm/stackprotector.h
index d9df3a76847c..141515a43b78 100644
--- a/arch/sh/include/asm/stackprotector.h
+++ b/arch/sh/include/asm/stackprotector.h
@@ -19,6 +19,7 @@ static __always_inline void boot_init_stack_canary(void)
 	/* Try to get a semi random initial value. */
 	get_random_bytes(&canary, sizeof(canary));
 	canary ^= LINUX_VERSION_CODE;
+	canary &= CANARY_MASK;
 
 	current->stack_canary = canary;
 	__stack_chk_guard = current->stack_canary;
