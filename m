From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Tue, 12 Jul 2016 14:05:14 +0900
Subject: [PATCH v22 8/8] Documentation: dt: chosen properties for arm64 kdump
In-Reply-To: <20160712050514.22307-1-takahiro.akashi@linaro.org>
References: <20160712050514.22307-1-takahiro.akashi@linaro.org>
Message-ID: <20160712050514.22307-9-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: James Morse <james.morse@arm.com>

Add documentation for
	linux,crashkernel-base and crashkernel-size,
	linux,usable-memory-range, and
	linux,elfcorehdr
used by arm64 kexec/kdump to decribe the kdump reserved area, and
the elfcorehdr's location within it.

Signed-off-by: James Morse <james.morse@arm.com>
[takahiro.akashi at linaro.org:
    renamed "usable-memory" to "usable-memory-range",
    added "linux,crashkernel-base" and "-size" ]
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 Documentation/devicetree/bindings/chosen.txt | 45 ++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/Documentation/devicetree/bindings/chosen.txt b/Documentation/devicetree/bindings/chosen.txt
index 6ae9d82..d7a3a86 100644
--- a/Documentation/devicetree/bindings/chosen.txt
+++ b/Documentation/devicetree/bindings/chosen.txt
@@ -52,3 +52,48 @@ This property is set (currently only on PowerPC, and only needed on
 book3e) by some versions of kexec-tools to tell the new kernel that it
 is being booted by kexec, as the booting environment may differ (e.g.
 a different secondary CPU release mechanism)
+
+linux,crashkernel-base
+linux,crashkernel-size
+----------------------
+These properties are set (on PowerPC and arm64) during kdump to tell
+use-space tools, like kexec-tools, the base address of the crash-dump
+kernel's reserved area of memory and the size. e.g.
+
+/ {
+	chosen {
+		linux,crashkernel-base = <0x9 0xf0000000>;
+		linux,crashkernel-size = <0x0 0x10000000>;
+	};
+};
+
+linux,usable-memory-range
+-------------------------
+
+This property is set (currently only on arm64) during kdump to tell
+the crash-dump kernel the base address of its reserved area of memory,
+and the size. e.g.
+
+/ {
+	chosen {
+		linux,usable-memory-range = <0x9 0xf0000000 0x0 0x10000000>;
+	};
+};
+
+Please note that, if this property is present, any memory regions under
+"memory" nodes will be ignored.
+
+linux,elfcorehdr
+----------------
+
+This property is set (currently only on arm64) during kdump to tell
+the crash-dump kernel the address and size of the elfcorehdr that describes
+the old kernel's memory as an elf file. This memory must reside within
+the area described by 'linux,usable-memory-range'. e.g.
+
+/ {
+	chosen {
+		linux,usable-memory = <0x9 0xf0000000 0x0 0x10000000>;
+		linux,elfcorehdr = <0x9 0xfffff000 0x0 0x800>;
+	};
+};
-- 
2.9.0
