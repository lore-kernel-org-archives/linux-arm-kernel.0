From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 18 Oct 2010 11:31:21 +0200
Subject: [PATCHv2] cpufreq for freescale mx51
In-Reply-To: <AANLkTimEdhXiLoxyqi0cSpWZDzDX7dwqchg8MEErEzQ2@mail.gmail.com>
References: <1286525307-1934-1-git-send-email-yong.shen@linaro.org>
	<1286525307-1934-2-git-send-email-yong.shen@linaro.org>
	<20101013175424.GU28242@pengutronix.de>
	<AANLkTimprV8=cAD-CfiAgLTCFyj=wc7qMj0sPDCUpWDC@mail.gmail.com>
	<20101018083106.GK28242@pengutronix.de>
	<AANLkTimEdhXiLoxyqi0cSpWZDzDX7dwqchg8MEErEzQ2@mail.gmail.com>
Message-ID: <20101018093121.GM28242@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 18, 2010 at 05:08:14PM +0800, Yong Shen wrote:
> Hi Sascha,
> 
> 
> On Mon, Oct 18, 2010 at 4:31 PM, Sascha Hauer <s.hauer@pengutronix.de>wrote:
> 
> > Hi Yong,
> >
> > On Mon, Oct 18, 2010 at 01:43:43PM +0800, Yong Shen wrote:
> > > Hi Sascha,
> > >
> > > Thanks for your thorough review. I have two feedbacks to your commends.
> > > Sorry for delayed response, cause I had a hard time due to my computer
> > crash
> > > and data loss.
> > >
> > > > diff --git a/arch/arm/mach-mx5/cpu.c b/arch/arm/mach-mx5/cpu.c
> > > > > index 2d37785..83add9c 100644
> > > > > --- a/arch/arm/mach-mx5/cpu.c
> > > > > +++ b/arch/arm/mach-mx5/cpu.c
> > > > > @@ -22,6 +22,8 @@ static int cpu_silicon_rev = -1;
> > > > >
> > > > >  #define SI_REV 0x48
> > > > >
> > > > > +struct cpu_wp *(*get_cpu_wp)(int *wp);
> > > > > +
> > > >
> > > > This is not needed.
> > > >
> > > This is needed, otherwise it does not pass compile.
> >
> > This hunk is the only change to arch/arm/mach-mx5/cpu.c and get_cpu_wp
> > is introduced with this patch, so how can this break compilation?
> > Also, you should move this to a header file. Otherwise you risk of
> > having multiple (and possibly different) declarations of the same
> > function which can lead to hard to find bugs.
> >
> IMHO,  get_cpu_wp is definition rather than a declaration and without it
> there will be errors in link phase. its declaration is in
> arch/arm/plat-mxc/include/mach/mxc.h.

Of course, you are right, my bad. Isn't this function common to al
i.MXs? In this case it should be somewhere in plat-mxc.
Anyway, it seems very odd to me to provide a global function pointer
which gets overwritten by the boards. For me it is more logical to
provide a mxc_register_workpoints() function along with a
mxc_for_each_workpoint() iterator.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
