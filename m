From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 21 Jun 2010 11:38:27 -0400 (EDT)
Subject: [PATCH 1/2] [ARM] Introduce 'struct machine_class' for SoC level
	abstraction
In-Reply-To: <AANLkTimHuNuaVrRqPMiLpItBNgBeW3Cdqg6hBYT1DEpl@mail.gmail.com>
References: <1277042450-30382-1-git-send-email-eric.miao@canonical.com>
	<201006211527.49786.jeremy.kerr@canonical.com>
	<AANLkTilUddhIW0C5LN4b7igh6vEDvelhnT8a3or677Zk@mail.gmail.com>
	<20100621090245.GA7702@n2100.arm.linux.org.uk>
	<AANLkTimHuNuaVrRqPMiLpItBNgBeW3Cdqg6hBYT1DEpl@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.1006211131170.24097@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 21 Jun 2010, Eric Miao wrote:

> On Mon, Jun 21, 2010 at 5:02 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > The same behaviour seems sensible to apply to the other class
> > functions as well - allow platforms to override the class
> > version, and leave the replacement platform function responsible
> > for calling the class if that's what it needs to do.
> >
> 
> Yep, that's a good idea, and actually was as my first version. Yet my
> concern is this doesn't easily fit for the class data, i.e., allow the
> machine specific data to override the class data like below:
> 
> 	if (valid_value(mdesc->phys_io))
> 		use(mdesc->phys_io);
> 	else
> 		use(mdesc->class->phys_io);
> 
> but since phys_io could be valid for value zero (as if not explicitly
> initialized), so we may end up defining like below to allow use of the
> default class values:
> 
> MACHINE_START(....)
> 	.phys_io	= INVALID_ADDRESS,
> 	.io_pg_offst	= INVALID_ADDRESS,
> 	....
> MACHINE_END

No, please don't do that.  This is horribly ugly.

And in fact I would actually be highly surprised if 0 was a sensible 
value to use for either of those fields anyway.  No SOCs I know about 
has its IO at physical address0, and we're even less likely to remap 
them at virtual address 0 either.  So having 0 meaning uninitialized 
makes perfect sense in practice.


Nicolas
