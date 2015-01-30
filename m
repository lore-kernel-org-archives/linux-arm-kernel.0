From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 30 Jan 2015 15:34:14 +0000
Subject: Continuing kallsyms failures - large kernels, XIP kernels, and
 large XIP kernels
In-Reply-To: <20150130145642.GK26493@n2100.arm.linux.org.uk>
References: <20150130145642.GK26493@n2100.arm.linux.org.uk>
Message-ID: <20150130153414.GM26493@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here's a potential patch for issue 2b - to cause the link to fail if
the resulting kernel would be broken by trying to run it.

 arch/arm/kernel/vmlinux.lds.S | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index b31aa73e8076..9351f7fbdfb1 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -351,3 +351,13 @@ ASSERT((__arch_info_end - __arch_info_begin), "no machine record defined")
  * The above comment applies as well.
  */
 ASSERT(((__hyp_idmap_text_end - __hyp_idmap_text_start) <= PAGE_SIZE), "HYP init code too big")
+
+#ifdef CONFIG_XIP_KERNEL
+/*
+ * __data_loc is not only the LMA of the data section, but also the VMA of
+ * the end of the .rodata section.  This must not overlap the VMA of the
+ * data section.  Since the .text section starts in module space, and that
+ * is always below the .data section, this should be sufficient.
+ */
+ASSERT((_data >= __data_loc), "Text section oversize")
+#endif


-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
