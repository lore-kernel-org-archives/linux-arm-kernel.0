From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 5 Jun 2013 12:29:13 +0100
Subject: [PATCH] ARM: zynq: wfi exit on same cpu is valid
In-Reply-To: <51AF1752.1040804@monstr.eu>
References: <1369997066-10585-1-git-send-email-sanjay.rawat@linaro.org>
 <51AC5060.80806@linaro.org> <51AC672A.5050501@monstr.eu>
 <51AC8F74.2060302@linaro.org>
 <CAP245DUsRcomDaNKbxYry39ZLCrR33SDRRAhNCdR91e17sHF-A@mail.gmail.com>
 <51ADD667.3010203@linaro.org> <20130604141017.GW18614@n2100.arm.linux.org.uk>
 <20130604141701.GX18614@n2100.arm.linux.org.uk> <51AF1752.1040804@monstr.eu>
Message-ID: <20130605112913.GD18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 05, 2013 at 12:47:46PM +0200, Michal Simek wrote:
> On 06/04/2013 04:17 PM, Russell King - ARM Linux wrote:
> > And yes, indeed, zynq can control the secondary CPU:
> > 
> > void zynq_slcr_cpu_start(int cpu)
> > {
> >         /* enable CPUn */
> >         writel(SLCR_A9_CPU_CLKSTOP << cpu,
> >                zynq_slcr_base + SLCR_A9_CPU_RST_CTRL);
> >         /* enable CLK for CPUn */
> >         writel(0x0 << cpu, zynq_slcr_base + SLCR_A9_CPU_RST_CTRL);
> > }
> > 
> > void zynq_slcr_cpu_stop(int cpu)
> > {
> >         /* stop CLK and reset CPUn */
> >         writel((SLCR_A9_CPU_CLKSTOP | SLCR_A9_CPU_RST) << cpu,
> >                zynq_slcr_base + SLCR_A9_CPU_RST_CTRL);
> > }
> > 
> > So there's no need for the pen.  There's no need for the low power crap
> > in hotplug.c, there's no need for the pen in hotplug.c.  You just arrange
> > for the secondary CPU to have its clock stopped and reset when it is
> > taken offline.
> > 
> > Hotplugging a CPU back in _should_ be no different from its initial
> > bringup into the kernel.
> 
> I have tested that and cpu_die code is performed on cpu which
> should die.
> And simple calling zynq_slcr_cpu_stop() on cpu which should die
> just doesn't work.
> There is probably any expectation which I can't see.

Have you checked whether the CPU to die can write to this register to
stop its own clock and reset itself?  Maybe you need a wfi() after
writing to that register to trigger the hardware to shutdown the CPU?

It's also entirely possible that you need some other CPU to do those
steps while the CPU to die spins in a loop or a wfi or something like
that.  You can hook into that via the cpu_kill() callback, which will
have the CPU which is to die as its argument.

Without knowing how your hardware works, it's very difficult to be able
to positively point you in an appropriate direction, but the fact that
it's allegedly possible to turn the clock off and place the secondary
CPU in reset means that this should be possible somehow.
