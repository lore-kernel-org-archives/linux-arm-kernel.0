From: sajjan.linux@gmail.com (Vikas Sajjan)
Date: Fri, 25 Apr 2014 13:35:06 +0530
Subject: [PATCH 1/4] ARM: dts: exynos4: add PMU syscon node
In-Reply-To: <535936A7.9050003@samsung.com>
References: <1397479700-15864-1-git-send-email-chanho61.park@samsung.com>
 <1397479700-15864-2-git-send-email-chanho61.park@samsung.com>
 <535936A7.9050003@samsung.com>
Message-ID: <CAGm_ybjhcAqX7biOvqLMgzHPQK=-EtaHtXpCtcJ1rcdRsxN_Og@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


On Thu, Apr 24, 2014 at 9:37 PM, Tomasz Figa <t.figa@samsung.com> wrote:
> Hi Chanho,
>
>
> On 14.04.2014 14:48, Chanho Park wrote:
>>
>> This patch adds a PMU(Power Management Unit) syscon node. This
>> should be required for USB Phy syscon regmap I/F.
>>
>> Cc: Tomasz Figa <t.figa@samsung.com>
>> Cc: Kamil Debski <k.debski@samsung.com>
>> Signed-off-by: Chanho Park <chanho61.park@samsung.com>
>> ---
>>   arch/arm/boot/dts/exynos4.dtsi | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/exynos4.dtsi
>> b/arch/arm/boot/dts/exynos4.dtsi
>> index 2f8bcd0..e565b86 100644
>> --- a/arch/arm/boot/dts/exynos4.dtsi
>> +++ b/arch/arm/boot/dts/exynos4.dtsi
>> @@ -110,6 +110,11 @@
>>                 reg = <0x10010000 0x400>;
>>         };
>>
>> +       pmu_reg: syscon at 10020000 {
>> +               compatible = "samsung,exynos4-pmureg", "syscon";
>

 Assume a case where exynos PMU is made as platform driver [1] and we
need use the compatible  "samsung,exynos4-pmureg" in the driver.
But since syscon driver uses compatible "syscon" and once the syscon
driver is probed, the  exynos PMU platform driver [1] will NEVER be
probed.
So my question is, can we have 2 compatible strings for a DT node, and
both the compatible strings are used for probing purpose?
Recently I faced this issue on exynos5250, where i was testing PMU
driver [1] and I noticed that  PMU driver [1] was NEVER probed, if I
enable syscon driver in menuconfig.

[1] http://www.spinics.net/lists/linux-samsung-soc/msg28038.html

>
> This compatible string doesn't seem to be defined in [1], please add it
> there,
>
> [1] Documentation/devicetree/bindings/arm/samsung/pmu.txt
>
> Otherwise looks good, so after fixing that you may add my
>
> Reviewed-by: Tomasz Figa <t.figa@samsung.com>
>
> Best regards,
> Tomasz
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc"
> in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
