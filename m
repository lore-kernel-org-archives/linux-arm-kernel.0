From: riel@redhat.com (riel at redhat.com)
Date: Wed, 24 May 2017 11:57:49 -0400
Subject: [PATCH 3/5] x86: ascii armor the x86_64 boot init stack canary
In-Reply-To: <20170524155751.424-1-riel@redhat.com>
References: <20170524155751.424-1-riel@redhat.com>
Message-ID: <20170524155751.424-4-riel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rik van Riel <riel@redhat.com>

Use the ascii-armor canary to prevent unterminated C string overflows
from being able to successfully overwrite the canary, even if they
somehow obtain the canary value.

Inspired by execshield ascii-armor and Daniel Micay's linux-hardened tree.

Signed-off-by: Rik van Riel <riel@redhat.com>
---
 arch/x86/include/asm/stackprotector.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/stackprotector.h b/arch/x86/include/asm/stackprotector.h
index dcbd9bcce714..8abedf1d650e 100644
--- a/arch/x86/include/asm/stackprotector.h
+++ b/arch/x86/include/asm/stackprotector.h
@@ -74,6 +74,7 @@ static __always_inline void boot_init_stack_canary(void)
 	get_random_bytes(&canary, sizeof(canary));
 	tsc = rdtsc();
 	canary += tsc + (tsc << 32UL);
+	canary &= CANARY_MASK;
 
 	current->stack_canary = canary;
 #ifdef CONFIG_X86_64
-- 
2.9.3
