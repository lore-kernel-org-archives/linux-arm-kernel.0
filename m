From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 2 May 2011 15:55:37 -0600
Subject: [PATCH v5 4/8] arm/dt: probe for platforms via the device tree
In-Reply-To: <20110502163951.GC9243@atomide.com>
References: <20110429070135.12522.35745.stgit@ponder>
	<20110429071548.12522.56929.stgit@ponder>
	<20110502151542.GG2092@atomide.com>
	<BANLkTikue6jMUcQMv9GD4cZ=o5EEW7QDqQ@mail.gmail.com>
	<20110502163951.GC9243@atomide.com>
Message-ID: <20110502215537.GE10097@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 02, 2011 at 07:39:54PM +0300, Tony Lindgren wrote:
> * Grant Likely <grant.likely@secretlab.ca> [110502 18:31]:
> > On Mon, May 2, 2011 at 9:15 AM, Tony Lindgren <tony@atomide.com> wrote:
> > > * Grant Likely <grant.likely@secretlab.ca> [110429 00:13]:
> > >> +
> > >> +/**
> > >> + * setup_machine_fdt - Machine setup when an dtb was passed to the kernel
> > >> + * @dt_phys: physical address of dt blob
> > >> + *
> > >> + * If a dtb was passed to the kernel in r2, then use it to choose the
> > >> + * correct machine_desc and to setup the system.
> > >> + */
> > >> +struct machine_desc * __init setup_machine_fdt(unsigned int dt_phys)
> > >> +{
> > > ...
> > >
> > >> +
> > >> + ? ? /* Retrieve various information from the /chosen node */
> > >> + ? ? of_scan_flat_dt(early_init_dt_scan_chosen, boot_command_line);
> > >
> > > Just to make sure we're considering properly what this change means..
> > >
> > > Does this patch require using CONFIG_CMDLINE_FORCE for older bootloaders
> > > with the device tree append patch?
> > 
> > With the current patch?  Yes, but there is a follow-on patch that was
> > posted a while ago[1] that will copy ATAG data into the device tree in
> > the bootloader.  I've not been pushing to include that change since it
> > adds a lot of code to the wrapper and I'm not sure how deeply we want
> > to support that use case.  Basically I want to have a better idea what
> > the supported use cases are before pushing something like that.
> 
> OK. Maybe that could be made simpler if we only copy the cmdline?
> 
> The cmdline is something that bootloaders typically allow to configure,
> while the other ATAGs are static and should be in the .dts file.

Once the libfdt code is pulled into to manipulate the command line,
it becomes trivial to parse the rest of the atags too, so this
probably won't make much difference (unless work is done to preparse
the devicetree and provide to the zimage wrapper a direct offset to
the cmdline buffer in the dtb, but that gets hairy and I really don't
want to go down that path).

>  
> > Adding a default command line to the .dts file instead of using
> > CONFIG_CMDLINE_FORCE also works.
> 
> But that requires carrying extra patches for something that should
> be user configured.. So not so nice for distros.

Right, so this is only a stop-gap solution.  I'll add this to the list
of topics to discuss in the device tree session at Linaro at UDS next
week.

g.

> 
> Tony
>  
> > [1] http://lists.ozlabs.org/pipermail/devicetree-discuss/2011-March/004652.html
