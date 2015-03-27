From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 27 Mar 2015 20:53:01 +0000
Subject: Reading twd_base at run-time
In-Reply-To: <5515BEA5.6040307@free.fr>
References: <55158261.9010108@free.fr> <551586E6.3020200@arm.com>
 <5515BEA5.6040307@free.fr>
Message-ID: <20150327205301.GD4019@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 27, 2015 at 09:33:41PM +0100, Mason wrote:
> Heya,
> 
> On 27/03/2015 17:35, Marc Zyngier wrote:
> 
> > Hi Mason,
> > 
> > On 27/03/15 16:16, Mason wrote:
> >
> >> In arch/arm/kernel/smp_twd.c, twd_local_timer_register() receives a
> >> struct twd_local_timer argument, which specifies
> >>
> >>    1) the physical address of twd_base
> >>    2) the twd interrupt number
> >>
> >> There's a helper to fill out the static struct: DEFINE_TWD_LOCAL_TIMER()
> >>
> >> But it seems to me (please correct me if I'm wrong) that the address
> >> of twd_base can be read at run-time, making it one less parameter to
> >> specify by hand at compile-time (with the risk that a HW engineer
> >> change the address in the next chip with no warning).
> > 
> > The main problem with that is that said HW engineer has ^%$%^%-up
> > PERIPHBASE, and that you can't trust it. I've seen a number of these
> > kicking around.
> 
> I don't understand your remark, perhaps mine was unclear?

Mark's reply seems clear to me.

> The value of PERIPHBASE is left to the implementer, right?
> So the HW engineer picks addrA for revA, then changes his
> mind for revB, and picks addrB. No screw-up there, right?
> 
> The problem comes when said engineer forgets to notify the
> grunts in software that they're supposed to change
> #define PERIPH_BASE ADDR_A
> to
> #define PERIPH_BASE ADDR_B
> in the header files for revB.
> 
> Looking up PERIPH_BASE at run-time through cp15 solves that
> particular issue. Do you disagree?

That's one scenario.  Here's the scenario Mark is describing - one which
has real-world examples:

Hardware engineer picks address A for rev A and sets CP15 to address A.
Everything works.  Hardware engineer then picks address B for rev B, but
forgets to update CP15.  It breaks.

If it's in DT, it can be fixed.  It should be there anyway as part of
the hardware description.  DT is a description of the hardware.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
