From: hramrach@gmail.com (Michal Suchanek)
Date: Fri, 1 Jul 2016 12:54:54 +0200
Subject: [linux-sunxi] [PATCH v2 14/14] ARM: dts: sun8i: Enable DVFS on
 Orange Pi One
In-Reply-To: <CAOMqctR+SBfo9UZxXuACz858ehXpa2jGHZw_-70dbUFX3Q_0CQ@mail.gmail.com>
References: <20160625034511.7966-1-megous@megous.com>
 <20160625034511.7966-15-megous@megous.com>
 <CAOMqctTe==M1SXxbdR8y33yh51fiFGn+oSaKJXhbnpLVTn-New@mail.gmail.com>
 <834b8045-d99f-74a3-0353-aa84b897351d@megous.com>
 <CAOMqctSbJOB67a=LiCZVUb-wUMCpeJPd81OL5epYkC2p5X1T-g@mail.gmail.com>
 <CAOMqctR+SBfo9UZxXuACz858ehXpa2jGHZw_-70dbUFX3Q_0CQ@mail.gmail.com>
Message-ID: <CAOMqctRWBkPdFtJMZmXErpWjK3JABKNyfK=ceFCW4CSYLgwm7A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30 June 2016 at 17:50, Michal Suchanek <hramrach@gmail.com> wrote:
> On 30 June 2016 at 17:16, Michal Suchanek <hramrach@gmail.com> wrote:
>> On 30 June 2016 at 16:19, Ond?ej Jirman <megous@megous.com> wrote:
>>> Hello,
>>)k, so I tried>
>>> On 30.6.2016 13:13, Michal Suchanek wrote:
>>>> Hello,
>>>>
>>>> On 25 June 2016 at 05:45,  <megous@megous.com> wrote:
>>>>> From: Ondrej Jirman <megous@megous.com>
>>>>>
>>>>> Use Xulong Orange Pi One GPIO based regulator for
>>>>> passive cooling and thermal management.
>>>>>
>>>>> Signed-off-by: Ondrej Jirman <megous@megous.com>
>>>>> ---
>>>>>  arch/arm/boot/dts/sun8i-h3-orangepi-one.dts | 39 +++++++++++++++++++++++++++++
>>>>>  1 file changed, 39 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts
>>>>> index b1bd6b0..a38d871 100644
>>>>> --- a/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts
>>>>> +++ b/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts
>>>>> @@ -109,6 +109,45 @@
>>>>>         };
>>>>>  };
>>>>>
>>>>> +&cpu0 {
>>>>> +       operating-points = <
>>>>> +               /* kHz    uV */
>>>>> +               1296000 1300000
>>>>> +               1200000 1300000
>>>>
>>>> First problem is that the board boots at 1008000 which is not listed
>>>> and the kernel complains.
>>>>
>>>> Second problem is that the board locks up during boot with this enabled.
>>>>
>>>> Do you have some suggestion for alternate configuration to test?
>>>
>>> Just to verify, did you test with the entire series applied? (especially
>>> the PLL1 clk application changes)
>>
>> Yes, I applied the whole series.
>>
>>>
>>> You may try dropping the highest operating point, it's probably overly
>>> optimistic for Orange Pi One.
>>>
>>> Is the power supply/cable you're using hard enough?
>>
>> I use a 7 port hub to power the board. It worked with some other small
>> devboards.
>>
>> The cable is some random Chinese USB to power jack adaptor with an
>> extra adaptor to fit the Pi socket. It looks ok but I did not test
>> this particular combination thoroughly.
>>
>>>
>>> Where during the boot process does it lock up?
>>
>> Usually sometime around enabling cpufreq  before getty starts.
>> Different runs and settings give slightly different results. In
>> particular adding the 1008000 point seems to make it go further.
>>
>> Removing all traces of the regulator, cpufreq and thermal I can boot
>> pretty much 100% to login prompt.
>>
>> I don't think the difference between 1GHz and 1.3GHz frequency on the
>> core would put much additional stress on the supply but I can try with
>> 35W PSU and some alternative cabling to be sure.
>>
>> I did some more tests and it seems 1008000 at 1.1V is fine but switching
>> to 1.3V crashes the board. Even with only the first 1.3V state. Maybe
>> there is need for some delay somewhere for the regulator to get
>> stable?
>>
>
> Hm, the AW table shows 1008000 at 1.3V as supported state and it indeed
> works. So the voltage switching works or does nothing. Can I measure
> the regulator output somewhere? Clocking the chip higher does not
> work.
>
> I will try with another PSU later.
>

Ok, so I tried. The result is the same.

A Chinese USB power meter shows voltage 5.1V which drops to like 4.95V
when the board is running. The power draw is around 170mA and
about 200mA when switch to 1.3V is attempted.
The voltage drop is not nice and is probably due to excessive cabling used
to distribute power to multiple boards.
The USB hub starts at 5.2V and drops to something like 5.1V.

When the top frequency is 1008000 at 1.3V and governor is performance
the board keeps running 1008000 at 1.1V as set up by u-boot.

Changing the top point to 1008000 at 1.1V the board locks up as soon as
governor is changed to conservative. So any attempt at frequency scaling
crashes even without touching the regulator.

Thanks

Michal
