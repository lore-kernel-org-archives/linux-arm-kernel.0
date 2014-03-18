From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 18 Mar 2014 14:07:51 +0100
Subject: [PATCH v11 15/27] iommu/exynos: use convenient macro to handle
 gate clocks
In-Reply-To: <CAK9yfHxcArgmxm4wSipY1afjmG00zugyycdU+BQbuexvL2bmBw@mail.gmail.com>
References: <20140314140951.3d443a3096e80297c9fecef0@samsung.com>
 <5323078E.4060903@samsung.com>
 <CAK9yfHx_=Os1G46nNO1HDA3tigkRNeHKN1KGCvuN=w7dRTkfjg@mail.gmail.com>
 <20140318200329.cc1dca7541b4b1916e5d9d48@samsung.com>
 <CAK9yfHxcArgmxm4wSipY1afjmG00zugyycdU+BQbuexvL2bmBw@mail.gmail.com>
Message-ID: <53284527.8010903@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18.03.2014 12:18, Sachin Kamat wrote:
> On 18 March 2014 16:33, Cho KyongHo <pullip.cho@samsung.com> wrote:
>> On Fri, 14 Mar 2014 22:27:59 +0530, Sachin Kamat wrote:
>>>   Hi KyongHo,
>>>
>>> On 14 March 2014 19:13, Tomasz Figa <t.figa@samsung.com> wrote:
>>>> Hi KyongHo,
>>>>
>>>>
>>>> On 14.03.2014 06:09, Cho KyongHo wrote:
>>>>>
>>>>> exynos-iommu driver must care about master H/W's gate clock as well as
>>>>> System MMU's gate clock. To enhance readability of the source code,
>>>>> macros to gate/ungate those clocks are defined.
>>>>>
>>>>> Signed-off-by: Cho KyongHo <pullip.cho@samsung.com>
>>>>> ---
>>>>>    drivers/iommu/exynos-iommu.c |   34 ++++++++++++++++++++++------------
>>>>>    1 file changed, 22 insertions(+), 12 deletions(-)
>>>>>
>>>>> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
>>>>> index 71e77f1..cef62d0 100644
>>>>> --- a/drivers/iommu/exynos-iommu.c
>>>>> +++ b/drivers/iommu/exynos-iommu.c
>>>>> @@ -101,6 +101,16 @@
>>>>>    #define REG_PB1_SADDR         0x054
>>>>>    #define REG_PB1_EADDR         0x058
>>>>>
>>>>> +#define __clk_gate_ctrl(data, clk, en) do {            \
>>>>> +               if (data->clk)                          \
>>>>> +                       clk_##en##able(data->clk);      \
>>>>> +       } while (0)
>>>>> +
>>>>> +#define __sysmmu_clk_enable(data)      __clk_gate_ctrl(data, clk, en)
>>>>> +#define __sysmmu_clk_disable(data)     __clk_gate_ctrl(data, clk, dis)
>>>>> +#define __master_clk_enable(data)      __clk_gate_ctrl(data, clk_master,
>>>>> en)
>>>>> +#define __master_clk_disable(data)     __clk_gate_ctrl(data, clk_master,
>>>>> dis)
>>>>> +
>>>>
>>>>
>>>> I'd say that such macros only obfuscate code, without any gains, as you can
>>>> see in diffstat - this patch adds more lines than it removes.
>>>>
>>>> Please drop this change.
>>>
>>>   I agree with Tomasz here.
>>>
>>
>> Are you concerning about using macros or more insertions than deletions?
>
> It is just making the code more difficult to read and understand.

Especially when hiding accesses to struct fields inside and doing fancy 
stuff like concatenations.

Best regards,
Tomasz
