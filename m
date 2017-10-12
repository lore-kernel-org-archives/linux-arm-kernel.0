From: james.morse@arm.com (James Morse)
Date: Thu, 12 Oct 2017 13:26:17 +0100
Subject: [PATCH v3 01/20] arm64: explicitly mask all exceptions
In-Reply-To: <25eb4c59-a09e-5b0a-66fb-6c650ab8e057@arm.com>
References: <20171005191812.5678-1-james.morse@arm.com>
 <20171005191812.5678-2-james.morse@arm.com>
 <25eb4c59-a09e-5b0a-66fb-6c650ab8e057@arm.com>
Message-ID: <59DF5F69.4080009@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Julien,

On 11/10/17 17:30, Julien Thierry wrote:
> On 05/10/17 20:17, James Morse wrote:
>> There are a few places where we want to mask all exceptions. Today we
>> do this in a piecemeal fashion, typically we expect the caller to
>> have masked irqs and the arch code masks debug exceptions, ignoring
>> SError which is probably masked.
>>
>> Make it clear that 'mask all exceptions' is the intention by adding
>> helpers to do exactly that.
>>
>> This will let us unmask SError without having to add 'oh and SError'
>> to these paths.

>> diff --git a/arch/arm64/include/asm/daifflags.h
>> b/arch/arm64/include/asm/daifflags.h
>> new file mode 100644
>> index 000000000000..fb40da8e1457
>> --- /dev/null
>> +++ b/arch/arm64/include/asm/daifflags.h

>> +#ifndef __ASM_DAIFFLAGS_H
>> +#define __ASM_DAIFFLAGS_H
>> +
>> +#include <asm/irqflags.h>
>> +#include <linux/irqflags.h>
>> +
>> +/* Mask/unmask/restore all exceptions, including interrupts. */
>> +static inline unsigned long local_mask_daif(void)
>> +{
>> +    unsigned long flags;
>> +    asm volatile(
>> +        "mrs    %0, daif        // local_mask_daif\n"
>> +        "msr    daifset, #0xf"
>> +        : "=r" (flags)
>> +        :
>> +        : "memory");
>> +    trace_hardirqs_off();
>> +    return flags;
>> +}
>> +
> nit:
> Can we call this local_daif_save? 

Sure, having a save version fits better with the C irqflags versions.

mask/unmask is just being pedantic, irqs and SError aren't disabled by these
flags, (but curiously debug is...).


> (and maybe a version that only disables without saving?)

irqflags.h has one, so yes, why not.


> Also, I was wondering why use 'local' as prefix? Is there gonna be a similar set
> of function for arm that could be called by common code? (e.g. drivers?)

Its a hangover from the C irqflags calls like arch_local_save_flags() etc. I
dropped the 'arch' as these should only be called by arch code and 'daif' should
prevent any name collisions.

Drivers should never touch this stuff, if they do its likely to be because they
want to defer bursting-into-flames until we get to userspace, where its harder
to work out which driver to blame.


> Otherwise:
> Reviewed-by: Julien Thierry <julien.thierry@arm.com>

Thanks!


James
