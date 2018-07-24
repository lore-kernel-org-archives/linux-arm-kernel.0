From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 24 Jul 2018 08:33:38 +0200
Subject: [RFC] ARM: exynos: Fix imprecise abort during Exynos5422 suspend
 to RAM
In-Reply-To: <20180723142503eucas1p24f8d96f8c4ec25dbdb80e27e2f1444c2~EBZNDRgPc2952429524eucas1p2C@eucas1p2.samsung.com>
References: <CGME20180718200005epcas1p1cb2568c593276849c066b3a53f1e971b@epcas1p1.samsung.com>
 <20180718195929.5852-1-krzk@kernel.org>
 <20180723142503eucas1p24f8d96f8c4ec25dbdb80e27e2f1444c2~EBZNDRgPc2952429524eucas1p2C@eucas1p2.samsung.com>
Message-ID: <CAJKOXPc=3-q4CXDqcHXgXfhMKvKLJWBzuH1JvXiV5m04TW_qig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23 July 2018 at 16:24, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
> Hi Krzysztof,
>
> On 2018-07-18 21:59, Krzysztof Kozlowski wrote:
>> Suspend to RAM on Odroid XU3/XU4/HC1 family (Exynos5422) causes
>> imprecise abort:
>>
>>       PM: Syncing filesystems ... done.
>>       Freezing user space processes ... (elapsed 0.003 seconds) done.
>>       OOM killer disabled.
>>       Freezing remaining freezable tasks ... (elapsed 0.003 seconds) done.
>>       wake enabled for irq 139
>>       Disabling non-boot CPUs ...
>>       IRQ51 no longer affine to CPU1
>>       IRQ52 no longer affine to CPU2
>>       IRQ53 no longer affine to CPU3
>>       IRQ54 no longer affine to CPU4
>>       IRQ55 no longer affine to CPU5
>>       IRQ56 no longer affine to CPU6
>>       cpu cpu4: Dropping the link to regulator.40
>>       IRQ57 no longer affine to CPU7
>>       Unhandled fault: external abort on non-linefetch (0x1008) at 0xf081a028
>>       Internal error: : 1008 [#1] PREEMPT SMP ARM
>>
>> with last call trace in exynos_suspend_enter().
>>
>> The abort is caused by writing to register in secure part of sysram.
>> All Exynos5422 devices, including Hardkernel Odroid boards, boot with
>> TrustZone in non-secure mode therefore they should access non-secure
>> sysram.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>>
>> ---
>>
>> Comments, whether my understanding is correct, are welcomed!
>
> The decision, weather to use secure or non-secure sysram depends on the
> enabled TrustZone interface IMHO. Exynos5420 PeachPIT and Exynos5800 PeachPI
> don't use TrustZone and don't have 'firmware' node in dts, thus they should
> keep existing code.

Ah, you are right. SMDK5420 also would be affected. I'll fix the patch.

Thanks for feedback!

Best regards,
Krzysztof
