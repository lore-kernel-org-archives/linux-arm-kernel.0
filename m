From: samitolvanen@google.com (Sami Tolvanen)
Date: Fri,  3 Nov 2017 10:11:55 -0700
Subject: [PATCH 10/15] arm64: disable ARM64_ERRATUM_843419 for clang LTO
In-Reply-To: <20171103171203.107569-1-samitolvanen@google.com>
References: <20171103171203.107569-1-samitolvanen@google.com>
Message-ID: <20171103171203.107569-12-samitolvanen@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_CLANG_LTO depends on GNU gold, which can generate ADR_PREL_PG_HI21
relocations even with --fix-cortex-a53-843419.

Since ARM64_ERRATUM_843419 disables kernel support for these relocations,
disable the erratum when LTO is used.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 0df64a6a56d4..43ccddb7c8ec 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -433,6 +433,7 @@ config ARM64_ERRATUM_845719
 
 config ARM64_ERRATUM_843419
 	bool "Cortex-A53: 843419: A load or store might access an incorrect address"
+	depends on !CLANG_LTO
 	default y
 	select ARM64_MODULE_CMODEL_LARGE if MODULES
 	help
-- 
2.15.0.403.gc27cc4dac6-goog
