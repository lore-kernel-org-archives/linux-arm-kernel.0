From: tony@atomide.com (Tony Lindgren)
Date: Mon, 13 Jun 2011 08:02:36 -0700
Subject: [PATCH 0/3] patches to allow DTB to be appended to the ARM zImage
In-Reply-To: <20110613142044.GC13643@n2100.arm.linux.org.uk>
References: <20110612115820.GF10283@n2100.arm.linux.org.uk>
	<201106121615.24059.arnd@arndb.de>
	<20110612145751.GA4013@ponder.secretlab.ca>
	<20110612151931.GK10283@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1106121145570.2142@xanadu.home>
	<20110612155940.GM10283@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1106121454510.2142@xanadu.home>
	<20110613095142.GA10951@atomide.com>
	<alpine.LFD.2.00.1106131010150.2142@xanadu.home>
	<20110613142044.GC13643@n2100.arm.linux.org.uk>
Message-ID: <20110613150236.GH3352@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [110613 07:16]:
> On Mon, Jun 13, 2011 at 10:14:07AM -0400, Nicolas Pitre wrote:
> > On Mon, 13 Jun 2011, Tony Lindgren wrote:
> > 
> > > * Nicolas Pitre <nicolas.pitre@linaro.org> [110612 11:55]:
> > > > On Sun, 12 Jun 2011, Russell King - ARM Linux wrote:
> > > > 
> > > > > I don't see this as a sustainable way forward.  If we're going to move a
> > > > > particular SoC over to DT, we need to move the entire SoC over.  We can't
> > > > > do this half-heartedly.
> > > > > 
> > > > > And that means we _must_ deal with accepting ATAGs from existing boot
> > > > > loaders, with that information taking precidence over the DT blob
> > > > > supplied with the kernel.
> > > > 
> > > > Well... OK.  Let's see how this can be accommodated with the existing 
> > > > patch floating around doing that.
> > > 
> > > I agree that we need to parse the user configurable ATAGs to support
> > > existing hardware properly. Otherwise we have edit the .dts for each board
> > > to change the user configurable things, which is not nice for distros.
> > 
> > You mean "existing bootloaders", right?

Yes that's correct. There are some bootloaders that will never get updated
as they're proprietary and signed.

> > Updated bootloaders should translate user configurable information into 
> > proper DT records and pass the resulting DTB to the kernel separately.
> 
> OMAP is one of the code bases where this really matters - they have a
> _lot_ of existing platforms with boot loaders which do the ATAG stuff.
> They also have a lot of code in arch/arm that needs to be converted to
> a DT representation.

I think we're OK to start using appended device tree support for mach-omap2
once we have some real data. The only thing missing is the support for
parsing ATAGs for cmdline and other user configurable stuff.

Of course that means that we need to set the DT_APPEND support on in the
omap2plus_defconfig. And I'm assuming that the DT_APPEND support works
also with bootloader passed DT data if the appended data is empty..
 
> With the current situation where you can have either ATAGs or DT but
> not both, they're currently facing either having to break all the
> existing platforms by ignoring the ATAGs _or_ keeping two copies of
> a considerable amount of data - one in DT form and one in its existing
> form.
> 
> At present, DT can only be used sensibly on brand new SoCs where there
> are no existing platforms with ATAG based boot loaders to worry about.
> As things stand at present, even with your patch series, existing SoCs
> have no viable path to transition to DT.

The situation is not actually not that bad, but currently changes to
the .dts file are needed. So some parsing of user configurable ATAGs
is badly needed.

Regards,

Tony
