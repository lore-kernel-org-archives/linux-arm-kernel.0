From: mpeg.blue@free.fr (Mason)
Date: Thu, 27 Nov 2014 11:40:34 +0100
Subject: Code generation involving __raw_readl and __raw_writel
Message-ID: <5476FFA2.8010403@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello everyone,

Consider the following code (preprocessor output):

static int tangox_target(struct cpufreq_policy *policy, unsigned int index)
{
  while (__raw_readl((volatile void *)(0xf0000000 +(0x10024))) >> 31);
  __raw_writel(0, (volatile void *)(0xf0000000 +(0x10024)));
  return 0;
}

gcc generates the following code:
(version and command-line in sig below)

00000014 <tangox_target>:
   14:   e3a03000        mov     r3, #0
   18:   e34f3001        movt    r3, #61441      ; 0xf001
   1c:   e3a02000        mov     r2, #0
   20:   e34f2001        movt    r2, #61441      ; 0xf001
   24:   e5931024        ldr     r1, [r3, #36]   ; 0x24
   28:   e3510000        cmp     r1, #0
   2c:   bafffffa        blt     1c <tangox_target+0x8>
   30:   e3a00000        mov     r0, #0
   34:   e5820024        str     r0, [r2, #36]   ; 0x24
   38:   e12fff1e        bx      lr

Do you know why gcc duplicates the address in r2 and r3?
And keeps putting the address in r2 over and over in the loop?

I was expecting something more along these lines:

00000014 <tangox_target>:
   14:   e3a03000        mov     r3, #0
   18:   e34f3001        movt    r3, #61441      ; 0xf001
   1c:   e5931024        ldr     r1, [r3, #36]   ; 0x24
   20:   e3510000        cmp     r1, #0
   24:   bafffffa        blt     1c <tangox_target+0x8>
   28:   e3a00000        mov     r0, #0
   2c:   e5820024        str     r0, [r3, #36]   ; 0x24
   30:   e12fff1e        bx      lr

Regards.

-- 
gcc version 4.6.3 (Sourcery CodeBench Lite 2012.03-57)

arm-none-linux-gnueabi-gcc -Wp,-MD,arch/arm/mach-tangox/.cpufreq.o.d  -nostdinc -isystem /utils/release/sets/6_1_3_8756/sigma-buildroot_2012.02-22/output/host/opt/ext-toolchain/bin/../lib/gcc/arm-none-linux-gnueabi/4.6.3/include -I/home/maze/linux/arch/arm/include -Iarch/arm/include/generated  -Iinclude -I/home/maze/linux/arch/arm/include/uapi -Iarch/arm/include/generated/uapi -I/home/maze/linux/include/uapi -Iinclude/generated/uapi -include /home/maze/linux/include/linux/kconfig.h -D__KERNEL__ -mlittle-endian -Iarch/arm/mach-tangox/include -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -Werror-implicit-function-declaration -Wno-format-security -fno-delete-null-pointer-checks -O2 -fno-dwarf2-cfi-asm -mabi=aapcs-linux -mno-thumb-interwork -mfpu=vfp -funwind-tables -marm -D__LINUX_ARM_ARCH__=7 -march=armv7-a -msoft-float -Uarm -Wframe-larger-than=1024 -fno-stack-protector -Wno-unused-but-set-variable -fomit-frame-pointer -fno-var-tracking-assignments 
 -
g -Wdeclaration-after-statement -Wno-pointer-sign -fno-strict-overflow -fconserve-stack -Werror=implicit-int -Werror=strict-prototypes    -D"KBUILD_STR(s)=#s" -D"KBUILD_BASENAME=KBUILD_STR(cpufreq)"  -D"KBUILD_MODNAME=KBUILD_STR(cpufreq)" -c -o arch/arm/mach-tangox/cpufreq.o arch/arm/mach-tangox/cpufreq.c
