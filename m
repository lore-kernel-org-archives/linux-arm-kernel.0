From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 2 Nov 2012 13:03:04 +0000
Subject: [PATCH 01/15] ARM: clps711x: Load serial driver from boards
In-Reply-To: <20121102165040.09be40cce1feb5845d7e51b5@mail.ru>
References: <1351762006-27368-1-git-send-email-shc_work@mail.ru>
 <20121101122731.GS21164@n2100.arm.linux.org.uk>
 <20121102165040.09be40cce1feb5845d7e51b5@mail.ru>
Message-ID: <20121102130304.GW21164@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 02, 2012 at 04:50:40PM +0400, Alexander Shiyan wrote:
> On Thu, 1 Nov 2012 12:27:31 +0000
> Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> 
> > BOn Thu, Nov 01, 2012 at 01:26:31PM +0400, Alexander Shiyan wrote:
> > >  MACHINE_START(AUTCPU12, "autronix autcpu12")
> > >  	/* Maintainer: Thomas Gleixner */
> > >  	.atag_offset	= 0x20000,
> > > -	.init_machine	= autcpu12_init,
> > >  	.map_io		= autcpu12_map_io,
> > > +	.init_machine	= autcpu12_init,
> > >  	.init_irq	= clps711x_init_irq,
> > > -	.timer		= &clps711x_timer,
> > >  	.restart	= clps711x_restart,
> > > +	.timer		= &clps711x_timer,
> > >  MACHINE_END
> > 
> > NAK.  If you're going to sort them, arrange them in the same order as
> > in the structure declaration in mach/arch.h.  That's the order in which
> > the functions will be called.
> > 
> > IOW, changing the order of .timer to be after .restart is wrong, .restart
> > should be the last.  .timer should be immediately before .init_machine.
> > .init_irq should be immediately before .timer.
> 
> It's just sort by functionality and does not affect on operation.

Please don't dream up different sorting criteral for structures; it's a
_real_ pain if I have to go through all the platforms and change something
(which I normally do in a scripted fashion) to have each sub-architecture
choosing to do things differently.

> Original sort I will return in the next patch after applying it.

The original wasn't actually correct.  As you're touching all of these,
it would be a good time for _you_ to fix it.  Please look at
asm/mach/arch.h and ensure that all initializer fields are in the same
order as those found in the structure declaration in mach-clps711x.
Thanks.
