From: mpe@ellerman.id.au (Michael Ellerman)
Date: Thu, 26 Nov 2015 18:07:57 +1100
Subject: [PATCH v3 0/4] Allow customizable random offset to mmap_base
 address.
In-Reply-To: <20151124163907.1a406b79458b1bb0d3519684@linux-foundation.org>
References: <1447888808-31571-1-git-send-email-dcashman@android.com>
 <20151124163907.1a406b79458b1bb0d3519684@linux-foundation.org>
Message-ID: <1448521677.19291.3.camel@ellerman.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2015-11-24 at 16:39 -0800, Andrew Morton wrote:
> On Wed, 18 Nov 2015 15:20:04 -0800 Daniel Cashman <dcashman@android.com> wrote:
> > Address Space Layout Randomization (ASLR) provides a barrier to
> > exploitation of user-space processes in the presence of security
> > vulnerabilities by making it more difficult to find desired code/data
> > which could help an attack.  This is done by adding a random offset to the
> > location of regions in the process address space, with a greater range of
> > potential offset values corresponding to better protection/a larger
> > search-space for brute force, but also to greater potential for
> > fragmentation.
> 
> mips, powerpc and s390 also implement arch_mmap_rnd().  Are there any
> special considerations here, or it just a matter of maintainers wiring
> it up and testing it?

I had a quick stab at powerpc. It seems to work OK, though I've only tested on
64-bit 64K pages.

I'll update this when Daniel does a version which supports a DEFAULT for both
MIN values.

cheers

>From 7c42636d5df21203977900d283c722116f06310c Mon Sep 17 00:00:00 2001
From: Michael Ellerman <mpe@ellerman.id.au>
Date: Thu, 26 Nov 2015 17:40:00 +1100
Subject: [PATCH] powerpc/mm: Use ARCH_MMCAP_RND_BITS

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/Kconfig   | 32 ++++++++++++++++++++++++++++++++
 arch/powerpc/mm/mmap.c | 12 +++++++-----
 2 files changed, 39 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index db49e0d796b1..e796d6c4055c 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -27,6 +27,36 @@ config MMU
 	bool
 	default y
 
+config ARCH_MMAP_RND_BITS_MIN
+	# On 64-bit up to 1G of address space (2^30)
+	default 12 if 64BIT && PPC_256K_PAGES 	# 256K (2^18), = 30 - 18 = 12
+	default 14 if 64BIT && PPC_64K_PAGES  	# 64K  (2^16), = 30 - 16 = 14
+	default 16 if 64BIT && PPC_16K_PAGES  	# 16K  (2^14), = 30 - 14 = 16
+	default 18 if 64BIT			# 4K   (2^12), = 30 - 12 = 18
+	default ARCH_MMAP_RND_COMPAT_BITS_MIN
+
+config ARCH_MMAP_RND_BITS_MAX
+	# On 64-bit up to 32T of address space (2^45)
+	default 27 if 64BIT && PPC_256K_PAGES   # 256K (2^18), = 45 - 18 = 27
+	default 29 if 64BIT && PPC_64K_PAGES    # 64K  (2^16), = 45 - 16 = 29
+	default 31 if 64BIT && PPC_16K_PAGES    # 16K  (2^14), = 45 - 14 = 31
+	default 33 if 64BIT			# 4K   (2^12), = 45 - 12 = 33
+	default ARCH_MMAP_RND_COMPAT_BITS_MAX
+
+config ARCH_MMAP_RND_COMPAT_BITS_MIN
+	# Up to 8MB of address space (2^23)
+	default 5 if PPC_256K_PAGES             # 256K (2^18), = 23 - 18 = 5
+	default 7 if PPC_64K_PAGES              # 64K  (2^16), = 23 - 16 = 7
+	default 9 if PPC_16K_PAGES              # 16K  (2^14), = 23 - 14 = 9
+	default 11				# 4K   (2^12), = 23 - 12 = 11
+
+config ARCH_MMAP_RND_COMPAT_BITS_MAX
+	# Up to 2G of address space (2^31)
+	default 13 if PPC_256K_PAGES            # 256K (2^18), = 31 - 18 = 13
+	default 15 if PPC_64K_PAGES             # 64K  (2^16), = 31 - 16 = 15
+	default 17 if PPC_16K_PAGES             # 16K  (2^14), = 31 - 14 = 17
+	default 19				# 4K   (2^12), = 31 - 12 = 19
+
 config HAVE_SETUP_PER_CPU_AREA
 	def_bool PPC64
 
@@ -160,6 +190,8 @@ config PPC
 	select EDAC_ATOMIC_SCRUB
 	select ARCH_HAS_DMA_SET_COHERENT_MASK
 	select HAVE_ARCH_SECCOMP_FILTER
+	select HAVE_ARCH_MMAP_RND_BITS
+	select HAVE_ARCH_MMAP_RND_COMPAT_BITS if COMPAT
 
 config GENERIC_CSUM
 	def_bool CPU_LITTLE_ENDIAN
diff --git a/arch/powerpc/mm/mmap.c b/arch/powerpc/mm/mmap.c
index 0f0502e12f6c..269f7bcd2702 100644
--- a/arch/powerpc/mm/mmap.c
+++ b/arch/powerpc/mm/mmap.c
@@ -55,13 +55,15 @@ static inline int mmap_is_legacy(void)
 
 unsigned long arch_mmap_rnd(void)
 {
-	unsigned long rnd;
+	unsigned long shift, rnd;
 
-	/* 8MB for 32bit, 1GB for 64bit */
+	shift = mmap_rnd_bits;
+#ifdef CONFIG_COMPAT
 	if (is_32bit_task())
-		rnd = (unsigned long)get_random_int() % (1<<(23-PAGE_SHIFT));
-	else
-		rnd = (unsigned long)get_random_int() % (1<<(30-PAGE_SHIFT));
+		shift = mmap_rnd_compat_bits;
+#endif
+
+	rnd = (unsigned long)get_random_int() % (1 << shift);
 
 	return rnd << PAGE_SHIFT;
 }
-- 
2.5.0
