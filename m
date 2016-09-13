From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 13 Sep 2016 20:18:52 +0100
Subject: [PATCH v3] arm64: mm: move zero page from .bss to right before
 swapper_pg_dir
In-Reply-To: <20160913173507.GA29678@leverpostej>
References: <1473696925-26156-1-git-send-email-ard.biesheuvel@linaro.org>
 <20160913173507.GA29678@leverpostej>
Message-ID: <CAKv+Gu90AokunA3zOcNhwXsFpCpoY_juipnr3y68nefZk9Ff0w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 September 2016 at 18:35, Mark Rutland <mark.rutland@arm.com> wrote:
> Hi,
>
> On Mon, Sep 12, 2016 at 05:15:25PM +0100, Ard Biesheuvel wrote:
>> Move the statically allocated zero page from the .bss section to right
>> before swapper_pg_dir. This allows us to refer to its physical address
>> by simply reading TTBR1_EL1 (which always points to swapper_pg_dir and
>> always has its ASID field cleared), and subtracting PAGE_SIZE.
>
> It might be worth worth mentioning that we want to do this to make
> cpu_set_reserved_ttbr0() as cheap as possible for the TTBR0_SW_PAN
> stuff, as that'll mean we're calling it far more frequently.
>
>> To protect the zero page from inadvertent modification, carve out a
>> segment that covers it as well as idmap_pg_dir[], and mark it read-only
>> in both the primary and the linear mappings of the kernel.
>>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>
> Otherwise, this looks good to me, builds without warnings, and works on
> Juno and Seattle without issue even when I throw the usual set of
> problematic config options at it. Which is to say:
>
> Reviewed-by: Mark Rutland <mark.rutland@arm.com>
> Tested-by: Mark Rutland <mark.rutland@arm.com>
>

Thanks. But actually, I think it makes sense to make the first
swapper_pg_dir page read-only as well, given that it is only modified
via the fixmap, and we can trivially extend the r/o bss region to end
at 'swapper_pg_dir + PAGE_SIZE'

Thoughts?
