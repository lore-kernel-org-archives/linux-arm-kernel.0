From: slash.tmp@free.fr (Mason)
Date: Thu, 30 Jul 2015 14:53:54 +0200
Subject: arch/arm/kernel/setup.c does not compile at -O0
Message-ID: <55BA1E62.9080103@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello everyone,

I'm trying to debug a live kernel (v3.14) using a DS-5 JTAG probe.

In order to make the control flow easier to follow, I disabled
optimizations by adding

  subdir-ccflags-y := -O0

to arch/arm/kernel/Makefile

With that change, linking fails:

arch/arm/kernel/setup.c:924: undefined reference to `psci_smp_ops'

      if (psci_smp_available())
        smp_set_ops(&psci_smp_ops);

#ifdef CONFIG_ARM_PSCI
void psci_init(void);
bool psci_smp_available(void);
#else
static inline void psci_init(void) { }
static inline bool psci_smp_available(void) { return false; }
#endif

The optimizer is able to remove the entire block, but this
does not happen when optimizations are disabled.

Is compiling at -O0 not supported?


My larger problem: the DS-5 debugger refuses to show the value
of local variables. As a work-around, I can make some variables
global, but it's really inconvenient.

I checked that CONFIG_FRAME_POINTER=y
and source files are compiled with -g

arm-linux-gnueabihf-gcc -Wp,-MD,init/.main.o.d  -nostdinc -isystem /opt/gcc-linaro-2014.11/bin/../lib/gcc/arm-linux-gnueabihf/4.9.3/include -I/opt/linux/arch/arm/include -Iarch/arm/include/generated  -Iinclude -I/opt/linux/arch/arm/include/uapi -Iarch/arm/include/generated/uapi -I/opt/linux/include/uapi -Iinclude/generated/uapi -include /opt/linux/include/linux/kconfig.h -D__KERNEL__ -mlittle-endian -Iarch/arm/mach-tangox/include -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -Werror-implicit-function-declaration -Wno-format-security -fno-delete-null-pointer-checks -std=gnu89 -O2 -fno-dwarf2-cfi-asm -fno-omit-frame-pointer -mapcs -mno-sched-prolog -mabi=aapcs-linux -mno-thumb-interwork -mfpu=vfp -marm -D__LINUX_ARM_ARCH__=7 -march=armv7-a -msoft-float -Uarm -Wframe-larger-than=1024 -fno-stack-protector -Wno-unused-but-set-variable -fno-omit-frame-pointer -fno-optimize-sibling-calls -fno-var-tracking-assignments -g -Wdeclaration-after-statement -Wno-
 p
ointer-sign -fno-strict-overflow -fconserve-stack -Werror=implicit-int -Werror=strict-prototypes -Werror=date-time -DCC_HAVE_ASM_GOTO -O0    -D"KBUILD_STR(s)=#s" -D"KBUILD_BASENAME=KBUILD_STR(main)"  -D"KBUILD_MODNAME=KBUILD_STR(main)" -c -o init/main.o init/main.c


Any idea how I can get DS-5 to properly handle local variables?


I'm trying to convert an old-style board config to a device tree,
and I can't even get serial to work... :-(

Regards.
