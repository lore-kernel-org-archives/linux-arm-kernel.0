From: dave.martin@linaro.org (Dave Martin)
Date: Fri, 18 Feb 2011 17:52:54 +0000
Subject: [PATCH] ARM: Avoid discarding sections that might have SMP_ON_UP
	fixups
In-Reply-To: <20110216163543.GA27480@arm.com>
References: <AANLkTinjAHLCMJja8q=bPhRBuoR2DCO_NjDw1qNi5MrU@mail.gmail.com>
	<20110210144617.GD3652@n2100.arm.linux.org.uk>
	<AANLkTiks_8hXd=7cKN0jNw=1QGcb=5ZyFu1sEFc0G=Px@mail.gmail.com>
	<20110210191125.GA12582@n2100.arm.linux.org.uk>
	<AANLkTim0RRw-xHQYTdHLCXCS_GXkaCiW8y9Fz=jMmwPa@mail.gmail.com>
	<20110211101345.GA23785@n2100.arm.linux.org.uk>
	<AANLkTikFkZH6KK_KUgXaaKyQM6eZOh-ki3xdtS2fk8zN@mail.gmail.com>
	<20110211160500.GA31529@n2100.arm.linux.org.uk>
	<AANLkTik1T_RDb_MVw9WWY_BX75isoGq2k1L+uVCN-bbq@mail.gmail.com>
	<20110211163247.GB31529@n2100.arm.linux.org.uk>
	<20110216163543.GA27480@arm.com>
Message-ID: <AANLkTina+bHd=dJRjfASci=GU3fAWbk2OGb6pU8rx67D@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Wed, Feb 16, 2011 at 4:35 PM, Dave Martin <dave.martin@linaro.org> wrote:
> Hi,
>
> On Fri, Feb 11, 2011 at 04:32:47PM +0000, Russell King - ARM Linux wrote:
>
> [...]
>
>> diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
>> index 45b5651..343d29f 100644
>> --- a/arch/arm/kernel/vmlinux.lds.S
>> +++ b/arch/arm/kernel/vmlinux.lds.S
>> @@ -21,6 +21,12 @@
>> ?#define ARM_CPU_KEEP(x)
>> ?#endif
>>
>> +#if defined(CONFIG_SMP_ON_UP) && !defined(CONFIG_DEBUG_SPINLOCK)
>> +#define ARM_EXIT_KEEP(x) ? ? x
>> +#else
>> +#define ARM_EXIT_KEEP(x)
>> +#endif
>> +
>> ?OUTPUT_ARCH(arm)
>> ?ENTRY(stext)
>>
>> @@ -43,6 +49,7 @@ SECTIONS
>> ? ? ? ? ? ? ? _sinittext = .;
>> ? ? ? ? ? ? ? ? ? ? ? HEAD_TEXT
>> ? ? ? ? ? ? ? ? ? ? ? INIT_TEXT
>> + ? ? ? ? ? ? ? ? ? ? ARM_EXIT_KEEP(EXIT_TEXT)
>> ? ? ? ? ? ? ? _einittext = .;
>> ? ? ? ? ? ? ? ARM_CPU_DISCARD(PROC_INFO)
>> ? ? ? ? ? ? ? __arch_info_begin = .;
>> @@ -71,6 +78,7 @@ SECTIONS
>> ?#ifndef CONFIG_XIP_KERNEL
>> ? ? ? ? ? ? ? __init_begin = _stext;
>> ? ? ? ? ? ? ? INIT_DATA
>> + ? ? ? ? ? ? ARM_EXIT_KEEP(EXIT_DATA)
>> ?#endif
>> ? ? ? }
>>
>> @@ -166,6 +174,7 @@ SECTIONS
>> ? ? ? ? ? ? ? . = ALIGN(PAGE_SIZE);
>> ? ? ? ? ? ? ? __init_begin = .;
>> ? ? ? ? ? ? ? INIT_DATA
>> + ? ? ? ? ? ? ARM_EXIT_KEEP(EXIT_DATA)
>> ? ? ? ? ? ? ? . = ALIGN(PAGE_SIZE);
>> ? ? ? ? ? ? ? __init_end = .;
>> ?#endif
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
> This works for me in a case known to fail without the patch.
>
> Tested-by: Dave Martin <dave.martin@linaro.org>
>
> I still don't quite understand the intricacies of how vmlinux
> is laid out, but the patch looks sensible.
>
> Do you need anything more from me on this? ?If not, I will
> throw away my patch and replace it with yours.

Are you still intending to merge your patch here?  I don't see it
anywhere yet, but I would like to get rid of my hack (which is rather
messy).

Cheers
---Dave
