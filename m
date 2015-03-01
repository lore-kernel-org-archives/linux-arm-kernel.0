From: daniel@iogearbox.net (Daniel Borkmann)
Date: Sun,  1 Mar 2015 11:14:39 +0100
Subject: [PATCH] arm64: mm: unexport set_memory_ro and set_memory_rw
Message-ID: <78efa617b015b18df3f29724bffe28b4231732e6.1425204526.git.daniel@iogearbox.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This effectively unexports set_memory_ro and set_memory_rw functions from
commit 11d91a770f1f ("arm64: Add CONFIG_DEBUG_SET_MODULE_RONX support").

No module user of those is in mainline kernel and we explicitly do not want
modules to use these functions, as they i.e. RO-protect eBPF (interpreted and
JIT'ed) images from malicious modifications/bugs.

Outside of eBPF scope, I believe also other set_memory_* functions should
be unexported on arm64 due to non-existant mainline module user. Laura
mentioned that they have some uses for modules doing set_memory_*, but
none that are in mainline and it's unclear if they would ever get there.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Alexei Starovoitov <ast@plumgrid.com>
Acked-by: Laura Abbott <lauraa@codeaurora.org>
---
 arch/arm64/mm/pageattr.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
index bb0ea94..8659357 100644
--- a/arch/arm64/mm/pageattr.c
+++ b/arch/arm64/mm/pageattr.c
@@ -70,7 +70,6 @@ int set_memory_ro(unsigned long addr, int numpages)
 					__pgprot(PTE_RDONLY),
 					__pgprot(PTE_WRITE));
 }
-EXPORT_SYMBOL_GPL(set_memory_ro);
 
 int set_memory_rw(unsigned long addr, int numpages)
 {
@@ -78,7 +77,6 @@ int set_memory_rw(unsigned long addr, int numpages)
 					__pgprot(PTE_WRITE),
 					__pgprot(PTE_RDONLY));
 }
-EXPORT_SYMBOL_GPL(set_memory_rw);
 
 int set_memory_nx(unsigned long addr, int numpages)
 {
-- 
1.9.3
