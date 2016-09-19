From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Mon, 19 Sep 2016 09:47:55 +0200
Subject: [PATCH 11/11] ARM: DT: STM32: add dma for usart1 on F429
In-Reply-To: <CAF3+TqcYuXnzokoR=vAsOofBkyA1WhuXvCc6HrekAovW2VejMQ@mail.gmail.com>
References: <CAF3+TqcYuXnzokoR=vAsOofBkyA1WhuXvCc6HrekAovW2VejMQ@mail.gmail.com>
Message-ID: <1f39f1b6-aca8-fca1-2618-2305cf72f94c@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bruno,

On 09/19/2016 03:28 AM, Bruno Herrera wrote:
>> Signed-off-by: Gerald Baeza <gerald.baeza@st.com>
>> Signed-off-by: Alexandre TORGUE <alexandre.torgue@st.com>
>
> I just tested your patch with success in two scenarios:
>
> 1) STM32F469IDISCO board
> 2) Custom board running STM32F439NI
>
> Tested-by: Bruno Herrera <bruherrera@gmail.com>
>
> One last comment I have bellow:
>
>>
>> diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
>> index 35df462..227376b 100644
>> --- a/arch/arm/boot/dts/stm32f429.dtsi
>> +++ b/arch/arm/boot/dts/stm32f429.dtsi
>> @@ -161,6 +161,9 @@
>>                         interrupts = <37>;
>>                         clocks = <&rcc 0 164>;
>>                         status = "disabled";
>> +                       dmas = <&dma2 2 4 0x414 0x0>,
>> +                              <&dma2 7 4 0x414 0x0>;
>
> According to stm32-dma.txt documentation in the third parameter (32bit
> mask) only the following bits can be set : 9,10,15,16,17 and 0x414 is
> setting bits 2 and 4. It make sense if you look in the register itself
> (DMA_SxCR) but as far I could see from the DMA driver code this bits
> are set internally. The correct value should be 0x400.

Thanks for you careful review: the dma issue you noticed is due to the 
fact that this bit field binding changed between kernel 4.2 and 4.8. 
Front of kernel 4.2, 0x414 was fine... but now it is no more, you are 
right.
I will fix it in my next pull request.

Thanks
Alex

>
>> +                       dma-names = "rx", "tx";
>>                 };
>>
>>                 usart6: serial at 40011400 {
.
