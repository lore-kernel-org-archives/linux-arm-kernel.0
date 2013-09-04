From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 4 Sep 2013 15:50:59 +0100
Subject: [PATCH 1/1] arm64: Align an assembler string properly
In-Reply-To: <CAC8NTUUdpUxfzn4_nrvMxj_otGmXROEKwio7DQ27BoMv0vwsAw@mail.gmail.com>
References: <CAC8NTUWvEYpugbUfZ3A54zFbS71mnChfCk2sVKUxxxWAHz+nRw@mail.gmail.com>
 <CAC8NTUUdpUxfzn4_nrvMxj_otGmXROEKwio7DQ27BoMv0vwsAw@mail.gmail.com>
Message-ID: <20130904145059.GC2369@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 04, 2013 at 06:22:44PM +0530, Radha Mohan wrote:
> Hi Catalin,
> Can you please review this?
> 
> regards,
> Radha Mohan
> 
> On Mon, Sep 2, 2013 at 4:18 PM, Radha Mohan <mohun106@gmail.com> wrote:
> > From: Corey Minyard <cminyard@mvista.com>
> >
> > Do a proper align and put it in the right section.
> >
> > Signed-off-by: Corey Minyard <cminyard@mvista.com>
> > ---
> >  arch/arm64/mm/proc.S |    3 ++-
> >  1 files changed, 2 insertions(+), 1 deletions(-)
> >
> > diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
> > index 76d8320..1f89adc 100644
> > --- a/arch/arm64/mm/proc.S
> > +++ b/arch/arm64/mm/proc.S
> > @@ -95,10 +95,11 @@ ENTRY(cpu_do_switch_mm)
> >         ret
> >  ENDPROC(cpu_do_switch_mm)
> >
> > +       .section ".rodata"
> >  cpu_name:
> >         .ascii  "AArch64 Processor"
> > -       .align
> >
> > +       .align 3

Since cpu_name is local, not referenced, and not next to anything
noteworthy (so, unlikely to be found implicitly), I wonder why it's
needed at all.

cputable.c:cpu_table just has a C string literal instead, with the same
content.

Perhaps proc.S:cpu_name is used in some other way, but I can't see it.
The kernel still builds if it is deleted.

Cheers
---Dave

> >         .section ".text.init", #alloc, #execinstr
> >
> >  /*
> > --
> > 1.7.1
> 
> _______________________________________________
> linaro-kernel mailing list
> linaro-kernel at lists.linaro.org
> http://lists.linaro.org/mailman/listinfo/linaro-kernel
