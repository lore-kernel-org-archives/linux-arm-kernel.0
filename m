From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 3 Jan 2012 12:00:33 +0000
Subject: [PATCH 09/12] ARM: EXYNOS: introduce
 arch/arm/mach-exynos/common.[ch]
In-Reply-To: <013b01ccca0e$6c06ce40$44146ac0$%kim@samsung.com>
References: <1324385316-6052-10-git-send-email-kgene.kim@samsung.com>
 <20111223191935.GS2577@n2100.arm.linux.org.uk>
 <088101ccc1d8$d2023b00$7606b100$%kim@samsung.com>
 <08f401ccc469$9a93a800$cfbaf800$%kim@samsung.com>
 <20120103104120.GK2914@n2100.arm.linux.org.uk>
 <012601ccca05$57d732b0$07859810$%kim@samsung.com>
 <20120103105425.GL2914@n2100.arm.linux.org.uk>
 <012801ccca07$037a24a0$0a6e6de0$%kim@samsung.com>
 <20120103112003.GN2914@n2100.arm.linux.org.uk>
 <013b01ccca0e$6c06ce40$44146ac0$%kim@samsung.com>
Message-ID: <20120103120033.GP2914@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 03, 2012 at 08:54:17PM +0900, Kukjin Kim wrote:
> Russell King - ARM Linux wrote:
> > 
> > On Tue, Jan 03, 2012 at 08:01:15PM +0900, Kukjin Kim wrote:
> > > If any problems, please kindly let me know.
> > 
> > Right, this looks better.  I'm now left with one remaining bit:
> > 
> > arch/arm/mach-exynos/include/mach/system.h:#include <plat/system-reset.h>
> > arch/arm/plat-s3c24xx/cpu.c:#include <plat/system-reset.h>
> > arch/arm/mach-s3c64xx/include/mach/system.h:#include <plat/system-reset.h>
> > arch/arm/mach-s3c2410/include/mach/system.h:#include <plat/system-reset.h>
> > 
> 
> And,
> 
> arch/arm/mach-s5p64x0/include/mach/system.h:#include <plat/system-reset.h>
> arch/arm/mach-s5pc100/include/mach/system.h:#include <plat/system-reset.h>
> arch/arm/mach-s5pv210/include/mach/system.h:#include <plat/system-reset.h>
> 
> > and:
> > 
> > arch/arm/plat-samsung/include/plat/system-reset.h:
> > ...
> > #include <plat/watchdog-reset.h>
> > 
> > static void arch_reset(char mode, const char *cmd)
> > {
> >         arch_wdt_reset();
> > }
> > 
> > I assume that with all the patches I now have merged, arch_reset()
> > should never be called on any Samsung platform, and so the include of
> > plat/watchdog-reset.h and call of arch_wdt_reset() can be removed in
> > my "ARM: restart: plat-samsung: remove plat/reset.h and s5p_reset_hook"
> > patch?
> > 
> Yes, if we don't need arch_reset() anymore, we can remove them in your
> patch.
> 
> But I'm not sure, because happened following build error. Russell, don't we
> need arch_reset()?
> 
> arch/arm/kernel/process.c: In function 'arm_machine_restart':
> arch/arm/kernel/process.c:127: error: implicit declaration of function
> 'arch_reset'
> 
> > What about arch/arm/plat-s3c24xx/cpu.c's include of system-reset.h?
> > Does that need to be replaced with watchdog-reset.h?
> > 
> > That then leads to "ARM: restart: remove the now empty arch_reset()"
> > removing system-reset.h and all includes of that file?
> 
> Thanks.

Oh god, I see what you've done.

ARM: 7256/1: restart: S3C64XX: use new restart hook

--- a/arch/arm/mach-s3c64xx/include/mach/system.h
+++ b/arch/arm/mach-s3c64xx/include/mach/system.h
...
-#include <plat/watchdog-reset.h>
+#include <plat/system-reset.h>
...
-static void arch_reset(char mode, const char *cmd)
-{
-       if (mode != 's')
-               arch_wdt_reset();
-
-       /* if all else fails, or mode was for soft, jump to 0 */
-       soft_restart(0);
-}

So we're making everything depend on plat/system-reset.h.  Why?  The
end result is to remove arch_reset() entirely, and making it depend
on some common definition in some shared header file makes things
more complicated and is error prone.  How do I know when everything
is fixed up as far as the shared header file goes?

It would be _far_ better if the s3c64xx changes to add the .restart
method to _all_ s3c64xx platforms also removed the _contents_ and
only the _contents_ of arch_reset(), leaving an empty function there.
