From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 30 Nov 2017 09:30:13 +0000
Subject: kasan: false use-after-scope warnings with KCOV
In-Reply-To: <CACT4Y+YTeLeUPRF=nsJFn-1wXux+yWCcbjmdcVQQFhXHXdY9YQ@mail.gmail.com>
References: <20171128123555.mo4ikj2ru6mkibwo@lakrids.cambridge.arm.com>
 <CACT4Y+Z2VhaDiFdg3aoi5uEsX7M+5-XMGH4PApys=qXKSMVUFg@mail.gmail.com>
 <20171128141355.3pwgzfhji32lehf2@lakrids.cambridge.arm.com>
 <20171128152405.vkwxdbkbuokjt2hv@lakrids.cambridge.arm.com>
 <CACT4Y+YTeLeUPRF=nsJFn-1wXux+yWCcbjmdcVQQFhXHXdY9YQ@mail.gmail.com>
Message-ID: <20171130093013.kvzmczmcramwq2i6@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 28, 2017 at 06:52:32PM +0100, Dmitry Vyukov wrote:
> On Tue, Nov 28, 2017 at 4:24 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> >> > > As a heads-up, I'm seeing a number of what appear to be false-positive
> >> > > use-after-scope warnings when I enable both KCOV and KASAN (inline or outline),
> >> > > when using the Linaro 17.08 GCC7.1.1 for arm64. So far I haven't spotted these
> >> > > without KCOV selected, and I'm only seeing these for sanitize-use-after-scope.
> >> > >
> >> > > The reports vary depending on configuration even with the same trigger. I'm not
> >> > > sure if it's the reporting that's misleading, or whether the detection is going
> >> > > wrong.
> >
> >> ... it looks suspiciously like something is setting up non-zero shadow
> >> bytes, but not zeroing them upon return.
> >
> > It looks like this is the case.
> >
> > The hack below detects leftover poison on an exception return *before*
> > the false-positive warning (example splat at the end of the email). With
> > scripts/Makefile.kasan hacked to not pass
> > -fsanitize-address-use-after-scope, I see no leftover poison.
> >
> > Unfortunately, there's not enough information left to say where exactly
> > that happened.
> >
> > Given the report that Andrey linked to [1], it looks like the compiler
> > is doing something wrong, and failing to clear some poison in some
> > cases. Dennis noted [2] that this appears to be the case where inline
> > functions are called in a loop.
> >
> > It sounds like this is a general GCC 7.x problem, on both x86_64 and
> > arm64. As we don't have a smoking gun, it's still possible that
> > something else is corrupting the shadow, but it seems unlikely.
> 
> We use gcc 7.1 extensively on x86_64 and have not seen any problems.

FWIW, it looks like ASAN does go wrong on x86 under some conditions:

https://lkml.kernel.org/r/20171129175430.GA58181 at big-sky.attlocal.net

I note that in all cases reported so far, there's a GCC plugin involved,
so perhaps there's some bad interaction between the compiler passes.

Thanks,
Mark.
