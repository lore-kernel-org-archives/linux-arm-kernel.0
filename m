From: hechtb@googlemail.com (Bastian Hecht)
Date: Wed, 17 Oct 2012 15:05:09 +0200
Subject: [PATCH v2 0/2] Add DMA and device tree support to the flash
 controller FLCTL
In-Reply-To: <1350473030.5769.137.camel@sauron.fi.intel.com>
References: <1349776729-9311-1-git-send-email-hechtb@gmail.com>
 <1350473030.5769.137.camel@sauron.fi.intel.com>
Message-ID: <CABYn4szACuH3LQ193VJj6E=J4q4Ye4E4O6cUgjB8jmQK6RRmpA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Artem,

> Hi, I used to be able to compile MTD stuff for mackerel board with the
> defconfig attached, but now it fails with 3.7-rc1 with as error:
>
> /tmp/cc2Nr7AN.s: Error: bad immediate value for 8-bit offset (1024)
>
> It fails for dogc4.c, but if I disable DOCG4, it fails for other drivers
> with a similar error.
>
> I've tried (arm) gcc 4.6.3 and the latest Linaro 4.7 build.
>
> Any idea? I did not dig this, is this a known issue? Could you try to
> reproduce this in your setup?
>

I can reproduce the error with the following output:
/tmp/ccYAbker.s: Assembler messages:
/tmp/ccYAbker.s: Error: bad immediate value for 8-bit offset (2048)
make[3]: *** [drivers/mtd/nand/docg4.o] Error 1

The compiler version is: gcc version 4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5)
I usually use: gcc version 4.4.1 (Sourcery G++ Lite 2010q1-202) and
can compile things without problems.

I found some old bug reports (from 2005) on the same issue with arm gcc.

Do we want to send a bug report? I've read in the gnu gcc docs about
reporting and they want the minimal set of data to reproduce this bug.
Hmmmm....

The command line used (with --save-temps added as they want it) is:
arm-linux-gnueabi-gcc -Wp,-MD,drivers/mtd/nand/.docg4.o.d  -nostdinc
-isystem /usr/lib/gcc/arm-linux-gnueabi/4.6/include
-I$KERNEL_DIR/arch/arm/include -Iarch/arm/include/generated  -Iinclude
-I$KERNEL_DIR/arch/arm/include/uapi -Iarch/arm/include/generated/uapi
-I$KERNEL_DIR/include/uapi -Iinclude/generated/uapi -include
$KERNEL_DIR/include/linux/kconfig.h -D__KERNEL__ -mlittle-endian
-Iarch/arm/mach-shmobile/include -Wall -Wundef -Wstrict-prototypes
-Wno-trigraphs -fno-strict-aliasing -fno-common
-Werror-implicit-function-declaration -Wno-format-security
-fno-delete-null-pointer-checks -O2 -marm -fno-dwarf2-cfi-asm
-fno-omit-frame-pointer -mapcs -mno-sched-prolog -mabi=aapcs-linux
-mno-thumb-interwork -D__LINUX_ARM_ARCH__=7 -march=armv7-a
-msoft-float -Uarm -Wframe-larger-than=1024 -fno-stack-protector
-Wno-unused-but-set-variable -fno-omit-frame-pointer
-fno-optimize-sibling-calls -Wdeclaration-after-statement
-Wno-pointer-sign -fno-strict-overflow -fconserve-stack  -DMODULE
-D"KBUILD_STR(s)=#s" -D"KBUILD_BASENAME=KBUILD_STR(docg4)"
-D"KBUILD_MODNAME=KBUILD_STR(docg4)" --save-temps -c -o
drivers/mtd/nand/docg4.o drivers/mtd/nand/docg4.c

This generates docg4.i.

The only way for them to reproduce it would be getting the kernel as a
whole with the .config, no?

cheers,

 Bastian
