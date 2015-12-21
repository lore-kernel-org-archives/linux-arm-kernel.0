From: dcashman@android.com (Daniel Cashman)
Date: Mon, 21 Dec 2015 09:26:56 -0800
Subject: [PATCH v7 3/4] arm64: mm: support ARCH_MMAP_RND_BITS.
In-Reply-To: <1450718817-7082-3-git-send-email-dcashman@android.com>
References: <1450718817-7082-1-git-send-email-dcashman@android.com>
 <1450718817-7082-2-git-send-email-dcashman@android.com>
 <1450718817-7082-3-git-send-email-dcashman@android.com>
Message-ID: <1450718817-7082-4-git-send-email-dcashman@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: dcashman <dcashman@google.com>

arm64: arch_mmap_rnd() uses STACK_RND_MASK to generate the
random offset for the mmap base address.  This value represents a
compromise between increased ASLR effectiveness and avoiding
address-space fragmentation. Replace it with a Kconfig option, which
is sensibly bounded, so that platform developers may choose where to
place this compromise. Keep default values as new minimums.

Signed-off-by: Daniel Cashman <dcashman@android.com>
---
 arch/arm64/Kconfig   | 29 +++++++++++++++++++++++++++++
 arch/arm64/mm/mmap.c |  8 ++++++--
 2 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 871f217..a4de63e 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -51,6 +51,8 @@ config ARM64
 	select HAVE_ARCH_JUMP_LABEL
 	select HAVE_ARCH_KASAN if SPARSEMEM_VMEMMAP && !(ARM64_16K_PAGES && ARM64_VA_BITS_48)
 	select HAVE_ARCH_KGDB
+	select HAVE_ARCH_MMAP_RND_BITS
+	select HAVE_ARCH_MMAP_RND_COMPAT_BITS if COMPAT
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_BPF_JIT
@@ -104,6 +106,33 @@ config ARCH_PHYS_ADDR_T_64BIT
 config MMU
 	def_bool y
 
+config ARCH_MMAP_RND_BITS_MIN
+       default 14 if ARM64_64K_PAGES
+       default 16 if ARM64_16K_PAGES
+       default 18
+
+# max bits determined by the following formula:
+#  VA_BITS - PAGE_SHIFT - 3
+config ARCH_MMAP_RND_BITS_MAX
+       default 19 if ARM64_VA_BITS=36
+       default 24 if ARM64_VA_BITS=39
+       default 27 if ARM64_VA_BITS=42
+       default 30 if ARM64_VA_BITS=47
+       default 29 if ARM64_VA_BITS=48 && ARM64_64K_PAGES
+       default 31 if ARM64_VA_BITS=48 && ARM64_16K_PAGES
+       default 33 if ARM64_VA_BITS=48
+       default 14 if ARM64_64K_PAGES
+       default 16 if ARM64_16K_PAGES
+       default 18
+
+config ARCH_MMAP_RND_COMPAT_BITS_MIN
+       default 7 if ARM64_64K_PAGES
+       default 9 if ARM64_16K_PAGES
+       default 11
+
+config ARCH_MMAP_RND_COMPAT_BITS_MAX
+       default 16
+
 config NO_IOPORT_MAP
 	def_bool y if !PCI
 
diff --git a/arch/arm64/mm/mmap.c b/arch/arm64/mm/mmap.c
index ed17747..4c893b5 100644
--- a/arch/arm64/mm/mmap.c
+++ b/arch/arm64/mm/mmap.c
@@ -51,8 +51,12 @@ unsigned long arch_mmap_rnd(void)
 {
 	unsigned long rnd;
 
-	rnd = (unsigned long)get_random_int() & STACK_RND_MASK;
-
+#ifdef CONFIG_COMPAT
+	if (test_thread_flag(TIF_32BIT))
+		rnd = (unsigned long)get_random_int() & ((1 << mmap_rnd_compat_bits) - 1);
+	else
+#endif
+		rnd = (unsigned long)get_random_int() & ((1 << mmap_rnd_bits) - 1);
 	return rnd << PAGE_SHIFT;
 }
 
-- 
2.6.0.rc2.230.g3dd15c0
