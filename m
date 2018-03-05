From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 5 Mar 2018 09:31:14 +0100
Subject: [PATCH v4 10/10] ARM: sunxi: smp: Add initialization of CNTVOFF
In-Reply-To: <20180305085148.1de2a99c@dell-desktop.home>
References: <20180223133742.26044-1-mylene.josserand@bootlin.com>
 <20180223133742.26044-11-mylene.josserand@bootlin.com>
 <CAGb2v67SuK9Xr7_dVb7RVGXUJwYRKnTiJwDrOJ-Su5CXmm7HXA@mail.gmail.com>
 <20180226101252.ozdsxjvawgkemz2c@flea.lan>
 <CAGb2v64SaBR-_nL9S20eXe57r_kJTiqSg-di=_mZrv3Yx2-2JA@mail.gmail.com>
 <20180305085148.1de2a99c@dell-desktop.home>
Message-ID: <20180305083114.dwqfdqlziwptfnxq@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 05, 2018 at 08:51:48AM +0100, Myl?ne Josserand wrote:
> > >> > diff --git a/arch/arm/mach-sunxi/sunxi.c b/arch/arm/mach-sunxi/sunxi.c
> > >> > index 5e9602ce1573..4bb041492b54 100644
> > >> > --- a/arch/arm/mach-sunxi/sunxi.c
> > >> > +++ b/arch/arm/mach-sunxi/sunxi.c
> > >> > @@ -37,8 +37,12 @@ static const char * const sun6i_board_dt_compat[] = {
> > >> >  };
> > >> >
> > >> >  extern void __init sun6i_reset_init(void);
> > >> > +extern void sunxi_init_cntvoff(void);
> > >> > +
> > >> >  static void __init sun6i_timer_init(void)
> > >> >  {
> > >> > +       sunxi_init_cntvoff();  
> > >>
> > >> You should check the enable-method to see if PSCI is set or not,
> > >> as an indicator whether the kernel is booted secure or non-secure.  
> > >
> > > It's an indicator, but it's not really a perfect one. You could very
> > > well have your kernel booted in non-secure, without PSCI. Or even with
> > > PSCI, but without the SMP ops.
> > >
> > > We have a quite big number of these cases already, where, depending on
> > > the configuration, we might not have access to the device we write to,
> > > the number of hacks to just enable that device for non-secure is a
> > > good example of that.  
> > 
> > I wouldn't consider them hacks though. The hardware gives the option
> > to have control of many devices delegated solely to secure-only, or
> > secure/non-secure. Our present model is to support everything we can
> > in Linux directly, instead of through some firmware interface to a
> > non-existent firmware.
> 
> I am not sure to understand what is the conclusion about it.
> Should I use "psci"/enable-method or should I use another mechanism to
> detect we are in secure/non-secure (if it exists)?
> 
> Otherwise, for the moment, I can use machine-compatible on sun8i-a83t
> and we will see later how we can handle it in a better way.

Can't we have another approach here?

If we use an enable-method (and we should), instead of having it tied
to the machine compatible, the SMP setup code will run only if our
enable-method is the one we set up. If PSCI is in use, the
enable-method is not going to be the one defined here, and the code
will not run.

So why not just move that call to the SMP ops setup function, just
like renesas does?

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180305/6708b4d0/attachment.sig>
