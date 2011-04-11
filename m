From: cavokz@gmail.com (Domenico Andreoli)
Date: Mon, 11 Apr 2011 23:03:46 +0200
Subject: [PATCH] CONFIG_VECTORS_BASE vs. 0xffff0000 documentation
In-Reply-To: <alpine.LFD.2.00.1104111509590.28032@xanadu.home>
References: <20110411170047.GA12509@dandreoli.com>
	<alpine.LFD.2.00.1104111509590.28032@xanadu.home>
Message-ID: <20110411210346.GA3395@dandreoli.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Domenico Andreoli <cavokz@gmail.com>

Nice explanation of CONFIG_VECTORS_BASE vs. 0xffff0000 usage. Save it
to make annoying people avoid not obvious questions.

Signed-off-by: Domenico Andreoli <cavokz@gmail.com>

---
 Documentation/arm/memory.txt |   35 +++++++++++++++++++++++++++++++++++
 arch/arm/mm/mmu.c            |    3 +++
 2 files changed, 38 insertions(+)

Index: b/Documentation/arm/memory.txt
===================================================================
--- a/Documentation/arm/memory.txt	2011-04-11 22:39:45.000000000 +0200
+++ b/Documentation/arm/memory.txt	2011-04-11 22:50:48.000000000 +0200
@@ -91,3 +91,38 @@
 must not access any memory which is not mapped inside their 0x0001000
 to TASK_SIZE address range.  If they wish to access these areas, they
 must set up their own mappings using open() and mmap().
+
+
+About using CONFIG_VECTORS_BASE and 0xffff0000
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+On CPU cores with a MMU, there are only two possibilities for the
+location of the vector page: either address 0, or address 0xffff0000.
+Some CPUs only supports the low vectors i.e. at 0.  Most others allow
+for a selection between either of those addresses using the V bit
+in the control register (see the vectors_high() macro for example).
+In those cases replacing 0xffff0000 with CONFIG_VECTORS_BASE is the
+wrong thing to do.
+
+Now, because the vector table and associated stubs are quite small,
+we also use the same memory page for other things such as read-only
+code segments made available to user space.  So to simplify things,
+the vector page is _always_ mapped at 0xffff0000, regardless if the CPU
+supports high vectors or not (if it doesn't then another mapping for
+the same page is installed at 0).  So also in this case it is wrong to
+substitute 0xffff0000 with CONFIG_VECTORS_BASE.
+
+Finally, on non-MMU processors, the actual vector table is often in ROM
+and no RAM page can be mapped to the vector address because of course
+there is no MMU.  In this case, all vectors (except for the reset one)
+are usually branching to some arbitrary location in RAM to allow the
+installed software to redirect them.  This is where CONFIG_VECTORS_BASE
+really makes sense as it should be set to the address of the memory
+area that the OS can modify to hook its exception handlers.
+
+So using CONFIG_VECTORS_BASE really depends on the context.  For shared
+code between the MMU and non-MMU cases with access to the vector page,
+then it makes sense to use CONFIG_VECTORS_BASE, and in the MMU case it
+shouldn't be set to anything other than 0xffff0000.
+
+ -- Nicolas Pitre
Index: b/arch/arm/mm/mmu.c
===================================================================
--- a/arch/arm/mm/mmu.c	2011-04-11 22:40:01.000000000 +0200
+++ b/arch/arm/mm/mmu.c	2011-04-11 22:42:10.000000000 +0200
@@ -964,6 +964,9 @@
 	 * Create a mapping for the machine vectors at the high-vectors
 	 * location (0xffff0000).  If we aren't using high-vectors, also
 	 * create a mapping at the low-vectors virtual address.
+	 *
+	 * Read Documentation/arm/memory.txt in case you want to replace
+	 * 0xffff0000 with CONFIG_VECTORS_BASE.
 	 */
 	map.pfn = __phys_to_pfn(virt_to_phys(vectors_page));
 	map.virtual = 0xffff0000;
