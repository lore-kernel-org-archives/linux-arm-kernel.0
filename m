From: ludovic.barre@st.com (Ludovic BARRE)
Date: Thu, 21 Jun 2018 09:25:18 +0200
Subject: [PATCH V3 1/3] watchdog: stm32: add pclk feature for stm32mp1
In-Reply-To: <20180620191409.GA29934@rob-hp-laptop>
References: <1529502698-13263-1-git-send-email-ludovic.Barre@st.com>
 <1529502698-13263-2-git-send-email-ludovic.Barre@st.com>
 <20180620191409.GA29934@rob-hp-laptop>
Message-ID: <618bcde6-0a41-9341-c55c-6e1d0ee8e51d@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 06/20/2018 09:14 PM, Rob Herring wrote:
> On Wed, Jun 20, 2018 at 03:51:36PM +0200, Ludovic Barre wrote:
>> From: Ludovic Barre <ludovic.barre@st.com>
>>
>> This patch adds config data to manage specific properties by
>> compatible. Adds stm32mp1 config which requires pclk clock.
>>
>> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
>> ---
>>   .../devicetree/bindings/watchdog/st,stm32-iwdg.txt |  21 +++-
> 
> Please split bindings to separate patch.

OK

> 
>>   drivers/watchdog/stm32_iwdg.c                      | 116 +++++++++++++--------
>>   2 files changed, 91 insertions(+), 46 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/watchdog/st,stm32-iwdg.txt b/Documentation/devicetree/bindings/watchdog/st,stm32-iwdg.txt
>> index cc13b10a..f07f6d89 100644
>> --- a/Documentation/devicetree/bindings/watchdog/st,stm32-iwdg.txt
>> +++ b/Documentation/devicetree/bindings/watchdog/st,stm32-iwdg.txt
>> @@ -2,18 +2,31 @@ STM32 Independent WatchDoG (IWDG)
>>   ---------------------------------
>>   
>>   Required properties:
>> -- compatible: "st,stm32-iwdg"
>> -- reg: physical base address and length of the registers set for the device
>> -- clocks: must contain a single entry describing the clock input
>> +- compatible: Should be either "st,stm32-iwdg" or "st,stm32mp1-iwdg"
> 
> Please format one per line.

OK

> 
>> +- reg: Physical base address and length of the registers set for the device
>> +- clocks: Reference to the clock entry lsi. Additional pclk clock entry
>> +  is required only for st,stm32mp1-iwdg.
>> +- clock-names: Name of the clocks used.
>> +  "lsi" for st,stm32-iwdg
>> +  "pclk", "lsi" for st,stm32mp1-iwdg
> 
> Put lsi 1st so it is always index 0.

OK

> 
>>   
>>   Optional Properties:
>>   - timeout-sec: Watchdog timeout value in seconds.
>>   
>> -Example:
>> +Examples:
>>   
>>   iwdg: watchdog at 40003000 {
>>   	compatible = "st,stm32-iwdg";
>>   	reg = <0x40003000 0x400>;
>>   	clocks = <&clk_lsi>;
>> +	clock-names = "lsi";
>> +	timeout-sec = <32>;
>> +};
>> +
>> +iwdg: iwdg at 5a002000 {
> 
> watchdog at ...

sorry, I forget this occurrence.

> 
> Do we really need 2 example just to show 2 clocks?

No, I could keep only one

> 
>> +	compatible = "st,stm32mp1-iwdg";
>> +	reg = <0x5a002000 0x400>;
>> +	clocks = <&rcc IWDG2>, <&clk_lsi>;
>> +	clock-names = "pclk", "lsi";
>>   	timeout-sec = <32>;
>>   };
