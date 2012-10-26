From: pavel@denx.de (Pavel Machek)
Date: Sat, 27 Oct 2012 01:00:53 +0200
Subject: [PATCH] arm: socfpga: fix build break for allyesconfig
In-Reply-To: <20121026224358.GD21164@n2100.arm.linux.org.uk>
References: <1351289861-16297-1-git-send-email-dinguyen@altera.com>
 <20121026215136.GC21164@n2100.arm.linux.org.uk>
 <20121026223654.GB2597@elf.ucw.cz>
 <20121026224358.GD21164@n2100.arm.linux.org.uk>
Message-ID: <20121026230052.GA24573@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > > If the above assembly file can only run on ARMv7, consider putting
> > > 
> > > 	.march	armv7
> > > 
> > > or similar before it.
> > 
> > My version of gas does not seem to recognize .march
> 
> Ah, that's because it's .arch not .march.  Please could you check with
> .arch instead.  If proven successful we should move the existing
> AFLAGS_xxx.o Makefile stuff into the assembly files concerned.

        .arch  armv7

results in

arch/arm/mach-socfpga/headsmp.S:21: Error: attempt to use an ARM
instruction on a Thumb-only processor -- `movw
r0,#:lower16:(0xffd08000+0x10)'
...

Using .arch armv7-a indeed works and is a very nice solution.

Signed-off-by: Pavel Machek <pavel@denx.de>

--- a/arch/arm/mach-socfpga/headsmp.S
+++ b/arch/arm/mach-socfpga/headsmp.S
@@ -11,6 +11,7 @@
 #include <linux/init.h>
 
 	__INIT
+	.arch	armv7-a
 
 #define HPS_SYSMGR_ADDRESS	0xffd08000
 #define CONFIG_SYSTEM_MANAGER	HPS_SYSMGR_ADDRESS


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
