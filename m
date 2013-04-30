From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 30 Apr 2013 11:33:40 +0200
Subject: linux-next build error (at91) - use of bool in mach/arch.h
Message-ID: <517F8FF4.3050901@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Today I discovered an issue while building linux-next for at91:

  CC      arch/arm/mach-at91/at91sam9260_devices.o
In file included from /home/nferre/dev/lnx_buid_test/arch/arm/mach-at91/at91sam9260_devices.c:12:0:
/home/nferre/dev/lnx_buid_test/arch/arm/include/asm/mach/arch.h:46:2: error: expected specifier-qualifier-list before ?bool?

It also applies to all non-DT at91 platforms (~ 6 machines).

It seems to be caused by inclusion of commmit
4dbfa9a25367cfa91aec0e56d75a6905d3242cd3 (ARM: Enable selection of 
SMP operations at boot time) and its use of the "bool" type.

In fact, we include asm/mach/arch.h file in our at91xxx_devices.c files and
we include it as the first include directive.

So, I am wondering if the best correction is to add the types.h header file
in the asm/mach/arch.h file, like this:

--- a/arch/arm/include/asm/mach/arch.h
+++ b/arch/arm/include/asm/mach/arch.h
@@ -8,6 +8,8 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/types.h>
+
 #ifndef __ASSEMBLY__
 
 struct tag;

or if a better option would be to re-arrange the include directives in
various at91xxx_devices.c files?

Thanks, bye,
-- 
Nicolas Ferre
