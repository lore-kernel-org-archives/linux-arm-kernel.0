From: tony@atomide.com (Tony Lindgren)
Date: Fri, 30 Apr 2010 18:37:51 -0700
Subject: [PATCH 02/11] omap2/3: Fix DEBUG_LL for omap zoom2/3
In-Reply-To: <87sk6c8osn.fsf@deeprootsystems.com>
References: <20100430202603.25812.41834.stgit@baageli.muru.com>
	<20100430203349.25812.64659.stgit@baageli.muru.com>
	<87sk6cirt0.fsf@deeprootsystems.com>
	<20100430210216.GI29604@atomide.com>
	<87vdb8hc2d.fsf@deeprootsystems.com>
	<FCCFB4CDC6E5564B9182F639FC3560870304E80F5F@dbde02.ent.ti.com>
	<87y6g4d2ic.fsf@deeprootsystems.com>
	<20100430233002.GJ29604@atomide.com>
	<87sk6c8osn.fsf@deeprootsystems.com>
Message-ID: <20100501013751.GL29604@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kevin Hilman <khilman@deeprootsystems.com> [100430 17:05]:
> Tony Lindgren <tony@atomide.com> writes:
> 
> > * Kevin Hilman <khilman@deeprootsystems.com> [100430 14:56]:
> >> "Pandita, Vikram" <vikram.pandita@ti.com> writes:
> >> >
> >> > So for Tony's approach to work, .phys_io/.io_pg_offset continued to
> >> > have 0x4800000 based mapping and for external uart zoom3 port,
> >> > create this extra mapping.
> >> >
> >> > So find a better way from compressed.S to pass the uart number to
> >> > kernel, and we can solve the problem.
> >> 
> >> Ah, yet another reason to use a memory location instead of UART1 SCR
> >> to pass the UART info (c.f. [1])
> >
> > That should work if we don't need to access any L4 registers
> > early on before .map_io.
> 
> I'd say if we're accessing L4 regs before .map_io, it's a bug that
> needs to be fixed, but I don't think we are.  If we were, we'd notice
> a hang when !CONFIG_DEBUG_LL since the .phys_io and .io_pg_offst are
> only mapped in when CONFIG_DEBUG_LL=y.

Yeah the current approach uses both, but only when CONFIG_DEBUG_LL=y
as you noted.
 
> I think we've been using .phys_io/.io_pg_offset incorrectly in OMAP as
> an early mapping of all the IO space, when it is intended just for use
> as early UART access, indicated by the comments in head.S and the
> fact that it's only used when CONFIG_DEBUG_LL=y

That's probably just a left over from when we could map L3 and L4 with
one mapping..

Anyways, here's an experimental patch for using a memory address instead
of UART1 for storing the debug port configuration in uncompress.h.

So far only tested on n900, will give it a try also on zoom3 after
updating the zoom3 related patch.

Now the real question is: Is it safe to use the fixed memory address?

#define OMAP_UART_INFO	(PHYS_OFFSET + 0x3ff8)

Also, another thing that needs to be checked is what happens if nothing
calls printk early and the debug port address configuration is not
set early.. Needs to be tested by adding printascii call only later
on.

Regards,

Tony
