From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Tue, 03 May 2016 12:13:33 +0100
Subject: [RFC PATCH] arm64: Make arch_randomize_brk avoid stack area
In-Reply-To: <CAGXu5jJKDE_pLCxy-FF7PN5+YC7wyvpQ_9DTDGqHuk+tb1mvJA@mail.gmail.com>
References: <1461848638.2848.19.camel@linaro.org>
 <1461853042.2848.24.camel@linaro.org>
 <CAGXu5jJKDE_pLCxy-FF7PN5+YC7wyvpQ_9DTDGqHuk+tb1mvJA@mail.gmail.com>
Message-ID: <1462274013.2862.46.camel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2016-05-02 at 12:34 -0700, Kees Cook wrote:
> On Thu, Apr 28, 2016 at 7:17 AM, Jon Medhurst (Tixy) <tixy@linaro.org> wrote:
[...]

> >  arch/arm64/kernel/process.c | 24 ++++++++++++++++++------
> >  1 file changed, 18 insertions(+), 6 deletions(-)
> >
> > diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> > index 07c4c53..7e0f404 100644
> > --- a/arch/arm64/kernel/process.c
> > +++ b/arch/arm64/kernel/process.c
> > @@ -434,13 +434,25 @@ unsigned long arch_align_stack(unsigned long sp)
> >         return sp & ~0xf;
> >  }
> >
> > -static unsigned long randomize_base(unsigned long base)
> > +unsigned long arch_randomize_brk(struct mm_struct *mm)
> >  {
> > +       unsigned long base = mm->brk;
> >         unsigned long range_end = base + (STACK_RND_MASK << PAGE_SHIFT) + 1;
> 
> This looks wrong. Shouldn't it be (STACK_RND_MASK + 1) << PAGE_SHIFT ?

That value is the same as before my changes and it matches the gap left
for stack randomisation in arch/arm64/mm/mmap.c

> 
> STACK_RND_MASK is 0x7ff (32-bit) or 0x3ffff (64-bit):
> 
> #define STACK_RND_MASK                  (test_thread_flag(TIF_32BIT) ? \
>                                                 0x7ff >> (PAGE_SHIFT - 12) : \
>                                                 0x3ffff >> (PAGE_SHIFT - 12))
> 
> (4K paged PAGE_SHIFT is 12)
> 
> So the correct offset max would be 0x800000 (32-bit) and 0x40000000
> (64-bit), instead of
> 0x7ff0001 and 0x3ffff0001.

It seems to me there isn't a 'correct' and 'incorrect' range to use here
and that randomising brk is not directly related to stack randomisation,
they just have similar requirements and constraints.

Anyway, for stack randomisation, in fs/binfmt_elf.c,
randomize_stack_top() has

		random_variable = get_random_long();
		random_variable &= STACK_RND_MASK;
		random_variable <<= PAGE_SHIFT;

so stack top can be randomised by adding a number from zero to
(STACK_RND_MASK << PAGE_SHIFT) inclusive. As the end value passed to
randomize_range() is exclusive, then adding one to the last permissible
value seems the like the right, I.e. arm64's usage of

  (STACK_RND_MASK << PAGE_SHIFT) + 1

for brk is 'correct' in that it's consistent with what happens to the
stack. Though the different functions align values to pages@different
stages, so possibly neither that nor 

  (STACK_RND_MASK + 1)  << PAGE_SHIFT

when used for brk, would be the same as the stack code.


> Even with that correction, this looks wrong for 32-bit, which uses
> 0x2000000 natively:
> 
> unsigned long arch_randomize_brk(struct mm_struct *mm)
> {
>         unsigned long range_end = mm->brk + 0x02000000;
>         return randomize_range(mm->brk, range_end, 0) ? : mm->brk;
> }
> 
> Seems like arm64 compat is using 4 times less entropy than native arm?
> (Note that STACK_RND_MASK is correct for arm64 compat: this matches
> the default in fs/binfmt_elf.c that arm uses. It just seems like the
> brk randomization is accidentally too small on arm64 compat since arm
> uses a fixed value unrelated to stack randomization.)
> 
> 0x02000000 arm native
> 0x00800000 arm64 compat  <- bug?
> 0x40000000 arm64

Well, it's a difference for which there probably isn't a good reason,
don't know if people would call it a bug.

As changing the range of values used for randomisation seems like a
separate issue I won't include any changes for that in my patch for
getting brk to avoid the stack.

-- 
Tixy
