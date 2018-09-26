From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 26 Sep 2018 17:41:50 +0200
Subject: [PATCH net-next v6 07/23] zinc: ChaCha20 ARM and ARM64
 implementations
In-Reply-To: <CAKv+Gu8ih-TsASRGqK+ST_5+EQ0=Zo-zhGCadOdGyPjucMFTCg@mail.gmail.com>
References: <20180925145622.29959-1-Jason@zx2c4.com>
 <20180925145622.29959-8-Jason@zx2c4.com>
 <CAKv+Gu9mVAfdBvOMCFqRJj+wBiWu3JVOgPZdkcdjzqSdQQ5Jrw@mail.gmail.com>
 <CAHmME9r9KppoFwwNVpzpYbU+9dCPzb7Pit+4iRa4MY_ouJBWrA@mail.gmail.com>
 <CAKv+Gu8ih-TsASRGqK+ST_5+EQ0=Zo-zhGCadOdGyPjucMFTCg@mail.gmail.com>
Message-ID: <CAKv+Gu8w74dUSEAGxxh=C6To6F=bSm8DjiExUPmh_LUyhoDLhg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 26 Sep 2018 at 16:02, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
> (+ Herbert, Thomas)
>
> On Wed, 26 Sep 2018 at 15:33, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >
> > Hi Ard,
> >
> > On Wed, Sep 26, 2018 at 10:59 AM Ard Biesheuvel
> > <ard.biesheuvel@linaro.org> wrote:
> > > > +static inline bool chacha20_arch(struct chacha20_ctx *state, u8 *dst,
> > > > +                                const u8 *src, size_t len,
> > > > +                                simd_context_t *simd_context)
> > > > +{
> > > > +#if defined(CONFIG_KERNEL_MODE_NEON)
> > > > +       if (chacha20_use_neon && len >= CHACHA20_BLOCK_SIZE * 3 &&
> > > > +           simd_use(simd_context))
> > > > +               chacha20_neon(dst, src, len, state->key, state->counter);
> > > > +       else
> > > > +#endif
> > >
> > > Better to use IS_ENABLED() here:
> > >
> > > > +       if (IS_ENABLED(CONFIG_KERNEL_MODE_NEON)) &&
> > > > +           chacha20_use_neon && len >= CHACHA20_BLOCK_SIZE * 3 &&
> > > > +           simd_use(simd_context))
> >
> > Good idea. I'll fix that up.
> >
> > >
> > > Also, this still has unbounded worst case scheduling latency, given
> > > that the outer library function passes its entire input straight into
> > > the NEON routine.
> >
> > The vast majority of crypto routines in arch/*/crypto/ follow this
> > same exact pattern, actually. I realize a few don't -- probably the
> > ones you had a hand in :) -- but I think this is up to the caller to
> > handle.
>
> Anything that uses the scatterwalk API (AEADs and skciphers) will
> handle at most a page at a time. Hashes are different, which is why
> some of them have to handle it explicitly.
>
> > I made a change so that in chacha20poly1305.c, it calls
> > simd_relax after handling each scatter-gather element, so a
> > "construction" will handle this gracefully. But I believe it's up to
> > the caller to decide on what sizes of information it wants to pass to
> > primitives. Put differently, this also hasn't ever been an issue
> > before -- the existing state of the tree indicates this -- and so I
> > don't anticipate this will be a real issue now.
>
> The state of the tree does not capture all relevant context or
> history. The scheduling latency issue was brought up very recently by
> the -rt folks on the mailing lists.
>
> > And if it becomes one,
> > this is something we can address *later*, but certainly there's no use
> > of adding additional complexity to the initial patchset to do this
> > now.
> >
>
> You are introducing a very useful SIMD abstraction, but it lets code
> run with preemption disabled for unbounded amounts of time, and so now
> is the time to ensure we get it right.
>

Actually, looking at the code again, the abstraction does appear to be
fine, it is just the chacha20 code that does not make use of it.
