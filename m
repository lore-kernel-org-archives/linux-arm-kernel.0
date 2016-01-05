From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 5 Jan 2016 09:38:11 +0100
Subject: [linux-next PATCH] arm64: fix kernel crash with 48-bit VA and
 64KB granule
In-Reply-To: <20160105083533.GD13942@arm.org>
References: <1451960299-14123-1-git-send-email-dennis.chen@arm.com>
 <CAKv+Gu-pz8rA2EfU6NwCndmoYneOjYUt8_PodTdZkepV3cRXJQ@mail.gmail.com>
 <20160105083533.GD13942@arm.org>
Message-ID: <CAKv+Gu9Q3CmC37dL3o+hcBeG-NJ7+bkOiLQihirje4YbazizJQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 January 2016 at 09:35, Dennis Chen <dennis.chen@arm.com> wrote:
> On Tue, Jan 05, 2016 at 08:36:39AM +0100, Ard Biesheuvel wrote:
>> On 5 January 2016 at 03:18, Dennis Chen <dennis.chen@arm.com> wrote:
>> > The commit 3400749b5a22 ("arm64/efi: refactor EFI init and runtime
>> > code for reuse by 32-bit ARM") uses pgd_alloc() to allocate space for
>> > efi_mm.pgd while not the static efi_pgd[], since this function will be
>> > called with early_initcall, which results in the pgd_cache used by
>> > pgd_alloc() has not been initialized yet, kernel will hang in this
>> > case. This patch is trying to make the pgd_cache_init() called before
>> > arm_enable_runtime_services() by changing its core_initcall to
>> > early_initcall.
>> >
>> > Signed-off-by: Dennis Chen <dennis.chen@arm.com>
>> > Tested-by: Sudeep Holla <sudeep.holla@arm.com>
>> >
>> > Cc: Will Deacon <will.deacon@arm.com>
>> > Cc: Catalin Marinas <catalin.marinas@arm.com>
>> > Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> > Cc: Sudeep Holla <sudeep.holla@arm.com>
>> > ---
>> >  arch/arm64/mm/pgd.c | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/arch/arm64/mm/pgd.c b/arch/arm64/mm/pgd.c
>> > index cb3ba1b..859a788 100644
>> > --- a/arch/arm64/mm/pgd.c
>> > +++ b/arch/arm64/mm/pgd.c
>> > @@ -56,4 +56,4 @@ static int __init pgd_cache_init(void)
>> >                                               SLAB_PANIC, NULL);
>> >         return 0;
>> >  }
>> > -core_initcall(pgd_cache_init);
>> > +early_initcall(pgd_cache_init);
>>
>>
>> Hello all,
>>
>> Apologies for not spotting this before sending it out.
>>
>> The issue only occurs when PGD_SIZE != PAGE_SIZE, which is why I did
>> not see it myself. I only tested with 4k/39-bits and 64k/42-bits IIRC,
>> since the series this is part of primarily concerns ARM not arm64.
>>
>> Anyway, shuffling init ordering is my least favorite way of fixing
>> bugs. Since only ARM requires pgd_alloc() (for the kernel mappings),
>> we could also simply factor out pgd_alloc() into efi_pgd_alloc(), and
>> define it to mean '__get_free_page(PGALLOC_GFP)' on arm64.
>>
>>
> Ard,
>
> Both arm and arm64 provide pgd_alloc(), I don't think it's a good idea to create
> another efi_pgd_alloc() used by efi only, which looks more like a temp workaround.
> Plus, for 64KB page granule when VA = 48bit, the PGD_SIZE = 0x200, it doesn't make
> sense to get an entire page as the space for the efi.pgd. Changing the init order
> sequence is a reasonable way to fix it unless you can see some potential issues there.
>

Well, since arm_enable_runtime_services() is an early_initcall()
itself, how are you guaranteeing the ordering between the two? Link
order?
