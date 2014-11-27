From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 27 Nov 2014 13:08:28 +0100
Subject: [PATCH 1/2] ARM: tegra: irq: fix buggy usage of irq_data irq field
In-Reply-To: <5476EA0A.7090406@arm.com>
References: <1417024532-5777-1-git-send-email-marc.zyngier@arm.com>
 <1417024532-5777-2-git-send-email-marc.zyngier@arm.com>
 <20141127082836.GA19323@ulmo> <5476EA0A.7090406@arm.com>
Message-ID: <20141127120826.GA25222@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 27, 2014 at 09:08:26AM +0000, Marc Zyngier wrote:
> Hi Thierry,
> 
> On 27/11/14 08:28, Thierry Reding wrote:
> > On Wed, Nov 26, 2014 at 05:55:31PM +0000, Marc Zyngier wrote:
> >> The crazy gic_arch_extn thing that Tegra uses contains multiple
> >> references to the irq field in struct irq_data, and uses this
> >> to directly poke hardware register.
> >>
> >> But irq is the *virtual* irq number, something that has nothing
> >> to do with the actual HW irq (stored in the hwirq field). And once
> >> we put the stacked domain code in action, the whole thing explodes,
> >> as these two values are *very* different:
> > 
> > Do you have follow-up patches to use stacked domains on Tegra? I tried
> > to move this driver out to drivers/irqchip at some point and that caused
> > a bit of pain because of gic_arch_extn and probe order. At the time I
> > was told that work was in progress to provide a more generic solution
> > that could replace gic_arch_extn, which I'm assuming this stacked domain
> > code is.
> 
> I'm working on that at the moment, and things look pretty good. The only
> issue I have so far is that this piece of HW needs to become the
> top-level interrupt-parent for all devices that are currently
> interrupting on the GIC. So far, the only solution I have is a change in
> the DT. But arguably, this should have been described in DT too...

I think I had discussed this with Arnd (Cc'ed) at some point but I can't
find a link to the discussion (perhaps it was on IRC). The outcome I
think was that from the CPU's perspective the GIC would still be the
interrupt parent of the devices, whereas the LIC would become the
interrupt parent of the GIC.

Admittedly, though, everytime I think about this I start feeling dizzy,
so perhaps I'm mixing this up again.

Maybe a picture to clarify for my own sake how this works:

	             /-----\     /-----\     /-----\
	   various --|     |     |     |     |     |
	  hardware --| LIC |-----| GIC |-----| CPU |
	interrupts --|     |     |     |  |  |     |
	             \-----/     \-----/  |  \-----/
	                |                 |
	             /-----\              |  /-----\
	             |     |              |  |     |
	             | AVP |              ---| CPU |
	             |     |              .  |     |
	             \-----/              .  \-----/
	                                  .

That is, interrupts are first routed to the LIC, which will primarily be
used by the AVP. The LIC is also configured (and that's the part where
gic_arch_extn comes into play) to forward interrupts to the GIC which
will distribute them to the Cortex-AXs.

Therefore, from the CPU perspective, the interrupt-parent of devices
should still be the GIC, since that's where the interrupt numbers will
need to come from in order to set up interrupt handlers. For any of
these interrupts GIC will need to program LIC so that they are forwarded
and can be used to wake up CPUs.

Doesn't that simplify everything to just adding an interrupt-parent
property to GIC referencing LIC?

> >> root at bacon-fat:~# cat /proc/interrupts
> >>             CPU0       CPU1
> >>  16:      25801       2075       GIC  29  twd
> >>  17:          0          0       GIC  73  timer0
> >> 112:          0          0      GPIO  58  c8000600.sdhci cd
> >> 123:          0          0      GPIO  69  c8000200.sdhci cd
> >> 279:       1126          0       GIC 122  serial
> >> 281:          0          0       GIC  70  7000c000.i2c
> >> 282:          0          0       GIC 116  7000c400.i2c
> >> 283:          0          0       GIC 124  7000c500.i2c
> >> 284:        300          0       GIC  85  7000d000.i2c
> >> [...]
> >>
> >> Just replacing all instances of irq with hwirq fixes the issue.
> >>
> >> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> >> ---
> >>  arch/arm/mach-tegra/irq.c | 22 +++++++++++-----------
> >>  1 file changed, 11 insertions(+), 11 deletions(-)
> > 
> > This looks correct to me. Do you need this to base subsequent patches on
> > or shall I just take those through the Tegra tree? I'm not sure if the
> > ARM SoC maintainers will take a follow-up pull request for 3.19, so let
> > me know if there's a hurry to get this in if it's going to make stacked
> > domain code difficult to merge.
> 
> Up to you, really. The only real issue is that when the stacked domain
> code hits mainline, Tegra will stop working without this patch. -next is
> probably already broken.

I've been running next-20141126 and nothing seems obviously broken.
Perhaps the numbering doesn't change until we actually enable stacked
domains by wiring this up to the GIC?

> I'd be tempted to consider it as a fix for 3.18, as the current code is
> obviously wrong. Just let me know how you want to get it in.

That's fine with me:

Acked-by: Thierry Reding <treding@nvidia.com>

Arnd, is this anything you could pick up for 3.18?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141127/637edd5f/attachment-0001.sig>
