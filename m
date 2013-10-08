From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Mon,  7 Oct 2013 21:37:19 -0700
Subject: [PATCH 1/2] ARM: mcpm: fix big endian issue in mcpm startup code
In-Reply-To: <1381207040-1623-1-git-send-email-victor.kamensky@linaro.org>
References: <1381207040-1623-1-git-send-email-victor.kamensky@linaro.org>
Message-ID: <1381207040-1623-2-git-send-email-victor.kamensky@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In big endian mode mcpm_entry_point is first function
that called on secondaries CPU. First it should switch
CPU into big endian code.

Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
---
 arch/arm/common/mcpm_head.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/common/mcpm_head.S b/arch/arm/common/mcpm_head.S
index 39c96df..4f88f5e 100644
--- a/arch/arm/common/mcpm_head.S
+++ b/arch/arm/common/mcpm_head.S
@@ -15,6 +15,7 @@
 
 #include <linux/linkage.h>
 #include <asm/mcpm.h>
+#include <asm/assembler.h>
 
 #include "vlock.h"
 
@@ -47,6 +48,7 @@
 
 ENTRY(mcpm_entry_point)
 
+ ARM_BE8(setend        be)
  THUMB(	adr	r12, BSYM(1f)	)
  THUMB(	bx	r12		)
  THUMB(	.thumb			)
-- 
1.8.1.4
