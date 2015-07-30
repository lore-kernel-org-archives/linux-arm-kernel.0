From: slash.tmp@free.fr (Mason)
Date: Thu, 30 Jul 2015 18:09:47 +0200
Subject: arch/arm/kernel/setup.c does not compile at -O0
In-Reply-To: <55BA2D9D.1070402@free.fr>
References: <55BA1E62.9080103@free.fr> <55BA2335.706@arm.com>
 <55BA2D9D.1070402@free.fr>
Message-ID: <55BA4C4B.3070705@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/07/2015 15:58, Mason wrote:

> But the problem seems to be on a higher level. My debugger
> just doesn't see ANY local variable whatsoever.

I found the magic setting!

NB: I'm using gcc version 4.9.3 20141031 (prerelease) (Linaro GCC 2014.11)

If I add either:

KBUILD_CFLAGS  += $(call cc-option, -gdwarf-2,)
or
KBUILD_CFLAGS  += $(call cc-option, -gdwarf-3,)

to my top-level Makefile, then DS-5 is able to display local variables.


However, if I add:

KBUILD_CFLAGS  += $(call cc-option, -gdwarf-4,)

or nothing at all, DS-5 just ignores local variables.


It appears that "gcc -g" and "gcc -gdwarf-2 -g" generate different
debugging information... What debugging format does "gcc -g" use?
(Not DWARF, apparently.)

I'll try setting KBUILD_CFLAGS += -gdwarf-2
instead of $(call cc-option, -gdwarf-2,)
=> Yes, that works too.
Does anyone know the difference?

So basically, I'm now using this patch locally:

$ git diff Makefile 
diff --git a/Makefile b/Makefile
index f9041e6d4d19..f79c480f8922 100644
--- a/Makefile
+++ b/Makefile
@@ -641,10 +641,8 @@ KBUILD_CFLAGS      += -fomit-frame-pointer
 endif
 endif
 
-KBUILD_CFLAGS   += $(call cc-option, -fno-var-tracking-assignments)
-
 ifdef CONFIG_DEBUG_INFO
-KBUILD_CFLAGS  += -g
+KBUILD_CFLAGS  += -gdwarf-3
 KBUILD_AFLAGS  += -Wa,--gdwarf-2
 endif
 

Regards.
