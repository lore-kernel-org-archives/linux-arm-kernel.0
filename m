From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 31 Dec 2015 17:51:59 +0100
Subject: [PATCH RFC] ARM: tango4: Fix build issues
In-Reply-To: <CAOesGMhBkacNRxQaBKG8f5Bv2FXH504YCj_O0eL=FwGzY03H-Q@mail.gmail.com>
References: <567DBA04.4060709@free.fr> <20151231132116.GB1547@localhost>
 <CAOesGMhBkacNRxQaBKG8f5Bv2FXH504YCj_O0eL=FwGzY03H-Q@mail.gmail.com>
Message-ID: <4372399.NmOEe7XGjA@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 31 December 2015 17:31:57 Olof Johansson wrote:
> On Thu, Dec 31, 2015 at 2:21 PM, Olof Johansson <olof@lixom.net> wrote:
> > On Fri, Dec 25, 2015 at 10:49:56PM +0100, Mason wrote:
> >> From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
> >>
> >> Move SMP setup to platsmp.c
> >> Specify the CPU type to the assembler, and only for smc.S
> >>
> >> Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
> >> ---
> >
> > Applied, thanks.
> 
> Actually, I just noticed that the smc.c Makefile part isn't done as it
> should, so I'll drop this again.
> 

I've applied a different patch now, so we can at least get allmodconfig
to build again in linux-next:

commit 765ff22d54591a24fe81f6a451b953f43e076ced
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Tue Dec 29 13:43:35 2015 +0100

    ARM: tango: pass ARM arch level for smc.S
    
    allmodconfig is broken by the addition of the -mcpu=cortex-a9
    flag for smc.S:
    
    arch/arm/mach-tango/smc.S:1:0: warning: switch -mcpu=cortex-a9 conflicts with -march=armv6k switch
    
    This sets the flag in the same way that all other platforms
    do, to fix the compile error.
    
    Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/arch/arm/mach-tango/Makefile b/arch/arm/mach-tango/Makefile
index 0d7e2b5..99422ea 100644
--- a/arch/arm/mach-tango/Makefile
+++ b/arch/arm/mach-tango/Makefile
@@ -1,2 +1,3 @@
-asflags-y += -mcpu=cortex-a9
+plus_sec := $(call as-instr,.arch_extension sec,+sec)
+AFLAGS_smc.o		:=-Wa,-march=armv7-a$(plus_sec)
 obj-y += setup.o smc.o

I think we still need the other half of the patch to fix non-SMP compilation.

	Arnd
