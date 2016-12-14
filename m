From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 14 Dec 2016 09:11:47 +0000
Subject: [PATCH 2/2] arm64: mm: enable CONFIG_HOLES_IN_ZONE for NUMA
In-Reply-To: <1481706707-6211-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1481706707-6211-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1481706707-6211-3-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The NUMA code may get confused by the presence of NOMAP regions within
zones, resulting in spurious BUG() checks where the node id deviates
from the containing zone's node id.

Since the kernel has no business reasoning about node ids of pages it
does not own in the first place, enable CONFIG_HOLES_IN_ZONE to ensure
that such pages are disregarded.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 111742126897..0472afe64d55 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -614,6 +614,10 @@ config NEED_PER_CPU_EMBED_FIRST_CHUNK
 	def_bool y
 	depends on NUMA
 
+config HOLES_IN_ZONE
+	def_bool y
+	depends on NUMA
+
 source kernel/Kconfig.preempt
 source kernel/Kconfig.hz
 
-- 
2.7.4
