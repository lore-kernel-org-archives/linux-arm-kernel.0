From: will.deacon@arm.com (Will Deacon)
Date: Mon, 24 Apr 2017 18:34:14 +0100
Subject: [PATCH] arm64: Add ASM modifier for xN register operands
In-Reply-To: <CAKv+Gu_Ms73qfFFjmhkwF9Rh2jBM6Cx9LfuSHPUnXv0GTR1z7w@mail.gmail.com>
References: <20170420183053.718-1-mka@chromium.org>
 <20170424170009.GT12323@arm.com>
 <CAKv+Gu_Ms73qfFFjmhkwF9Rh2jBM6Cx9LfuSHPUnXv0GTR1z7w@mail.gmail.com>
Message-ID: <20170424173413.GW12323@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 24, 2017 at 06:22:51PM +0100, Ard Biesheuvel wrote:
> On 24 April 2017 at 18:00, Will Deacon <will.deacon@arm.com> wrote:
> > Hi Matthias,
> >
> > On Thu, Apr 20, 2017 at 11:30:53AM -0700, Matthias Kaehlcke wrote:
> >> Many inline assembly statements don't include the 'x' modifier when
> >> using xN registers as operands. This is perfectly valid, however it
> >> causes clang to raise warnings like this:
> >>
> >> warning: value size does not match register size specified by the
> >>   constraint and modifier [-Wasm-operand-widths]
> >> ...
> >> arch/arm64/include/asm/barrier.h:62:23: note: expanded from macro
> >>   '__smp_store_release'
> >>     asm volatile ("stlr %1, %0"
> >
> > If I understand this correctly, then the warning is emitted when we pass
> > in a value smaller than 64-bit, but refer to %<n> without a modifier
> > in the inline asm.
> >
> > However, if that's the case then I don't understand why:
> >
> >> diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
> >> index 0c00c87bb9dd..021e1733da0c 100644
> >> --- a/arch/arm64/include/asm/io.h
> >> +++ b/arch/arm64/include/asm/io.h
> >> @@ -39,33 +39,33 @@
> >>  #define __raw_writeb __raw_writeb
> >>  static inline void __raw_writeb(u8 val, volatile void __iomem *addr)
> >>  {
> >> -     asm volatile("strb %w0, [%1]" : : "rZ" (val), "r" (addr));
> >> +     asm volatile("strb %w0, [%x1]" : : "rZ" (val), "r" (addr));
> >
> > is necessary. addr is a pointer type, so is 64-bit.
> >
> > Given that the scattergun nature of this patch implies that you've been
> > fixing the places where warnings are reported, then I'm confused as to
> > why a warning is generated for the case above.
> >
> > What am I missing?
> >
> 
> AIUI, Clang now always complains for missing register width modifiers,
> not just for placeholders that resolve to a 32-bit (or smaller)
> quantity.

Ok, in which case this patch is incomplete as there's a bunch of asm that
isn't updated (e.g. spinlock.h).

Will
