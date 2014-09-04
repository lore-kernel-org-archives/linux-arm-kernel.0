From: will.deacon@arm.com (Will Deacon)
Date: Thu, 4 Sep 2014 15:06:19 +0100
Subject: [PATCH v4 4/8] arm: use fixmap for text patching when text is RO
In-Reply-To: <CAGXu5jJJyLkw38VyZ6fuKf5k5EcQNf+Ke0G0=qZ+pc+CptvXmA@mail.gmail.com>
References: <1407949593-16121-1-git-send-email-keescook@chromium.org>
 <1407949593-16121-5-git-send-email-keescook@chromium.org>
 <20140819122933.GI23128@arm.com>
 <CAGXu5jLxqyfJtg8rR9nzOrSBSsRC6y34rG6mZ8bb=AoxbSHkWQ@mail.gmail.com>
 <CAGXu5jJ890ruLO8Nit2exMSWigSM71kfZOkLoF0DcY1viFiX_A@mail.gmail.com>
 <20140904092720.GA7156@arm.com>
 <CAGXu5jJJyLkw38VyZ6fuKf5k5EcQNf+Ke0G0=qZ+pc+CptvXmA@mail.gmail.com>
Message-ID: <20140904140619.GH7156@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 04, 2014 at 03:00:31PM +0100, Kees Cook wrote:
> On Thu, Sep 4, 2014 at 2:27 AM, Will Deacon <will.deacon@arm.com> wrote:
> > On Wed, Sep 03, 2014 at 10:43:58PM +0100, Kees Cook wrote:
> >> On Wed, Aug 20, 2014 at 5:28 AM, Kees Cook <keescook@chromium.org> wrote:
> >> > On Tue, Aug 19, 2014 at 7:29 AM, Will Deacon <will.deacon@arm.com> wrote:
> >> >> On Wed, Aug 13, 2014 at 06:06:29PM +0100, Kees Cook wrote:
> >> >>> +     set_fixmap(fixmap, page_to_phys(page));
> >> >>
> >> >> set_fixmap does TLB invalidation, right? I think that means it can block on
> >> >> 11MPCore and A15 w/ the TLBI erratum, so it's not safe to call this with
> >> >> interrupts disabled anyway.
> >> >
> >> > Oh right. Hrm.
> >> >
> >> > In an earlier version of this series set_fixmap did not perform TLB
> >> > invalidation. I wonder if this is not needed at all? (Wouldn't that be
> >> > nice...)
> >>
> >> As suspected, my tests fail spectacularly without the TLB flush.
> >> Adding WARN_ON(!irqs_disabled()) doesn't warn, so I think we're safe
> >> here. Should I leave the WARN_ON in place for clarity, or some other
> >> comments?
> >
> > I thought there was a potential call to spin_lock_irqsave right before
> > this TLB flush?
> 
> I'm not sure I understand what you mean. Should I change something
> here? It looks like irqs are disabled, so isn't this a safe code path?

My point was that it's not safe to call set_fixmap when interrupts are
disabled, because it will try to flush the TLB, and this can lock-up on
some CPUs where it needs to do something like smp_call_function.

Will
