From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Wed,  6 Jul 2016 16:52:26 +0900
Subject: [PATCH v21 8/8] Documentation: dt: usable-memory and elfcorehdr nodes
 for arm64 kexec
In-Reply-To: <20160706075226.27609-1-takahiro.akashi@linaro.org>
References: <20160706075226.27609-1-takahiro.akashi@linaro.org>
Message-ID: <20160706075226.27609-9-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: James Morse <james.morse@arm.com>

Add documentation for linux,usable-memory and linux,elfcorehdr chosen
nodes used by arm64 kexec to decribe the kdump reserved area, and the
elfcorehdr's location within it.

Signed-off-by: James Morse <james.morse@arm.com>
[akashi: wrap the commit description to avoid a checkpatch warning]
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 Documentation/devicetree/bindings/chosen.txt | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/Documentation/devicetree/bindings/chosen.txt b/Documentation/devicetree/bindings/chosen.txt
index 6ae9d82..443f88b 100644
--- a/Documentation/devicetree/bindings/chosen.txt
+++ b/Documentation/devicetree/bindings/chosen.txt
@@ -52,3 +52,31 @@ This property is set (currently only on PowerPC, and only needed on
 book3e) by some versions of kexec-tools to tell the new kernel that it
 is being booted by kexec, as the booting environment may differ (e.g.
 a different secondary CPU release mechanism)
+
+linux,usable-memory
+-------------------
+
+This property is set on PowerPC and arm64 by kexec-tools during kdump
+to tell the crash kernel the base address of its reserved area of memory, and
+the size. e.g.
+
+/ {
+	chosen {
+		linux,usable-memory = <0x9 0xf0000000 0x0 0x10000000>;
+	};
+};
+
+linux,elfcorehdr
+----------------
+
+This property is set (currently only on arm64) by kexec-tools during kdump
+to tell the crash kernel the address and size of the elfcorehdr that describes
+the old kernel's memory as an elf file. This memory must reside within the area
+described by 'linux,usable-memory'. e.g.
+
+/ {
+	chosen {
+		linux,usable-memory = <0x9 0xf0000000 0x0 0x10000000>;
+		linux,elfcorehdr = <0x9 0xfffff000 0x0 0x800>;
+	};
+};
-- 
2.9.0
