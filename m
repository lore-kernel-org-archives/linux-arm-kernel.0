From: j-keerthy@ti.com (Keerthy)
Date: Wed, 13 Sep 2017 11:20:23 +0530
Subject: da850.dtsi Naming convention Question
In-Reply-To: <27e31de3-ec41-80e1-d1a3-d468df1f5282@ti.com>
References: <CAHCN7xJ7N6W2Pz1vsVV192V-s0g6q+ozvNBR21rx6LufJ4kR6g@mail.gmail.com>
 <d92f726f-8a84-14ac-571e-f405255fed0b@ti.com>
 <CAHCN7xJosHuuPWUkr=ettc8gWgx9m6PvbFe90f2FnvT0meZVUA@mail.gmail.com>
 <27e31de3-ec41-80e1-d1a3-d468df1f5282@ti.com>
Message-ID: <29f004d7-0a3e-65a0-bbdc-535ea37a274d@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Wednesday 13 September 2017 11:05 AM, Sekhar Nori wrote:
> On Tuesday 12 September 2017 08:58 PM, Adam Ford wrote:
>> That makes a lot of sense, but I have a followup question.  Why would
>> we only have 1 gpio registered at 22600 when we have multiple banks?
>> Again, I am comparing this to the Omap3 because I have more experience
>> with that, and they register each bank separately.
>>
>> The datasheet breaks it up into small banks, 0-1, 2-3, 4-5, 6-7 and 8
>> yet the device tree shows ti,ngpio = <144> and
>> ti,davinci-gpio-unbanked = <0>;
Adam,

Yes there are 9 banks and each of them have a banked interrupt. Hence

gpio: gpio at 226000 {
                        compatible = "ti,dm6441-gpio";
                        gpio-controller;
                        #gpio-cells = <2>;
                        reg = <0x226000 0x1000>;
                        interrupts = <42 IRQ_TYPE_EDGE_BOTH
                                43 IRQ_TYPE_EDGE_BOTH 44 IRQ_TYPE_EDGE_BOTH
                                45 IRQ_TYPE_EDGE_BOTH 46 IRQ_TYPE_EDGE_BOTH
                                47 IRQ_TYPE_EDGE_BOTH 48 IRQ_TYPE_EDGE_BOTH
                                49 IRQ_TYPE_EDGE_BOTH 50
IRQ_TYPE_EDGE_BOTH>;
                        ti,ngpio = <144>;
                        ti,davinci-gpio-unbanked = <0>;
                        status = "disabled";
                        interrupt-controller;
                        #interrupt-cells = <2>;
                };

So this one node caters to all of the 9 banks. Instead of adding all
banks separately in device tree i was suggested to add one node which
caters to all 9 banks. Each of the 9 banks have a banked interrupt.
I have seen OMAPs having multiple DT nodes for every 32 GPIOs.

Check this commit id: b5cf3fd827d2e11355c126b44ea625650ebf4d39

Also the discussion where in was suggested to have one big gpio chip:

https://www.spinics.net/lists/linux-omap/msg132869.html


> 
> Adding Keerthy for this. He maintains the DaVinci GPIO driver and is
> much more familiar with it.
> 
>> I only ask as I am trying to get more familiar with this platform, and
>> I am trying to enhance improve the da850-evm which I realize has been
>> replaced by the lcdk.

Thanks,
Keerthy

> 
> No problem. Thanks for your work on this platform!
> 
> Regards,
> Sekhar
> 
