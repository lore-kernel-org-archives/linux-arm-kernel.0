From: h.feurstein@gmail.com (Hubert Feurstein)
Date: Mon, 16 Nov 2009 15:57:24 +0100
Subject: [RFC PATCH] ARM: add (experimental) alternative memcpy_{from,
	to}io() and memset_io()
In-Reply-To: <4AFD667B.3020505@billgatliff.com>
References: <200911121749.49676.h.feurstein@gmail.com>
	<20091113122438.GB29008@n2100.arm.linux.org.uk>
	<4AFD667B.3020505@billgatliff.com>
Message-ID: <200911161557.24543.h.feurstein@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implement faster memcpy_{to,from}io() and memset_io() by using the
highly optimized mem{cpy,set} implementation instead of sequential
8bit read/write accesses. This gives significantly higher throughput
accessing big iomem-regions.

Signed-off-by: Hubert Feurstein <h.feurstein@gmail.com>
---

Hi Russell,

would such a patch be acceptable, since it would not break existing users?

Would be great if some people from the community could test it and post their
experience.

Regards
Hubert

 arch/arm/Kconfig          |   12 ++++++++++++
 arch/arm/include/asm/io.h |    6 ++++++
 2 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 1c4119c..2723948 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1221,6 +1221,18 @@ config UACCESS_WITH_MEMCPY
 	  However, if the CPU data cache is using a write-allocate mode,
 	  this option is unlikely to provide any performance gain.
 
+config OPTIMIZED_IOMEM_MEMCPY
+	bool "Use kernel memcpy() for memcpy_{from,to}io() (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
+	help
+	  Implement faster memcpy_{to,from}io() and memset_io() by using the
+	  highly optimized mem{cpy,set} implementation instead of sequential
+	  8bit read/write accesses. This gives significantly higher throughput
+	  accessing big iomem-regions.
+
+	  This might not work on all machines in case they have problems accessing
+	  the iomem-space word-by-word.
+
 endmenu
 
 menu "Boot options"
diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index d2a59cf..b37e057 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -195,9 +195,15 @@ extern void _memset_io(volatile void __iomem *, int, size_t);
 #define writesw(p,d,l)		__raw_writesw(__mem_pci(p),d,l)
 #define writesl(p,d,l)		__raw_writesl(__mem_pci(p),d,l)
 
+#ifdef CONFIG_OPTIMIZED_IOMEM_MEMCPY
+#define memset_io(c,v,l)	memset(__mem_pci(c),(v),(l))
+#define memcpy_fromio(a,c,l)	memcpy((a),__mem_pci(c),(l))
+#define memcpy_toio(c,a,l)	memcpy(__mem_pci(c),(a),(l))
+#else
 #define memset_io(c,v,l)	_memset_io(__mem_pci(c),(v),(l))
 #define memcpy_fromio(a,c,l)	_memcpy_fromio((a),__mem_pci(c),(l))
 #define memcpy_toio(c,a,l)	_memcpy_toio(__mem_pci(c),(a),(l))
+#endif
 
 #elif !defined(readb)
 
-- 
1.6.4.4
