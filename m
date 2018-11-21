From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 21 Nov 2018 14:17:33 +0100
Subject: [PATCH v2 2/2] arm64/bpf: don't allocate BPF JIT programs in module
 memory
In-Reply-To: <20181121131733.14910-1-ard.biesheuvel@linaro.org>
References: <20181121131733.14910-1-ard.biesheuvel@linaro.org>
Message-ID: <20181121131733.14910-3-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The arm64 module region is a 128 MB region that is kept close to
the core kernel, in order to ensure that relative branches are
always in range. So using the same region for programs that do
not have this restriction is wasteful, and preferably avoided.

Now that the core BPF JIT code permits the alloc/free routines to
be overridden, implement them by simple vmalloc_exec()/vfree()
calls, which can be served from anywere. This also solves an
issue under KASAN, where shadow memory is needlessly allocated for
all BPF programs (which don't require KASAN shadow pages since
they are not KASAN instrumented)

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/net/bpf_jit_comp.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index a6fdaea07c63..f91b7c157841 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -940,3 +940,13 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 					   tmp : orig_prog);
 	return prog;
 }
+
+void *bpf_jit_alloc_exec(unsigned long size)
+{
+	return vmalloc_exec(size);
+}
+
+void bpf_jit_free_exec(const void *addr)
+{
+	return vfree(size);
+}
-- 
2.17.1
