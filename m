From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 23 Nov 2018 10:41:52 +0100
Subject: [PATCH v3 2/2] arm64/bpf: don't allocate BPF JIT programs in module
 memory
In-Reply-To: <20181123094152.21368-1-ard.biesheuvel@linaro.org>
References: <20181123094152.21368-1-ard.biesheuvel@linaro.org>
Message-ID: <20181123094152.21368-3-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The arm64 module region is a 128 MB region that is kept close to
the core kernel, in order to ensure that relative branches are
always in range. So using the same region for programs that do
not have this restriction is wasteful, and preferably avoided.

Now that the core BPF JIT code permits the alloc/free routines to
be overridden, implement them by vmalloc()/vfree() calls from a
dedicated 128 MB region set aside for BPF programs. This ensures
that BPF programs are still in branching range of each other, which
is something the JIT currently depends upon (and is not guaranteed
when using module_alloc() on KASLR kernels like we do currently).
It also ensures that placement of BPF programs does not correlate
with the placement of the core kernel or modules, making it less
likely that leaking the former will reveal the latter.

This also solves an issue under KASAN, where shadow memory is
needlessly allocated for all BPF programs (which don't require KASAN
shadow pages since they are not KASAN instrumented)

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/memory.h  |  3 +++
 arch/arm64/include/asm/pgtable.h |  2 +-
 arch/arm64/net/bpf_jit_comp.c    | 13 +++++++++++++
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index b96442960aea..506e319da98f 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -69,6 +69,9 @@
 #define PCI_IO_END		(VMEMMAP_START - SZ_2M)
 #define PCI_IO_START		(PCI_IO_END - PCI_IO_SIZE)
 #define FIXADDR_TOP		(PCI_IO_START - SZ_2M)
+#define BPF_JIT_REGION_BASE	(VMALLOC_END)
+#define BPF_JIT_REGION_SIZE	(SZ_128M)
+#define BPF_JIT_REGION_END	(BPF_JIT_REGION_BASE + BPF_JIT_REGION_SIZE)
 
 #define KERNEL_START      _text
 #define KERNEL_END        _end
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 50b1ef8584c0..9db98a4cd9b4 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -31,7 +31,7 @@
  *	and fixed mappings
  */
 #define VMALLOC_START		(MODULES_END)
-#define VMALLOC_END		(PAGE_OFFSET - PUD_SIZE - VMEMMAP_SIZE - SZ_64K)
+#define VMALLOC_END		(PAGE_OFFSET - PUD_SIZE - VMEMMAP_SIZE - BPF_JIT_REGION_SIZE - SZ_64K)
 
 #define vmemmap			((struct page *)VMEMMAP_START - (memstart_addr >> PAGE_SHIFT))
 
diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index a6fdaea07c63..298beba29fa5 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -940,3 +940,16 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 					   tmp : orig_prog);
 	return prog;
 }
+
+void *bpf_jit_alloc_exec(unsigned long size)
+{
+	return __vmalloc_node_range(size, PAGE_SIZE, BPF_JIT_REGION_BASE,
+				    BPF_JIT_REGION_END, GFP_KERNEL,
+				    PAGE_KERNEL_EXEC, 0, NUMA_NO_NODE,
+				    __builtin_return_address(0));
+}
+
+void bpf_jit_free_exec(const void *addr)
+{
+	return vfree(addr);
+}
-- 
2.17.1
