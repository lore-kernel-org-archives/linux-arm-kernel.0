From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 7 Dec 2016 08:13:03 +0200
Subject: [PATCH 3/5] arm64: dts: exynos5433: Add PPMU dt node
In-Reply-To: <5847A419.9050801@samsung.com>
References: <1480663087-4590-1-git-send-email-cw00.choi@samsung.com>
 <1480663087-4590-4-git-send-email-cw00.choi@samsung.com>
 <CGME20161206190841epcas1p33b8c4f39ff4ff396a5602231a2ffc59c@epcas1p3.samsung.com>
 <20161206190756.GA12683@kozik-lap> <58478C41.5090500@samsung.com>
 <5847A419.9050801@samsung.com>
Message-ID: <CAJKOXPe=D8F9WQU_A-arqygALT7ehG-a3W5gZmaC11B-jV-i9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 7, 2016 at 7:54 AM, Chanwoo Choi <cw00.choi@samsung.com> wrote:
> On 2016? 12? 07? 13:12, Chanwoo Choi wrote:
>> On 2016? 12? 07? 04:07, Krzysztof Kozlowski wrote:
>>> On Fri, Dec 02, 2016 at 04:18:05PM +0900, Chanwoo Choi wrote:
>>>> This patch adds PPMU (Platform Performance Monitoring Unit) Device-tree node
>>>> to measure the utilization of each IP in Exynos SoC.
>>>>
>>>> - PPMU_D{0|1}_CPU are used to measure the utilization of MIF (Memory Interface)
>>>>   block with VDD_MIF power source.
>>>> - PPMU_D{0|1}_GENERAL are used to measure the utilization of INT(Internal)
>>>>   block with VDD_INT power source.
>>>>
>>>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>>>> ---
>>>>  arch/arm64/boot/dts/exynos/exynos5433.dtsi | 24 ++++++++++++++++++++++++
>>>>  1 file changed, 24 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
>>>> index 64226d5ae471..8c4ee84d5232 100644
>>>> --- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
>>>> +++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
>>>> @@ -599,6 +599,30 @@
>>>>                     clock-names = "fin_pll", "mct";
>>>>             };
>>>>
>>>> +           ppmu_d0_cpu: ppmu at 10480000 {
>>>> +                   compatible = "samsung,exynos-ppmu-v2";
>>>> +                   reg = <0x10480000 0x2000>;
>>>> +                   status = "disabled";
>>>
>>> Why these are disabled? They have some external dependencies?
>>
>> There is no any dependency. If you want to remain it always enabled,
>> I'm OK.
>
> One more comment. Each PPMU has the four events which is used for devfreq driver
> to get the utilization. If I remove the 'status = "disabled"' from exynos5433.dtsi,
> first probe of PPMU device is fail on case1.
>
> Case1. Disable PPMU device and then enable it on exynos5433-tm2.dts
> [    2.560126] exynos-ppmu: new PPMU device registered 10490000.ppmu (ppmu-event0-d0-general)
> [    2.565957] exynos-ppmu: new PPMU device registered 104c0000.ppmu (ppmu-event0-d1-general)
>
> Case2. Enable PPMU device always. First probe is failed and then second probe is successful.
> [    2.898781] exynos-ppmu 10480000.ppmu: failed to get child node of devfreq-event devices
> [    2.899077] exynos-ppmu 10480000.ppmu: failed to parse exynos ppmu dt node
> [    2.899289] exynos-ppmu 10480000.ppmu: failed to parse devicetree for resource
> [    2.899602] exynos-ppmu: probe of 10480000.ppmu failed with error -22
> [    2.905364] exynos-ppmu: new PPMU device registered 10490000.ppmu (ppmu-event0-d0-general)
> [    2.913535] exynos-ppmu 104b0000.ppmu: failed to get child node of devfreq-event devices
> [    2.921402] exynos-ppmu 104b0000.ppmu: failed to parse exynos ppmu dt node
> [    2.928250] exynos-ppmu 104b0000.ppmu: failed to parse devicetree for resource
> [    2.935571] exynos-ppmu: probe of 104b0000.ppmu failed with error -22
> [    2.942144] exynos-ppmu: new PPMU device registered 104c0000.ppmu (ppmu-event0-d1-general)

I got it, so leaving it as disabled makes sense. For the reference:
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
