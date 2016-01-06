From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 6 Jan 2016 08:13:24 +0100
Subject: [linux-next PATCH] arm64: fix kernel crash with 48-bit VA and
 64KB granule
In-Reply-To: <20160106061407.GA7082@arm.org>
References: <1451960299-14123-1-git-send-email-dennis.chen@arm.com>
 <CAKv+Gu-pz8rA2EfU6NwCndmoYneOjYUt8_PodTdZkepV3cRXJQ@mail.gmail.com>
 <20160105083533.GD13942@arm.org>
 <CAKv+Gu9Q3CmC37dL3o+hcBeG-NJ7+bkOiLQihirje4YbazizJQ@mail.gmail.com>
 <20160105084042.GF13942@arm.org>
 <20160105095603.GG6301@e104818-lin.cambridge.arm.com>
 <20160106061407.GA7082@arm.org>
Message-ID: <CAKv+Gu8t56rfdN1ot08BgsteaaincFek0uzoDAroefMWQ+kKEA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 January 2016 at 07:14, Dennis Chen <dennis.chen@arm.com> wrote:
> On Tue, Jan 05, 2016 at 09:56:03AM +0000, Catalin Marinas wrote:
>> On Tue, Jan 05, 2016 at 04:40:44PM +0800, Dennis Chen wrote:
>> > On Tue, Jan 05, 2016 at 09:38:11AM +0100, Ard Biesheuvel wrote:
>> > > >> On 5 January 2016 at 03:18, Dennis Chen <dennis.chen@arm.com> wrote:
>> > > >> > The commit 3400749b5a22 ("arm64/efi: refactor EFI init and runtime
>> > > >> > code for reuse by 32-bit ARM") uses pgd_alloc() to allocate space for
>> > > >> > efi_mm.pgd while not the static efi_pgd[], since this function will be
>> > > >> > called with early_initcall, which results in the pgd_cache used by
>> > > >> > pgd_alloc() has not been initialized yet, kernel will hang in this
>> > > >> > case. This patch is trying to make the pgd_cache_init() called before
>> > > >> > arm_enable_runtime_services() by changing its core_initcall to
>> > > >> > early_initcall.
>> > > >> >
>> > > >> > Signed-off-by: Dennis Chen <dennis.chen@arm.com>
>> > > >> > Tested-by: Sudeep Holla <sudeep.holla@arm.com>
>> > > >> >
>> > > >> > Cc: Will Deacon <will.deacon@arm.com>
>> > > >> > Cc: Catalin Marinas <catalin.marinas@arm.com>
>> > > >> > Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> > > >> > Cc: Sudeep Holla <sudeep.holla@arm.com>
>> > > >> > ---
>> > > >> >  arch/arm64/mm/pgd.c | 2 +-
>> > > >> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> > > >> >
>> > > >> > diff --git a/arch/arm64/mm/pgd.c b/arch/arm64/mm/pgd.c
>> > > >> > index cb3ba1b..859a788 100644
>> > > >> > --- a/arch/arm64/mm/pgd.c
>> > > >> > +++ b/arch/arm64/mm/pgd.c
>> > > >> > @@ -56,4 +56,4 @@ static int __init pgd_cache_init(void)
>> > > >> >                                               SLAB_PANIC, NULL);
>> > > >> >         return 0;
>> > > >> >  }
>> > > >> > -core_initcall(pgd_cache_init);
>> > > >> > +early_initcall(pgd_cache_init);
>> [...]
>> > > Well, since arm_enable_runtime_services() is an early_initcall()
>> > > itself, how are you guaranteeing the ordering between the two? Link
>> > > order?
>> >
>> > Link order.
>>
>> And can you explain how this works, what guarantees it gives?
>>
> You can take a look at include/asm-generic/vmlinux.ldx.h: INIT_CALLS macro,
> for the init call section, early_initcall is the first chuck in the section,
> followed by LEVEL[0-7]. For the same level, the layout order is determined
> by the link order, ARCH is always precedence over the drivers. Catalin, are
> you giving me a kernel examination? :)
>

We all know how initcalls are implemented. The question is how you are
going to ensure that the early_initcall() that initializes the PGD
cache is always invoked before the early_initcall() that creates the
UEFI runtime page tables.

And saying that the currently observed link order happens to be
correct is not good enough. We need to be sure that, even if we change
the link order, or switch to LTO at some point, things don't suddenly
break again.

-- 
Ard.
