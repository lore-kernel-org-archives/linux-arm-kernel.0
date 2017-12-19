From: ludovic.barre@st.com (Ludovic BARRE)
Date: Tue, 19 Dec 2017 16:54:57 +0100
Subject: [PATCH V2 3/9] ARM: stm32: prepare stm32 family to welcome armv7
 architecture
In-Reply-To: <CAK8P3a3X1icDWmVng8w0Yd58nAcViJQ9oZc4xm-dEycVPe+5pg@mail.gmail.com>
References: <1513610272-7824-1-git-send-email-ludovic.Barre@st.com>
 <1513610272-7824-4-git-send-email-ludovic.Barre@st.com>
 <CAK8P3a1WzkVQ3591XjVQPLCqP0_zZ4ksqJqWvm7de_OnkE3oaQ@mail.gmail.com>
 <45e2f530-1e72-6933-4367-95aadd709873@st.com>
 <CAK8P3a3X1icDWmVng8w0Yd58nAcViJQ9oZc4xm-dEycVPe+5pg@mail.gmail.com>
Message-ID: <00e3d1b3-56cc-f003-9538-0cc769a00c9c@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 12/19/2017 04:26 PM, Arnd Bergmann wrote:
> On Tue, Dec 19, 2017 at 3:43 PM, Ludovic BARRE <ludovic.barre@st.com> wrote:
>>
>>
>> On 12/18/2017 09:24 PM, Arnd Bergmann wrote:
>>>
>>> On Mon, Dec 18, 2017 at 4:17 PM, Ludovic Barre <ludovic.Barre@st.com>
>>> wrote:
>>>>
>>>> From: Ludovic Barre <ludovic.barre@st.com>
>>>>
>>>> This patch prepares the STM32 machine for the integration of Cortex-A
>>>> based microprocessor (MPU), on top of the existing Cortex-M
>>>> microcontroller family (MCU). Since both MCUs and MPUs are sharing
>>>> common hardware blocks we can keep using ARCH_STM32 flag for most of
>>>> them. If a hardware block is specific to one family we can use either
>>>> ARM_SINGLE_ARMV7M or ARCH_MULTI_V7 flag.
>>>>
>>>> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
>>>
>>>
>>> Looks good overall. Two more small comments:
>>>
>>>
>>>>
>>>> +if ARCH_STM32
>>>> +
>>>>    config MACH_STM32F429
>>>> -       bool "STMicrolectronics STM32F429"
>>>> -       depends on ARCH_STM32
>>>> +       bool "STMicroelectronics STM32F429"
>>>> +       depends on ARM_SINGLE_ARMV7M
>>>>           default y
>>>
>>>
>>> Instead of the explicit dependency for each board, I'd leave the
>>> surrounding
>>> 'if ARM_SINGLE_ARMV7M'. I think you had in v1.
>>
>>
>> As you suggest, I follow mach-at91 example.
>> The point is on "depends on ARM_SINGLE_ARMV7M" ?
>> You prefer this way:
>> config MACH_STM32F429
>>          bool "STMicroelectronics STM32F429" if ARM_SINGLE_ARMV7M
>>          default y
>>
> 
> No, that would be wrong, that way you would always enable
> MACH_STM32F429 when ARM_SINGLE_ARMV7M is turned
> off, which is exactly the wrong way round. What I meant is
> 
> if ARCH_STM32
> 
> if ARM_SINGLE_ARMV7M
> 
> config MACH_STM32F429
>           bool "STMicrolectronics STM32F429"
> 
> config MACH_STM32...
>            ...
> 
> endif # ARMv7-M
> 
> if ARCH_MULTI_V7
> 
> config MACH_STM32...
>            ...
> 
> endif # ARMv7-A
> 
> endif # STM32
> 
>         Arnd
> 
Ok, it's clear :-)
