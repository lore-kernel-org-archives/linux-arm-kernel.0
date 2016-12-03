From: jic23@kernel.org (Jonathan Cameron)
Date: Sat, 3 Dec 2016 09:35:58 +0000
Subject: [PATCH v3 5/7] IIO: add bindings for stm32 timer trigger driver
In-Reply-To: <CA+M3ks7GhvApJwZVFK7KAbbvbAhp40sdOVvhkyZWBHZXpLfZDQ@mail.gmail.com>
References: <1480673842-20804-1-git-send-email-benjamin.gaignard@st.com>
 <1480673842-20804-6-git-send-email-benjamin.gaignard@st.com>
 <20161202135904.GN2683@dell>
 <CA+M3ks7GhvApJwZVFK7KAbbvbAhp40sdOVvhkyZWBHZXpLfZDQ@mail.gmail.com>
Message-ID: <7f9e10e7-6793-64f2-9e62-bebd9f60ce72@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/12/16 14:23, Benjamin Gaignard wrote:
> 2016-12-02 14:59 GMT+01:00 Lee Jones <lee.jones@linaro.org>:
>> On Fri, 02 Dec 2016, Benjamin Gaignard wrote:
>>
>>> Define bindings for stm32 timer trigger
>>>
>>> version 3:
>>> - change file name
>>> - add cross reference with mfd bindings
>>>
>>> version 2:
>>> - only keep one compatible
>>> - add DT parameters to set lists of the triggers:
>>>   one list describe the triggers created by the device
>>>   another one give the triggers accepted by the device
>>>
>>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
>>> ---
>>>  .../bindings/iio/timer/stm32-timer-trigger.txt     | 39 ++++++++++++++++++++++
>>>  1 file changed, 39 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.txt b/Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.txt
>>> new file mode 100644
>>> index 0000000..858816d
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.txt
>>> @@ -0,0 +1,39 @@
>>> +timer trigger bindings for STM32
>>> +
>>> +Must be a sub-node of STM32 general purpose timer driver
>>> +Parent node properties are describe in ../mfd/stm32-general-purpose-timer.txt
>>> +
>>> +Required parameters:
>>> +- compatible:                must be "st,stm32-iio-timer"
>>> +- interrupts:                Interrupt for this device
>>> +                     See ../interrupt-controller/st,stm32-exti.txt
>>> +
>>> +Optional parameters:
>>> +- st,input-triggers-names:   List of the possible input triggers for
>>> +                             the device
>>> +- st,output-triggers-names:  List of the possible output triggers for
>>> +                             the device
>>> +
>>> +Possible triggers are defined in include/dt-bindings/iio/timer/st,stm32-timer-trigger.h
>>> +
>>> +Example:
>>> +     gptimer1: gptimer1 at 40010000 {
>>> +             compatible = "st,stm32-gptimer";
>>> +             reg = <0x40010000 0x400>;
>>> +             clocks = <&rcc 0 160>;
>>> +             clock-names = "clk_int";
>>> +
>>> +             timer1 at 0 {
>>> +                     compatible = "st,stm32-timer-trigger";
>>> +                     interrupts = <27>;
>>> +                     st,input-triggers-names = TIM5_TRGO,
>>> +                                               TIM2_TRGO,
>>> +                                               TIM4_TRGO,
>>> +                                               TIM3_TRGO;
>>> +                     st,output-triggers-names = TIM1_TRGO,
>>> +                                                TIM1_CH1,
>>> +                                                TIM1_CH2,
>>> +                                                TIM1_CH3,
>>> +                                                TIM1_CH4;
>>
>> I see why you've done it like this now ... because it makes things
>> easier for you in the driver, since the IIO subsystem matches on names
>> such as these.
>>
>> BUT, this is a Linux-implementation-ism.  Just use pairs of integers
>> and create the Linux-ism strings in the driver.
> 
> The goal is not to make things easier in driver but to be able to share
> the triggers names with other drivers like DAC or ADC.
> If each driver have to create it own triggers names it will more difficult
> to keep them coherent than it they share the same definitions
Do it by documentation.  This will be effectively ABI going forward
so fixed once it is defined. Should be fairly easy to tell during testing
if someone has messed it up ;)

Jonathan
> 
>>
>>> +             };
>>> +     };
>>
>> --
>> Lee Jones
>> Linaro STMicroelectronics Landing Team Lead
>> Linaro.org ? Open source software for ARM SoCs
>> Follow Linaro: Facebook | Twitter | Blog
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
