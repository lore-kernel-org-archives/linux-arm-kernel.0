From: tony@atomide.com (Tony Lindgren)
Date: Wed, 26 Nov 2014 12:08:06 -0800
Subject: [PATCH] ARM: OMAP2+: Warn about deprecated legacy booting mode
In-Reply-To: <201411262022.03338@pali>
References: <20141027200008.GR2560@atomide.com> <201411261957.08860@pali>
 <20141126191027.GM2817@atomide.com> <201411262022.03338@pali>
Message-ID: <20141126200806.GO2817@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Pali Roh?r <pali.rohar@gmail.com> [141126 11:24]:
> On Wednesday 26 November 2014 20:10:28 Tony Lindgren wrote:
> > * Pali Roh?r <pali.rohar@gmail.com> [141126 10:59]:
> > > On Wednesday 26 November 2014 19:19:35 Tony Lindgren wrote:
> > > > Maybe Pali can try to restart that discussion? To me it
> > > > seems the /proc/cpuinfo should be the same as it's a user
> > > > interface. Sorry forgot the details of the previous
> > > > discussion..
> > > 
> > > Yes, two days ago I again wrote emails about this problem...
> > > 
> > > E.g. one of them, see: https://lkml.org/lkml/2014/11/24/774
> > > 
> > > > And with which app was that? Sorry I forgot..
> > > 
> > > More applications/libraries for N900 which running on Maemo
> > > 5 system. Some of them are Nokia proprietary, some of them
> > > are open source and some are mine.
> > > 
> > > Basically problem is that non DT boot provides this info in
> > > /proc/cpuinfo:
> > > 
> > > Hardware        : Nokia RX-51 board
> > > Revision        : 0012
> > > 
> > > New DT boot provides this:
> > > 
> > > Hardware        : Generic OMAP3 (Flattened Device Tree)
> > > Revision        : 0000
> > 
> > Oh you can easily fix that by adding a n900 specific
> > DT_MACHINE_START entry to mach-omap2/board-generic.c.
> > 
> 
> I would like to see some solution which does not depend on 
> distributing addition patch which will not be in mainline 
> kernel...

Yes mainline of course. Maybe you misunderstood what I was
suggesting, maybe try the attached patch to fix the "Hardware"
line problem in /proc/cpuinfo?
 
> For this problem I proposed patch (which was rejected): 
> https://lkml.org/lkml/2014/6/18/853

Yes I think that should continue as a separate discussion
too if there are other differences in /proc/cpuinfo.
 
> Basically Hardware is used to check if application is running on 
> Nokia N900 or not. Also entry from Hardware is appended to Web 
> browser user agent and some internet services using it as 
> identifier (N900 device).
> 
> > The revision entry you can populate too in pdata-quirks.c,
> > or maybe add something generic to populate it based on the
> > cmdline or a dts entry as I believe that comes from the
> > legacy ATAGs. I think that's just the system_rev or some
> > other *_rev global in the kernel.
> 
> Revision comes from bootloader (via ATAG) and it is HW revision 
> of N900 device. It cannot be hardcoded into kernel or DTS as it 
> it depends on HW.

Well for the "Revision" line problem, we could pass the revision
in cmdline or .dts if not passed in the legacy ATAGs. It sounds
like were just not copying it to system_rev for DT based booting?
Maybe it's just some missing CONFIG_ATAG option that needs to be
enabled?

Regards,

Tony

8< ------------
From: Tony Lindgren <tony@atomide.com>
Date: Wed, 26 Nov 2014 11:55:29 -0800
Subject: [PATCH] ARM: OMAP2+: Fix n900 board name for legacy user space

N900 legacy user space apps need the board name in
/proc/cpuinfo to work properly for the Hardware entry.

For other boards this should not be an issues and they
can use the generic Hardware entry.

Let's fix the issue by adding a custom DT_MACHINE_START
for n900.

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -118,6 +118,24 @@ MACHINE_END
 #endif
 
 #ifdef CONFIG_ARCH_OMAP3
+/* Some boards need board name for legacy userspace in /proc/cpuinfo */
+static const char *const n900_boards_compat[] __initconst = {
+	"nokia,omap3-n900",
+	NULL,
+};
+
+DT_MACHINE_START(OMAP3_N900_DT, "Nokia RX-51 board")
+	.reserve	= omap_reserve,
+	.map_io		= omap3_map_io,
+	.init_early	= omap3430_init_early,
+	.init_machine	= omap_generic_init,
+	.init_late	= omap3_init_late,
+	.init_time	= omap3_sync32k_timer_init,
+	.dt_compat	= n900_boards_compat,
+	.restart	= omap3xxx_restart,
+MACHINE_END
+
+/* Generic omap3 boards, most boards can use these */
 static const char *const omap3_boards_compat[] __initconst = {
 	"ti,omap3430",
 	"ti,omap3",
