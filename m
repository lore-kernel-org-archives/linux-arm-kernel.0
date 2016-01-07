From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 7 Jan 2016 11:01:40 +0100
Subject: [PATCH] mm/kasan: map KASAN zero page read only
In-Reply-To: <20160107095127.GQ6301@e104818-lin.cambridge.arm.com>
References: <1452095687-18136-1-git-send-email-ard.biesheuvel@linaro.org>
 <CAPAsAGxmjF-_ZZFwtaxZsXN9g7J2sn6O0L+pBiPdARsKC_644g@mail.gmail.com>
 <CAKv+Gu9b_2WWYhgQmdnAUk0G0W3dwWXdWmpEmMtKW+=-KaJYgw@mail.gmail.com>
 <20160107095127.GQ6301@e104818-lin.cambridge.arm.com>
Message-ID: <CAKv+Gu-tvGYp7hFZgOfo3ZDkFBrEC5isXuwhZinwncpSEhkLYg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7 January 2016 at 10:51, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Wed, Jan 06, 2016 at 09:18:03PM +0100, Ard Biesheuvel wrote:
>> On 6 January 2016 at 20:48, Andrey Ryabinin <ryabinin.a.a@gmail.com> wrote:
>> > 2016-01-06 18:54 GMT+03:00 Ard Biesheuvel <ard.biesheuvel@linaro.org>:
>> >> The original x86_64-only version of KASAN mapped its zero page
>> >> read-only, but this got lost when the code was generalised and
>> >> ported to arm64, since, at the time, the PAGE_KERNEL_RO define
>> >> did not exist. It has been added to arm64 in the mean time, so
>> >> let's use it.
>> >>
>> >
>> > Read-only wasn't lost. Just look at the next line:
>> >      zero_pte = pte_wrprotect(zero_pte);
>> >
>> > PAGE_KERNEL_RO is not available on all architectures, thus it would be better
>> > to not use it in generic code.
>>
>> OK, I didn't see that. For some reason, it is not working for me on
>> arm64, though.
>
> It's because the arm64 set_pte_at() doesn't bother checking for
> !PTE_WRITE to set PTE_RDONLY when mapping kernel pages. It works fine
> for user though. That's because usually all read-only kernel mappings
> already have PTE_RDONLY set via PAGE_KERNEL_RO.
>
> We may need to change the set_pte_at logic a bit to cover the above
> case.
>

Yes, that would be useful. I had an interesting dive down a rabbit
hole yesterday due to the fact that the kasan zero page (which backs a
substantial chunk of the shadow area) was getting written to by one
mapping, and reporting KAsan errors via another.

-- 
Ard.
