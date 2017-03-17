From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Fri, 17 Mar 2017 14:42:09 +0000
Subject: [PATCH] arm: kprobes: Align stack to 8-bytes in test code
In-Reply-To: <20170317140610.GF21222@n2100.armlinux.org.uk>
References: <20170316135359.23019-1-tixy@linaro.org>
 <20170317121025.GD21222@n2100.armlinux.org.uk>
 <1489755542.3063.2.camel@linaro.org>
 <20170317140610.GF21222@n2100.armlinux.org.uk>
Message-ID: <1489761729.3063.7.camel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2017-03-17 at 14:06 +0000, Russell King - ARM Linux wrote:
> On Fri, Mar 17, 2017 at 12:59:02PM +0000, Jon Medhurst (Tixy) wrote:
> > 
[...]
> > It isn't, because GCC turns code like this
> > 
> > void foo(void)
> > {
> >         asm volatile("bl __kprobes_test_case_start"
> >                      : : : "r0", "r1", "r2", "r3", "ip", "lr", "memory", "cc");
> > }
> > 
> > into this...
> > 
> > 8010e4ac <foo>:
> > 8010e4ac:       e52de004        push    {lr}            ; (str lr, [sp, #-4]!)
> > 8010e4b0:       eb002c99        bl      8011971c <__kprobes_test_case_start>
> > 8010e4b4:       e49df004        pop     {pc}            ; (ldr pc, [sp], #4)
> > 
> > Perhaps we need a way of telling GCC we are using the stack but I've not
> > managed to spot a way of doing that.
> 
> Using which compiler options?

The ones the Linux makefile picks when building with vexpress_defconfig.
I hacked a kernel file to build the above example but the behaviour is
what I observed with the real kprobes code. I've pasted the commanline
produced by building with V=1 at the end of this email.

One thing I've noticed playing around just now is that if I add "sp" to
the clobber list, and use a newer GCC (gcc-linaro-6.2.1-2016.11) then it
does allign the stack correctly. "sp" makes no difference with GCC 5.3 or
4.8.

That commandline ...

/data/arm32/aarch32-toolchain/gcc-linaro-5.3.1-2016.05-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-gcc
-Wp,-MD,arch/arm/kernel/.patch.o.d  -nostdinc -isystem
/data/arm32/aarch32-toolchain/gcc-linaro-5.3.1-2016.05-x86_64_arm-linux-gnueabihf/bin/../lib/gcc/arm-linux-gnueabihf/5.3.1/include
-I./arch/arm/include -I./arch/arm/include/generated/uapi
-I./arch/arm/include/generated  -I./include -I./arch/arm/include/uapi
-I./include/uapi -I./include/generated/uapi -include ./include/linux/kconfig.h
-D__KERNEL__ -mlittle-endian -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs
-fno-strict-aliasing -fno-common -Werror-implicit-function-declaration
-Wno-format-security -std=gnu89 -fno-PIE -fno-dwarf2-cfi-asm -fno-ipa-sra
-mabi=aapcs-linux -mno-thumb-interwork -mfpu=vfp -funwind-tables -marm
-D__LINUX_ARM_ARCH__=7 -march=armv7-a -msoft-float -Uarm
-fno-delete-null-pointer-checks -O2 --param=allow-store-data-races=0
-Wframe-larger-than=1024 -fno-stack-protector -Wno-unused-but-set-variable
-fomit-frame-pointer -fno-var-tracking-assignments -g
-fno-inline-functions-called-once -Wdeclaration-after-statement
-Wno-pointer-sign -fno-strict-overflow -fconserve-stack -Werror=implicit-int
-Werror=strict-prototypes -Werror=date-time -Werror=incompatible-pointer-types
-DCC_HAVE_ASM_GOTO    -DKBUILD_BASENAME='"patch"'  -DKBUILD_MODNAME='"patch"' -c
-o arch/arm/kernel/patch.o arch/arm/kernel/patch.c
