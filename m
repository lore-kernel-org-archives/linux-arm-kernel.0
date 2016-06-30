From: hramrach@gmail.com (Michal Suchanek)
Date: Thu, 30 Jun 2016 17:16:36 +0200
Subject: [linux-sunxi] [PATCH v2 14/14] ARM: dts: sun8i: Enable DVFS on
 Orange Pi One
In-Reply-To: <834b8045-d99f-74a3-0353-aa84b897351d@megous.com>
References: <20160625034511.7966-1-megous@megous.com>
 <20160625034511.7966-15-megous@megous.com>
 <CAOMqctTe==M1SXxbdR8y33yh51fiFGn+oSaKJXhbnpLVTn-New@mail.gmail.com>
 <834b8045-d99f-74a3-0353-aa84b897351d@megous.com>
Message-ID: <CAOMqctSbJOB67a=LiCZVUb-wUMCpeJPd81OL5epYkC2p5X1T-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30 June 2016 at 16:19, Ond?ej Jirman <megous@megous.com> wrote:
> Hello,
>
> On 30.6.2016 13:13, Michal Suchanek wrote:
>> Hello,
>>
>> On 25 June 2016 at 05:45,  <megous@megous.com> wrote:
>>> From: Ondrej Jirman <megous@megous.com>
>>>
>>> Use Xulong Orange Pi One GPIO based regulator for
>>> passive cooling and thermal management.
>>>
>>> Signed-off-by: Ondrej Jirman <megous@megous.com>
>>> ---
>>>  arch/arm/boot/dts/sun8i-h3-orangepi-one.dts | 39 +++++++++++++++++++++++++++++
>>>  1 file changed, 39 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts
>>> index b1bd6b0..a38d871 100644
>>> --- a/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts
>>> +++ b/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts
>>> @@ -109,6 +109,45 @@
>>>         };
>>>  };
>>>
>>> +&cpu0 {
>>> +       operating-points = <
>>> +               /* kHz    uV */
>>> +               1296000 1300000
>>> +               1200000 1300000
>>
>> First problem is that the board boots at 1008000 which is not listed
>> and the kernel complains.
>>
>> Second problem is that the board locks up during boot with this enabled.
>>
>> Do you have some suggestion for alternate configuration to test?
>
> Just to verify, did you test with the entire series applied? (especially
> the PLL1 clk application changes)

Yes, I applied the whole series.

>
> You may try dropping the highest operating point, it's probably overly
> optimistic for Orange Pi One.
>
> Is the power supply/cable you're using hard enough?

I use a 7 port hub to power the board. It worked with some other small
devboards.

The cable is some random Chinese USB to power jack adaptor with an
extra adaptor to fit the Pi socket. It looks ok but I did not test
this particular combination thoroughly.

>
> Where during the boot process does it lock up?

Usually sometime around enabling cpufreq  before getty starts.
Different runs and settings give slightly different results. In
particular adding the 1008000 point seems to make it go further.

Removing all traces of the regulator, cpufreq and thermal I can boot
pretty much 100% to login prompt.

I don't think the difference between 1GHz and 1.3GHz frequency on the
core would put much additional stress on the supply but I can try with
35W PSU and some alternative cabling to be sure.

I did some more tests and it seems 1008000 at 1.1V is fine but switching
to 1.3V crashes the board. Even with only the first 1.3V state. Maybe
there is need for some delay somewhere for the regulator to get
stable?

Thanks

Michal
