From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 5 Sep 2013 10:05:34 +0100
Subject: [PATCH 1/1] arm64: Align an assembler string properly
In-Reply-To: <20130904145059.GC2369@localhost.localdomain>
References: <CAC8NTUWvEYpugbUfZ3A54zFbS71mnChfCk2sVKUxxxWAHz+nRw@mail.gmail.com>
 <CAC8NTUUdpUxfzn4_nrvMxj_otGmXROEKwio7DQ27BoMv0vwsAw@mail.gmail.com>
 <20130904145059.GC2369@localhost.localdomain>
Message-ID: <20130905090534.GC11887@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 04, 2013 at 03:50:59PM +0100, Dave P Martin wrote:
> On Wed, Sep 04, 2013 at 06:22:44PM +0530, Radha Mohan wrote:
> > Hi Catalin,
> > Can you please review this?
> > 
> > regards,
> > Radha Mohan
> > 
> > On Mon, Sep 2, 2013 at 4:18 PM, Radha Mohan <mohun106@gmail.com> wrote:
> > > From: Corey Minyard <cminyard@mvista.com>
> > >
> > > Do a proper align and put it in the right section.
> > >
> > > Signed-off-by: Corey Minyard <cminyard@mvista.com>
> > > ---
> > >  arch/arm64/mm/proc.S |    3 ++-
> > >  1 files changed, 2 insertions(+), 1 deletions(-)
> > >
> > > diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
> > > index 76d8320..1f89adc 100644
> > > --- a/arch/arm64/mm/proc.S
> > > +++ b/arch/arm64/mm/proc.S
> > > @@ -95,10 +95,11 @@ ENTRY(cpu_do_switch_mm)
> > >         ret
> > >  ENDPROC(cpu_do_switch_mm)
> > >
> > > +       .section ".rodata"
> > >  cpu_name:
> > >         .ascii  "AArch64 Processor"
> > > -       .align
> > >
> > > +       .align 3
> 
> Since cpu_name is local, not referenced, and not next to anything
> noteworthy (so, unlikely to be found implicitly), I wonder why it's
> needed at all.
> 
> cputable.c:cpu_table just has a C string literal instead, with the same
> content.
> 
> Perhaps proc.S:cpu_name is used in some other way, but I can't see it.
> The kernel still builds if it is deleted.

I replied couple of days ago but the SMTP server was playing tricks, so
still not sure whether it is delayed or dropped. Anyway, what I said
was:

  Oh, we still have this in proc.S. I moved it long time ago to
  arch/arm64/kernel/cputable.c but forgot about this. It compiles fine
  after removing it completely.

And I already pushed a patch to -next removing it (and it will make it
to mainline shortly.

Thanks.

-- 
Catalin
