From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 12 Oct 2009 23:20:31 -0400 (EDT)
Subject: [PATCH] [ARM] kirkwood: combine support for openrd base/client
	support
In-Reply-To: <20091009140508.GD6085@chipmunk>
References: <20091009123956.GA6085@chipmunk>
	<200910091600.45161.dk-arm-linux@gmx.de>
	<20091009140508.GD6085@chipmunk>
Message-ID: <alpine.LFD.2.00.0910122313090.20122@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 9 Oct 2009, Alexander Clouter wrote:

> Hi,
> 
> * Dieter Kiermaier <dk-arm-linux@gmx.de> [2009-10-09 16:00:44+0200]:
> >
> > [snipped]
> >
> > > +static void __init openrd_init(void)
> > > +{
> > > +	/*
> > > +	 * Basic setup. Needs to be called early.
> > > +	 */
> > > +	kirkwood_init();
> > > +	kirkwood_mpp_conf(openrd_mpp_config);
> > > +
> > > +	kirkwood_uart0_init();
> > > +	kirkwood_nand_init(ARRAY_AND_SIZE(openrd_nand_parts), 25);
> > > +
> > > +	kirkwood_ehci_init();
> > > +
> > > +	kirkwood_ge00_init(&openrd_ge00_data);
> > > +#ifdef CONFIG_MACH_OPENRD_CLIENT
> > > +	if (machine_is_openrd_client())
> > > +		kirkwood_ge01_init(&openrd_ge01_data);
> > > +#endif
> > 
> > shouldn't it be enough to have the if(machine_is.... statement?
> > I didn't see why you test #ifdef, too?
> >
> the struct 'openrd_ge01_data' is wrapped in 
> #ifdef CONFIG_MACH_OPENRD_CLIENT too and only exists if you want the 
> board support for it.  So although machine_is_openrd_client() will 
> exist, the compiler will barf that openrd_ge01_data does not exist;

Don't put a #ifdef on it either then.

> the alternative is to have it grumble (when you do not want the Client 
> support) that there is an un-used struct floating about.

That shouldn't happen.  It will still be referenced by the

	if (machine_is_openrd_client())
		kirkwood_ge01_init(&openrd_ge01_data);

and when the Client support is not configured in, then the 
machine_is_openrd_client() is turned into a 0 which makes gcc nicely 
optimize the unused code and static data structures away.

> I was under the impression the latter is considered worse than the 
> former, I personally am not bothered either way.

Did you try the later?

> > Additionally it would be nice, if you could integrate the i2c / pcie 
> > init in your patch? Please see Simons patch at:
> >
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2009-October/001950.html
> > 
> I knew someone was going to say that :)  Will do though, so 'watch this 
> space'.

Being a separate issue, this probably should remain a separate patch.  
My position is that the missing PCI init call could go upstream now 
whereas the consolidation patch would need to wait for the next merge 
window.


Nicolas
