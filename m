From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 1 Oct 2018 17:13:15 +0200
Subject: [PATCH] ARM: makefile: pass -march=armv4 to assembler even on
 CPU32v3
In-Reply-To: <20180930024904.14240-1-Jason@zx2c4.com>
References: <20180930024904.14240-1-Jason@zx2c4.com>
Message-ID: <CAK8P3a0grG5OBjwpTeH0fqzoFFBLDH6-oGM4ibzHypUKWedg3A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 30, 2018 at 4:49 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Per the discussion about half-way down in [1], the kernel doesn't
> actually support the ARMv3 ISA, but selects it for some ARMv4 ISA
> hardware that benefits from ARMv3 code generation. Such a consideration,
> then, only applies to the compiler but not to the assembler. This commit
> passes -march=armv4 to the assembler in those cases, so that code
> written for ARMv4 will continue to compile and run fine, without needing
> module-specific asflags-y overrides.
>
> [1] https://lore.kernel.org/lkml/CAKv+Gu9FoFQymp2-=rUeh14CkUKON389OCE7stYCOFwKZpaCrg at mail.gmail.com/
>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
> I don't have too much familiarity with hardware this old, nor access to
> testing systems, so please do carefully evaluate the assertions above
> before merging this, since I'm not sure I have a full understanding of
> the Linux ARMv3 situation.

I took a look at the original build problem. It seems that the issue
here that your assembler implementation contains multiplication
instructions that are part of ARMv3M and higher but not ARMv3.

Since RPC/sa110 supports those instructions, should we maybe
just build the kernel with -march-armv3 instead?

Russell, does this make sense, or is there a reason we're not
already doing the below?

       Arnd

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 8c05ab53425a..445ae57ee3a1 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -81,7 +81,7 @@ endif
 arch-$(CONFIG_CPU_32v5)                =-D__LINUX_ARM_ARCH__=5 -march=armv5te
 arch-$(CONFIG_CPU_32v4T)       =-D__LINUX_ARM_ARCH__=4 -march=armv4t
 arch-$(CONFIG_CPU_32v4)                =-D__LINUX_ARM_ARCH__=4 $(call
cc-option,-march=armv4,-march=armv4t)
-arch-$(CONFIG_CPU_32v3)                =-D__LINUX_ARM_ARCH__=3 -march=armv3
+arch-$(CONFIG_CPU_32v3)                =-D__LINUX_ARM_ARCH__=3 -march=armv3m

 # Evaluate arch cc-option calls now
 arch-y := $(arch-y)
