From: keescook@chromium.org (Kees Cook)
Date: Mon, 10 Feb 2014 09:26:28 -0800
Subject: [PATCH] ARM: mm: report both sections from PMD
In-Reply-To: <20140210104135.GD25305@arm.com>
References: <20140209221826.GA30556@www.outflux.net>
 <20140210102935.GC25305@arm.com> <20140210104135.GD25305@arm.com>
Message-ID: <CAGXu5jL0asY2L9xvnEDwBPQoWYZAVHjtG+U7nyz=JfZtXFK34A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 10, 2014 at 2:41 AM, Catalin Marinas
<catalin.marinas@arm.com> wrote:
> On Mon, Feb 10, 2014 at 10:29:35AM +0000, Catalin Marinas wrote:
>> On Sun, Feb 09, 2014 at 10:18:26PM +0000, Kees Cook wrote:
>> > diff --git a/arch/arm/mm/dump.c b/arch/arm/mm/dump.c
>> > index 1f7b1e13d945..ff1559f9200c 100644
>> > --- a/arch/arm/mm/dump.c
>> > +++ b/arch/arm/mm/dump.c
>> > @@ -264,6 +264,9 @@ static void walk_pmd(struct pg_state *st, pud_t *pud, unsigned long start)
>> >                     note_page(st, addr, 3, pmd_val(*pmd));
>> >             else
>> >                     walk_pte(st, pmd, addr);
>> > +
>> > +           if (SECTION_SIZE < PMD_SIZE && pmd_sect(*pmd))
>> > +                   note_page(st, addr + SECTION_SIZE, 3, pmd_val(pmd[1]));
>>
>> You can  use pmd_large() here as well.
>>
>> But I think this function is broken (the "for" statement not shown
>> here). The pmd_t is 32-bit with classic MMU and it uses pmd++ while the
>> address grows by PMD_SIZE (two pmd_t entries).
>
> Actually it's ok since PTRS_PER_PMD is 1, so it only goes through this
> loop once.
>
> But in your patch shouldn't you check for pmd_large(*(pmd+1))? The first
> pmd is already caught by the 'if' statement.

It wasn't clear to me what the logic should be here. If PTRS_PER_PMD
is 1, then why is there this second pmd after the first? Shouldn't
PTRS_PER_PMD be 2 if that's the case? If that's not the case, then I
figured the state of needing to report the 2nd pmd depended on the
type of the first one, so that's what I wrote instead of trying to
figure out why PTRS_PER_PMD wasn't 2.

There's clearly something I'm not understanding in here. :)

Thanks!

-Kees

-- 
Kees Cook
Chrome OS Security
