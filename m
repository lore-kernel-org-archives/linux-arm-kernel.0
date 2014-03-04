From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Tue,  4 Mar 2014 15:50:15 +0000
Subject: [PATCH v5 2/3] arm64: Extend the PCI I/O space to 16MB
In-Reply-To: <1393948216-11599-1-git-send-email-Liviu.Dudau@arm.com>
References: <1393948216-11599-1-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <1393948216-11599-3-git-send-email-Liviu.Dudau@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Catalin Marinas <catalin.marinas@arm.com>

The patch moves the PCI I/O space (currently at 64K) before the
earlyprintk mapping and extends it to 16MB.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>

diff --git a/Documentation/arm64/memory.txt b/Documentation/arm64/memory.txt
index 5e054bf..85e24c4 100644
--- a/Documentation/arm64/memory.txt
+++ b/Documentation/arm64/memory.txt
@@ -35,11 +35,13 @@ ffffffbc00000000	ffffffbdffffffff	   8GB		vmemmap
 
 ffffffbe00000000	ffffffbffbbfffff	  ~8GB		[guard, future vmmemap]
 
-ffffffbffbc00000	ffffffbffbdfffff	   2MB		earlyprintk device
+ffffffbffa000000	ffffffbffaffffff	  16MB		PCI I/O space
+
+ffffffbffb000000	ffffffbffbbfffff	  12MB		[guard]
 
-ffffffbffbe00000	ffffffbffbe0ffff	  64KB		PCI I/O space
+ffffffbffbc00000	ffffffbffbdfffff	   2MB		earlyprintk device
 
-ffffffbffbe10000	ffffffbcffffffff	  ~2MB		[guard]
+ffffffbffbe00000	ffffffbffbffffff	   2MB		[guard]
 
 ffffffbffc000000	ffffffbfffffffff	  64MB		modules
 
@@ -60,11 +62,13 @@ fffffdfc00000000	fffffdfdffffffff	   8GB		vmemmap
 
 fffffdfe00000000	fffffdfffbbfffff	  ~8GB		[guard, future vmmemap]
 
-fffffdfffbc00000	fffffdfffbdfffff	   2MB		earlyprintk device
+fffffdfffa000000	fffffdfffaffffff	  16MB		PCI I/O space
+
+fffffdfffb000000	fffffdfffbbfffff	  12MB		[guard]
 
-fffffdfffbe00000	fffffdfffbe0ffff	  64KB		PCI I/O space
+fffffdfffbc00000	fffffdfffbdfffff	   2MB		earlyprintk device
 
-fffffdfffbe10000	fffffdfffbffffff	  ~2MB		[guard]
+fffffdfffbe00000	fffffdfffbffffff	   2MB		[guard]
 
 fffffdfffc000000	fffffdffffffffff	  64MB		modules
 
diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
index 4cc813e..7846a6b 100644
--- a/arch/arm64/include/asm/io.h
+++ b/arch/arm64/include/asm/io.h
@@ -121,7 +121,7 @@ static inline u64 __raw_readq(const volatile void __iomem *addr)
  *  I/O port access primitives.
  */
 #define IO_SPACE_LIMIT		0xffff
-#define PCI_IOBASE		((void __iomem *)(MODULES_VADDR - SZ_2M))
+#define PCI_IOBASE		((void __iomem *)(MODULES_VADDR - SZ_32M))
 
 static inline u8 inb(unsigned long addr)
 {
-- 
1.9.0
