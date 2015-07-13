From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 13 Jul 2015 16:44:28 +0900
Subject: [PATCH 3/6] mfd: devicetree: bindings: 88pm800: Add DT property
 for 32KHz output enable
In-Reply-To: <55A36AE6.5070802@linaro.org>
References: <1436442431-3471-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1436442431-3471-4-git-send-email-vaibhav.hiremath@linaro.org>
 <55A0C1B8.4030402@samsung.com> <55A367BE.6040103@linaro.org>
 <55A36939.7070607@samsung.com> <55A36AE6.5070802@linaro.org>
Message-ID: <55A36C5C.7000903@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13.07.2015 16:38, Vaibhav Hiremath wrote:
> 
> 
> On Monday 13 July 2015 01:01 PM, Krzysztof Kozlowski wrote:
>> On 13.07.2015 16:24, Vaibhav Hiremath wrote:
>>>
>>>
>>> On Saturday 11 July 2015 12:41 PM, Krzysztof Kozlowski wrote:
>>>> W dniu 09.07.2015 o 20:47, Vaibhav Hiremath pisze:
>>>>> 88PM800 family of device supports output of 32KHz clock (low jitter)
>>>>> on CLK32K2/3 pin which can be supplied to other peripherals on the
>>>>> board.
>>>>>
>>>>> This patch adds the devicetree binding to enable this feature.
>>>>>
>>>>> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
>>>>> ---
>>>>>    Documentation/devicetree/bindings/mfd/88pm800.txt | 6 ++++++
>>>>>    1 file changed, 6 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/mfd/88pm800.txt
>>>>> b/Documentation/devicetree/bindings/mfd/88pm800.txt
>>>>> index dec842f..ae1311c 100644
>>>>> --- a/Documentation/devicetree/bindings/mfd/88pm800.txt
>>>>> +++ b/Documentation/devicetree/bindings/mfd/88pm800.txt
>>>>> @@ -9,6 +9,12 @@ Required parent device properties:
>>>>>    - #interrupt-cells     : should be 1.
>>>>>                  The cell is the 88pm80x local IRQ number
>>>>>
>>>>> +Optional properties :
>>>>> + - marvell,88pm800-32khz-xolj-out-en    : If set, driver will enable
>>>>> low jitter
>>>>> +   version of 32Khz clock output on
>>>>
>>>> I am not sure if I understand it correctly. The hardware always has
>>>> such
>>>> clocks and you only want to enable/disable it in DT? Any reasons why
>>>> these should not be enabled always?
>>>>
>>>
>>> Small amount of Power savings...
>>> Although currently I do not have power numbers to justify this.
>>>
>>> As per spec, (it only talks about power consumption in power down state)
>>>
>>> Power-down State => VSYS > 2.8   => 4.5 ?A
>>>                      CLK32K2 = 0  => 18 ?W
>>
>> This would be a power saving if it could be enabled/disabled runtime.
>> But with DT you will either:
>> 1. enable it always so there won't be any power saving,
>> 2. disable it always so there won't be such clock.
>>
>> I can find a use case - when on some boards the clock output is not
>> wired to anything so it cannot be used. In other cases (there is some
>> potential user) this should be triggered per-use (runtime
>> enabled/disabled).
>>
> 
> Exactly,
> 
>> Do you have such case? I mean boards where this is not connected at all
>> and boards where this is used?
>>
> 
> The PXA1928 based board which I have,
> 
> CLK32K1 (G3 pad)  = Used by Wireless chip
> CLK32K2 (G11 pad) = Not connected to anything, so we need to disable
>                     this output

Okay... however still such binding is uncommon. Such cases are modelled
by using (or not) the clock phandle. So the wireless driver would take
phandle to CLK32K1 clock thus enabling it after probed/started. The
CLK32K2 phandle would be unused and clock would remain disabled.

The binding for device should describe hardware and device always has
these clocks.

> 
>>>> Enabling it in DT does not look like a job for DT. Maybe you there
>>>> should be just a clock driver (clock provider)?
>>>>
>>>
>>> It's init time (and one time) settings, wouldn't clock-provider
>>> be overkill for this?
>>
>> The clock provider would be a proper way to do it and some PMICs I know
>> do this. Examples are max77686 and s5m8767/s2mps11. These are PMICs used
>> for Samsung SoCs. They have two or three 32kHz clocks.
>>
> 
> This is good to know.
> Let me take a look at these drivers.

drivers/mfd/sec-core.c - MFD for the family of PMICs
drivers/clk/clk-s2mps11.c for clocks
The drivers are actually a little more complicated than they should... :)

Best regards,
Krzysztof
