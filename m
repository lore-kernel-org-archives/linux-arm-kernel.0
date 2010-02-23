From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 23 Feb 2010 19:02:54 +0000
Subject: [RFC PATCH 05/12] arm: mm: retry on QSD icache parity errors
In-Reply-To: <1266950168.24069.1.camel@c-dwalke-linux.qualcomm.com>
References: <1264719577-5436-6-git-send-email-dwalker@codeaurora.org>
	<1264763482.4242.50.camel@pc1117.cambridge.arm.com>
	<1266950168.24069.1.camel@c-dwalke-linux.qualcomm.com>
Message-ID: <20100223190254.GB26434@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 23, 2010 at 10:36:08AM -0800, Daniel Walker wrote:
> On Fri, 2010-01-29 at 11:11 +0000, Catalin Marinas wrote:
> > On Thu, 2010-01-28 at 22:59 +0000, Daniel Walker wrote:
> > > diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
> > > index 10e0680..bea3e75 100644
> > > --- a/arch/arm/mm/fault.c
> > > +++ b/arch/arm/mm/fault.c
> > [...]
> > >  static struct fsr_info {
> > >         int     (*fn)(unsigned long addr, unsigned int fsr, struct pt_regs *regs);
> > >         int     sig;
> > > @@ -479,7 +513,7 @@ static struct fsr_info {
> > >         { do_bad,               SIGBUS,  0,             "unknown 19"                       },
> > >         { do_bad,               SIGBUS,  0,             "lock abort"                       }, /* xscale */
> > >         { do_bad,               SIGBUS,  0,             "unknown 21"                       },
> > > -       { do_bad,               SIGBUS,  BUS_OBJERR,    "imprecise external abort"         }, /* xscale */
> > > +       { do_imprecise_ext,     SIGBUS,  BUS_OBJERR,    "imprecise external abort"         }, /* xscale */
> > 
> > Can you not use hook_fault_code() and move the do_imprecise_ext() to a
> > platform-specific file (under arch/arm/mach-* maybe)?
> > 
> 
> How do you mean? I'm not sure how we would move this into
> arch/arm/mach- ..

Err, exactly as Catalin says.  Use hook_fault_code() to hook into the
fault table at run time, just like platforms which have to handle
imprecise exceptions on PCI and the alignment fault handler do.
