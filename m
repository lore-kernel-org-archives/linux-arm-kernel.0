From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 26 Mar 2014 18:09:39 +0100
Subject: [PATCH] ARM: realview: basic device tree implementation
In-Reply-To: <4327457.yKTHVHA17K@wuerfel>
References: <1395826060-26662-1-git-send-email-linus.walleij@linaro.org>
 <4327457.yKTHVHA17K@wuerfel>
Message-ID: <26412341.aCOKep5CZC@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 26 March 2014 11:56:30 Arnd Bergmann wrote:
> > +     /*
> > +      * Generic RealView fixup
> > +      * Most RealView platforms have 512MB contiguous RAM at 0x70000000.
> > +      * Half of this is mirrored at 0.
> > +      */
> > +     else {
> > +#ifdef CONFIG_REALVIEW_HIGH_PHYS_OFFSET
> > +             meminfo->bank[0].start = 0x70000000;
> > +             meminfo->bank[0].size = SZ_512M;
> > +             meminfo->nr_banks = 1;
> > +#else
> > +             meminfo->bank[0].start = 0;
> > +             meminfo->bank[0].size = SZ_256M;
> > +             meminfo->nr_banks = 1;
> > +#endif
> > +     }
> > +}
> 
> And this one is where it gets tricky. We don't have a good way
> to describe memory aliases in DT, but we need the start of memory
> to match PHYS_OFFSET if CONFIG_SPARSEMEM is set (which implies
> !CONFIG_REALVIEW_HIGH_PHYS_OFFSET), or if we are running a no-MMU
> kernel. I have to think about this some more.
> 

I've thought about it some more. We can actually get rid of the
CONFIG_REALVIEW_HIGH_PHYS_OFFSET option entirely for any case except
CONFIG_XIP_KERNEL by using ARM_PATCH_PHYS_VIRT and relying on the
ATAGS or DT to pass the correct memory location. Unfortunately,
I don't know if the ATAGS are actually correct in common boot loaders,
since the kernel has been overriding them for ages.

With SPARSEMEM enabled, we already depend on REALVIEW_HIGH_PHYS_OFFSET
being disabled, and we also use ARM_PATCH_PHYS_VIRT by default (it
is not disabled in realview_defconfig).

The dependencies are really:

* The value of PHYS_OFFSET must match the address to which the kernel
  is loaded at boot time (currently enforced using 'make uImage').

* We could use SPARSEMEM in order to use all 512MB of RAM on
  realview-eb/pb11mp/pb-a8, but this is prevented by the definition
  of __phys_to_virt/__virt_to_phys, since it puts the 0x20000000
  physical memory segment into the middle! This is in theory fixable,
  but I'd rather not add more hacks on top. I don't see anything that
  prevents us from using SPARSEMEM on older realview machines with
  PHYS_OFFSET=0.

* The board files always ignore the memory passed in the ATAGS and
  set what they think is correct. I consider this a bad idea,
  in particular because it prevents us from using the -m option
  in qemu. We should not do this with DT. If we just trust the
  DT to contain correct data, we don't actually need the
  REALVIEW_HIGH_PHYS_OFFSET setting,

Catalin originally added the sparsemem hack. I asked him today about
it, and he also thinks that sparsemem without the hack should work,
as long as there is highmem support. I think we can either do away
with it entirely, or use the patch below to keep it alive.

I'd prefer not to add any memory location fixup to the realview-dt
implementation, but it seems hard to kill it off for the ATAGS
based board files, in particular because the information passed
by qemu seems to be wrong more often than not (at least if I read
the qemu right), and we never relied on it in the past. We might
be able to make that a compile-time or boot-time option though.

	Arnd

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 7c35c4d..caf9bd3 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -236,7 +236,6 @@ config ARM_PATCH_PHYS_VIRT
 	bool "Patch physical to virtual translations at runtime" if BROKEN_MULTIPLATFORM
 	default y
 	depends on !XIP_KERNEL && MMU
-	depends on !ARCH_REALVIEW || !SPARSEMEM
 	help
 	  Patch phys-to-virt and virt-to-phys translation functions at
 	  boot and module load time according to the position of the
diff --git a/arch/arm/mach-realview/Kconfig b/arch/arm/mach-realview/Kconfig
index 297e214..8a92dbf 100644
--- a/arch/arm/mach-realview/Kconfig
+++ b/arch/arm/mach-realview/Kconfig
@@ -121,7 +121,7 @@ config MACH_REALVIEW_PBA8
 
 config MACH_REALVIEW_PBX
 	bool "Support RealView(R) Platform Baseboard Explore"
-	select ARCH_SPARSEMEM_ENABLE if CPU_V7 && !REALVIEW_HIGH_PHYS_OFFSET
+	select ARCH_SPARSEMEM_ENABLE if CPU_V7
 	select ARM_GIC
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
@@ -165,7 +165,7 @@ config MACH_REALVIEW_AUTO
 
 config REALVIEW_HIGH_PHYS_OFFSET
 	bool "High physical base address for the RealView platform"
-	depends on MMU && !MACH_REALVIEW_PB1176
+	depends on MMU && !MACH_REALVIEW_PB1176 && !ARM_PATCH_PHYS_VIRT
 	default y
 	help
 	  RealView boards other than PB1176 have the RAM available at
@@ -175,4 +175,21 @@ config REALVIEW_HIGH_PHYS_OFFSET
 	  offset. On the PBX board, disabling this option allows 1GB of
 	  RAM to be used with SPARSEMEM.
 
+config REALVIEW_PBX_SPARSEMEM_HACK
+	bool "Hack to avoid highmem on Realview-PBX"
+	depends on SPARSEMEM && MMU
+	depends on MACH_REALVIEW_PBX
+	depends on !(MACH_REALVIEW_EB || MACH_REALVIEW_PB11MP || MACH_REALVIEW_PBA8 || MACH_REALVIEW_DT)
+	depends on !REALVIEW_HIGH_PHYS_OFFSET
+	depends on !ARM_PATCH_PHYS_VIRT
+	help
+	  Realview-PBX uses noncontiguous memory that is spread over
+	  more than 2GB of physical address space, which means that in
+	  order to access it, we have to either enable HIGHMEM or
+	  VMSPLIT_1G, both of which come with a performance impact.
+	  As a third alternative, this rearranges the kernel virtual
+	  memory space to cover all the discontiguous memory on
+	  Realview PBX, with the main cost of breaking support for
+	  any other hardware.
+
 endmenu
diff --git a/arch/arm/mach-realview/include/mach/memory.h b/arch/arm/mach-realview/include/mach/memory.h
index db09170..2b95178 100644
--- a/arch/arm/mach-realview/include/mach/memory.h
+++ b/arch/arm/mach-realview/include/mach/memory.h
@@ -31,6 +31,11 @@
 
 #ifdef CONFIG_SPARSEMEM
 
+/* these can be moved to arm/memory.h when we get to support multiplatform */
+#define MAX_PHYSMEM_BITS	32
+#define SECTION_SIZE_BITS	28
+
+#ifdef CONFIG_REALVIEW_PBX_SPARSEMEM_HACK
 /*
  * Sparsemem definitions for RealView PBX.
  *
@@ -45,13 +50,6 @@
  * 512MB @ 0x20000000 -> PAGE_OFFSET + 0x10000000
  * 256MB @ 0x80000000 -> PAGE_OFFSET + 0x30000000
  */
-#ifdef CONFIG_REALVIEW_HIGH_PHYS_OFFSET
-#error "SPARSEMEM not available with REALVIEW_HIGH_PHYS_OFFSET"
-#endif
-
-#define MAX_PHYSMEM_BITS	32
-#define SECTION_SIZE_BITS	28
-
 /* bank page offsets */
 #define PAGE_OFFSET1	(PAGE_OFFSET + 0x10000000)
 #define PAGE_OFFSET2	(PAGE_OFFSET + 0x30000000)
@@ -68,6 +66,8 @@
 	  (virt) >= PAGE_OFFSET1 ? (virt) - PAGE_OFFSET1 + 0x20000000 :	\
 	  (virt) - PAGE_OFFSET)
 
+#endif
+
 #endif	/* CONFIG_SPARSEMEM */
 
 #endif
