From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Thu, 29 Oct 2015 07:36:09 +0530
Subject: [PATCH] ARM: exynos: Bring back reboot on Exynos5410
In-Reply-To: <56317960.9070608@samsung.com>
References: <1446024965-8508-1-git-send-email-p.fedin@samsung.com>
 <56317960.9070608@samsung.com>
Message-ID: <CAGcde9H4WVt34rn6_9H+sVu2Bp2xq4awMiwV1zgv1D6posPWSg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pavel,

On 29 October 2015 at 07:11, Krzysztof Kozlowski
<k.kozlowski@samsung.com> wrote:
> On 28.10.2015 18:36, Pavel Fedin wrote:
>> Since 8cfc7fdd33080e30b86d21b1a8c9ad0686427ddc ("ARM: EXYNOS: move restart
>
> This should be sufficient (although full is okay as well):
> $ git config core.abbrev 12
>
>> code into pmu driver") PMU support is required in order for the reboot to
>> work. Unfortunately, there is currently no PMU support for 5410.
>>
>> This patch adds exynos5410-pmu to the list of recognized devices. It is
>> okay for the code to have empty struct exynos_pmu_data, in this case only
>> minimal support is enabled. This is enough for SWRESET to work.
>>
>> Signed-off-by: Pavel Fedin <p.fedin@samsung.com>
>
> This definitely looks like a fix for a regression, so:
> Cc: <stable@vger.kernel.org>
> Fixes: 8cfc7fdd3308 ("ARM: EXYNOS: move restart code into pmu driver")
>
>> ---
>>  arch/arm/mach-exynos/pmu.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/arch/arm/mach-exynos/pmu.c b/arch/arm/mach-exynos/pmu.c
>> index de68938..7b9e33c 100644
>> --- a/arch/arm/mach-exynos/pmu.c
>> +++ b/arch/arm/mach-exynos/pmu.c
>> @@ -908,6 +908,10 @@ static const struct exynos_pmu_data exynos5250_pmu_data = {
>>       .powerdown_conf = exynos5_powerdown_conf,
>>  };
>>
>> +static struct exynos_pmu_data exynos5410_pmu_data = {
>> +     /* Only SWRESET is currently supported on 5410 */
>> +};
>
> static const struct
>
> With these changes:
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>
>

Patch looks ok, but after Alim's patch series [1] to handle poweroff
and reboot via generic syscon based driver gets merged, this will
become redundant entry into PMU driver in the absence of any PMU  data
for Exynos5410. Alim has taken care of adding power-off and reboot
device node in exynos5410.dtsi [2].

[1]: http://www.spinics.net/lists/devicetree/msg98858.html
[2]: http://www.spinics.net/lists/devicetree/msg98862.html

Thanks,
Pankaj Dubey

> Best regards,
> Krzysztof
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
