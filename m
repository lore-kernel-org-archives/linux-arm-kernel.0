From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 12 Jan 2016 14:23:27 +0100
Subject: [PATCH v3 05/21] arm64: kvm: deal with kernel symbols outside of
 linear mapping
In-Reply-To: <20160112123656.GC4858@leverpostej>
References: <1452518355-4606-1-git-send-email-ard.biesheuvel@linaro.org>
 <1452518355-4606-6-git-send-email-ard.biesheuvel@linaro.org>
 <20160112123656.GC4858@leverpostej>
Message-ID: <CAKv+Gu_G+Za43fUxBWiD-C=eDWv+bEMYWgUzvDOnXMPKDdagaw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 January 2016 at 13:36, Mark Rutland <mark.rutland@arm.com> wrote:
> On Mon, Jan 11, 2016 at 02:18:58PM +0100, Ard Biesheuvel wrote:
>> KVM on arm64 uses a fixed offset between the linear mapping at EL1 and
>> the HYP mapping at EL2. Before we can move the kernel virtual mapping
>> out of the linear mapping, we have to make sure that references to kernel
>> symbols that are accessed via the HYP mapping are translated to their
>> linear equivalent.
>>
>> To prevent inadvertent direct references from sneaking in later, change
>> the type of all extern declarations to HYP kernel symbols to the opaque
>> 'struct kvm_ksym', which does not decay to a pointer type like char arrays
>> and function references. This is not bullet proof, but at least forces the
>> user to take the address explicitly rather than referencing it directly.
>>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>
> Cool feature!
>
>> diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
>> index 5e377101f919..e3865845d3e1 100644
>> --- a/arch/arm64/include/asm/kvm_asm.h
>> +++ b/arch/arm64/include/asm/kvm_asm.h
>> @@ -105,24 +105,29 @@
>>  #ifndef __ASSEMBLY__
>>  struct kvm;
>>  struct kvm_vcpu;
>> +struct kvm_ksym;
>
> So that one doesn't have to trawl git logs, it might be worth a comment
> as to the purpose of struct kvm_ksym (and thus why we never need to
> actually define it).
>

Yes, I can add something

> Either way:
>
> Reviewed-by: Mark Rutland <mark.rutland@arm.com>
>

Thanks
