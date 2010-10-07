From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 7 Oct 2010 09:30:28 +0200
Subject: [PATCH] cpufreq for freescale mx51
In-Reply-To: <AANLkTi=fh4_19QhB8ArTfiigbPOQSejB=gLPMiEmyXjP@mail.gmail.com>
References: <1285738417-1638-1-git-send-email-yong.shen@linaro.org>
	<20100930104817.GC2526@matterhorn.lan>
	<20101006095111.GV28242@pengutronix.de>
	<AANLkTi=fh4_19QhB8ArTfiigbPOQSejB=gLPMiEmyXjP@mail.gmail.com>
Message-ID: <20101007073027.GY28242@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 07, 2010 at 11:36:07AM +0800, Yong Shen wrote:
> Hi Sascha,
> 
> Thanks for your thorough comments.
> I have already received comments from Arnd before yours arrived. So some of
> the commends you two provided are common.
> I acknowledge most of your opinions, except for two, I have some
> explanations.
> 
> > > +    */
> > > > +   reg = __raw_readl(MXC_CCM_CACRR);
> > > > +   reg &= ~MXC_CCM_CACRR_ARM_PODF_MASK;
> > > > +   reg |= cpu_wp_tbl[wp].cpu_podf << MXC_CCM_CACRR_ARM_PODF_OFFSET;
> > > > +   __raw_writel(reg, MXC_CCM_CACRR);
> >
> > We have a simple divider here. Why do we need a reference to struct
> > cpu_wp then? This code could look much simpler.
> >
> > (side note: I'm aware that the original Freescale code is also able
> > to change the cpu frequency using the pll instead of the divider, but is
> > this really necessary?)
> >
> Using wp_tbl is because that it also contains information like regulator
> voltage.

The clock code does not handle the regulators, not even in the fsl
kernel.

> Since the regulator driver for imx51 have not been upstreamed, you
> don't see any regulator operation here. Also, like you mentioned, there are
> two ways to change cpufreq, by post divider or pll change. And post divider
> change is a simpler way and also the only way for babbage, since cpu freq
> and ddr freq are all root from the same pll on babbage and they will
> interfere each other.

I understand what you have to do, but the way you did really looks
strange. You introduce get_cpu_wp() to get the complete array of
workpoints. In the cpufreq driver you have this complete array, pick
the desired workpoint, pass the frequency to the clock layer which in
turn calls get_cpu_wp() to get the array and loop around it to get
the workpoint from the frequency again. Addionally you maintain a
pointer to what the clock code thinks the current workpoint is.

How about making the clock code agnostic of such workpoints and
calculate the pll values and dividers for a given frequency based
on the frequency. If that's to complicated you could maintain
a table in the clock code. If that's not flexible enough you could
pass a pointer to this table to mx51_clocks_init. This array could
carry information relevant only to the clock code and only relevant
to the i.MX51, In the fsl kernel struct cpu_wp is a catch-all struct
for all i.MXs. The i.MX51 uses the pdf/mfi/mfd/mfn/cpu_podf fields,
the i.MX35 uses the pll_reg and pdr0_reg fields and who knows what
the next i.MX needs.

> 
> > > +static struct cpufreq_frequency_table imx_freq_table[4];
> >
> > Three frequencies should be enough for everyone, right? This should be
> > dynamically allocated like in other cpufreq drivers.
> >
> 
> Yes, we only support 3 work points, which is for sure. Actually, we only
> support 2 points on most mx51 chips. I supposed it is ok to use static array
> here.

Please just add dynamic allocation, then we are safe for any potential
future use.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
