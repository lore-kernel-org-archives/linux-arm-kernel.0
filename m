From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 25 Jun 2013 19:45:39 +0100
Subject: amba-pl08x and 'get_signal' namespace collision/build error
In-Reply-To: <51C97F40.5030101@arm.com>
References: <51C97F40.5030101@arm.com>
Message-ID: <20130625184539.GB2718@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 25, 2013 at 12:30:08PM +0100, Jonathan Austin wrote:
> There's a patch making its way to mainline via Russell's tree
> (8d96250700: ARM: mm: Transparent huge page support for LPAE systems)
> that breaks the build of the amba-pl08x driver (drivers/dma/amba-pl08x.c) 
> because the 'get_signal' macro from include/linux/signal.h is now in the
> driver's scope and it clobbers a (previously) valid function call.

Well, here's the change to asm/pgtable.h in that patch:

diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index 9bcd262..eaedce7 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -24,6 +24,9 @@
 #include <asm/memory.h>
 #include <asm/pgtable-hwdef.h>

+
+#include <asm/tlbflush.h>
+
 #ifdef CONFIG_ARM_LPAE
 #include <asm/pgtable-3level.h>
 #else

And the question is - if that's all that is going on in that file, why
is asm/tlbflush.h being added to it?  What in _that_ file uses anything
from asm/tlbflush.h (nothing apparantly from what I can see)?

So, I'm tempted to kill this change off unless someone can justify why
that addition happened - it looks completely inappropriate to me.
