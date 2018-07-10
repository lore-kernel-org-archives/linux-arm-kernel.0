From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 10 Jul 2018 17:16:27 +0200
Subject: [PATCH] arm64: make flatmem depend on !NUMA
Message-ID: <20180710151639.2184213-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Building without NUMA but with FLATMEM results in a link error
because mem_map[] is not available:

aarch64-linux-ld -EB -maarch64elfb --no-undefined -X -pie -shared -Bsymbolic --no-apply-dynamic-relocs --build-id -o .tmp_vmlinux1 -T ./arch/arm64/kernel/vmlinux.lds --whole-archive built-in.a --no-whole-archive --start-group arch/arm64/lib/lib.a lib/lib.a --end-group
init/do_mounts.o: In function `mount_block_root':
do_mounts.c:(.init.text+0x1e8): undefined reference to `mem_map'
arch/arm64/kernel/vdso.o: In function `vdso_init':
vdso.c:(.init.text+0xb4): undefined reference to `mem_map'

This uses the same trick as the other architectures, making flatmem
depend on !NUMA to avoid the broken configuration.

Fixes: e7d4bac428ed ("arm64: add ARM64-specific support for flatmem")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1dd68d973704..ba19f03bc327 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -787,7 +787,7 @@ config ARCH_SELECT_MEMORY_MODEL
 	def_bool ARCH_SPARSEMEM_ENABLE
 
 config ARCH_FLATMEM_ENABLE
-	def_bool y
+	def_bool !NUMA
 
 config HAVE_ARCH_PFN_VALID
 	def_bool ARCH_HAS_HOLES_MEMORYMODEL || !SPARSEMEM
-- 
2.9.0
