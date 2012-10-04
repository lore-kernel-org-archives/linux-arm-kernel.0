From: simon.guinot@sequanux.org (Simon Guinot)
Date: Thu, 4 Oct 2012 09:53:36 +0200
Subject: [PATCH] ARM: kirkwood: DT board setup for Network Space v2 and
 parents
In-Reply-To: <20121004055443.GK21046@lunn.ch>
References: <1349277270-24962-1-git-send-email-simon.guinot@sequanux.org>
 <20121003154310.GI11837@lunn.ch>
 <20121003220916.GW31897@kw.sim.vm.gnt>
 <20121004055443.GK21046@lunn.ch>
Message-ID: <20121004075335.GY31897@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 04, 2012 at 07:54:43AM +0200, Andrew Lunn wrote:
> > > > --- a/arch/arm/mach-kirkwood/board-dt.c
> > > > +++ b/arch/arm/mach-kirkwood/board-dt.c
> > > > @@ -96,6 +96,11 @@ static void __init kirkwood_dt_init(void)
> > > >  	if (of_machine_is_compatible("keymile,km_kirkwood"))
> > > >  		km_kirkwood_init();
> > > >  
> > > > +	if (of_machine_is_compatible("lacie,inetspace_v2") ||
> > > > +	    of_machine_is_compatible("lacie,netspace_v2") ||
> > > > +	    of_machine_is_compatible("lacie,netspace_max_v2"))
> > > > +		ns2_init();
> > > > +
> > > >  	of_platform_populate(NULL, kirkwood_dt_match_table,
> > > >  			     kirkwood_auxdata_lookup, NULL);
> > > 
> > > I'm not a DT policy expert. Could this be one compatibility string for
> > > all the boards? Maybe ask on the DT mainline list?
> > 
> > Maybe I could use "lacie,ns2_common" as a compatibility string. But this
> > does not match any existing device. I don't know if it is correct.
> 
> Hi Simon
> 
> I did a bit of looking around. For kirkwood, we already have two
> boards sharing the same compatibility string. kirkwood-dns320.dts and
> kirkwood-dns325.dts both have dlink,dns-kirkwood and this is what the
> board-dt.c matches on.
> 
> For the tegra20 soc, all boards match on nvidia,tegra20, and that is the only
> compatibility string in board-dt-tegra20.c.
> 
> So i don't see any problem having just one compatibility string here.
> 
> The question is, what is the appropriate name. How common is this
> common C code? Are there ns2 where this C code is not appropriate. One
> thing to remember is that most of this C code will soon disappear and
> become DT. All the mpp will be replaced with pinctrl in 3.8. I hope we
> can get the Ethernet setup in DT as well. You are working on ns2_led,
> so all the C code will be replaced by DT. So all we are really left
> with is power off GPIO handling.
> 
> So i think the danger of using lacie,ns2_common, and then finding it
> does not work with some other ns2 device is quite low.
> 
> What do you think?

The status for this ns2 boards is more or less end-of-life. I mean, this
boards are no longer in production. So I think it is safe to consider
the code inside board-ns2.c as common and shareable between ns2, is2 and
ns2max.

Once this file will be removed, the compatibility checks will be removed
as well. But one could easily forget to remove the useless compatibility
string "lacie,ns2_common" from the dts...

Let me know your preference.

Simon
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121004/0802e67b/attachment.sig>
