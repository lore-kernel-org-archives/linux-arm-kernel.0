From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 30 Mar 2016 15:18:42 +0200
Subject: [PATCH 1/2] arm64: add the initrd region to the linear mapping
 explicitly
In-Reply-To: <1459343923-16283-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1459343923-16283-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1459343923-16283-2-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of going out of our way to relocate the initrd if it turns out
to occupy memory that is not covered by the linear mapping, just add the
initrd to the linear mapping. This puts the burden on the bootloader to
pass initrd= and mem= options that are mutually consistent.

Note that, since the placement of the linear region in the PA space is
also dependent on the placement of the kernel Image, which may reside
anywhere in memory, we may still end up with a situation where the initrd
and the kernel Image are simply too far apart to be covered by the linear
region.

Since we now leave it up to the bootloader to pass the initrd in memory
that is guaranteed to be accessible by the kernel, add a mention of this to
the arm64 boot protocol specification as well.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 Documentation/arm64/booting.txt |  4 +++
 arch/arm64/mm/init.c            | 29 ++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/Documentation/arm64/booting.txt b/Documentation/arm64/booting.txt
index 56d6d8b796db..8d0df62c3fe0 100644
--- a/Documentation/arm64/booting.txt
+++ b/Documentation/arm64/booting.txt
@@ -132,6 +132,10 @@ NOTE: versions prior to v4.6 cannot make use of memory below the
 physical offset of the Image so it is recommended that the Image be
 placed as close as possible to the start of system RAM.
 
+If an initrd/initramfs is passed to the kernel at boot, it must reside
+entirely within a 1 GB aligned physical memory window of up to 32 GB in
+size that fully covers the kernel Image as well.
+
 Any memory described to the kernel (even that below the start of the
 image) which is not marked as reserved from the kernel (e.g., with a
 memreserve region in the device tree) will be considered as available to
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 83ae8b5e5666..82ced5fa1e66 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -207,6 +207,35 @@ void __init arm64_memblock_init(void)
 		memblock_add(__pa(_text), (u64)(_end - _text));
 	}
 
+	if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && initrd_start) {
+		/*
+		 * Add back the memory we just removed if it results in the
+		 * initrd to become inaccessible via the linear mapping.
+		 * Otherwise, this is a no-op
+		 */
+		u64 base = initrd_start & PAGE_MASK;
+		u64 size = PAGE_ALIGN(initrd_end) - base;
+
+		/*
+		 * We can only add back the initrd memory if we don't end up
+		 * with more memory than we can address via the linear mapping.
+		 * It is up to the bootloader to position the kernel and the
+		 * initrd reasonably close to each other (i.e., within 32 GB of
+		 * each other) so that all granule/#levels combinations can
+		 * always access both.
+		 */
+		if (WARN(base < memblock_start_of_DRAM() ||
+			 base + size > memblock_start_of_DRAM() +
+				       linear_region_size,
+			"initrd not fully accessible via the linear mapping -- please check your bootloader ...\n")) {
+			initrd_start = 0;
+		} else {
+			memblock_remove(base, size); /* clear MEMBLOCK_ flags */
+			memblock_add(base, size);
+			memblock_reserve(base, size);
+		}
+	}
+
 	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {
 		extern u16 memstart_offset_seed;
 		u64 range = linear_region_size -
-- 
2.5.0
