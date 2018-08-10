From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 10 Aug 2018 11:28:52 +0100
Subject: [PATCH v2] arm64: Trap WFI executed in userspace
In-Reply-To: <a71ad7e3-8584-36b2-3912-dac3c38db204@arm.com>
References: <20180810091939.2773-1-marc.zyngier@arm.com>
 <a71ad7e3-8584-36b2-3912-dac3c38db204@arm.com>
Message-ID: <86r2j6plaz.wl-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 10 Aug 2018 10:43:13 +0100,
Robin Murphy <robin.murphy@arm.com> wrote:
> 
> On 10/08/18 10:19, Marc Zyngier wrote:
> > It recently came to light that userspace can execute WFI, and that
> > the arm64 kernel doesn trap this event. This sounds rather benign,
> 
>                         't

Damn! Catalin had the same remark on v1, and I missed it.

> 
> > but the kernel should decide when it wants to wait for an interrupt,
> > and not userspace.
> > 
> > Let's trap WFI and immediately return after having skipped the
> > instruction. This effectively makes WFI a rather expensive NOP.
> 
> ...which is still a perfectly valid behaviour, given that it's a
> hint. That's fine by me :)
> 
> > Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> > ---
> >   arch/arm64/include/asm/esr.h    |  4 ++++
> >   arch/arm64/include/asm/sysreg.h |  4 ++--
> >   arch/arm64/kernel/entry.S       |  1 +
> >   arch/arm64/kernel/traps.c       | 11 +++++++++++
> >   4 files changed, 18 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
> > index ce70c3ffb993..9a2b6cee4e2b 100644
> > --- a/arch/arm64/include/asm/esr.h
> > +++ b/arch/arm64/include/asm/esr.h
> > @@ -137,6 +137,7 @@
> >   #define ESR_ELx_CV		(UL(1) << 24)
> >   #define ESR_ELx_COND_SHIFT	(20)
> >   #define ESR_ELx_COND_MASK	(UL(0xF) << ESR_ELx_COND_SHIFT)
> > +#define ESR_ELx_WFx_ISS_WFI	(UL(0) << 0)
> >   #define ESR_ELx_WFx_ISS_WFE	(UL(1) << 0)
> >   #define ESR_ELx_xVC_IMM_MASK	((1UL << 16) - 1)
> >   @@ -148,6 +149,9 @@
> >   #define DISR_EL1_ESR_MASK	(ESR_ELx_AET | ESR_ELx_EA | ESR_ELx_FSC)
> >     /* ESR value templates for specific events */
> > +#define ESR_ELx_WFx_MASK	(ESR_ELx_EC_MASK | 1)
> 
> Super-nit: is it worth defining ESR_ELx_WFx_ISS_TI rather than
> open-coding 1?

Could do!

Thanks,

	M.

-- 
Jazz is not dead, it just smell funny.
