From: fu.wei@linaro.org (Fu Wei)
Date: Wed, 10 Aug 2016 14:22:06 +0800
Subject: [PATCH v12] acpi, apei, arm64: APEI initial support for aarch64.
In-Reply-To: <20160804103028.GA8152@nazgul.tnic>
References: <1469782664-12611-1-git-send-email-fu.wei@linaro.org>
 <20160804094838.GB8093@nazgul.tnic> <20160804103028.GA8152@nazgul.tnic>
Message-ID: <CADyBb7syoK4_iH55gh9w8ShsZ4be3iLTeJz3g1yMCAKbYxWy1w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Borislav.

On 4 August 2016 at 18:30, Borislav Petkov <bp@suse.de> wrote:
> Tomasz's linaro address bounces, adding one I've found on lkml to CC
> instead.

Thanks for reminding me, I have added him(tn at semihalf.com) in TO list.
The dated email address(tomasz.nowicki at linaro.org) was added by "git
send-email".
I have disabled it by "--no-signed-off-by-cc"

>
> On Thu, Aug 04, 2016 at 11:48:38AM +0200, Borislav Petkov wrote:
>> On Fri, Jul 29, 2016 at 04:57:44PM +0800, fu.wei at linaro.org wrote:
>> > From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
>> >
>> > This commit provides APEI arch-specific bits for aarch64
>> >
>> > Meanwhile,
>> > (1)add a new subfunction "hest_ia32_init" for
>> > "acpi_disable_cmcff" which is used by IA-32 Architecture
>> > Corrected Machine Check (CMC).
>> > (2)move HEST type (ACPI_HEST_TYPE_IA32_CORRECTED_CHECK) checking to
>> > a generic place.
>> > (3)select HAVE_ACPI_APEI when EFI and ACPI is set on ARM64,
>> > because arch_apei_get_mem_attribute is using efi_mem_attributes on ARM64.
>> >
>> > [Fu Wei: improve && upstream]
>> >
>> > Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
>> > Tested-by: Jonathan (Zhixiong) Zhang <zjzhang@codeaurora.org>
>> > Signed-off-by: Fu Wei <fu.wei@linaro.org>
>> > Acked-by: Hanjun Guo <hanjun.guo@linaro.org>
>> > Tested-by: Tyler Baicar <tbaicar@codeaurora.org>
>> > Acked-by: Will Deacon <will.deacon@arm.com>
>> > ---
>>
>> ...
>>
>> > @@ -110,8 +111,21 @@ static inline const char *acpi_get_enable_method(int cpu)
>> >  }
>> >
>> >  #ifdef     CONFIG_ACPI_APEI
>> > +#define acpi_disable_cmcff 1
>>
>> What does that mean? ARM doesn't have firmware-first mode?
>>
>> A piece of comment please.
>>
>> >  pgprot_t arch_apei_get_mem_attribute(phys_addr_t addr);
>> > -#endif
>> > +
>> > +/*
>> > + * Despite its name, this function must still broadcast the TLB
>> > + * invalidation in order to ensure other CPUs don't up with junk
>>                                                     ^
>>                                                    end
>>
>> > + * entries as a result of speculation. Unusually, its also called in
>> > + * IRQ context (ghes_iounmap_irq) so if we ever need to use IPIs for
>> > + * TLB broadcasting, then we're in trouble here.
>> > + */
>> > +static inline void arch_apei_flush_tlb_one(unsigned long addr)
>> > +{
>> > +   flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
>> > +}
>> > +#endif /* CONFIG_ACPI_APEI */
>> >
>> >  #ifdef CONFIG_ACPI_NUMA
>> >  int arm64_acpi_numa_init(void);
>> > diff --git a/arch/x86/kernel/acpi/apei.c b/arch/x86/kernel/acpi/apei.c
>> > index c280df6..ea3046e 100644
>> > --- a/arch/x86/kernel/acpi/apei.c
>> > +++ b/arch/x86/kernel/acpi/apei.c
>>
>> ...
>>
>> > diff --git a/drivers/acpi/apei/hest.c b/drivers/acpi/apei/hest.c
>> > index 20b3fcf..792a0d9 100644
>> > --- a/drivers/acpi/apei/hest.c
>> > +++ b/drivers/acpi/apei/hest.c
>> > @@ -232,8 +243,9 @@ void __init acpi_hest_init(void)
>> >             goto err;
>> >     }
>> >
>> > -   if (!acpi_disable_cmcff)
>> > -           apei_hest_parse(hest_parse_cmc, NULL);
>> > +   rc = hest_ia32_init();
>>
>> Why do you need a separate hest_ia32_init() here?
>>
>> You can do
>>
>>       rc = apei_hest_parse(hest_parse_cmc, NULL);
>>
>> directly here AFAICT.
>>
>> > +   if (rc)
>> > +           goto err;
>> >
>> >     if (!ghes_disable) {
>> >             rc = apei_hest_parse(hest_parse_ghes_count, &ghes_count);
>> > --
>> > 2.5.5
>> >
>
> --
> Regards/Gruss,
>     Boris.
>
> ECO tip #101: Trim your mails when you reply.
>
> SUSE Linux GmbH, GF: Felix Imend?rffer, Jane Smithard, Graham Norton, HRB 21284 (AG N?rnberg)
> --



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat
