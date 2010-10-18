From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 18 Oct 2010 10:31:06 +0200
Subject: [PATCHv2] cpufreq for freescale mx51
In-Reply-To: <AANLkTimprV8=cAD-CfiAgLTCFyj=wc7qMj0sPDCUpWDC@mail.gmail.com>
References: <1286525307-1934-1-git-send-email-yong.shen@linaro.org>
	<1286525307-1934-2-git-send-email-yong.shen@linaro.org>
	<20101013175424.GU28242@pengutronix.de>
	<AANLkTimprV8=cAD-CfiAgLTCFyj=wc7qMj0sPDCUpWDC@mail.gmail.com>
Message-ID: <20101018083106.GK28242@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yong,

On Mon, Oct 18, 2010 at 01:43:43PM +0800, Yong Shen wrote:
> Hi Sascha,
> 
> Thanks for your thorough review. I have two feedbacks to your commends.
> Sorry for delayed response, cause I had a hard time due to my computer crash
> and data loss.
> 
> > diff --git a/arch/arm/mach-mx5/cpu.c b/arch/arm/mach-mx5/cpu.c
> > > index 2d37785..83add9c 100644
> > > --- a/arch/arm/mach-mx5/cpu.c
> > > +++ b/arch/arm/mach-mx5/cpu.c
> > > @@ -22,6 +22,8 @@ static int cpu_silicon_rev = -1;
> > >
> > >  #define SI_REV 0x48
> > >
> > > +struct cpu_wp *(*get_cpu_wp)(int *wp);
> > > +
> >
> > This is not needed.
> >
> This is needed, otherwise it does not pass compile.

This hunk is the only change to arch/arm/mach-mx5/cpu.c and get_cpu_wp
is introduced with this patch, so how can this break compilation?
Also, you should move this to a header file. Otherwise you risk of
having multiple (and possibly different) declarations of the same
function which can lead to hard to find bugs.

> 
> >
> > > +             return ret;
> > > +     }
> > > +
> > > +     cpufreq_frequency_table_get_attr(imx_freq_table, policy->cpu);
> > > +     return 0;
> > > +}
> > > +
> > > +static int mxc_cpufreq_exit(struct cpufreq_policy *policy)
> > > +{
> > > +     cpufreq_frequency_table_put_attr(policy->cpu);
> > > +
> > > +     /* Reset CPU to 665MHz */
> > > +     set_cpu_freq(arm_normal_clk);
> >
> > arm_normal_clk is initialized to cpu_freq_khz_max * 1000 and never touched
> > again. It would be clearer here to remove arm_normal_clk and write
> > cpu_freq_khz_max * 1000 directly here. Then you can also remove the
> > comment which is wrong for most i.MXs, even for the i.MX51.
> >
> >
> Actually, this is arm_normal_clk is touched later in mxc_cpufreq_exit()
> fuction.

It's *read* but not changed. That's why I suggested to just remove
arm_normal_clk and instead do a set_cpu_freq(cpu_freq_khz_max * 1000) in
mxc_cpufreq_exit.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
