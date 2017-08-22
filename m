From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 22 Aug 2017 15:39:00 +0100
Subject: [PATCH v3] arm64: kaslr: Adjust the offset to avoid Image across
 alignment boundary
In-Reply-To: <CAKv+Gu84Y-LWvhnzqK5KbjSGa75MpQPcwX6LiC0kpuyFXrP+9w@mail.gmail.com>
References: <CAKv+Gu84Y-LWvhnzqK5KbjSGa75MpQPcwX6LiC0kpuyFXrP+9w@mail.gmail.com>
Message-ID: <150341255454.1724.9424700469626550839.stgit@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With 16KB pages and a kernel Image larger than 16MB, the current
kaslr_early_init() logic for avoiding mappings across swapper table
boundaries fails since increasing the offset by kimg_sz just moves the
problem to the next boundary.

This patch rounds the offset down to (1 << SWAPPER_TABLE_SHIFT) if the
Image crosses a PMD_SIZE boundary.

Fixes: afd0e5a87670 ("arm64: kaslr: Fix up the kernel image alignment")
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---

Changes since v2:

Simplified the offset adjustment by just rounding it down to (1 <<
SWAPPER_TABLE_SHIFT). Tested together with Ard's patch:

http://lkml.kernel.org/r/20170818174230.30435-1-ard.biesheuvel@linaro.org

 arch/arm64/kernel/kaslr.c |   10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/kaslr.c b/arch/arm64/kernel/kaslr.c
index 1d95c204186b..47080c49cc7e 100644
--- a/arch/arm64/kernel/kaslr.c
+++ b/arch/arm64/kernel/kaslr.c
@@ -131,8 +131,7 @@ u64 __init kaslr_early_init(u64 dt_phys)
 	/*
 	 * The kernel Image should not extend across a 1GB/32MB/512MB alignment
 	 * boundary (for 4KB/16KB/64KB granule kernels, respectively). If this
-	 * happens, increase the KASLR offset by the size of the kernel image
-	 * rounded up by SWAPPER_BLOCK_SIZE.
+	 * happens, round down the KASLR offset by (1 << SWAPPER_TABLE_SHIFT).
 	 *
 	 * NOTE: The references to _text and _end below will already take the
 	 *       modulo offset (the physical displacement modulo 2 MB) into
@@ -141,11 +140,8 @@ u64 __init kaslr_early_init(u64 dt_phys)
 	 *       mapping we choose.
 	 */
 	if ((((u64)_text + offset) >> SWAPPER_TABLE_SHIFT) !=
-	    (((u64)_end + offset) >> SWAPPER_TABLE_SHIFT)) {
-		u64 kimg_sz = _end - _text;
-		offset = (offset + round_up(kimg_sz, SWAPPER_BLOCK_SIZE))
-				& mask;
-	}
+	    (((u64)_end + offset) >> SWAPPER_TABLE_SHIFT))
+		offset = round_down(offset, 1 << SWAPPER_TABLE_SHIFT);
 
 	if (IS_ENABLED(CONFIG_KASAN))
 		/*
