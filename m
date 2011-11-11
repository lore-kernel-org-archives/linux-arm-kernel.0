From: shawn.guo@freescale.com (Shawn Guo)
Date: Sat, 12 Nov 2011 07:07:15 +0800
Subject: [PATCH 1/2] ARM: mach-imx: convert logical CPU numbers to
 physical numbers
In-Reply-To: <20111111134135.GH12410@mudshark.cambridge.arm.com>
References: <1320762894-11824-1-git-send-email-will.deacon@arm.com>
 <1320762894-11824-2-git-send-email-will.deacon@arm.com>
 <20111111092925.GM16886@pengutronix.de>
 <20111111100800.GA12410@mudshark.cambridge.arm.com>
 <20111111105607.GC12410@mudshark.cambridge.arm.com>
 <20111111130701.GI8732@S2100-06.ap.freescale.net>
 <20111111134135.GH12410@mudshark.cambridge.arm.com>
Message-ID: <20111111230713.GA9471@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 11, 2011 at 01:41:35PM +0000, Will Deacon wrote:
> On Fri, Nov 11, 2011 at 01:07:02PM +0000, Shawn Guo wrote:
> > On Fri, Nov 11, 2011 at 10:56:07AM +0000, Will Deacon wrote:
> > > On Fri, Nov 11, 2011 at 10:08:00AM +0000, Will Deacon wrote:
> > > > On Fri, Nov 11, 2011 at 09:29:25AM +0000, Sascha Hauer wrote:
> > > > > On Tue, Nov 08, 2011 at 02:34:53PM +0000, Will Deacon wrote:
> > > > > > This patch uses the new cpu_logical_map() macro for converting logical
> > > > > > CPU numbers into physical numbers when releasing CPUs during the SMP
> > > > > > boot and CPU hotplug paths.
> > > > > 
> > > > > Shawn, is this one ok?
> > > > 
> > > > I reckon I need to post a v2 because this probably breaks when !SMP.
> > > 
> > > Actually, I take that back. Looks like the function is only used by
> > > hotplug.c and platsmp.c, both of which depend on CONFIG_SMP.
> > > 
> > But the build of src.c does not depend on CONFIG_SMP.  So when building
> > with no CONFIG_SMP, we get:
> > 
> >   CC      arch/arm/mach-imx/src.o
> > arch/arm/mach-imx/src.c: In function ?imx_enable_cpu?:
> > arch/arm/mach-imx/src.c:31:2: error: implicit declaration of function ?cpu_logical_map?
> > make[2]: *** [arch/arm/mach-imx/src.o] Error 1
> > make[1]: *** [arch/arm/mach-imx] Error 2
> 
> Ok, then maybe we should #ifdef CONFIG_SMP that function entirely. If that
> sounds ok, I can post a v2.
> 
Yes for imx_enable_cpu(), and no for imx_set_cpu_jump() as it's being
called by pm-imx6q.c as well.  And I would suggest just wrap #ifdef
cpu_logical_map, as these two functions are exported in
arch/arm/plat-mxc/include/mach/common.h for !SMP users too.

-- 
Regards,
Shawn
