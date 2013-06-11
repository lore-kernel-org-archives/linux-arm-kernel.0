From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 10 Jun 2013 22:41:00 -0700
Subject: [PATCH] ARM: KVM: perform save/restore of PAR
In-Reply-To: <82f4e1a74f1d50072e7b3e18e545de1e@localhost>
References: <1370627593-28882-1-git-send-email-marc.zyngier@arm.com>
 <20130607223819.GE18614@n2100.arm.linux.org.uk>
 <82f4e1a74f1d50072e7b3e18e545de1e@localhost>
Message-ID: <20130611054100.GB32686@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 08, 2013 at 10:22:41AM +0200, Marc Zyngier wrote:
> On Fri, 7 Jun 2013 23:38:19 +0100, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> 
> Hi Russell,
> 
> > On Fri, Jun 07, 2013 at 06:53:13PM +0100, Marc Zyngier wrote:
> >> @@ -37,16 +37,18 @@
> >>  #define c5_AIFSR	15	/* Auxilary Instrunction Fault Status R */
> >>  #define c6_DFAR		16	/* Data Fault Address Register */
> >>  #define c6_IFAR		17	/* Instruction Fault Address Register */
> >> -#define c9_L2CTLR	18	/* Cortex A15 L2 Control Register */
> >> -#define c10_PRRR	19	/* Primary Region Remap Register */
> >> -#define c10_NMRR	20	/* Normal Memory Remap Register */
> >> -#define c12_VBAR	21	/* Vector Base Address Register */
> >> -#define c13_CID		22	/* Context ID Register */
> >> -#define c13_TID_URW	23	/* Thread ID, User R/W */
> >> -#define c13_TID_URO	24	/* Thread ID, User R/O */
> >> -#define c13_TID_PRIV	25	/* Thread ID, Privileged */
> >> -#define c14_CNTKCTL	26	/* Timer Control Register (PL1) */
> >> -#define NR_CP15_REGS	27	/* Number of regs (incl. invalid) */
> >> +#define c7_PAR		18	/* Physical Address Register */
> >> +#define c7_PAR_high	19	/* PAR top 32 bits */
> >> +#define c9_L2CTLR	20	/* Cortex A15 L2 Control Register */
> >> +#define c10_PRRR	21	/* Primary Region Remap Register */
> >> +#define c10_NMRR	22	/* Normal Memory Remap Register */
> >> +#define c12_VBAR	23	/* Vector Base Address Register */
> >> +#define c13_CID		24	/* Context ID Register */
> >> +#define c13_TID_URW	25	/* Thread ID, User R/W */
> >> +#define c13_TID_URO	26	/* Thread ID, User R/O */
> >> +#define c13_TID_PRIV	27	/* Thread ID, Privileged */
> >> +#define c14_CNTKCTL	28	/* Timer Control Register (PL1) */
> >> +#define NR_CP15_REGS	29	/* Number of regs (incl. invalid) */
> > 
> > Umm, the fact that you've just had to renumber everything above 17
> > suggests that maybe this should have been an enum?
> 
> That would have been ideal indeed. Unfortunately, these values are
> directly used from assembly code.
> 
> One possible workaround would be to define each value in terms of the
> previous ones:
> #define c7_PAR      (c6_IFAR + 1)
> #define c7_PAR_high (c7_PAR + 1)
> #define c9_L2CTLR   (c7_PAR_high + 1)
> ...
> 
> Another possibility would be not to use these values in the assembly code,
> but instead to generate all the offsets from asm-offset.c and use that
> instead.
> 
> What do you think?
> 
I personally think generating all these lines in asm-offset.c is
overkill.  On the other hand, defining one number by way of the other is
also not beautiful.

I think we can live with this noise in the git log, as long as it's not
something happening on every release, which I doubt it is, and I prefer
that over a more complicated code base.

For the record, you don't *have* to order the reg definitions, they just
happen to be that. You *could*, theoretically, also add it at the end
of the list simply, but, yuck.

-Christoffer
