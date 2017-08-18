From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 18 Aug 2017 16:04:34 +0100
Subject: [PATCH] arm64: kaslr: Adjust the offset to avoid Image across
 alignment boundary
Message-ID: <20170818150435.35224-1-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With 16KB pages and a kernel Image larger than 16MB, the current
kaslr_early_init() logic for avoiding mappings across swapper table
boundaries fails since increasing the offset by kimg_sz just moves the
problem to the next boundary.

This patch decreases the offset by the boundary overflow amount, with
slight risk of reduced entropy as the kernel is more likely to be found
at kimg_sz below a swapper table boundary.

Trying-to-fix: afd0e5a87670 ("arm64: kaslr: Fix up the kernel image alignment")
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---

While preparing this email, I noticed that the kernel eventually failed
to boot, though after a lot more reboot iterations. Mark Rutland also
managed to make the KASLR kernel fail to boot with 64K pages which
wouldn't be explained by this patch.

So, any suggestions are welcome. My testing method, qemu starting a
guest in a loop with virtio-rng-pci.

Thanks.

 arch/arm64/kernel/kaslr.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/kaslr.c b/arch/arm64/kernel/kaslr.c
index a9710efb8c01..e8cdc02f66ae 100644
--- a/arch/arm64/kernel/kaslr.c
+++ b/arch/arm64/kernel/kaslr.c
@@ -131,13 +131,14 @@ u64 __init kaslr_early_init(u64 dt_phys, u64 modulo_offset)
 	/*
 	 * The kernel Image should not extend across a 1GB/32MB/512MB alignment
 	 * boundary (for 4KB/16KB/64KB granule kernels, respectively). If this
-	 * happens, increase the KASLR offset by the size of the kernel image
-	 * rounded up by SWAPPER_BLOCK_SIZE.
+	 * happens, decrease the KASLR offset by the boundary overflow rounded
+	 * up to SWAPPER_BLOCK_SIZE.
 	 */
 	if ((((u64)_text + offset + modulo_offset) >> SWAPPER_TABLE_SHIFT) !=
 	    (((u64)_end + offset + modulo_offset) >> SWAPPER_TABLE_SHIFT)) {
-		u64 kimg_sz = _end - _text;
-		offset = (offset + round_up(kimg_sz, SWAPPER_BLOCK_SIZE))
+		u64 adjust = ((u64)_end + offset + modulo_offset) &
+			((1 << SWAPPER_TABLE_SHIFT) - 1);
+		offset = (offset - round_up(adjust, SWAPPER_BLOCK_SIZE))
 				& mask;
 	}
 
