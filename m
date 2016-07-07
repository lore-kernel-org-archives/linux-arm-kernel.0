From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 7 Jul 2016 11:00:53 +0100
Subject: kexec failures with DEBUG_RODATA
In-Reply-To: <20160615211359.GJ1041@n2100.armlinux.org.uk>
References: <20160614175920.GD1041@n2100.armlinux.org.uk>
 <CAGXu5j+5j32HO0rQtF2hcqMUBaa8cyxgLT4JvaZ6LL2WPj_zjw@mail.gmail.com>
 <20160615211359.GJ1041@n2100.armlinux.org.uk>
Message-ID: <20160707100053.GN1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 15, 2016 at 10:13:59PM +0100, Russell King - ARM Linux wrote:
> On Tue, Jun 14, 2016 at 11:05:23AM -0700, Kees Cook wrote:
> > I'm much less familiar with the ARM decompression stub, but is there a
> > boot image header (like x86 has)? If not, perhaps we can invent one,
> > and it can carry all the details needed for a bootloader to do the
> > right things.
> 
> With a bit of tinkering around, I now have this:
> 
> 00000000 <.data>:
>        0:       e1a00000        nop                     ; (mov r0, r0)
>        4:       e1a00000        nop                     ; (mov r0, r0)
>        8:       e1a00000        nop                     ; (mov r0, r0)
>        c:       e1a00000        nop                     ; (mov r0, r0)
>       10:       e1a00000        nop                     ; (mov r0, r0)
>       14:       e1a00000        nop                     ; (mov r0, r0)
>       18:       e1a00000        nop                     ; (mov r0, r0)
>       1c:       e1a00000        nop                     ; (mov r0, r0)
>       20:       ea00000f        b       0x64
> 
> Then follows the existing "header" which we've had there for years:
> 
>       24:       016f2818	; LE magic number
>       28:       00000000	; LE zImage start address (always zero now)
>       2c:       00431fe0	; LE zImage _edata
>       30:       04030201	; endian flag
> 
> And now comes the new header:
> 
>       34:       016f2818	; LE magic number
>       38:       00000001	; LE version number (v1)
>       3c:       01287000	; LE total space required for decompressor
>       40:       00e54000	; LE uncompressed image size
> 
> Up to 64 bytes available here for future expansion, currently filled
> with zeros.
>         ...
> 
> Remainder of the zImage code:
>       64:       e10f9000        mrs     r9, CPSR

Looking at this again, this can't work for another _two_ reasons:

1. Thumb2 kernels - we rely on a relative address to jump to for the
   remainder of the zImage code, using an "adr" instruction.  The offset
   needs to be known at assembly time, but with my approach of moving
   the header into the linker script, this is no longer the case.

2. EFI images need the header offset at 0x3c, which gets in the way of
   us appending to our existing header.

So... I don't think we can solve it this way, and I'm all out of ideas
how to solve this in a sane manner - I'm currently of the opinion that
it _isn't_ solvable given where we are without defining a new format
for a zImage, which is really quite depressing.

I think people are just going to have to get used to using --image-size
to kexec on ARM to work around this problem.  So, let's document it
in kexec's --help - though this could do with something better, but I
fear it'll turn into a multi-line description of the option:

 kexec/arch/arm/kexec-zImage-arm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kexec/arch/arm/kexec-zImage-arm.c b/kexec/arch/arm/kexec-zImage-arm.c
index 9400d1f4..45c587c2 100644
--- a/kexec/arch/arm/kexec-zImage-arm.c
+++ b/kexec/arch/arm/kexec-zImage-arm.c
@@ -122,6 +122,8 @@ void zImage_arm_usage(void)
 		"     --initrd=FILE         Use FILE as the kernel's initial ramdisk.\n"
 		"     --ramdisk=FILE        Use FILE as the kernel's initial ramdisk.\n"
 		"     --dtb=FILE            Use FILE as the fdt blob.\n"
+		"     --image-size=IMAGE_SIZE\n"
+		"                           Reserve IMAGE_SIZE between kernel and initrd.\n"
 		"     --atags               Use ATAGs instead of device-tree.\n"
 		"     --page-offset=PAGE_OFFSET\n"
 		"                           Set PAGE_OFFSET of crash dump vmcore\n"


-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
