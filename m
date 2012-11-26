From: simon.guinot@sequanux.org (Simon Guinot)
Date: Mon, 26 Nov 2012 16:18:11 +0100
Subject: [PATCH v3 2/4] ARM: kirkwood: DT board setup for Network Space
 v2 and parents
In-Reply-To: <20121126090253.GI9580@quad.lixom.net>
References: <1350468546-25901-1-git-send-email-simon.guinot@sequanux.org>
 <1350468546-25901-3-git-send-email-simon.guinot@sequanux.org>
 <20121126090253.GI9580@quad.lixom.net>
Message-ID: <20121126151811.GF8628@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 26, 2012 at 01:02:53AM -0800, Olof Johansson wrote:
> Hi,
> 
> This is more directed at Jason and the other maintainers than you, Simon --
> it's something I noticed when looking at his pull request.
> 
> On Wed, Oct 17, 2012 at 12:09:04PM +0200, Simon Guinot wrote:
> 
> > diff --git a/arch/arm/mach-kirkwood/Kconfig b/arch/arm/mach-kirkwood/Kconfig
> > index 50bca50..847e0c2 100644
> > --- a/arch/arm/mach-kirkwood/Kconfig
> > +++ b/arch/arm/mach-kirkwood/Kconfig
> > @@ -130,6 +130,27 @@ config MACH_KM_KIRKWOOD_DT
> >  	  Say 'Y' here if you want your kernel to support the
> >  	  Keymile Kirkwood Reference Desgin, using Flattened Device Tree.
> >  
> > +config MACH_INETSPACE_V2_DT
> > +	bool "LaCie Internet Space v2 NAS (Flattened Device Tree)"
> > +	select ARCH_KIRKWOOD_DT
> > +	help
> > +	  Say 'Y' here if you want your kernel to support the LaCie
> > +	  Internet Space v2 NAS, using Flattened Device Tree.
> > +
> > +config MACH_NETSPACE_V2_DT
> > +	bool "LaCie Network Space v2 NAS (Flattened Device Tree)"
> > +	select ARCH_KIRKWOOD_DT
> > +	help
> > +	  Say 'Y' here if you want your kernel to support the LaCie
> > +	  Network Space v2 NAS, using Flattened Device Tree.
> > +
> > +config MACH_NETSPACE_MAX_V2_DT
> > +	bool "LaCie Network Space Max v2 NAS (Flattened Device Tree)"
> > +	select ARCH_KIRKWOOD_DT
> > +	help
> > +	  Say 'Y' here if you want your kernel to support the LaCie
> > +	  Network Space Max v2 NAS, using Flattened Device Tree.
> 
> It would be nice to get away from these config options. The whole point with
> device tree is to no longer have to do code changes for new similar boards.
> 
> And even then, since they share the same init function, there's no need for
> three options, just one.
> 
> > diff --git a/arch/arm/mach-kirkwood/Makefile b/arch/arm/mach-kirkwood/Makefile
> > index 294779f..1f63d80 100644
> > --- a/arch/arm/mach-kirkwood/Makefile
> > +++ b/arch/arm/mach-kirkwood/Makefile
> > @@ -31,3 +31,6 @@ obj-$(CONFIG_MACH_GOFLEXNET_DT)		+= board-goflexnet.o
> >  obj-$(CONFIG_MACH_LSXL_DT)		+= board-lsxl.o
> >  obj-$(CONFIG_MACH_IOMEGA_IX2_200_DT)	+= board-iomega_ix2_200.o
> >  obj-$(CONFIG_MACH_KM_KIRKWOOD_DT)	+= board-km_kirkwood.o
> > +obj-$(CONFIG_MACH_INETSPACE_V2_DT)	+= board-ns2.o
> > +obj-$(CONFIG_MACH_NETSPACE_V2_DT)	+= board-ns2.o
> > +obj-$(CONFIG_MACH_NETSPACE_MAX_V2_DT)	+= board-ns2.o
> 
> Same here.

Hi,

All this configuration options (plus those for ns2 lite and mini) are
indeed useless as we are using a single init function. Moreover there
is no code relying on this options in the file  board-ns2.c. All the
checks are made at run-time.

I will send a patch to remove this options.

Simon

> 
> > diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
> > index 70c5a28..b3e0519 100644
> > --- a/arch/arm/mach-kirkwood/board-dt.c
> > +++ b/arch/arm/mach-kirkwood/board-dt.c
> > @@ -96,6 +96,11 @@ static void __init kirkwood_dt_init(void)
> >  	if (of_machine_is_compatible("keymile,km_kirkwood"))
> >  		km_kirkwood_init();
> >  
> > +	if (of_machine_is_compatible("lacie,inetspace_v2") ||
> > +	    of_machine_is_compatible("lacie,netspace_v2") ||
> > +	    of_machine_is_compatible("lacie,netspace_max_v2"))
> > +		ns2_init();
> > +
> 
> This function is now a long sequence of if statments like the ones above. It
> would be great if they could be removed by moving most of the functionality
> implemented in the board file to the device tree. Looks like it's not a whole
> lot left, so that's promising. I'm guessing there's already efforts underway to
> take care of the last pieces.
> 
> But, until then, I think it'd be nice to make this a table driven lookup
> instead of a sequence of open-coded if statements. Tegra had this early on
> before the board files were removed too. I.e. just a table of
> 
> static struct match_table {
> 	char *compat;
> 	void (*fn)(void);
> } match_table = {
> 	{ "lacie,inetspace_v2", ns2_init },
> 	{ "lacie,netspace_v2", ns2_init },
> 	....
> }
> 
> and then an interator over that table.
> 
> > @@ -112,6 +117,9 @@ static const char *kirkwood_dt_board_compat[] = {
> >  	"buffalo,lsxl",
> >  	"iom,ix2-200",
> >  	"keymile,km_kirkwood",
> > +	"lacie,inetspace_v2",
> > +	"lacie,netspace_max_v2",
> > +	"lacie,netspace_v2",
> >  	NULL
> >  };
> 
> Same here. I actually think this is a table that is no longer needed -- the
> board compat can/should be done on the generic compatible string instead of for
> each most-specific board string.
> 
> > +static void ns2_power_off(void)
> > +{
> > +	gpio_set_value(NS2_GPIO_POWER_OFF, 1);
> > +}
> 
> This kind of thing should be possible to generalize through a generic binding.
> 
> 
> -Olof
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121126/60830598/attachment-0001.sig>
