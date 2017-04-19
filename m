From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Wed, 19 Apr 2017 15:10:44 +0100
Subject: [PATCH v3 6/7] ARM: NOMMU: Set ARM_DMA_MEM_BUFFERABLE for M-class
 cpus
In-Reply-To: <CAK8P3a1UH1qfCi5FC0aKxJvG=CNKOGSKbiU6Nz=0GA6Jit5Cpg@mail.gmail.com>
References: <1489137839-549-1-git-send-email-vladimir.murzin@arm.com>
 <1489137839-549-7-git-send-email-vladimir.murzin@arm.com>
 <CAK8P3a1UH1qfCi5FC0aKxJvG=CNKOGSKbiU6Nz=0GA6Jit5Cpg@mail.gmail.com>
Message-ID: <7eb9a87f-9b61-1367-311c-bc37430291e5@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/04/17 11:02, Arnd Bergmann wrote:
> On Fri, Mar 10, 2017 at 10:23 AM, Vladimir Murzin
> <vladimir.murzin@arm.com> wrote:
>> Now, we have dedicated non-cacheable region for consistent DMA
>> operations. However, that region can still be marked as bufferable by
>> MPU, so it'd be safer to have barriers by default.
>>
>> Tested-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
>> Tested-by: Andras Szemzo <sza@esh.hu>
>> Tested-by: Alexandre TORGUE <alexandre.torgue@st.com>
>> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
>> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
>> ---
>>  arch/arm/mm/Kconfig | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
>> index d731f28..7dd46ae 100644
>> --- a/arch/arm/mm/Kconfig
>> +++ b/arch/arm/mm/Kconfig
>> @@ -1050,7 +1050,7 @@ config ARM_L1_CACHE_SHIFT
>>
>>  config ARM_DMA_MEM_BUFFERABLE
>>         bool "Use non-cacheable memory for DMA" if (CPU_V6 || CPU_V6K) && !CPU_V7
>> -       default y if CPU_V6 || CPU_V6K || CPU_V7
>> +       default y if CPU_V6 || CPU_V6K || CPU_V7 || CPU_V7M
>>         help
>>           Historically, the kernel has used strongly ordered mappings to
>>           provide DMA coherent memory.  With the advent of ARMv7, mapping
> 
> The patch doesn't seem to match the description: I would have expected
> this to be user-selectable on CPU_V7M as we do on V6, but it is enabled
> unconditionally.
> 
> Can you either modify the description to explain why we now need this on
> all ARMv7M, or add a '|| CPU_V7M' for the 'bool' line to make it optional?
> 
> Would it be better to leave the default as disabled on CPU_V7M and
> require users to enable it manually? That way we don't regress the
> performance of readl/writel on platforms that don't need this.
> 

It is architectural vs implementation differences. Even though existing
implementations rarely need this sticking with architecture (it permits memory
re-ordering to happen in many cases) makes code more robust and save some
debugging time when more sophisticated implementations go wild (see, for
instance, 8e02676ffa69 "ARM: 8610/1: V7M: Add dsb before jumping in handler
mode"). We can consider making it user selectable if performance regressions
are reported.

Cheers
Vladimir

>      Arnd
> 
