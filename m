From: pj0585@gmail.com (Prasant J)
Date: Mon, 22 Aug 2011 12:43:16 +0530
Subject: at91sam9g45: Issues while working with RAM that is separated on
	physical address space
In-Reply-To: <alpine.LFD.2.00.1107261741090.12766@xanadu.home>
References: <CAA2DH4u1kcky3xzxpepS=gtDK1Xas17zDxcRkDR7qRNLHQyoxw@mail.gmail.com>
	<20110722135505.GB25947@n2100.arm.linux.org.uk>
	<CAA2DH4u9GANxUTnTqRzUR=GihNLS8EEDAKm8u8SFZ_Yq48qXOg@mail.gmail.com>
	<CAA2DH4sviHkHEHZTR+0AHP3pToC7fEgTc+irw0vk_WU5q0XEQQ@mail.gmail.com>
	<20110726133702.GA14526@taskit.de>
	<20110726135428.GC1655@n2100.arm.linux.org.uk>
	<CAA2DH4u3n3JmLcnFurQRXbc2Me5aHw2wR4sHUbZOA+zoex3c7Q@mail.gmail.com>
	<alpine.LFD.2.00.1107261741090.12766@xanadu.home>
Message-ID: <CAA2DH4vht6JRsU8K9Tn2Qfqwt2pQaA5bb70YAJfnVQZu5STOgg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 27, 2011 at 3:18 AM, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Tue, 26 Jul 2011, P J wrote:
>
>> The mapping of second memory bank is going wrong because of the
>> reasons I have said earlier, so my second memory bank gets overlapped
>> with the vmalloc region and is ignored. With highemem seems like the
>> problem should have been solved but my kernel does not boot with
>> highmem enabled.
>>
>> Any suggestions ? I'm using Linux 2.6.30..
>
> Highmem support was introduced on ARM in v2.6.29 and became somewhat
> "reliable" on v2.6.31. ?In any case, v2.6.30 is more than 2 years old.
> Please try to upgrade your kernel.
>
>
> Nicolas
>

Thanks to everyone. I got 256 MB working. Its been running quite
stable for many days now.

1) I have used Nicu Pavels patch as reference:
    (http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=6143/1)
    with minor changes

2) I switched to linux 3.0.0 (and also have tested with linux 3.0.3).
Applied the above patch (manually) with little changes: patch is as
follows:


diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 92622eb..c1773e1 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -275,6 +275,8 @@ config ARCH_AT91
 	select GENERIC_GPIO
 	select ARCH_REQUIRE_GPIOLIB
 	select HAVE_CLK
+	select ARCH_SPARSEMEM_ENABLE
+	select ARCH_SELECT_MEMORY_MODEL
+	select ARM_PATCH_PHYS_VIRT if MMU
 	help
 	  This enables support for systems based on the Atmel AT91RM9200,
 	  AT91SAM9 and AT91CAP9 processors.
diff --git a/arch/arm/mach-at91/include/mach/memory.h
b/arch/arm/mach-at91/include/mach/memory.h
index 14f4ef4..89aed9b 100644
--- a/arch/arm/mach-at91/include/mach/memory.h
+++ b/arch/arm/mach-at91/include/mach/memory.h
@@ -25,4 +25,24 @@

+ #define PHYS_OFFSET	0x70000000     /* DDRSDRC0 */
+/*#define PHYS_OFFSET	0x20000000 */ /* DDRSDRC1 - EBI */

+#if defined(CONFIG_ARCH_AT91SAM9G45) || defined(CONFIG_ARCH_AT91SAM9M10)
+/*
+ * Non-linear mapping like so:
+ * phys       => virt
+ * 0x70000000 => 0xc0000000
+ * 0x20000000 => 0xc8000000
+ */
+
+#define __phys_to_virt(p)   \
+            (((p) & 0x07ffffff) + (((p) & 0x40000000) ? 0xc0000000 :
0xc8000000))
+
+#define __virt_to_phys(v)   \
+            (((v) & 0x07ffffff) + (((v) & 0x08000000) ? 0x20000000 :
0x70000000 ))
+
+#define NODE_MEM_SIZE_BITS	27
+#define MAX_PHYSMEM_BITS	32
+#define SECTION_SIZE_BITS	27 /*128 Mb */
+#define HIGH_MEMORY_VIRT	0xd0000000
+#endif
+
 #endif
diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 0ed29bf..38b7526 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -461,7 +461,11 @@ void __init bootmem_init(void)
 	for_each_node(node)
 		bootmem_free_node(node, mi);

+#ifdef HIGH_MEMORY_VIRT
+	high_memory = HIGH_MEMORY_VIRT;
+#else
 	high_memory = __va(((phys_addr_t)max_low << PAGE_SHIFT) - 1) + 1;
+#endif

 	/*
 	 * This doesn't seem to be used by the Linux memory manager any

3) High Memory is disabled.

4) Followed Russell Kings advice by changing the function in
atmel_mci.c to flush_kernel_dcache_page()

Its works pretty good for me. Now I have 256 MB working on my custom
board based on AT91SAM9G45-EKES

-Prasant Jalan
