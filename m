From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 24 Aug 2016 22:44:34 +0200
Subject: [PATCH v2 4/9] arm64: head.S: move KASLR processing out of
 __enable_mmu()
In-Reply-To: <20160824203609.GA1642@remoulade>
References: <1472049366-10922-1-git-send-email-ard.biesheuvel@linaro.org>
 <1472049366-10922-5-git-send-email-ard.biesheuvel@linaro.org>
 <20160824203609.GA1642@remoulade>
Message-ID: <CAKv+Gu8ixdAtV4zDbH7zT_Tkj_BRQCa9B2rdtWgXKbMcGA29dQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 August 2016 at 22:36, Mark Rutland <mark.rutland@arm.com> wrote:
> Hi,
>
> On Wed, Aug 24, 2016 at 04:36:01PM +0200, Ard Biesheuvel wrote:
>> The KASLR processing in __enable_mmu() is only used by the primary boot
>> path, and complements the processing that takes place in __primary_switch().
>> Move the two parts together, to make the code easier to understand.
>
> As a heads-up, while reviewing this I spotted an existing issue [1]. I'd meant
> to comment so when posting that patch, but in my hubris from making
> git-send-email work I forgot to do so. :/
>
> [...]
>
>> @@ -770,11 +748,11 @@ __no_granule_support:
>>  1:
>>       wfe
>>       wfi
>> -     b 1b
>> +     b       1b
>>  ENDPROC(__no_granule_support)
>
> Unrelated change? Perhaps it's worth putting all the whitespace fixup in a
> preparatory patch?
>
> [...]
>

I couldn't resist. It's the only occurrence in this series apart from #2

>> +__primary_switch:
>> +#ifdef CONFIG_RANDOMIZE_BASE
>> +     mov     x19, x0                         // preserve new SCTLR_EL1 value
>> +     mrs     x20, sctlr_el1                  // preserve old SCTLR_EL1 value
>> +#endif
>> +
>> +     adr     x27, 0f
>> +     b       __enable_mmu
>
> As we do elsewhere, it's probably worth a comment on the line with the ADR into
> x27, mentioning that __enable_mmu will branch there.
>
> ... or perhaps we should just have __enable_mmu return to the LR like a normal
> AAPCS function, place the switch routines in the idmap, and use the idiomatic
> sequence:
>
> __thing_switch:
>         bl      __enable_mmu
>         ldr     xN, =__thing
>         blr     xN
>
> [...]
>

Yes, that is more or less the point of the two subsequent patches.

>> +     /*
>> +      * If we return here, we have a KASLR displacement in x23 which we need
>> +      * to take into account by discarding the current kernel mapping and
>> +      * creating a new one.
>> +      */
>> +     msr     sctlr_el1, x20                  // disable the MMU
>> +     isb
>> +     bl      __create_page_tables            // recreate kernel mapping
>
> As per the issue I mentioned above [1], here we also need:
>
>         tlbi    vmalle1
>         dsb     nsh
>
> ... in order to avoid TLB conflicts and other issues resulting from BBM
> violations.
>

Indeed.

Thanks,
Ard.
