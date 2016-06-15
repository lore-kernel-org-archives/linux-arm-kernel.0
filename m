From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 15 Jun 2016 22:13:59 +0100
Subject: kexec failures with DEBUG_RODATA
In-Reply-To: <CAGXu5j+5j32HO0rQtF2hcqMUBaa8cyxgLT4JvaZ6LL2WPj_zjw@mail.gmail.com>
References: <20160614175920.GD1041@n2100.armlinux.org.uk>
 <CAGXu5j+5j32HO0rQtF2hcqMUBaa8cyxgLT4JvaZ6LL2WPj_zjw@mail.gmail.com>
Message-ID: <20160615211359.GJ1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 14, 2016 at 11:05:23AM -0700, Kees Cook wrote:
> I'm much less familiar with the ARM decompression stub, but is there a
> boot image header (like x86 has)? If not, perhaps we can invent one,
> and it can carry all the details needed for a bootloader to do the
> right things.

With a bit of tinkering around, I now have this:

00000000 <.data>:
       0:       e1a00000        nop                     ; (mov r0, r0)
       4:       e1a00000        nop                     ; (mov r0, r0)
       8:       e1a00000        nop                     ; (mov r0, r0)
       c:       e1a00000        nop                     ; (mov r0, r0)
      10:       e1a00000        nop                     ; (mov r0, r0)
      14:       e1a00000        nop                     ; (mov r0, r0)
      18:       e1a00000        nop                     ; (mov r0, r0)
      1c:       e1a00000        nop                     ; (mov r0, r0)
      20:       ea00000f        b       0x64

Then follows the existing "header" which we've had there for years:

      24:       016f2818	; LE magic number
      28:       00000000	; LE zImage start address (always zero now)
      2c:       00431fe0	; LE zImage _edata
      30:       04030201	; endian flag

And now comes the new header:

      34:       016f2818	; LE magic number
      38:       00000001	; LE version number (v1)
      3c:       01287000	; LE total space required for decompressor
      40:       00e54000	; LE uncompressed image size

Up to 64 bytes available here for future expansion, currently filled
with zeros.
        ...

Remainder of the zImage code:
      64:       e10f9000        mrs     r9, CPSR

I'm rather on the fence whether we need to give the uncompressed image
size - the important thing is the size of memory that's required for
the decompressor to run, which is sizeof(uncompressed kernel) rounded
up to 256 bytes, and the relocated decompressor image size.

The "total space required for decompressor" is slightly cheating at the
figure - I'm including the uncompressed image rounded up and the entire
compressed image in that size, so it's a safe over-estimate.

I'm not sure there's a need to provide the uncompressed image size, the
boot environment shouldn't have a reason to know that, so I'm tempted to
omit it.

We could dispense with the endian conversions, and push the responsibility
for interpreting that onto the reader of this data: we have the endian
flag in the existing header block, so the boot environment can work out
the endianness of the image and apply fixups as appropriate.

Why generate this in the linker script?  We need the size of the zImage
here, which is only known to the linker.

diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index d50430c40045..1d5467e05250 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -119,6 +119,10 @@ asflags-y := -DZIMAGE
 KBSS_SZ = $(shell $(CROSS_COMPILE)size $(obj)/../../../../vmlinux | \
 		awk 'END{print $$3}')
 LDFLAGS_vmlinux = --defsym _kernel_bss_size=$(KBSS_SZ)
+
+KERNEL_IMAGE_SIZE = $(shell stat -c '%s' $(obj)/../Image)
+LDFLAGS_vmlinux += --defsym _kernel_image_size=$(KERNEL_IMAGE_SIZE)
+
 # Supply ZRELADDR to the decompressor via a linker symbol.
 ifneq ($(CONFIG_AUTO_ZRELADDR),y)
 LDFLAGS_vmlinux += --defsym zreladdr=$(ZRELADDR)
diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index e2e0dcb42ca2..395c60dcc4f7 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -131,11 +131,7 @@ start:
  THUMB(		badr	r12, 1f		)
  THUMB(		bx	r12		)
 
-		.word	_magic_sig	@ Magic numbers to help the loader
-		.word	_magic_start	@ absolute load/run zImage address
-		.word	_magic_end	@ zImage end address
-		.word	0x04030201	@ endianness flag
-
+		.section ".start2", #alloc, #execinstr
  THUMB(		.thumb			)
 1:		__EFI_HEADER
 
diff --git a/arch/arm/boot/compressed/vmlinux.lds.S b/arch/arm/boot/compressed/vmlinux.lds.S
index 81c493156ce8..77267724ec8a 100644
--- a/arch/arm/boot/compressed/vmlinux.lds.S
+++ b/arch/arm/boot/compressed/vmlinux.lds.S
@@ -37,6 +37,19 @@ SECTIONS
   .text : {
     _start = .;
     *(.start)
+    _header = .;
+    LONG(ZIMAGE_MAGIC(0x016f2818));	/* Magic numbers to help the loader */
+    LONG(ZIMAGE_MAGIC(_start));		/* absolute load/run zImage address */
+    LONG(ZIMAGE_MAGIC(_edata));		/* zImage end address */
+    LONG(0x04030201);			/* Endianness flag */
+    LONG(ZIMAGE_MAGIC(0x016f2818));	/* Further header indicator */
+    LONG(ZIMAGE_MAGIC(1));		/* Version 1 */
+    LONG(ZIMAGE_MAGIC(((_kernel_image_size + 255) & ~ 255) + \
+			_edata - _text + _end_stack - __bss_start));
+    LONG(ZIMAGE_MAGIC(_kernel_image_size));
+    /* Reserve 64 bytes for the header block */
+    . = _header + 64;
+    *(.start2)
     *(.text)
     *(.text.*)
     *(.fixup)
@@ -72,10 +85,6 @@ SECTIONS
   .pad			: { BYTE(0); . = ALIGN(8); }
   _edata = .;
 
-  _magic_sig = ZIMAGE_MAGIC(0x016f2818);
-  _magic_start = ZIMAGE_MAGIC(_start);
-  _magic_end = ZIMAGE_MAGIC(_edata);
-
   . = BSS_START;
   __bss_start = .;
   .bss			: { *(.bss) }
@@ -83,6 +92,7 @@ SECTIONS
 
   . = ALIGN(8);		/* the stack must be 64-bit aligned */
   .stack		: { *(.stack) }
+  _end_stack = .;
 
   .stab 0		: { *(.stab) }
   .stabstr 0		: { *(.stabstr) }


-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
