From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 5 Dec 2013 15:34:38 +0000
Subject: [PATCH v2] arm64: enable EDAC on arm64
In-Reply-To: <CAL_JsqLa-EPEnV=H1rU2Ex_h=tkZCmh2TvwAcSnbhzzvfR2oCw@mail.gmail.com>
References: <1385154308-31335-1-git-send-email-robherring2@gmail.com>
 <20131126153747.GC692@arm.com>
 <CAL_JsqJLf-kjzafMJ=wh_ZZa63SOMKy20M_5xjy9GRdofiZVCA@mail.gmail.com>
 <20131205115142.GD17165@arm.com>
 <CAL_JsqLa-EPEnV=H1rU2Ex_h=tkZCmh2TvwAcSnbhzzvfR2oCw@mail.gmail.com>
Message-ID: <20131205153438.GE974@darko.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 05, 2013 at 01:52:23PM +0000, Rob Herring wrote:
> On Thu, Dec 5, 2013 at 5:51 AM, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > On Thu, Dec 05, 2013 at 12:53:33AM +0000, Rob Herring wrote:
> >> On Tue, Nov 26, 2013 at 9:37 AM, Catalin Marinas
> >> <catalin.marinas@arm.com> wrote:
> >> > On Fri, Nov 22, 2013 at 09:05:08PM +0000, Rob Herring wrote:
> >> >> +static inline void atomic_scrub(void *va, u32 size)
> >> >> +{
> >> >> +     unsigned int *virt_addr = va;
> >> >> +     unsigned int i;
> >> >> +
> >> >> +     for (i = 0; i < size / sizeof(*virt_addr); i++, virt_addr++) {
> >> >
> >> > BTW, maybe the compiler is smart enough to drop the i but why not just
> >> > use a int *last_addr = va + size - 3; and just compare against this?
> >>
> >> Evidently, the compiler is not that smart. Here's what I ended up
> >> with. There's no need to subtract 3 that I can see:
> >>
> >> unsigned int *last_addr = va + size;
> >> for (; virt_addr < last_addr; virt_addr++) {
> >
> > The 3 thing was for size not multiple of 4. Do we have any guarantees
> > here?
> 
> Only that no one does ECC on less that 64-bit wide DDR. I'm only
> assuming 32-bit alignment and that is what all the other
> implementations assume.
> 
> If we have a non-multiple of 4 size, then we want to expand the size
> to include the partial bytes. This function is a nop effectively, so
> the fact that we may touch 1-3 extra bytes at the end does not matter.
> The only thing subtracting 3 does is mean the comparison needs to be
> '<=' instead of '<'. It would also break if you had a size of 1 or 2.
> I think what you intended was to align size, but you really need to
> add 3 and mask it to do that. But that is not necessary in my version.

What I wanted was to make sure it doesn't write more bytes than size. If
you think it's safe to write the extra bytes, than you don't need any
subtraction.

-- 
Catalin
