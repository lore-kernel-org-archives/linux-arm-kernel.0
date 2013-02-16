From: nico@fluxnic.net (Nicolas Pitre)
Date: Sat, 16 Feb 2013 00:36:56 -0500 (EST)
Subject: [RFC/NOT FOR MERGING 2/3] serial: omap: remove hwmod dependency
In-Reply-To: <20130215163031.GA5724@atomide.com>
References: <20130214171253.GC7144@atomide.com>
 <20130214175650.GA25891@arwen.pp.htv.fi> <20130214181217.GA11806@atomide.com>
 <20130214192719.GB26679@arwen.pp.htv.fi> <20130214193911.GD11806@atomide.com>
 <alpine.DEB.2.00.1302141946110.11016@utopia.booyaka.com>
 <20130215101610.GR17852@n2100.arm.linux.org.uk> <511E3797.2070802@ti.com>
 <20130215132726.GT17852@n2100.arm.linux.org.uk> <511E38C3.7080404@ti.com>
 <20130215163031.GA5724@atomide.com>
Message-ID: <alpine.LFD.2.03.1302160035240.6419@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 15 Feb 2013, Tony Lindgren wrote:

> * Santosh Shilimkar <santosh.shilimkar@ti.com> [130215 05:34]:
> > On Friday 15 February 2013 06:57 PM, Russell King - ARM Linux wrote:
> > >On Fri, Feb 15, 2013 at 06:56:47PM +0530, Santosh Shilimkar wrote:
> > >>Whats your view on use of arch_ioremap_caller() hook ? This can allow
> > >>us to avoid the dual ioremap() issue discussed here if the hook
> > >>maintains the list of mapped ios.
> > >>
> > >>I was even thinking of having such intelligence within the core
> > >>ioremap code but thought that might be too invasive.
> > >
> > >Why do you even need it?  There's no problem with ioremapping the same
> > >space multiple times (you end up with multiple mappings but that
> > >shouldn't be a problem, except for the additional space used.)
> > >
> > It just waste of iospace and Tony insisted to have just single ioremap()
> > hence all this discussion
> 
> The main goal is to avoid duplicating data both in hwmod and DT.
> That's pretty much solved as we can have the driver probe populate
> the common data for hwmod from DT as Santosh has already demonstrated.
> 
> Then we also want the driver specific idle and reset code to be done
> in the drivers rather than in hwmod and glue it together with hwmod
> using runtime PM. The biggest issue there is how do we reset and idle
> some piece of hardware for PM purposes when there's no driver loaded.
> 
> For the duplicate ioremapping, I don't think there's any need to
> do it if we get things right.

Note that if the ioremap matches a static map area there is no cost to 
ioremap it multiple times.


Nicolas
