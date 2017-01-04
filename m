From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 4 Jan 2017 13:56:44 +0000
Subject: [PATCH 15/20] ARM/hw_breakpoint: Convert to hotplug state machine
In-Reply-To: <20170103093335.GA5605@leverpostej>
References: <20161117183541.8588-1-bigeasy@linutronix.de>
 <20161117183541.8588-16-bigeasy@linutronix.de>
 <CACRpkdZE+h0+3EizLCMUr-e-4pv4w9iAatSqL8k0Ovd2iUaS8Q@mail.gmail.com>
 <CACRpkda2gdjM--LSoJTL0dvqyw796w1hMSAhUQwv9X0EPzJHig@mail.gmail.com>
 <20170102150015.GJ14217@n2100.armlinux.org.uk>
 <CACRpkdaxAPSU-XPQrgVRoBecAD1ZpVVP4qPe59af-yy11WqBQw@mail.gmail.com>
 <20170103093335.GA5605@leverpostej>
Message-ID: <20170104135644.GA29212@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 03, 2017 at 09:33:36AM +0000, Mark Rutland wrote:
> Hi,
> 
> On Mon, Jan 02, 2017 at 09:15:29PM +0100, Linus Walleij wrote:
> > On Mon, Jan 2, 2017 at 4:00 PM, Russell King - ARM Linux
> > <linux@armlinux.org.uk> wrote:
> > > On Mon, Jan 02, 2017 at 03:34:32PM +0100, Linus Walleij wrote:
> > >> in the first line of arch_hw_breakpoint_init() in
> > >> arch/arm/kernel/hw_breakpoint.c
> > >>
> > >> I suspect that is not an accepable solution ...
> > >>
> > >> It hangs at PC is at write_wb_reg+0x20c/0x330
> > >> Which is c03101dc, and looks like this in objdump -d:
> > >>
> > >> c031020c:       ee001eba        mcr     14, 0, r1, cr0, cr10, {5}
> > >> c0310210:       eaffffb3        b       c03100e4 <write_wb_reg+0x114>
> > >
> > > ... and this is several instructions after the address you mention above.
> > > Presumably c03101dc is accessing a higher numbered register?
> > 
> > Ah sorry. It looks like this:
> > 
> > c03101dc:       ee001ed0        mcr     14, 0, r1, cr0, cr0, {6}
> > c03101e0:       eaffffbf        b       c03100e4 <write_wb_reg+0x114>
> > c03101e4:       ee001ebf        mcr     14, 0, r1, cr0, cr15, {5}
> > c03101e8:       eaffffbd        b       c03100e4 <write_wb_reg+0x114>
> > c03101ec:       ee001ebe        mcr     14, 0, r1, cr0, cr14, {5}
> > c03101f0:       eaffffbb        b       c03100e4 <write_wb_reg+0x114>
> > c03101f4:       ee001ebd        mcr     14, 0, r1, cr0, cr13, {5}
> > c03101f8:       eaffffb9        b       c03100e4 <write_wb_reg+0x114>
> 
> FWIW, I was tracking an issue in this area before the holiday.
> 
> It looked like DBGPRSR.SPD is set unexpectedly over the default idle
> path (i.e. WFI), causing the (otherwise valid) register accesses above
> to be handled as undefined.
> 
> I haven't looked at the patch in detail, but I guess that it allows idle
> to occur between reset_ctrl_regs() and arch_hw_breakpoint_init().

I've just reproduced this locally on my dragonboard APQ8060.

It looks like the write_wb_reg() call that's exploding is from
get_max_wp_len(), which we call immediately after registering the
dbg_reset_online callback. Clearing DBGPRSR.SPD before the write_wb_reg() hides
the problem, so I suspect we're seeing the issue I mentioned above -- it just
so happens that we go idle in a new place.

The below hack allows boot to continue, but is not a real fix. I'm not
immediately sure what to do.

Linus, I wasn't able to get ethernet working. Do I need anything on top
of v4.10-rc2 && multi_v7_defconfig?

Thanks,
Mark.

---->8----
diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
index 188180b..a0982ab 100644
--- a/arch/arm/kernel/hw_breakpoint.c
+++ b/arch/arm/kernel/hw_breakpoint.c
@@ -302,7 +302,7 @@ int hw_breakpoint_slots(int type)
  */
 static u8 get_max_wp_len(void)
 {
-       u32 ctrl_reg;
+       u32 ctrl_reg, val;
        struct arch_hw_breakpoint_ctrl ctrl;
        u8 size = 4;
 
@@ -313,6 +313,9 @@ static u8 get_max_wp_len(void)
        ctrl.len = ARM_BREAKPOINT_LEN_8;
        ctrl_reg = encode_ctrl_reg(ctrl);
 
+       /* HACK: CLEAR SPD */
+       ARM_DBG_READ(c1, c5, 4, val);
+
        write_wb_reg(ARM_BASE_WVR, 0);
        write_wb_reg(ARM_BASE_WCR, ctrl_reg);
        if ((read_wb_reg(ARM_BASE_WCR) & ctrl_reg) == ctrl_reg)
