From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Wed,  9 Oct 2013 00:34:37 +0200
Subject: [PATCH 21/23] ARM: mcpm: fix big endian issue in mcpm startup code
In-Reply-To: <1381271679-27804-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1381271679-27804-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1381271679-27804-22-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Victor Kamensky <victor.kamensky@linaro.org>

In big endian mode mcpm_entry_point is first function
that called on secondaries CPU. First it should switch
CPU into big endian code.

[ben.dooks at codethink.co.uk: merge fix patch from Victor into this]
Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
Acked-by: Nicolas Pitre <nico@linaro.org>
Reviewed-by: Dave Martin <Dave.Martin@arm.com>
Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
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
1.8.4.rc3
