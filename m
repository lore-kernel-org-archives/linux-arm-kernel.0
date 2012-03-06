From: will.deacon@arm.com (Will Deacon)
Date: Tue,  6 Mar 2012 16:54:05 +0000
Subject: [PATCH 5/6] ARM: nommu: Use VECTORS_BASE for vector copying with !MMU
In-Reply-To: <1331052846-19144-1-git-send-email-will.deacon@arm.com>
References: <1331052846-19144-1-git-send-email-will.deacon@arm.com>
Message-ID: <1331052846-19144-6-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jonathan Austin <jonathan.austin@arm.com>

When compiling with !CONFIG_MMU the vectors_page pointer does not get
initialised. In the high vectors case, this results in copying to the
wrong address (0x0) and hence a failure to boot.

This patch instead uses CONFIG_VECTORS_BASE as the destination address
when !CONFIG_MMU.

Signed-off-by: Jonathan Austin <jonathan.austin@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/traps.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index f84dfe6..f1ab393 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -786,7 +786,7 @@ static void __init kuser_get_tls_init(unsigned long vectors)
 
 void __init early_trap_init(void)
 {
-#if defined(CONFIG_CPU_USE_DOMAINS)
+#if defined(CONFIG_CPU_USE_DOMAINS) || !defined(CONFIG_MMU)
 	unsigned long vectors = CONFIG_VECTORS_BASE;
 #else
 	unsigned long vectors = (unsigned long)vectors_page;
-- 
1.7.4.1
