From: robherring2@gmail.com (Rob Herring)
Date: Mon, 15 Jul 2013 17:08:58 -0500
Subject: [PATCH] ARM: Add check for Cortex-A15 errata 798181 ECO
In-Reply-To: <CAOesGMjATn9MCzazUGmbD44XR8HyJZU4cCvmOEoUZsmCgutPUg@mail.gmail.com>
References: <1373920943-18308-1-git-send-email-robherring2@gmail.com>
 <CAOesGMjATn9MCzazUGmbD44XR8HyJZU4cCvmOEoUZsmCgutPUg@mail.gmail.com>
Message-ID: <51E472FA.1080905@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/15/2013 03:59 PM, Olof Johansson wrote:
> On Mon, Jul 15, 2013 at 1:42 PM, Rob Herring <robherring2@gmail.com> wrote:
>> diff --git a/arch/arm/kernel/smp_tlb.c b/arch/arm/kernel/smp_tlb.c
>> index 9a52a07..7fd64b7 100644
>> --- a/arch/arm/kernel/smp_tlb.c
>> +++ b/arch/arm/kernel/smp_tlb.c
>> @@ -74,10 +74,21 @@ static inline void ipi_flush_bp_all(void *ignored)
>>  static int erratum_a15_798181(void)
>>  {
>>         unsigned int midr = read_cpuid_id();
>> +       unsigned int revidr;
>>
>>         /* Cortex-A15 r0p0..r3p2 affected */
>>         if ((midr & 0xff0ffff0) != 0x410fc0f0 || midr > 0x413fc0f2)
>>                 return 0;
>> +
>> +       /* Check for Cortex A15 <= r3p2 with ECO fix */
>> +       revidr = read_cpuid(CPUID_REVIDR);
>> +       if ((revidr & 0x210) == 0x210)
>> +               return 0;
> 
> Reading and evaluating all this on every invalidate seems suboptimal.
> It should be possible to read just once and cache the result.

Yes, but I'm not sure it is so clear. 2 coproc reads may be faster than
a load potentially from memory. But then how much more code do we have
to fetch. How about something like this:

static int erratum_a15_798181(void)
{
	static int errata_fix_needed = -1;

	if (unlikely(errata_fix_needed == -1)) {
		unsigned int midr = read_cpuid_id();
		unsigned int revidr = read_cpuid(CPUID_REVIDR);

		/* Cortex-A15 r0p0..r3p2 w/o ECO fix affected */
		if ((midr & 0xff0ffff0) != 0x410fc0f0 || midr > 0x413fc0f2 ||
		    (revidr & 0x210) == 0x210) {
			errata_fix_needed = 0;
			return 0;
		}
		if (revidr & 0x10)
			errata_fix_needed = 1;

		errata_fix_needed = 2;
	}

	if (errata_fix_needed)
		dummy_flush_tlb_a15_erratum();
	return (errata_fix_needed == 2) ? 1: 0;
}


> I would have had the same comment about the original patch, but ARM
> pushes those to Russell in secret so it wasn't on the list. :-)

And I would have commented that we need to handle ECO fixes...

Rob
