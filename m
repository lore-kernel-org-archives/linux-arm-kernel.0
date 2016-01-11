From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 11 Jan 2016 17:21:01 +0000
Subject: [PATCH v3 04/21] arm64: decouple early fixmap init from linear
 mapping
In-Reply-To: <CAKv+Gu-SkF3Tf496meuhuy63AKvp7Sq=0BdnwsL1Eh+K=3Yd5w@mail.gmail.com>
References: <1452518355-4606-1-git-send-email-ard.biesheuvel@linaro.org>
 <1452518355-4606-5-git-send-email-ard.biesheuvel@linaro.org>
 <20160111160906.GO6499@leverpostej>
 <CAKv+Gu8KbcJEfpjRMpaQHcsDo0ziv-2xmWowE9Syn_8pOX0WTw@mail.gmail.com>
 <20160111162737.GQ6499@leverpostej>
 <20160111165103.GA29503@leverpostej>
 <CAKv+Gu8HJsz9tg7AQV2fek9xiMbFkbsDSoHRGGfYg0uJDWCkZQ@mail.gmail.com>
 <CAKv+Gu-SkF3Tf496meuhuy63AKvp7Sq=0BdnwsL1Eh+K=3Yd5w@mail.gmail.com>
Message-ID: <20160111172100.GA6105@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 11, 2016 at 06:15:56PM +0100, Ard Biesheuvel wrote:
> On 11 January 2016 at 18:08, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> > On 11 January 2016 at 17:51, Mark Rutland <mark.rutland@arm.com> wrote:
> >> Sorry,  I'm gonig to change my mind on that again. I think using
> >> p?d_offset_kimg is preferable. e.g.
> >>
> >> static inline pud_t * fixmap_pud(unsigned long addr)
> >> {
> >>         pgd_t *pgd = pgd_offset_k(addr);
> >>
> >>         BUG_ON(pgd_none(*pgd) || pgd_bad(*pgd));
> >>
> >>         return pud_offset_kimg(pgd, addr);
> >> }
> >>
> >> static inline pmd_t * fixmap_pmd(unsigned long addr)
> >> {
> >>         pud_t *pud = fixmap_pud(addr);
> >>
> >>         BUG_ON(pud_none(*pud) || pud_bad(*pud));
> >>
> >>         return pmd_offset_kimg(pud, addr);
> >> }
> >>
> >> That avoids having to check CONFIG_PGTABLE_LEVELS check and perform a cast,
> >> avoids duplicating details about bm_{pud,pmd}, and keeps the existing structure
> >> so it's easier to reason about the change. I was wrong about having to pass the
> >> pgd or pud in, so callers don't need upating.
> >>
> >> From my PoV that is preferable.
> >>
> >
> > OK. I think it looks better, indeed.
> 
> ... however, this does mean we have to go through a __pa() translation
> and back just to get to the address of bm_pud/bm_pmd

True, but we only do it in the case of a one-off init function, so I
don't think we'll notice the overhead.

Mark.
