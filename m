From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 9 Jan 2013 14:49:38 +0000
Subject: [PATCH v3 2/7] vexpress: Match the "arm, sp810" DT entry for
 clock initialisation
In-Reply-To: <1357732214.3222.11.camel@linaro1.home>
References: <1357309041-6192-1-git-send-email-catalin.marinas@arm.com>
 <1357309041-6192-3-git-send-email-catalin.marinas@arm.com>
 <1357666147.24697.27.camel@linaro1.home>
 <20130109113649.GB1673@arm.com>
 <1357732214.3222.11.camel@linaro1.home>
Message-ID: <20130109144938.GD1673@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 09, 2013 at 11:50:14AM +0000, Jon Medhurst (Tixy) wrote:
> On Wed, 2013-01-09 at 11:36 +0000, Catalin Marinas wrote:
> > On Tue, Jan 08, 2013 at 05:29:07PM +0000, Jon Medhurst (Tixy) wrote:
> > > On Fri, 2013-01-04 at 14:17 +0000, Catalin Marinas wrote:
> > > > Currently the clk-vexpress.c implementation relies on the vexpress code
> > > > to call the vexpress_clk_of_init() function which performs the SP810
> > > > initialisation. This patch adds "arm,sp810" to the clock DT match array
> > > > allowing of_clk_init() to call the vexpress_sp810_of_setup() function.
> > > > In case of CONFIG_ARM64, make vexpress_clk_of_init() an arch_initcall().
> > > > 
> > > > Note that SP810 requires the fixed clocks to be already registered.
> > > > Since the clock subsystem does not handle DT dependencies, the
> > > > corresponding DT entries must be in the correct order.
> > > 
> > > Which they aren't on 32-bit vexpress ;-) leading to:
> > > 
> > >   ERROR: could not get clock /smb/motherboard/iofpga at 3,00000000/sysctl at 020000:refclk(0)
> > >   ERROR: could not get clock /smb/motherboard/iofpga at 3,00000000/sysctl at 020000:timclk(1)
> > >   ------------[ cut here ]------------
> > >   WARNING: at drivers/clk/versatile/clk-vexpress.c:112 vexpress_sp810_of_setup+0x43/0xc8()
> > >   Modules linked in:
> > >   [<c0011cbd>] (unwind_backtrace+0x1/0x9c) from [<c001c1a9>] (warn_slowpath_common+0x39/0x50)
> > >   [<c001c1a9>] (warn_slowpath_common+0x39/0x50) from [<c001c1d7>] (warn_slowpath_null+0x17/0x1c)
> > >   [<c001c1d7>] (warn_slowpath_null+0x17/0x1c) from [<c05b4fab>] (vexpress_sp810_of_setup+0x43/0xc8)
> > >   [<c05b4fab>] (vexpress_sp810_of_setup+0x43/0xc8) from [<c05b4e67>] (of_clk_init+0x1f/0x34)
> > >   [<c05b4e67>] (of_clk_init+0x1f/0x34) from [<c05b515d>] (vexpress_clk_of_init+0x9/0x10)
> > >   [<c05b515d>] (vexpress_clk_of_init+0x9/0x10) from [<c05a7d2b>] (v2m_dt_timer_init+0x7/0x78)
> > >   [<c05a7d2b>] (v2m_dt_timer_init+0x7/0x78) from [<c05a4d09>] (time_init+0x11/0x20)
> > >   [<c05a4d09>] (time_init+0x11/0x20) from [<c05a24fb>] (start_kernel+0x113/0x214)
> > >   [<c05a24fb>] (start_kernel+0x113/0x214) from [<8000807f>] (0x8000807f)
> > >   ---[ end trace 1b75b31a2719ed1c ]---
> > > 
> > > After moving all "fixed-clock" nodes to be the first devices in
> > > arch/arm/boot/dts/vexpress-v2m{-rs1,}.dtsi then all appears well. (I am
> > > only trying out patches 1-3 of this set at the moment).
> > 
> > I'm waiting for Pawel's feedback (he's still on holiday). He may have a
> > better solution for the vexpress code than relying on the dts order but
> > for now the simples fix is to change the dts.
> 
> Fair enough. But if the patch series gets used as is then another patch
> will need to be added to it to fix the device-trees.

Yes, indeed. I won't break 32-bit support ;)

-- 
Catalin
