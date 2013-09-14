From: b.brezillon@overkiz.com (boris brezillon)
Date: Sat, 14 Sep 2013 09:08:24 +0200
Subject: [RFC PATCH alt 4/4] pinctrl: at91: rework debounce configuration
In-Reply-To: <52339479.6030402@wwwdotorg.org>
References: <1379058213-3245-1-git-send-email-b.brezillon@overkiz.com>
 <1379058813-3489-1-git-send-email-b.brezillon@overkiz.com>
 <52339479.6030402@wwwdotorg.org>
Message-ID: <52340B68.5020505@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Stephen,

Le 14/09/2013 00:40, Stephen Warren a ?crit :
> On 09/13/2013 01:53 AM, Boris BREZILLON wrote:
>> AT91 SoCs do not support per pin debounce time configuration.
>> Instead you have to configure a debounce time which will be used for all
>> pins of a given bank (PIOA, PIOB, ...).
>> diff --git a/Documentation/devicetree/bindings/pinctrl/atmel,at91-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/atmel,at91-pinctrl.txt
>> +Optional properties for iomux controller:
>> +- atmel,default-debounce-div: array of debounce divisors (one divisor per bank)
>> +  which describes the debounce timing in use for all pins of a given bank
>> +  configured with the DEBOUNCE option (see the following description).
>> +  Debounce timing is obtained with this formula:
>> +  Tdebounce = 2 * (debouncediv + 1) / Fslowclk
>> +  with Fslowclk = 32KHz
>> +
>>   Required properties for pin configuration node:
>>   - atmel,pins: 4 integers array, represents a group of pins mux and config
>>     setting. The format is atmel,pins = <PIN_BANK PIN_BANK_NUM PERIPH CONFIG>.
>> @@ -91,7 +99,6 @@ DEGLITCH	(1 << 2): indicate this pin need deglitch.
>>   PULL_DOWN	(1 << 3): indicate this pin need a pull down.
>>   DIS_SCHMIT	(1 << 4): indicate this pin need to disable schmit trigger.
>>   DEBOUNCE	(1 << 16): indicate this pin need debounce.
>> -DEBOUNCE_VAL	(0x3fff << 17): debounce val.
> This change would break the DT ABI since it removes a feature that's
> already present.

I missed this point in my cons list.
This won't be an issue for in kernel DT definitions (nobody is currently 
using the
DEBOUCE option), but may be for out-of-tree DT definitions.

> I suppose it's still up to the Atmel maintainers to decide whether this
> is appropriate, or whether the impact to out-of-tree DT files would be
> problematic.
>
> Assuming the DT ABI can be broken, I think I'd prefer to do so, rather
> than take "non-alt" patch 4/4, since a per-pin DEBOUNCE_VAL clearly
> doesn't correctly model the HW, assuming the patch description is
> correct. I don't think arguments re: the generic pinconf debounce
> property hold; if the Linux-specific/internal generic property doesn't
> apply, the DT binding should not be bent to adjust to it, but should
> rather still represent the HW itself.

What about the last point in my list: "reconfigure debounce after startup" ?

Here is an example that may be problematic:

Let's say you have one device using multiple configuration of pins 
("default", "xxx", "yyy").
The "default" config needs a particular debounce time on a given pin and 
the "xxx" and "yyy"
configs need different debounce time on the same pin.

How would you solve this with this patch approach ?


Best Regards,

Boris
