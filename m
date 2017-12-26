From: dongas86@gmail.com (Dong Aisheng)
Date: Tue, 26 Dec 2017 18:36:29 +0800
Subject: [PATCH] arm: imx: suspend/resume: use outer_disable/resume
In-Reply-To: <20171226102038.GB11724@b29396-OptiPlex-7040>
References: <20171210120718.15197-1-peng.fan@nxp.com>
 <20171226091230.GP23070@X250>
 <DB6PR04MB3221C1B5362775C72B34B01088060@DB6PR04MB3221.eurprd04.prod.outlook.com>
 <20171226100344.GA11724@b29396-OptiPlex-7040>
 <DB6PR04MB3221FC8A0E2D6980F8AAB1A288060@DB6PR04MB3221.eurprd04.prod.outlook.com>
 <20171226102038.GB11724@b29396-OptiPlex-7040>
Message-ID: <20171226103629.GC11724@b29396-OptiPlex-7040>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 26, 2017 at 06:20:38PM +0800, Dong Aisheng wrote:
> On Tue, Dec 26, 2017 at 10:11:41AM +0000, Peng Fan wrote:
> > 
> > Hi Aisheng,
> > 
> > > -----Original Message-----
> > > From: Dong Aisheng [mailto:dongas86 at gmail.com]
> > > Sent: Tuesday, December 26, 2017 6:04 PM
> > > To: Peng Fan <peng.fan@nxp.com>
> > > Cc: Shawn Guo <shawnguo@kernel.org>; A.s. Dong <aisheng.dong@nxp.com>;
> > > linux-kernel at vger.kernel.org; Russell King <linux@armlinux.org.uk>; Fabio
> > > Estevam <fabio.estevam@nxp.com>; Sascha Hauer <kernel@pengutronix.de>;
> > > van.freenix at gmail.com; linux-arm-kernel at lists.infradead.org
> > > Subject: Re: [PATCH] arm: imx: suspend/resume: use outer_disable/resume
> > > 
> > > On Tue, Dec 26, 2017 at 09:49:01AM +0000, Peng Fan wrote:
> > > > Hi Shawn
> > > >
> > > > > -----Original Message-----
> > > > > From: Shawn Guo [mailto:shawnguo at kernel.org]
> > > > > Sent: Tuesday, December 26, 2017 5:13 PM
> > > > > To: Peng Fan <peng.fan@nxp.com>
> > > > > Cc: A.s. Dong <aisheng.dong@nxp.com>; linux-kernel at vger.kernel.org;
> > > > > Russell King <linux@armlinux.org.uk>; Fabio Estevam
> > > > > <fabio.estevam@nxp.com>; Sascha Hauer <kernel@pengutronix.de>;
> > > > > van.freenix at gmail.com; linux-arm- kernel at lists.infradead.org
> > > > > Subject: Re: [PATCH] arm: imx: suspend/resume: use
> > > > > outer_disable/resume
> > > > >
> > > > > On Sun, Dec 10, 2017 at 08:07:18PM +0800, Peng Fan wrote:
> > > > > > Use outer_disable/resume for suspend/resume.
> > > > > > With the two APIs used, code could be simplified and easy to
> > > > > > extend to introduce l2c_write_sec for i.MX platforms when moving
> > > > > > Linux Kernel runs in non-secure world.
> > > > > >
> > > > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > > > > Cc: Shawn Guo <shawnguo@kernel.org>
> > > > > > Cc: Sascha Hauer <kernel@pengutronix.de>
> > > > > > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> > > > > > Cc: Russell King <linux@armlinux.org.uk>
> > > > > > Cc: Dong Aisheng <aisheng.dong@nxp.com>
> > > > >
> > > > > Changed 'arm: ' prefix to 'ARM: ', and applied patch.
> > > >
> > > > I just tested it on 6sx-sdb, seems this patch breaks 6sx. Could you
> > > > first drop this patch? I'll send out v2 fix the 6sx issue soon.
> > > >
> > > 
> > > Yes, i tested mx6ul/mx6sl ok but mx6sx sdb failed.
> > 
> > Thanks for the test.
> > 
> > > 
> > > After a few debug, it seems you removed the l2c310_early_resume in
> > > v7_cpu_resume which is shared between lower power idle and suspend.
> > > 
> > > Current only mx6sx/mx6ul supports low power idle in upstream, but mx6ul is
> > > A7 with internal L2, that's probably why only mx6sx showed the issue.
> > > 
> > > I did the following quick try to restore L2 after exit lower power idle, but still
> > > can meet occasional crash during booting.
> > > 
> > > diff --git a/arch/arm/mach-imx/cpuidle-imx6sx.c b/arch/arm/mach-
> > > imx/cpuidle-imx6sx.c
> > > index c5a5c3a..edce5bd 100644
> > > --- a/arch/arm/mach-imx/cpuidle-imx6sx.c
> > > +++ b/arch/arm/mach-imx/cpuidle-imx6sx.c
> > > @@ -26,7 +26,7 @@ static int imx6sx_idle_finish(unsigned long val)
> > >          * to adding conditional code for L2 cache type,
> > >          * just call flush_cache_all() is fine.
> > >          */
> > > -       flush_cache_all();
> > > +//     flush_cache_all();
> > 
> > I think flush_cache_all is still needed, to flush L1 data, right?
> > 
> 
> I thought it will be done in generic cpu_suspend.
> See: __cpu_suspend_save()
> 
> So we still need it?
> 

Shawn,

Do you have comments about it?

Regards
Dong Aisheng
