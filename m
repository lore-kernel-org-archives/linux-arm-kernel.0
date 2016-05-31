From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 31 May 2016 15:39:06 +0100
Subject: [PATCH v2] arm64: Implement optimised IP checksum helpers
In-Reply-To: <574D9E8F.7080509@arm.com>
References: <ba9cf5bf84b8adc766f7f7511dda8cb501cd4101.1464693619.git.robin.murphy@arm.com>
 <574D9E8F.7080509@arm.com>
Message-ID: <574DA20A.4070302@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi James,

On 31/05/16 15:24, James Morse wrote:
> Hi Robin,
>
> On 31/05/16 12:22, Robin Murphy wrote:
>> AArch64 is capable of 128-bit memory accesses without alignment
>> restrictions, which makes it both possible and highly practical to slurp
>> up a typical 20-byte IP header in just 2 loads. Implement our own
>> version of ip_fast_checksum() to take advantage of that, resulting in
>> considerably fewer instructions and memory accesses than the generic
>> version. We can also get more optimal code generation for csum_fold() by
>> defining it a slightly different way round from the generic version, so
>> throw that into the mix too.
>>
>> Suggested-by: Luke Starrett <luke.starrett@broadcom.com>
>> Acked-by: Luke Starrett <luke.starrett@broadcom.com>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>
>> Minor changes: include types.h for correctness, add Luke's ack.
>>
>>   arch/arm64/include/asm/checksum.h | 51 +++++++++++++++++++++++++++++++++++++++
>
> Maybe a nit, don't you need to remove the 'generic-y += checksum.h' line from
> arch/arm64/include/asm/Kbuild to avoid the generated version being created too? [0]

I guess you skimmed the very end of the patch ;)

+#include <asm-generic/checksum.h>

> The compiler on my box picks your header in preference to the generated one, but
> [1] suggests it isn't to be trusted!

We only cherry-pick a couple of functions to optimise, so not building 
the generic file would necessitate copy-pasting the rest of it. I'd hope 
this pattern is sufficiently robust, since it's already in use on a 
number of other architectures! AFAICS [1] only applies when the generic 
file shouldn't be built at all, so cross fingers we're probably OK.

Robin.

> Thanks,
>
> James
>
> [0] d8ecc5cd8e22 ("kbuild: asm-generic support")
> [1] https://lkml.org/lkml/2016/5/23/78
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
