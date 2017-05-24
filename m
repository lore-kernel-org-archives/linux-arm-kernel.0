From: james.morse@arm.com (James Morse)
Date: Wed, 24 May 2017 17:58:01 +0100
Subject: [PATCH 4/9] arm64: entry.S: mask all exceptions during kernel_exit
In-Reply-To: <20170524165806.29866-1-james.morse@arm.com>
References: <20170524165806.29866-1-james.morse@arm.com>
Message-ID: <20170524165806.29866-5-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a disable_daif call to kernel_exit to mask all exceptions
before restoring registers that are overwritten by an exception.

This should be done before we restore sp_el0, as any exception taken
from EL1 will assume this register is set correctly.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/arm64/kernel/entry.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index b738880350f9..fd429d3ba29b 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -207,6 +207,8 @@ alternative_else_nop_endif
 2:
 #endif
 
+	disable_daif
+
 	.if	\el == 0
 	ldr	x23, [sp, #S_SP]		// load return stack pointer
 	msr	sp_el0, x23
-- 
2.11.0
