From: will.deacon@arm.com (Will Deacon)
Date: Fri, 26 Nov 2010 12:22:15 -0000
Subject: linux-next: omap2plus_defconfig not building
In-Reply-To: <20101126114509.GL9310@n2100.arm.linux.org.uk>
References: <4CBD707F.6050204@ti.com>
	<1287488255.18646.110.camel@e102109-lin.cambridge.arm.com>
	<eace9c309e371630528bc9f8fa208705@mail.gmail.com>
	<1289209693.3538.5.camel@e102109-lin.cambridge.arm.com>
	<4CEE6AB1.7090404@ti.com>
	<20101125165048.GA2367@n2100.arm.linux.org.uk>
	<4CEF9B8D.3010106@ti.com>
	<20101126114509.GL9310@n2100.arm.linux.org.uk>
Message-ID: <000101cb8d64$8fe819f0$afb84dd0$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

> $ arm-linux-as -v -o /dev/null /dev/null
> GNU assembler version 2.19.1 (arm-linux) using BFD version (GNU Binutils) 2.19.1
> $ arm-linux-as -march=armv6 -mfloat-abi=soft -meabi=5 -march=armv7-a -o /dev/null t.s
> $ arm-linux-as -march=armv6 -mfloat-abi=soft -meabi=5 -o /dev/null t.s
> t.s: Assembler messages:
> t.s:1: Error: selected processor does not support `ldrexb r7,[r6]'
> 
> So it looks like someone's changed the behaviour of the assembler so it's
> no longer possible to override the -march= argument from the gcc frontend.
> 
> Maybe Will can shed some light on this?

Well we pass -march=armv6 to GCC and -march=v7-a to the assembler using the -Wa
option. This means that the compiler generates a .arch armv6 directive in the .s
file and the assembler barfs.

Please can you try this patch?

diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index 4036a59..7f32510 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -43,7 +43,7 @@ obj-$(CONFIG_ARM_UNWIND)      += unwind.o
 obj-$(CONFIG_HAVE_TCM)         += tcm.o
 obj-$(CONFIG_CRASH_DUMP)       += crash_dump.o
 obj-$(CONFIG_SWP_EMULATE)      += swp_emulate.o
-CFLAGS_swp_emulate.o           := -Wa,-march=armv7-a
+CFLAGS_swp_emulate.o           := -march=armv7-a
 obj-$(CONFIG_HAVE_HW_BREAKPOINT)       += hw_breakpoint.o
 
 obj-$(CONFIG_CRUNCH)           += crunch.o crunch-bits.o


Will
