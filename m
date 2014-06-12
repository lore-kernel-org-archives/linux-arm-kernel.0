From: geoff@infradead.org (Geoff Levand)
Date: Thu, 12 Jun 2014 00:12:56 +0000
Subject: [PATCH 1/2] Makefile: Add local perl module include path
In-Reply-To: <cover.1402531738.git.geoff@infradead.org>
References: <cover.1402531738.git.geoff@infradead.org>
Message-ID: <85d9a93781abdc1dea4688d96e9a4936c06bfbf0.1402531738.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We recently added perl scripting to our makefile, but omitted adding the include
path of the local modules in the invocation of perl.  Fixes build errors like
these when building out of the source tree:

  Can't locate FDT.pm in @INC (you may need to install the FDT module)

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 Makefile.am | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index aa4e572..0c174e6 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -8,9 +8,9 @@
 # found in the LICENSE.txt file.
 
 # VE
-PHYS_OFFSET	:= $(shell $(top_srcdir)/findmem.pl $(KERNEL_DTB))
-UART_BASE	:= $(shell $(top_srcdir)/findbase.pl $(KERNEL_DTB) 0 'arm,pl011')
-SYSREGS_BASE	:= $(shell $(top_srcdir)/findbase.pl $(KERNEL_DTB) 0 'arm,vexpress-sysreg')
+PHYS_OFFSET	:= $(shell perl -I $(top_srcdir) $(top_srcdir)/findmem.pl $(KERNEL_DTB))
+UART_BASE	:= $(shell perl -I $(top_srcdir) $(top_srcdir)/findbase.pl $(KERNEL_DTB) 0 'arm,pl011')
+SYSREGS_BASE	:= $(shell perl -I $(top_srcdir) $(top_srcdir)/findbase.pl $(KERNEL_DTB) 0 'arm,vexpress-sysreg')
 CNTFRQ		:= 0x01800000	# 24Mhz
 
 DEFINES		= -DCNTFRQ=$(CNTFRQ)
@@ -39,14 +39,14 @@ CPUS_NODE	:=
 endif
 
 if GICV3
-GIC_DIST_BASE	:= $(shell $(top_srcdir)/findbase.pl $(KERNEL_DTB) 0 'arm,gic-v3')
-GIC_RDIST_BASE	:= $(shell $(top_srcdir)/findbase.pl $(KERNEL_DTB) 1 'arm,gic-v3')
+GIC_DIST_BASE	:= $(shell perl -I $(top_srcdir) $(top_srcdir)/findbase.pl $(KERNEL_DTB) 0 'arm,gic-v3')
+GIC_RDIST_BASE	:= $(shell perl -I $(top_srcdir) $(top_srcdir)/findbase.pl $(KERNEL_DTB) 1 'arm,gic-v3')
 DEFINES		+= -DGIC_DIST_BASE=$(GIC_DIST_BASE)
 DEFINES		+= -DGIC_RDIST_BASE=$(GIC_RDIST_BASE)
 GIC		:= gic-v3.o
 else
-GIC_DIST_BASE	:= $(shell $(top_srcdir)/findbase.pl $(KERNEL_DTB) 0 'arm,cortex-a15-gic')
-GIC_CPU_BASE	:= $(shell $(top_srcdir)/findbase.pl $(KERNEL_DTB) 1 'arm,cortex-a15-gic')
+GIC_DIST_BASE	:= $(shell perl -I $(top_srcdir) $(top_srcdir)/findbase.pl $(KERNEL_DTB) 0 'arm,cortex-a15-gic')
+GIC_CPU_BASE	:= $(shell perl -I $(top_srcdir) $(top_srcdir)/findbase.pl $(KERNEL_DTB) 1 'arm,cortex-a15-gic')
 DEFINES		+= -DGIC_CPU_BASE=$(GIC_CPU_BASE)
 DEFINES		+= -DGIC_DIST_BASE=$(GIC_DIST_BASE)
 GIC		:= gic.o
-- 
1.9.1
