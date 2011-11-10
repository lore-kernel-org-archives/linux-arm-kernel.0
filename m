From: B29396@freescale.com (Dong Aisheng-B29396)
Date: Thu, 10 Nov 2011 11:05:49 +0000
Subject: [alsa-devel] [PATCH v4 2/3] ARM: mx28evk: add platform data for
 saif
In-Reply-To: <20111110102608.GY16886@pengutronix.de>
References: <1320907333-12696-1-git-send-email-b29396@freescale.com>
 <1320907333-12696-3-git-send-email-b29396@freescale.com>
 <20111110083852.GU16886@pengutronix.de>
 <65EE16ACC360FA4D99C96DC085B3F7722CB9F2@039-SN1MPN1-002.039d.mgd.msft.net>
 <20111110102608.GY16886@pengutronix.de>
Message-ID: <65EE16ACC360FA4D99C96DC085B3F7722CBB69@039-SN1MPN1-002.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: alsa-devel-bounces at alsa-project.org [mailto:alsa-devel-
> bounces at alsa-project.org] On Behalf Of Sascha Hauer
> Sent: Thursday, November 10, 2011 6:26 PM
> To: Dong Aisheng-B29396
> Cc: alsa-devel at alsa-project.org; broonie at opensource.wolfsonmicro.com;
> w.sang at pengutronix.de; Guo Shawn-R65073; u.kleine-koenig at pengutronix.de;
> lrg at ti.com; linux-arm-kernel at lists.infradead.org
> Subject: Re: [alsa-devel] [PATCH v4 2/3] ARM: mx28evk: add platform data
> for saif
> 
> On Thu, Nov 10, 2011 at 09:23:18AM +0000, Dong Aisheng-B29396 wrote:
> > > > +
> > > > +static const struct mxs_saif_platform_data
> > > > +			mx28evk_mxs_saif_pdata __initconst = {
> > > > +	.init = mx28evk_mxs_saif_pinit,
> > > > +	.get_master_id = mxs_get_saif_clk_master_id,
> > >
> > > This looks *very* suspicious. .init sets the mux register and
> > > .get_master_id reads the very same information back. Why not simply
> > > put a bool is_master into platform data?
> >
> > Originally it's used to avoid introduce a global variable to save
> > clkmux Since we can directly read it from register.
> >
> > If put a bool is_master into pdata, we are assuming there are only two
> > saif Instances. As I was suggested by Wolfram before that how about if
> > there are more than two saifs in the future SoCs?
> 
> I don't understand. A is_master variable in platform_data does not make
> any assumption about the number of interfaces in the system.
>
I was thinking that you may mean we can assume saif1 is master if
saif0_pdate.is_master is false.
So here we assume there two interfaces and the other is master.
Sorry if I mislead your meaning.

> > So the original saif driver design is following this rule that it only
> > needs to know its master id.
> 
> If that's the design then put the master id into platform_data. This
> information is purely static and the board knows it. No need to put a
> function in platform_data. Something like this:
> 	struct saif_pdata {
> 		bool master_mode; /* if true use master mode */
> 		int master_id; /* id of the master if in slave mode */
> 	};
> 
Yes, you're right.
I will try that.
Thanks for the suggestion.

> > If we decide to change here, I may also have a lot to change in saif
> driver.
> 
> Some lines in the probe code, not more.
> 
> Sascha
> 
> --
> Pengutronix e.K.                           |
> |
> Industrial Linux Solutions                 | http://www.pengutronix.de/
> |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0
> |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555
> |
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel at alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

Regards
Dong Aisheng
