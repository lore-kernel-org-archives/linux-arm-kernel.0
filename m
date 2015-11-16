From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 16 Nov 2015 20:04:00 +0100
Subject: [PATCH v2 11/12] ARM: wire up UEFI init and runtime support
In-Reply-To: <20151116190156.GH8644@n2100.arm.linux.org.uk>
References: <1447698757-8762-1-git-send-email-ard.biesheuvel@linaro.org>
 <1447698757-8762-12-git-send-email-ard.biesheuvel@linaro.org>
 <20151116190156.GH8644@n2100.arm.linux.org.uk>
Message-ID: <CAKv+Gu8w+2GA5tV4roYtEsza+mkCZKYX_=tT2t=+eh-ZO1Y2fA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 November 2015 at 20:01, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Nov 16, 2015 at 07:32:36PM +0100, Ard Biesheuvel wrote:
>> +static inline void efi_set_pgd(struct mm_struct *mm)
>> +{
>> +     if (unlikely(mm->context.vmalloc_seq != init_mm.context.vmalloc_seq))
>> +             __check_vmalloc_seq(mm);
>> +
>> +     cpu_switch_mm(mm->pgd, mm);
>> +
>> +     flush_tlb_all();
>> +     if (icache_is_vivt_asid_tagged())
>> +             __flush_icache_all();
>> +}
>
> I don't think that's sufficient.  There's a gap between switching the mm
> and flushing the TLBs where we could have different global TLB entries
> from those in the page tables - and that can cause problems with CPUs
> which speculatively prefetch.  Some CPUs raise exceptions for this...
>

OK. So you mean set TTBR to the zero page, perform the TLB flush and
only then switch to the new page tables?
