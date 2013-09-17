From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 17 Sep 2013 10:17:23 -0600
Subject: [PATCH v3] PWM: PXA: add device tree support to PWM driver
In-Reply-To: <5238621D.3050504@newsguy.com>
References: <1379091281-23662-1-git-send-email-mikedunn@newsguy.com>
 <52375FB1.5050700@wwwdotorg.org> <5238621D.3050504@newsguy.com>
Message-ID: <52388093.2000401@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/17/2013 08:07 AM, Mike Dunn wrote:
> On 09/16/2013 12:44 PM, Stephen Warren wrote:
>> On 09/13/2013 10:54 AM, Mike Dunn wrote:
>>> This patch adds device tree support to the PXA's PWM driver.  Only an OF match
>>> table is added; nothing needs to be extracted from the device tree node.  The
>>> existing ID table is reused for the match table data.
>>>
>>> Tested on a Palm Treo 680 (both platform data and DT cases).
>>
>>> diff --git a/Documentation/devicetree/bindings/pwm/pxa-pwm.txt b/Documentation/devicetree/bindings/pwm/pxa-pwm.txt
>>
>>> +- compatible: should be one of:
>>> +  - "marvell,pxa250-pwm"
>>> +  - "marvell,pxa270-pwm"
>>> +  - "marvell,pxa168-pwm"
>>> +  - "marvell,pxa910-pwm"
>>
>> Not just one of, but possible more than one...
> 
> So the phrasing should be "compatible: should be among:" ?

I think I've seen "One or more of".


>>> diff --git a/arch/arm/boot/dts/pxa27x.dtsi b/arch/arm/boot/dts/pxa27x.dtsi
>>
>>> +		pwm0: pwm at 40b00000 {
>>> +			compatible = "marvell,pxa270-pwm";
>>
>> I thought the assertion was that pax270 and pxa250 were both compatible?
>> If so, that should be:
>>
>> 		compatible = "marvell,pxa270-pwm", "marvell,pxa250-pwm";
> 
> 
> Indeed.  Currently, they are all the same.  By that logic, shouldn't it be
> 
> compatible = "marvell,pxa250-pwm", "marvell,pxa270-pwm", "marvell,pxa168-pwm",
> "marvell,pxa910-pwm";

compatible should include:

* The exact HW model (so the driver knows exactly which HW is present in
order to enable any bug quirks).
* The "first" HW model this HW is compatible with, since this is what
the driver will bind to (ignoring the possibility of bug quirks).

So, you don't need to include all the values, just two in this case.
