From: mmayer@broadcom.com (Markus Mayer)
Date: Tue, 27 Nov 2012 17:16:49 -0800
Subject: vexpress compilation error in next-20121127
Message-ID: <50B56601.5010305@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pawel,

There seems to be an issue compiling vexpress at this point. The problem 
being that vexpress' makefile references reset.o, but there's no reset.c 
in arch/arm/mach-vexpress.

[...]
   CC      arch/arm/mach-bcm/board_bcm.o
   LD      arch/arm/mach-bcm/built-in.o
   CC      arch/arm/mach-vexpress/v2m.o
make[1]: *** No rule to make target `arch/arm/mach-vexpress/reset.o', 
needed by `arch/arm/mach-vexpress/built-in.o'.  Stop.
make: *** [arch/arm/mach-vexpress] Error 2

The commit in question seems to be this:

http://git.kernel.org/?p=linux/kernel/git/arm/arm-soc.git;a=commitdiff;h=38669e045dbf8f62a008898a7fb1e93975b3817c

It adds the reference to reset.o to the makefile, but doesn't add 
reset.c itself. That doesn't seem right -- or did I overlook anything 
obvious?

As a quick fix, I tried commenting out reset.o in Makefile. While that 
lets the compilation proceed, I end up with unresolved symbols at link time.

[...]
   CC      init/version.o
   LD      init/built-in.o
arch/arm/mach-vexpress/built-in.o: In function `v2m_dt_init':
/home/mmayer/Development/upstreaming/arm-soc/arch/arm/mach-vexpress/v2m.c:487: 
undefined reference to `vexpress_power_off'
arch/arm/mach-vexpress/built-in.o: In function `v2m_init':
/home/mmayer/Development/upstreaming/arm-soc/arch/arm/mach-vexpress/v2m.c:371: 
undefined reference to `vexpress_power_off'
arch/arm/mach-vexpress/built-in.o:(.arch.info.init+0x48): undefined 
reference to `vexpress_restart'
arch/arm/mach-vexpress/built-in.o:(.arch.info.init+0x94): undefined 
reference to `vexpress_restart'
make: *** [vmlinux] Error 1

Regards,
-Markus
