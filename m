From: pawel.moll@arm.com (Pawel Moll)
Date: Tue, 20 Sep 2011 17:16:43 +0100
Subject: DT vs ARM static mappings
In-Reply-To: <4E78A546.9040604@gmail.com>
References: <1316519479.4611.150.camel@hornet.cambridge.arm.com>
	<4E788E12.8000801@gmail.com>
	<1316527365.4611.354.camel@hornet.cambridge.arm.com>
	<4E78A546.9040604@gmail.com>
Message-ID: <1316535403.4611.534.camel@hornet.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-09-20 at 15:37 +0100, Rob Herring wrote
> > My point is that we should be able to handle _all_ of them using one
> > DT_MACHINE_START with a single compat value "arm,vexpress". The only
> > problem with this (so far) is the mapping.
> 
> Yes, you should have 1 DT_MACHINE_START, but arm,vexpress is too
> generic. You can and should have a list of compatible strings for each
> board/machine.

Our DTS has:

compatible = "arm,vexpress-v2p-ca9", "arm,vexpress";

and v2m.c:

static const char *v2m_dt_match[] __initconst = {
       "arm,vexpress",
       NULL,
};

DT_MACHINE_START(VEXPRESS_DT, "ARM Versatile Express")
       .map_io         = v2m_map_io,
       .init_early     = v2m_init_early,
       .init_irq       = v2m_init_irq,
       .timer          = &v2m_timer,
       .init_machine   = v2m_dt_init,
       .dt_compat      = v2m_dt_match,
MACHINE_END

Isn't it what you meant?

Essentially I see two ways of doing what we are discussing:

1. Two DT_MACHINE_START, one matching "arm,vexpress-legacy" with map_io
= v2m_map_io_legacy and second matching "arm,vexpress-rs1" with map_io =
v2m_map_io_rs1,

2. Single DT_MACHINE_START matching (the most generic) "arm,vexpress"
and doing (rougly) this in v2m_map_io:

of_scan_flat_dt(v2m_dt_iotable_init, NULL);

v2m_dt_iotable_init(...)
{
	if (depth != 0)
		return 0;
	if (of_flat_dt_is_compatible(node, "arm,vexpress-legacy"))
		iotable_init(v2m_io_desc_legacy);
	else (of_flat_dt_is_compatible(node, "arm,vexpress-rs1"))
		iotable_init(v2m_io_desc_rs1);
	else
		panic();
}

Neither of them seem particularly appealing... ;-)

> >> In "chosen" like the kernel command line would be the place, but I don't
> >> think that is the right approach. Chosen is really for things that
> >> change frequently and this doesn't really fall in that category.
> > 
> > Again, no argument from me here :-)
> > 
> > The question is - where should it be?
>
> Nowhere. It's an OS specific issue, not a h/w issue.

That's exactly why I didn't like this idea in the first place. This
doesn't change the fact that current infrastructure isn't really helpful
here.

> So create a mapping per peripheral rather than per chip select. Then the
> virtual address can always be the same.

As I said (see below) this is exactly what I wanted to do, but I was
defeated by the reality :-)

On Tue, 2011-09-20 at 12:51 +0100, Pawel Moll wrote: 
> > > Initially I wanted to find the mentioned devices and create individual
> > > mappings for them, so the MMIO_P2V would be still valid (if slightly
> > > "abused"), but I failed due to the problems mentioned above. And I can't
> > > delay this operation till the tree is un-flattened, as the core tile
> > > must be probed (via sysreg) in map_io (tile's specific code must be able
> > > to create its own mappings):


> >> Generally, the trend is to get rid of static mappings as much as
> >> possible. Doing that first might simplify things.
> > 
> > You can't do ioremap() before kmalloc() is up and running (correct me if
> > I am wrong), at least you can't do this in map_io. So the static mapping
> > is a must sometimes. And actually, with the latest Nico's changes:
> > 
> Correct. You can't do ioremap until init_irq. map_io and init_early are
> too early. My point was if you can delay h/w access then you can remove
> the static mappings. But yes, we generally can't remove them all. SCU
> and LL debug uart are 2 examples.

In my case it's sysreg and sysctl. There are two more users of static
mappings: timer01 and timer23, but they could at some point do ioremap()
on their own (especially with Nico's changes).

> For the short term, I would just have 2 static iotables and select the
> right one based on the board's (or motherboard's) compatible string.

Yes, as mentioned above. This doesn't help with the sysreg offset
problem though. I may just scan the flat tree looking for their
particular names and getting raw offset from their regs... Sounds like a
hack, though.

> Long term, we should look into implementing a common early DT address
> parsing function.

Well, assuming that we want to have them at all. I'm not convinced,
frankly ;-)

Pawe?
