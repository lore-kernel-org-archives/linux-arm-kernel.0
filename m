From: ivan.khoronzhuk@ti.com (Ivan Khoronzhuk)
Date: Tue, 20 May 2014 21:35:23 +0300
Subject: [Patch v3 0/5] Introduce keystone reset driver
In-Reply-To: <537B5D5D.8030106@ti.com>
References: <1400495155-11136-1-git-send-email-ivan.khoronzhuk@ti.com>
 <5095812.b6DgWAxYzH@wuerfel> <537B5598.8070603@ti.com>
 <5272855.vIyLIadgKe@wuerfel> <537B5D5D.8030106@ti.com>
Message-ID: <537BA06B.5060200@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 05/20/2014 04:49 PM, Santosh Shilimkar wrote:
> On Tuesday 20 May 2014 09:44 AM, Arnd Bergmann wrote:
>> On Tuesday 20 May 2014 16:16:08 Ivan Khoronzhuk wrote:
>>> Thank for the reply
>>>
>>> The reset driver uses two ranges:
>>> - RSTYPE, RSTCTRL,RSTCFG, RSISO  (Reset Main PLL Controller)
>>> - RESETMUX8-10 registers
>>>
>>> The content of these register ranges are completely used by the reset
>>> driver.
>>> Currently no one on the SoC can access them instead of the reset driver.
>>> Also we don't use syscon/regmap at all - so adding this will be some
>>> overhead.
>>>
>>> As I posted previously:
>>> "...configuring Reset multiplexer & PLL. And it tunes not only watchdog
>>> usage..."
>>>
>>> Yes, it tunes not only watchdog usage and uses part of registers from
>>> PLL controller,
>>> but all it works with are connected with reset functionality. These
>>> ranges are used only
>>> by reset driver and their purpose is reset functionality.
>>>
>>> Maybe in the future some soft can use ranges in question for own tasks,
>>> but it should be
>>> done via reset driver. So as I see there is no reasons to use regmap for
>>> reset driver.
>> You should not look at these registers in isolation, they are part of
>> some register area that has other functions as well and that you should
>> at least represent correctly in DT.
>>
>> When I see something like
>>
>> +                       reg = <0x23100e4 0x10>,
>> +                             <0x2620328 0x10>;
>>
>> I am certain that there are other things between 0x2310000 and 0x23100e3, and
>> probably after 0x23100f4 as well. There must be some data sheet that
>> gives this register range a proper name, so put that into DT rather than
>> making up some arbitrary stuff that happens to match how today's kernel
>> driver needs it.
>>
> Even though there are no other users, I think you have a valid point about
> DT representing the hardware layout in the correct form.
>
> Regards,
> Santosh
>

Thank for the note.

Ok.

Memory map:
[00 02310000 - 00 023101FF] size=512 PLL Controller
[00 02620000 - 00 02620FFF] size=4K device state control registers

I'll define in DT two new syscon compatible nodes like:

         pllctrl: pll_controller {
             compatible = "syscon";
             reg = <0x2310000 0x200>;
         };

         devctrl: device_state_control {
             compatible = "syscon";
             reg = <0x2620000 0x1000>;
         };


then correct reset-controller node like:

         rstctrl: reset-controller {
             compatible = "ti,keystone-reset";
             reg = <0xE4 0x10>, <0x328 0x10>;
             reg-names = "pllregs", "muxregs";
             syscon1 = <&pllctrl>;
             syscon2 = <&devctrl>;
             ti,wdt_list = <0>;
         };

And correct reset-controller code to get regmap by phandle,
then access registers by regmap.

Also I'll post two separate patches that add syscon nodes in question.

-- 
Regards,
Ivan Khoronzhuk
