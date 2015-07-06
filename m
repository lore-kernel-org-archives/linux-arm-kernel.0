From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 6 Jul 2015 13:03:32 +0900
Subject: [PATCH v2] clk: exynos4: Fix wrong clock for Exynos4x12 ADC
In-Reply-To: <CABxcv=mQfcb3jsRzOcWXAbNRf-dumoHS8X-2TEeOdB2E_T5BMQ@mail.gmail.com>
References: <1434074005-18846-1-git-send-email-k.kozlowski@samsung.com>
 <CABxcv=mQfcb3jsRzOcWXAbNRf-dumoHS8X-2TEeOdB2E_T5BMQ@mail.gmail.com>
Message-ID: <CAJKOXPeFxABcm27_tmriY6RreaRYZiEPvUvFav4DK-AoNbUs=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-06-12 14:46 GMT+09:00 Javier Martinez Canillas <javier@dowhile0.org>:
> Hello Krzysztof,
>
> On Fri, Jun 12, 2015 at 3:53 AM, Krzysztof Kozlowski
> <k.kozlowski@samsung.com> wrote:
>> The TSADC gate clock was used in Exynos4x12 DTSI for exynos-adc driver.
>> However TSADC is present only on Exynos4210 so on Trats2 board (with
>> Exynos4412 SoC) the exynos-adc driver could not be probed:
>>    ERROR: could not get clock /adc at 126C0000:adc(0)
>>    exynos-adc 126c0000.adc: failed getting clock, err = -2
>>    exynos-adc: probe of 126c0000.adc failed with error -2
>>
>> Instead on Exynos4x12 SoCs the main clock used by Analog to Digital
>> Converter is located in different register and it is named in datasheet
>> as PCLK_ADC. Regardless of the name the purpose of this PCLK_ADC clock
>> is the same as purpose of TSADC from Exynos4210.
>>
>> The patch adds gate clock for Exynos4x12 using the proper register so
>> backward compatibility is preserved. This fixes the probe of exynos-adc
>> driver on Exynos4x12 boards and allows accessing sensors connected to it
>> on Trats2 board (ntc,ncp15wb473 AP and battery thermistors).
>>
>> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>> Cc: <stable@vger.kernel.org>
>> Fixes: c63c57433003 ("ARM: dts: Add ADC's dt data to read raw data for exynos4x12")
>> Link: https://lkml.org/lkml/2015/6/11/85
>>
>> ---
>>
>> Changes since v1:
>> 1. After discussion on LKML this solution was chosen because it smaller,
>>    simpler, self-contained (one patch to fix issue) and maintains backward
>>    compatibility. Thanks to Javier Martinez Canillas and Tomasz Figa for
>>    valuable comments.
>> 2. Dropped patch 2/2 because now it is not needed. The clock id "TSADC"
>>    will be used on all Exynos4 boards.
>> 3. Added CC-stable.
>> ---
>>  drivers/clk/samsung/clk-exynos4.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>
> Patch looks good to me.
>
> Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Hi Tomasz and Sylwester,

Any comments on this version of patch?
Tomasz, you gave me comments on previous version. Are their satisfied?

Best regards,
Krzysztof
