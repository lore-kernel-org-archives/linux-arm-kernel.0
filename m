From: stefan@agner.ch (Stefan Agner)
Date: Thu, 17 Mar 2016 15:12:24 -0700
Subject: [PATCH 14/18] gpio: vf610: add support for WKPU unit
In-Reply-To: <20160317200054.GA3799@rob-hp-laptop>
References: <1457576219-7971-1-git-send-email-stefan@agner.ch>
 <1457576219-7971-15-git-send-email-stefan@agner.ch>
 <20160317200054.GA3799@rob-hp-laptop>
Message-ID: <752bcc77253ae252c5a9928116b96b44@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On 2016-03-17 13:00, Rob Herring wrote:
> On Wed, Mar 09, 2016 at 06:16:55PM -0800, Stefan Agner wrote:
>> WKPU unit support within the VF610 GPIO driver. The WKPU unit allows
>> some GPIO to be the wakeup source from lowest power modes LPSTOPx.
>> The relationship between the GPIO banks and the WKPU GPIO numbering
>> can be derived from the device tree property fsl,gpio-wakeup.
>>
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>> ---
>>  .../devicetree/bindings/gpio/gpio-vf610.txt        |   6 +
>>  drivers/gpio/gpio-vf610.c                          | 151 +++++++++++++++++++++
>>  2 files changed, 157 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/gpio/gpio-vf610.txt b/Documentation/devicetree/bindings/gpio/gpio-vf610.txt
>> index 436cc99..985ddfd 100644
>> --- a/Documentation/devicetree/bindings/gpio/gpio-vf610.txt
>> +++ b/Documentation/devicetree/bindings/gpio/gpio-vf610.txt
>> @@ -22,6 +22,12 @@ Required properties for GPIO node:
>>        4 = active high level-sensitive.
>>        8 = active low level-sensitive.
>>
>> +Option properties:
> 
> Optional
> 
>> +- fsl,gpio-wakeup : map GPIOs to WKPU unit, 3 argument cells per phandle
> 
> phandle to what?
> 
>> +      cell 1: First GPIO (relative to the GPIO block)
>> +      cell 2: First GPIO of the WKPU unit
>> +      cell 3: Number of consecutive GPIO's
> 
> An interrupt-map could work here instead even though I'm guessing you 
> don't make the WKPU an interrupt parent. Your table would look something 
> like this:
> 
> <WKPU# <&gpio> GPIO#>
> 

Hm, that would need two interrupt parents since the main interrupt for
the GPIO's would still be GIC...


>> +
>>  Note: Each GPIO port should have an alias correctly numbered in "aliases"
>>  node.
>>
>> diff --git a/drivers/gpio/gpio-vf610.c b/drivers/gpio/gpio-vf610.c
>> index 1a022be..650a41a 100644
>> --- a/drivers/gpio/gpio-vf610.c
>> +++ b/drivers/gpio/gpio-vf610.c
> 
> The WKPU seems to purely be an interrupt controller. Perhaps you should 
> use stacked irq domain here. Then it would not be tied into the GPIO 
> controller at all.

It actually allows to configure pull-up/downs, that is why I chose to
implement it as a GPIO controller. Although the pull-up/down part is not
implemented yet.

But when I think about it, it actually is probably more a pinctrl with
interrupt capabilities?

--
Stefan
