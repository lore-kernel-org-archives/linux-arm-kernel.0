From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 16 Nov 2015 16:51:00 +0000
Subject: [PATCH v7 0/4] KASAN for arm64
In-Reply-To: <5649F783.40109@gmail.com>
References: <1444665180-301-1-git-send-email-ryabinin.a.a@gmail.com>
 <20151013083432.GG6320@e104818-lin.cambridge.arm.com>
 <5649BAFD.6030005@arm.com> <5649F783.40109@gmail.com>
Message-ID: <20151116165100.GE6556@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 16, 2015 at 06:34:27PM +0300, Andrey Ryabinin wrote:
> On 11/16/2015 02:16 PM, Suzuki K. Poulose wrote:
> > On 13/10/15 09:34, Catalin Marinas wrote:
> >> On Mon, Oct 12, 2015 at 06:52:56PM +0300, Andrey Ryabinin wrote:
> >>> Andrey Ryabinin (3):
> >>>    arm64: move PGD_SIZE definition to pgalloc.h
> >>>    arm64: add KASAN support
> >>>    Documentation/features/KASAN: arm64 supports KASAN now
> >>>
> >>> Linus Walleij (1):
> >>>    ARM64: kasan: print memory assignment
> >>
> >> Patches queued for 4.4. Thanks.
> > 
> > I get the following failure with KASAN + 16K_PAGES + 48BIT_VA, with 4.4-rc1:
> > 
> > arch/arm64/mm/kasan_init.c: In function ?kasan_early_init?:
> > include/linux/compiler.h:484:38: error: call to ?__compiletime_assert_95? declared with attribute error: BUILD_BUG_ON failed: !IS_ALIGNED(KASAN_SHADOW_END, PGDIR_SIZE)
> >   _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
> >                                       ^
> > include/linux/compiler.h:467:4: note: in definition of macro ?__compiletime_assert?
> >     prefix ## suffix();    \
> >     ^
> > include/linux/compiler.h:484:2: note: in expansion of macro ?_compiletime_assert?
> >   _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
> >   ^
> > include/linux/bug.h:50:37: note: in expansion of macro ?compiletime_assert?
> >  #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
> >                                      ^
> > include/linux/bug.h:74:2: note: in expansion of macro ?BUILD_BUG_ON_MSG?
> >   BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
> >   ^
> > arch/arm64/mm/kasan_init.c:95:2: note: in expansion of macro ?BUILD_BUG_ON?
> >   BUILD_BUG_ON(!IS_ALIGNED(KASAN_SHADOW_END, PGDIR_SIZE));
> > 
> > The problem is that the PGDIR_SIZE is (1UL << 47) with 16K+48bit, which makes
> > the KASAN_SHADOW_END unaligned(which is aligned to (1UL << (48 - 3)) ). Is the
> > alignment really needed ? Thoughts on how best we could fix this ?
> 
> Yes, it's really needed, because some code relies on this (e.g.
> clear_pgs() and kasan_init()). But it should be possible to get rid of
> this requirement.

I don't think clear_pgds() and kasan_init() are the only problems. IIUC,
kasan_populate_zero_shadow() also assumes that KASan shadow covers
multiple pgds. You need some kind of recursive writing which avoids
populating an entry which is not empty (like kasan_early_pud_populate).

-- 
Catalin
