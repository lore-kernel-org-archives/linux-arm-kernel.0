From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 3 Jun 2016 15:32:11 +0200
Subject: [PATCH v2 1/2] usb: ohci-at91: Forcibly suspend ports while USB
 suspend
In-Reply-To: <B256D81BAE5131468A838E5D7A24364101650B1491@penmbx01>
References: <1464755400-6825-1-git-send-email-wenyou.yang@atmel.com>
 <1464755400-6825-2-git-send-email-wenyou.yang@atmel.com>
 <20160603015409.GA18051@rob-hp-laptop>
 <B256D81BAE5131468A838E5D7A24364101650B1491@penmbx01>
Message-ID: <575186DB.6030405@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 03/06/2016 11:22, Yang, Wenyou a ?crit :
>> -----Original Message-----
>> From: Rob Herring [mailto:robh at kernel.org]
>> Sent: 2016?6?3? 9:54
>> To: Yang, Wenyou <Wenyou.Yang@atmel.com>
>> Cc: Alan Stern <stern@rowland.harvard.edu>; Greg Kroah-Hartman
>> <gregkh@linuxfoundation.org>; Ferre, Nicolas <Nicolas.FERRE@atmel.com>;
>> Pawel Moll <pawel.moll@arm.com>; Mark Brown <broonie@kernel.org>; Ian
>> Campbell <ijc+devicetree@hellion.org.uk>; Kumar Gala <galak@codeaurora.org>;
>> Alexandre Belloni <alexandre.belloni@free-electrons.com>; linux-
>> kernel at vger.kernel.org; devicetree at vger.kernel.org; linux-arm-
>> kernel at lists.infradead.org; linux-usb at vger.kernel.org
>> Subject: Re: [PATCH v2 1/2] usb: ohci-at91: Forcibly suspend ports while USB
>> suspend
>>
>> On Wed, Jun 01, 2016 at 12:29:59PM +0800, Wenyou Yang wrote:
>>> In order to the save power consumption, as a workaround, suspend
>>> forcibly the USB PORTA/B/C via set the SUSPEND_A/B/C bits of OHCI
>>> Interrupt Configuration Register in the SFRs while OHCI USB suspend.
>>>
>>> This suspend operation must be done before the USB clock is disabled,
>>> resume after the USB clock is enabled.
>>>
>>> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
>>> ---
>>>
>>> Changes in v2:
>>>  - Add compatible to support forcibly suspend the ports.
>>>  - Add soc/at91/at91_sfr.h to accommodate the defines.
>>>  - Add error checking for .sfr_regmap.
>>>  - Remove unnecessary regmap_read() statement.
>>>
>>>  .../devicetree/bindings/usb/atmel-usb.txt          |  5 +-
>>>  drivers/usb/host/ohci-at91.c                       | 80 +++++++++++++++++++++-
>>>  include/soc/at91/at91_sfr.h                        | 29 ++++++++
>>>  3 files changed, 111 insertions(+), 3 deletions(-)  create mode
>>> 100644 include/soc/at91/at91_sfr.h
>>>
>>> diff --git a/Documentation/devicetree/bindings/usb/atmel-usb.txt
>>> b/Documentation/devicetree/bindings/usb/atmel-usb.txt
>>> index 5883b73..3e3e58a 100644
>>> --- a/Documentation/devicetree/bindings/usb/atmel-usb.txt
>>> +++ b/Documentation/devicetree/bindings/usb/atmel-usb.txt
>>> @@ -3,8 +3,9 @@ Atmel SOC USB controllers  OHCI
>>>
>>>  Required properties:
>>> - - compatible: Should be "atmel,at91rm9200-ohci" for USB controllers
>>> -   used in host mode.
>>> + - compatible: Should be one of the following
>>> +	       "atmel,at91rm9200-ohci" for USB controllers used in host mode.
>>> +	       "atmel,sama5d2-ohci" for SAMA5D2 which can force to suspend.
>>
>> That may be why you need this now, but that is irrelevant to having a chip specific
>> compatible string.
> 
> Maybe a property is better.

It seems that it's not an issue to the binding that Rob is talking about
but the description that you used: "for SAMA5D2 which can force
suspend". Don't modify it to use a property for this: a compatible sting
makes a lot of sense.

So just listing the new compatible string is enough. If the "force
suspend" is not needed anymore in next product, we will come back to the
"atmel,at91rm9200-ohci" compatible string or add a new one if needed...

bye,
-- 
Nicolas Ferre
