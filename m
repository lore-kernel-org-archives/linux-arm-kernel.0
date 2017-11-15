From: samitolvanen@google.com (Sami Tolvanen)
Date: Wed, 15 Nov 2017 13:34:20 -0800
Subject: [PATCH v2 10/18] arm64: add a workaround for GNU gold with
 ARM64_MODULE_PLTS
In-Reply-To: <20171115213428.22559-1-samitolvanen@google.com>
References: <20171115213428.22559-1-samitolvanen@google.com>
Message-ID: <20171115213428.22559-11-samitolvanen@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_CLANG_LTO depends on GNU gold and due to a known bug, the
linker crashes when ARM64_MODULE_PLTS is enabled:

  https://sourceware.org/bugzilla/show_bug.cgi?id=14592

To work around the problem, this change removes NOLOAD from .plt
and .init.plt, which allows us to link modules with ld.gold.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/arm64/kernel/module.lds | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/module.lds b/arch/arm64/kernel/module.lds
index f7c9781a9d48..eacb5c67f61e 100644
--- a/arch/arm64/kernel/module.lds
+++ b/arch/arm64/kernel/module.lds
@@ -1,4 +1,4 @@
 SECTIONS {
-	.plt (NOLOAD) : { BYTE(0) }
-	.init.plt (NOLOAD) : { BYTE(0) }
+	.plt : { BYTE(0) }
+	.init.plt : { BYTE(0) }
 }
-- 
2.15.0.448.gf294e3d99a-goog
