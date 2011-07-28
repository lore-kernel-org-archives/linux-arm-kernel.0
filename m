From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 28 Jul 2011 19:17:46 +0100
Subject: [RFC PATCH 06/17] ARM: kernel: save/restore generic infrastructure
In-Reply-To: <CAK44p23SSgg10ghS45cBuk4n1RJHCHSJVF07Ety1tgNTHri6XQ@mail.gmail.com>
References: <1310053830-23779-1-git-send-email-lorenzo.pieralisi@arm.com>
	<1310053830-23779-7-git-send-email-lorenzo.pieralisi@arm.com>
	<CAK44p23SSgg10ghS45cBuk4n1RJHCHSJVF07Ety1tgNTHri6XQ@mail.gmail.com>
Message-ID: <20110728181741.GA21241@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 28, 2011 at 05:22:38PM +0100, Amit Kachhap wrote:
> On 7 July 2011 21:20, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
> >
> > This patch provides the code infrastructure needed to maintain
> > a generic per-cpu architecture implementation of idle code.
> >
> > sr_platform.c :
> >        - code manages patchset initialization and memory management
> >
> > sr_context.c:
> >        - code initializes run-time context save/restore generic
> >          support
> >
> > sr_power.c:
> >        - provides the generic infrastructure to enter exit low
> >          power modes and communicate with Power Control Unit (PCU)
> >
> > v7 support hinges on the basic infrastructure to provide per-cpu
> > arch implementation basically through standard function pointers
> > signatures.
> >
> > Preprocessor defines include size of data needed to save/restore
> > L2 state. This define value should be moved to the respective
> > subsystem (PL310) once the patchset IF to that subsystem is settled.
> >
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > ---
> >  arch/arm/kernel/sr.h          |  162 +++++++++++++++++++++++++++++++++++++++++
> >  arch/arm/kernel/sr_context.c  |   23 ++++++
> >  arch/arm/kernel/sr_helpers.h  |   56 ++++++++++++++
> >  arch/arm/kernel/sr_platform.c |   48 ++++++++++++
> >  arch/arm/kernel/sr_power.c    |   26 +++++++
> >  5 files changed, 315 insertions(+), 0 deletions(-)
> >  create mode 100644 arch/arm/kernel/sr.h
> >  create mode 100644 arch/arm/kernel/sr_context.c
> >  create mode 100644 arch/arm/kernel/sr_helpers.h
> >  create mode 100644 arch/arm/kernel/sr_platform.c
> >  create mode 100644 arch/arm/kernel/sr_power.c
> >

[...]

> > +#ifdef CONFIG_SMP
> > +static inline void exit_coherency(void)
> > +{
> > +       unsigned int v;
> > +       asm volatile (
> > +               "mrc    p15, 0, %0, c1, c0, 1\n"
> > +               "bic    %0, %0, %1\n"
> > +               "mcr    p15, 0, %0, c1, c0, 1\n"
> > +                : "=&r" (v)
> > +                : "Ir" (0x40)
> > +                : );
> 
> The above line gives compilation error with my toolchain.
> Adding it as           : "cc");   fixes the error.
> 
>

Already fixed, with thanks,
Lorenzo
