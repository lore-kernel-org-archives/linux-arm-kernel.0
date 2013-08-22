From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 22 Aug 2013 10:10:14 -0400
Subject: [PATCH 2/8] clk: keystone: Add gate control clock driver
In-Reply-To: <20130822081256.8231.50781@quantum>
References: <1375719147-7578-1-git-send-email-santosh.shilimkar@ti.com>
 <20130813165344.GU27165@e106331-lin.cambridge.arm.com>
 <20130819204353.4443.48466@quantum> <5213756A.5090903@ti.com>
 <20130820213045.4443.89971@quantum> <5213E5EC.8070208@ti.com>
 <20130820224128.4443.78729@quantum> <5213F397.6020708@ti.com>
 <20130821022225.4443.97467@quantum> <5214BDB1.9080503@ti.com>
 <20130822081256.8231.50781@quantum>
Message-ID: <52161BC6.1050905@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 22 August 2013 04:12 AM, Mike Turquette wrote:
> Quoting Santosh Shilimkar (2013-08-21 06:16:33)
>> On Tuesday 20 August 2013 10:22 PM, Mike Turquette wrote:
>>> Quoting Santosh Shilimkar (2013-08-20 15:54:15)
>>>> On Tuesday 20 August 2013 06:41 PM, Mike Turquette wrote:
>>>>> Quoting Santosh Shilimkar (2013-08-20 14:55:56)
>>>>>> On Tuesday 20 August 2013 05:30 PM, Mike Turquette wrote:
>>>>
>>>> [...]
>>>>
>>>>>>>> They are bit different w.r.t OMAP. LPSC itself is the clock control of the
>>>>>>>> IP. The LPSC number in the bindings is actually the specific number which
>>>>>>>> is used to reach to the address space of the clock control. One can view
>>>>>>>> that one as clock control register index.
>>>>>>>
>>>>>>> Thanks for the information. I have a further question about then: are
>>>>>>> the LPSC clocks really module clocks that belong to the IP that they are
>>>>>>> gating?
>>>>>>>
>>>>>> LPSC controls the clock enable/disable to the IP/module so answer is yes.
>>>>>> In certain cases LPSC controls clock to more than one IP as well.
>>>>>>
>>>>>>> If so then they could be defined within the node defining their parent
>>>>>>> IP. That might be enough to get rid of the LPSC index value. Again I
>>>>>>> might be over-engineering it. Just trying to get an understanding.
>>>>>>>
>>>>>> Am not sure I follow you here on not having the LPSC index. Sorry. 
>>>>>
>>>>> How are the 'reg' property and the 'lpsc' property related? Does the
>>>>> lpsc property modify the register address used to access the clock
>>>>> control bits?
>>>>>
>>>> Yes it does. Currently all nodes use fix address and then lpsc is
>>>> used as an index.
>>>
>>> Ok cool. Well the reason I brought that up was because I even had the
>>> idea to define these module clocks within the module nodes that own them
>>> in DT. I am way outside of my DT knowledge at this point but I wonder
>>> if the following type of binding is possible:
>>>
>>> module: module at 4a308200 {
>>>       #address-cells = <1>;
>>>       #size-cells = <1>;
>>>       reg = <0x4a308200 0x1000>;
>>>
>>>       clock {
>>>               #clock-cells = <0>;
>>>               compatible = "keystone,psc-clk";
>>>               clocks = <&chipclk3>;
>>>               clock-output-names = "debugss_trc";
>>>               reg = <0x0256>;
>>>               pd = <1>;
>>>       };
>>> };
>>>
>>> Again, my DT knowledge is pretty limited, but could the reg property of
>>> the clock be directly affected by the parent node? That seems like it
>>> could nicely model what the hardware is really doing.
>>>
>> The module(I assume you mean IP here) reg address space is separate than
>> that used for clock control so that doesn't fit as such. Traditionally
>> clock controls even though targeted for specific modules sits in different
>> control as at least seen on OMAP and Keystone. OCP wrappers on OMAP
>> were bit of exceptions but they were little bit of glue logic without
>> much control within the address space.
> 
> Great, you perfectly answered my questions. I think that assigning the
> "final" address to the 'reg' property is the right way to go (fixed
> address + LPSC index).
> 
Thanks Mike.

Regards,
Santosh
