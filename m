From: will.deacon@arm.com (Will Deacon)
Date: Wed, 4 Jan 2017 14:32:06 +0000
Subject: [PATCH 15/20] ARM/hw_breakpoint: Convert to hotplug state machine
In-Reply-To: <20170104135644.GA29212@leverpostej>
References: <20161117183541.8588-1-bigeasy@linutronix.de>
 <20161117183541.8588-16-bigeasy@linutronix.de>
 <CACRpkdZE+h0+3EizLCMUr-e-4pv4w9iAatSqL8k0Ovd2iUaS8Q@mail.gmail.com>
 <CACRpkda2gdjM--LSoJTL0dvqyw796w1hMSAhUQwv9X0EPzJHig@mail.gmail.com>
 <20170102150015.GJ14217@n2100.armlinux.org.uk>
 <CACRpkdaxAPSU-XPQrgVRoBecAD1ZpVVP4qPe59af-yy11WqBQw@mail.gmail.com>
 <20170103093335.GA5605@leverpostej>
 <20170104135644.GA29212@leverpostej>
Message-ID: <20170104143205.GG18193@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 04, 2017 at 01:56:44PM +0000, Mark Rutland wrote:
> On Tue, Jan 03, 2017 at 09:33:36AM +0000, Mark Rutland wrote:
> > On Mon, Jan 02, 2017 at 09:15:29PM +0100, Linus Walleij wrote:
> > > On Mon, Jan 2, 2017 at 4:00 PM, Russell King - ARM Linux
> > > <linux@armlinux.org.uk> wrote:
> > > > On Mon, Jan 02, 2017 at 03:34:32PM +0100, Linus Walleij wrote:
> > > >> in the first line of arch_hw_breakpoint_init() in
> > > >> arch/arm/kernel/hw_breakpoint.c
> > > >>
> > > >> I suspect that is not an accepable solution ...
> > > >>
> > > >> It hangs at PC is at write_wb_reg+0x20c/0x330
> > > >> Which is c03101dc, and looks like this in objdump -d:
> > > >>
> > > >> c031020c:       ee001eba        mcr     14, 0, r1, cr0, cr10, {5}
> > > >> c0310210:       eaffffb3        b       c03100e4 <write_wb_reg+0x114>
> > > >
> > > > ... and this is several instructions after the address you mention above.
> > > > Presumably c03101dc is accessing a higher numbered register?
> > > 
> > > Ah sorry. It looks like this:
> > > 
> > > c03101dc:       ee001ed0        mcr     14, 0, r1, cr0, cr0, {6}
> > > c03101e0:       eaffffbf        b       c03100e4 <write_wb_reg+0x114>
> > > c03101e4:       ee001ebf        mcr     14, 0, r1, cr0, cr15, {5}
> > > c03101e8:       eaffffbd        b       c03100e4 <write_wb_reg+0x114>
> > > c03101ec:       ee001ebe        mcr     14, 0, r1, cr0, cr14, {5}
> > > c03101f0:       eaffffbb        b       c03100e4 <write_wb_reg+0x114>
> > > c03101f4:       ee001ebd        mcr     14, 0, r1, cr0, cr13, {5}
> > > c03101f8:       eaffffb9        b       c03100e4 <write_wb_reg+0x114>
> > 
> > FWIW, I was tracking an issue in this area before the holiday.
> > 
> > It looked like DBGPRSR.SPD is set unexpectedly over the default idle
> > path (i.e. WFI), causing the (otherwise valid) register accesses above
> > to be handled as undefined.
> > 
> > I haven't looked at the patch in detail, but I guess that it allows idle
> > to occur between reset_ctrl_regs() and arch_hw_breakpoint_init().
> 
> I've just reproduced this locally on my dragonboard APQ8060.
> 
> It looks like the write_wb_reg() call that's exploding is from
> get_max_wp_len(), which we call immediately after registering the
> dbg_reset_online callback. Clearing DBGPRSR.SPD before the write_wb_reg() hides
> the problem, so I suspect we're seeing the issue I mentioned above -- it just
> so happens that we go idle in a new place.

When you say "go idle", are we just executing a WFI, or is the power
controller coming into play and we're actually powering down the non-debug
logic? In the case of the latter, the PM notifier should clear SPD in
reset_ctrl_regs, so this sounds like a hardware bug where the SPD bit is
set unconditionally on WFI.

In that case, this code has always been dodgy -- what happens if you try
to use hardware breakpoints in GDB in the face of WFI-based idle?

> The below hack allows boot to continue, but is not a real fix. I'm not
> immediately sure what to do.

If it's never worked, I suggest we blacklist the MIDR until somebody from
Qualcomm can help us further.

Will
