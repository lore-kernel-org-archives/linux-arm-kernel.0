From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 15 Jan 2013 16:48:15 +0000
Subject: [RFC PATCH 1/4] ARM: b.L: Remove C declarations for vlocks
In-Reply-To: <1358268498-8086-1-git-send-email-dave.martin@linaro.org>
References: <1358268498-8086-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1358268498-8086-2-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vlocks are only useful in very specialised situations, so the
precence of a C header file is more confusing than helpful.  All
current use of vlocks, including allocation of space for the lock
structures themselves, is done in assembler.

This patch removes the C interface, so that people are not tempted
to use vlocks when they shouldn't.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/common/vlock.h |   43 -------------------------------------------
 1 files changed, 0 insertions(+), 43 deletions(-)
 delete mode 100644 arch/arm/common/vlock.h

diff --git a/arch/arm/common/vlock.h b/arch/arm/common/vlock.h
deleted file mode 100644
index 94c29a6..0000000
--- a/arch/arm/common/vlock.h
+++ /dev/null
@@ -1,43 +0,0 @@
-/*
- * vlock.h - simple voting lock implementation
- *
- * Created by:	Dave Martin, 2012-08-16
- * Copyright:	(C) 2012  Linaro Limited
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- */
-
-#ifndef __VLOCK_H
-#define __VLOCK_H
-
-#include <asm/bL_entry.h>
-
-#define VLOCK_OWNER_OFFSET	0
-#define VLOCK_VOTING_OFFSET	4
-#define VLOCK_VOTING_SIZE	((BL_CPUS_PER_CLUSTER + 3) / 4 * 4)
-#define VLOCK_SIZE		(VLOCK_VOTING_OFFSET + VLOCK_VOTING_SIZE)
-#define VLOCK_OWNER_NONE	0
-
-#ifndef __ASSEMBLY__
-
-struct vlock {
-	char data[VLOCK_SIZE];
-};
-
-int vlock_trylock(struct vlock *lock, unsigned int owner);
-void vlock_unlock(struct vlock *lock);
-
-#endif /* __ASSEMBLY__ */
-#endif /* ! __VLOCK_H */
-- 
1.7.4.1
