From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Tue, 04 Dec 2012 15:46:51 +0100
Subject: linker problem with xip kernel and recent toolchains
Message-ID: <50BE0CDB.5000704@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

we've just discovered a linker problem with newer toolchains, that
support --build-id and xip kernels. The resulting vmlinux is about 13
MiB big, but the xipimage ~2GiB.

A look at the vmlinux's objdump shows that the .notes section is around
2 GiB and it's placed by the linker script into the RAM. With the ROM
starting at 0x0 this results into a ~2 GiB big image.

>   [16] .data             PROGBITS        88008000 0a0000 012aa0 00  WA  0   0 256
>   [17] .notes            NOTE            8801aaa0 0b2aa0 000024 00  AX  0   0  4
>   [18] .bss              NOBITS          8801aae0 0b2ac4 005414 00  WA  0   0 32

After discarding the .notes section in the objcopy (see patch below) the
resulting binary images has a proper size again.

Marc

index 1ec5f67..4448790 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -18,7 +18,7 @@ ifeq ($(CONFIG_CPU_ENDIAN_BE8),y)
 LDFLAGS_vmlinux        += --be8
 endif

-OBJCOPYFLAGS   :=-O binary -R .comment -S
+OBJCOPYFLAGS   :=-O binary -R .comment -R .notes -S
 GZFLAGS                :=-9
 #KBUILD_CFLAGS +=-pipe

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 261 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121204/78670e47/attachment.sig>
