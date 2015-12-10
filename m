From: fu.wei@linaro.org (Fu Wei)
Date: Thu, 10 Dec 2015 10:02:39 +0800
Subject: [PATCH v4] acpi, apei, arm64: APEI initial support for aarch64.
In-Reply-To: <CADyBb7sLAJdiC=2UzKFsHQ=+Tfuwd6FGi80O9H+1sj70qtCiPg@mail.gmail.com>
References: <1449558183-12259-1-git-send-email-fu.wei@linaro.org>
 <20151208123433.GB404@red-moon> <5666D28C.4090305@linaro.org>
 <CADyBb7tByoke4PGZqcx_jHvgCK0xNTneod8WoVv7VmoSYii+hg@mail.gmail.com>
 <20151208140720.GA2395@red-moon>
 <CADyBb7sLAJdiC=2UzKFsHQ=+Tfuwd6FGi80O9H+1sj70qtCiPg@mail.gmail.com>
Message-ID: <CADyBb7vVaPsNZeKp=XQ0zwd-qH1mwuECCtCfkpqm0jDyFTzDcg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lorenzo,

On 9 December 2015 at 11:25, Fu Wei <fu.wei@linaro.org> wrote:
> Hi Lorenzo,
>
> On 8 December 2015 at 22:07, Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
>> On Tue, Dec 08, 2015 at 09:08:24PM +0800, Fu Wei wrote:
>>> Hi Lorenzo,
>>>
>>>
>>>
>>> On 8 December 2015 at 20:52, Hanjun Guo <hanjun.guo@linaro.org> wrote:
>>> > Hi Lorenzo,
>>> >
>>> > On 12/08/2015 08:34 PM, Lorenzo Pieralisi wrote:
>>> >>
>>> >> On Tue, Dec 08, 2015 at 03:03:03PM +0800, fu.wei at linaro.org wrote:
>>> >>>
>>> >>> From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
>>> >>
>>> >>
>>> >> [...]
>>> >>
>>> >>> +#if defined(__i386__) || defined(__x86_64__)
>>> >>>   /*
>>> >>>    * Check if firmware advertises firmware first mode. We need FF bit to
>>> >>> be set
>>> >>>    * along with a set of MC banks which work in FF mode.
>>> >>>    */
>>> >>>   static int __init hest_parse_cmc(struct acpi_hest_header *hest_hdr,
>>> >>> void *data)
>>> >>>   {
>>> >>> -       return arch_apei_enable_cmcff(hest_hdr, data);
>>> >>> +       if (!acpi_disable_cmcff)
>>> >>
>>> >>
>>> >> Why do not you define the flag above in this file (move it out of x86 -
>>> >> that's what I was aiming at in my previous reply) and remove this
>>> >> ifdeffery
>>> >> altogether (First firmware handling could apply to arm64 too according to
>>> >> specs and ACPI on arm64 guidelines) ?
>>> >
>>> >
>>> > If I understand it correctly, CMC (Corrected Machine Check) is for IA32
>>> > only, see section 18.3.2.1 IA-32 Architecture Machine Check Exception
>>> > in ACPI 6.0. for ARM64, we can use other type of error source for
>>> > firmware first handling, such as Generic Hardware Error Source, did
>>> > I miss something?
>>>
>>> yes, that is why I try to use "#if defined(__i386__) ||
>>> defined(__x86_64__)" instead of moving acpi_disable_cmcff out of x86
>>> code to here.
>>>
>>> And I thinks we also can do "arch_apei_enable_cmcff" -->
>>> "apei_enable_ia_cmcff" because that is IA32 only.
>>>
>>> Please correct me if I misunderstand something.  Thanks :-)
>>
>> No you are right, I was confused by the arch_apei_enable_cmcff __weak
>> function declaration, I am not sure that makes much sense, as you say.
>>
>
> Thanks :-)
>
>
>> Side note: I wonder if there is a way to make the TLB flushing API common
>> across architectures therefore avoiding this arch_apei_flush_tlb* churn.
>
> yes, make sense, I will think about this today , thanks for your suggestion.

I do some investigation on this "tlb" problem(actually not just tlb,
but also "get_mem_attribute") today,
I think we need to
(1)have a common API in tlbflush.h (at least for flushing one page)
across architectures(at least in x86 and arm64)
(2)use this API in drivers/acpi/apei/gest.c instead of arch_apei_flush_tlb_one
(3)delete the old function from arm64 and x86

So maybe we can have the another patchset to solve this problem, make
this patch just enable APEI for arm64 first. :-)

>
>>
>> Thanks,
>> Lorenzo
>>
>>> Great thanks for your feedback :-)
>>>
>>> >
>>> > Thanks
>>> > Hanjun
>>>
>>>
>>>
>>> --
>>> Best regards,
>>>
>>> Fu Wei
>>> Software Engineer
>>> Red Hat Software (Beijing) Co.,Ltd.Shanghai Branch
>>> Ph: +86 21 61221326(direct)
>>> Ph: +86 186 2020 4684 (mobile)
>>> Room 1512, Regus One Corporate Avenue,Level 15,
>>> One Corporate Avenue,222 Hubin Road,Huangpu District,
>>> Shanghai,China 200021
>>>
>
>
>
> --
> Best regards,
>
> Fu Wei
> Software Engineer
> Red Hat Software (Beijing) Co.,Ltd.Shanghai Branch
> Ph: +86 21 61221326(direct)
> Ph: +86 186 2020 4684 (mobile)
> Room 1512, Regus One Corporate Avenue,Level 15,
> One Corporate Avenue,222 Hubin Road,Huangpu District,
> Shanghai,China 200021



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat Software (Beijing) Co.,Ltd.Shanghai Branch
Ph: +86 21 61221326(direct)
Ph: +86 186 2020 4684 (mobile)
Room 1512, Regus One Corporate Avenue,Level 15,
One Corporate Avenue,222 Hubin Road,Huangpu District,
Shanghai,China 200021
