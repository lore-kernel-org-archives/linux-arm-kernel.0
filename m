From: stern@rowland.harvard.edu (Alan Stern)
Date: Fri, 10 Jan 2014 10:29:27 -0500 (EST)
Subject: [PATCH v3 1/2] ohci-platform: Add support for devicetree
 instantiation
In-Reply-To: <52CFC7DC.3010406@redhat.com>
Message-ID: <Pine.LNX.4.44L0.1401101025401.1399-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 10 Jan 2014, Hans de Goede wrote:

> >> +static struct usb_ohci_pdata ohci_platform_defaults = {
> >> +	.power_on =		ohci_platform_power_on,
> >> +	.power_suspend =	ohci_platform_power_off,
> >> +	.power_off =		ohci_platform_power_off,
> >>   };
> >
> > I wonder if these routines couldn't be shared with non-DT setups.  We
> > could add an array of 3 struct clk pointers to the usb_ohci_pdata
> > structure.  Then if any of them are set, store these routines in the
> > power_* pointers.  (And likewise for ehci-platform.)  Something to
> > consider for a future patch...
> 
> I don't like automatically setting the power_ platform_data members much.

Me either.

> But I've already been thinking about moving the clks member to platform_data,
> and simply exporting ohci_platform_power_* so that other drivers can use them
> and put them in the platform_data members themselves. That is indeed something
> for another patch though.

It would require building ohci-platform into the kernel instead of 
making it a separate module.  That shouldn't matter much for 
embedded/SoC systems, though.  It seems like a good approach.

> >>   	if (!pdata) {
> >> -		WARN_ON(1);
> >> -		return -ENODEV;
> >> +		pdata = dev->dev.platform_data = &ohci_platform_defaults;
> >
> > This has a subtle bug.  Consider what will happen if ohci-platform is
> > loaded, then unloaded and loaded again.
> 
> Right, so we need to add a "dev->dev.platform_data == &ohci_platform_defaults"
> check on remove an then set platform_data to NULL, good point, will fix in the
> next version.

Exactly.

> > The existing ehci-platform driver has this same bug.  I definitely
> > remember discussing at once or twice in the past, but evidently it has
> > never been fixed.
> 
> If you agree with the above fix I'll also throw it into the next revision
> of the ehci patch.

Thank you.

> Before I do a v4, one question:
> 
> Ma Haijun does not like the use of OHCI_MAX_CLKS:
> 
>  >> +#define OHCI_MAX_CLKS 3
>  >
>  > I still recommend using of_count_phandle_with_args(np, "clocks",
>  > "#clock-cells") to determine the number of clocks or the existence of clocks
>  > property (-ENOENT)
> 
> His suggestion would mean dynamically allocating the clks array and having
> clks_count variable. I still think this is a bit overkill, but I can do that for
> v4 if you want, so what do you prefer ?

Space isn't a big consideration, because we're not likely to see a 
system with more a few controllers.  I say keep it simple.  If someone 
comes up with a controller using more than 3 clocks, we can change to 
dynamic allocation then.

Alan Stern
