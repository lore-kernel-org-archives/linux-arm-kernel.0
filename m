From: tixy@linaro.org (Jon Medhurst)
Date: Thu, 16 Mar 2017 13:36:09 +0000
Subject: [PATCH] arm: Fix text patching via fixmap with virtually tagged
 D-caches
Message-ID: <20170316133609.22679-1-tixy@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When __patch_text_real changes an instruction via a fixmap on systems
with a virtually tagged cache, there may still be a stale entry in the
data cache for the real instruction address. Fix this by also flushing
the cache at that address.

One consequence of this issue is that if a kprobe is added then removed,
the D-cache may still hold the breakpoint instruction from when the
probe was active. In that situation, when re-inserting the kprobe, the
kernel thinks the instruction being probed is a breakpoint instruction
and will reject the attempt. This shows up with test failures when
enabling CONFIG_ARM_KPROBES_TEST on a device with a Marvel Kirkwood SoC
and also enabling CONFIG_STRICT_KERNEL_RWX which triggers the use of
fixmaps.

Fixes: ab0615e2d6fb ("arm: use fixmap for text patching when text is RO")

Signed-off-by: Jon Medhurst <tixy@linaro.org>
---
 arch/arm/kernel/patch.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/kernel/patch.c b/arch/arm/kernel/patch.c
index 020560b2dcb7..c3c64bc2f50d 100644
--- a/arch/arm/kernel/patch.c
+++ b/arch/arm/kernel/patch.c
@@ -101,6 +101,7 @@ void __kprobes __patch_text_real(void *addr, unsigned int insn, bool remap)
 	if (waddr != addr) {
 		flush_kernel_vmap_range(waddr, twopage ? size / 2 : size);
 		patch_unmap(FIX_TEXT_POKE0, &flags);
+		flush_kernel_vmap_range(addr, size);
 	} else
 		__release(&patch_lock);
 
-- 
2.11.0
