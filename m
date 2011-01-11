From: rabin@rab.in (Rabin Vincent)
Date: Tue, 11 Jan 2011 21:16:38 +0530
Subject: ARM: relocation out of range (when loading a module)
In-Reply-To: <4D2BFA08.5030104@ahsoftware.de>
References: <4D2B4CE4.9080309@ahsoftware.de>
	<alpine.LFD.2.00.1101101722470.9794@xanadu.home>
	<4D2BFA08.5030104@ahsoftware.de>
Message-ID: <AANLkTinR7ih2ZMRMbXmSvoh-rS3LVv+UCvd0rRH_ESzf@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 11, 2011 at 12:04, Alexander Holler <holler@ahsoftware.de> wrote:
> Point is that I would like to understand why including an initramfs has such
> consequences.
>
> I have to search for some pictures which are explaining the memory layout
> (never had any interested in that before).
>
> I assume some memory near the kernel is reserved for the modules and an
> initramfs will come inbetween the kernel and the reserved memory for
> modules.

Modules get placed 16MiB below PAGE_OFFSET, and when you add another
~16MiB initramfs between them and the kernel symbols, you exceed the
offset range of the branch instruction.

It's possible to hack around this by placing the initramfs at the end of
the kernel image rather than at the beginning with the rest of the init
data.  Something like the below should work, although you should also
probably take care of alignment and also have this section freed when
the rest of the init data is freed.

diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index b16c079..05ad361 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -46,7 +46,6 @@ SECTIONS
 		INIT_CALLS
 		CON_INITCALL
 		SECURITY_INITCALL
-		INIT_RAM_FS

 #ifndef CONFIG_XIP_KERNEL
 		__init_begin = _stext;
@@ -170,6 +169,11 @@ SECTIONS

 		_edata = .;
 	}
+
+	.initramfs : {
+		INIT_RAM_FS
+	}
+
 	_edata_loc = __data_loc + SIZEOF(.data);

 #ifdef CONFIG_HAVE_TCM
