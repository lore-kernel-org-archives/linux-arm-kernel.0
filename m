From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 19 Jul 2011 11:59:37 +0100
Subject: [RFC] Improving scalability of smp_mb__[before|after]_clear_bit
In-Reply-To: <20110719104308.GD26574@n2100.arm.linux.org.uk>
References: <CAN_5kQAniGQgLix4nAsLpJZ3r=LR_NDjuvaXokJ=NiwLfp=7zw@mail.gmail.com>
	<20110719104308.GD26574@n2100.arm.linux.org.uk>
Message-ID: <20110719105937.GG26574@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 19, 2011 at 11:43:08AM +0100, Russell King - ARM Linux wrote:
> On Tue, Jul 12, 2011 at 12:34:59AM -0700, heechul Yun wrote:
> > I think L2 cache sync operation, called by mb(), is not necessary for bitops.
> > This patch improves lat_pagefault of lmbench by up to 11% on a A9 SMP.
> > Higher proceesor
> > counts can benefit more.
> 
> bitops should only be used on normal memory and not for stuff used for IO,
> so this should be safe.
> 
> Could you submit it to the patch system please with Catalins ack?

Oh, you have but yet again the patch is broken by tabs converted to
whitespace:

$ pdb getpatch 6998/1 | tr ' ' '.'
===============================================================================
Patch:.6998/1:.kernel:.use.proper.memory.barriers.for.bitops
From:.Heechul.Yun
-------------------------------------------------------------------------------
.arch/arm/include/asm/bitops.h.|....4.++--
.1.file.changed,.2.insertions(+),.2.deletions(-)
-------------------------------------------------------------------------------
diff.--git.a/arch/arm/include/asm/bitops.h.b/arch/arm/include/asm/bitops.h
index.b4892a0..f428059.100644
---.a/arch/arm/include/asm/bitops.h
+++.b/arch/arm/include/asm/bitops.h
@@.-26,8.+26,8.@@
.#include.<linux/compiler.h>
.#include.<asm/system.h>
.
-#define.smp_mb__before_clear_bit().....mb()
-#define.smp_mb__after_clear_bit()......mb()
+#define.smp_mb__before_clear_bit().....smp_mb()
+#define.smp_mb__after_clear_bit()......smp_mb()
.
./*
..*.These.functions.are.the.basis.of.our.bit.ops.

If you can't fix your mail client not to do this, the patch system gives
you another way to submit - via the web interface where you can simply
attach the patch as a file.  That will avoid any messing about with your
mail client.

However, you really should get your mail client fixed so that it doesn't
mess up whitespace in patches.
