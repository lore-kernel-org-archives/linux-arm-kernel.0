From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 23 Feb 2015 18:12:39 +0100
Subject: [RESEND PATCH] ARM: EXYNOS: Fix failed second suspend on Exynos4
In-Reply-To: <2802418.zt8CxNGGkT@amdc1032>
References: <1424256325-16659-1-git-send-email-k.kozlowski@samsung.com>
 <2802418.zt8CxNGGkT@amdc1032>
Message-ID: <CAJKOXPe23vtEByLOLNnmm5u=fpR5OSV_KUC_nc6UV-LUuKfHGQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-02-23 17:25 GMT+01:00 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>:
>
> Hi,
>
> On Wednesday, February 18, 2015 11:45:25 AM Krzysztof Kozlowski wrote:
>> On Exynos4412 boards (Trats2, Odroid U3) after enabling L2 cache in
>> 56b60b8bce4a ("ARM: 8265/1: dts: exynos4: Add nodes for L2 cache
>> controller") the second suspend to RAM failed. First suspend worked fine
>> but the next one hang just after powering down of secondary CPUs (system
>> consumed energy as it would be running but was not responsive).
>>
>> The issue was caused by enabling delayed reset assertion for CPU0 just
>> after issuing power down of cores. This was introduced for Exynos4 in
>> 13cfa6c4f7fa ("ARM: EXYNOS: Fix CPU idle clock down after CPU off").
>>
>> The whole behavior is not well documented but after checking with vendor
>> code this should be done like this (on Exynos4):
>> 1. Enable delayed reset assertion when system is running (for all CPUs).
>> 2. Disable delayed reset assertion before suspending the system.
>>    This can be done after powering off secondary CPUs.
>> 3. Re-enable the delayed reset assertion when system is resumed.
>>
>> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>> Fixes: 13cfa6c4f7fa ("ARM: EXYNOS: Fix CPU idle clock down after CPU off")
>> Cc: <stable@vger.kernel.org>
>
> It turned out that this patch is also needed to fix cpuidle AFTR mode
> hang on Trats2.
>
> Tested-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Thanks for testing.

Dear Kukjin,
Could you pick it up for this RC cycle? This patch fixes fatal suspend
and cpuidle failures on Exynos4 based boards on current mainline.

Best regards,
Krzysztof
