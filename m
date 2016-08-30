From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Tue, 30 Aug 2016 15:54:31 +0900
Subject: [PATCH v25] 9/9] Documentation: dt: chosen properties for arm64 kdump
In-Reply-To: <20160830064941.19452-2-takahiro.akashi@linaro.org>
References: <20160830064941.19452-2-takahiro.akashi@linaro.org>
Message-ID: <20160830065431.19663-1-takahiro.akashi@linaro.org>
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
 Documentation/devicetree/bindings/chosen.txt | 50 ++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/Documentation/devicetree/bindings/chosen.txt b/Documentation/devicetree/bindings/chosen.txt
index 6ae9d82..236188a 100644
--- a/Documentation/devicetree/bindings/chosen.txt
+++ b/Documentation/devicetree/bindings/chosen.txt
@@ -52,3 +52,53 @@ This property is set (currently only on PowerPC, and only needed on
 book3e) by some versions of kexec-tools to tell the new kernel that it
 is being booted by kexec, as the booting environment may differ (e.g.
 a different secondary CPU release mechanism)
+
+linux,crashkernel-base
+linux,crashkernel-size
+----------------------
+These properties (currently used on PowerPC and arm64) indicates
+the base address and the size, respectively, of the reserved memory
+range for crash dump kernel.
+e.g.
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
+This property (currently used only on arm64) holds the memory range,
+the base address and the size, which can be used as system ram on
+the *current* kernel. Note that, if this property is present, any memory
+regions under "memory" nodes in DT blob or ones marked as "conventional
+memory" in EFI memory map should be ignored.
+e.g.
+
+/ {
+	chosen {
+		linux,usable-memory-range = <0x9 0xf0000000 0x0 0x10000000>;
+	};
+};
+
+The main usage is for crash dump kernel to identify its own usable
+memory and exclude, at its boot time, any other memory areas that are
+part of the panicked kernel's memory.
+
+linux,elfcorehdr
+----------------
+
+This property (currently used only on arm64) holds the memory range,
+the address and the size, of the elf core header which mainly describes
+the panicked kernel's memory layout in elf format.
+e.g.
+
+/ {
+	chosen {
+		linux,usable-memory-range = <0x9 0xf0000000 0x0 0x10000000>;
+		linux,elfcorehdr = <0x9 0xfffff000 0x0 0x800>;
+	};
+};
-- 
2.9.0
