From: megous@megous.com (=?UTF-8?Q?Ond=c5=99ej_Jirman?=)
Date: Fri, 1 Jul 2016 03:17:35 +0200
Subject: [linux-sunxi] [PATCH v2 14/14] ARM: dts: sun8i: Enable DVFS on
 Orange Pi One
In-Reply-To: <20160630172330.0608178e@i7>
References: <20160625034511.7966-1-megous@megous.com>
 <20160625034511.7966-15-megous@megous.com>
 <CAOMqctTe==M1SXxbdR8y33yh51fiFGn+oSaKJXhbnpLVTn-New@mail.gmail.com>
 <20160630172330.0608178e@i7>
Message-ID: <247afcd4-4b5c-3776-5392-1125b03b65b1@megous.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 30.6.2016 16:23, Siarhei Siamashka wrote:
> On Thu, 30 Jun 2016 13:13:48 +0200
> Michal Suchanek <hramrach@gmail.com> wrote:
> 
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
> Maybe try the Allwinner's original DVFS table instead of these
> undervolted values and see if it helps?
> 
> https://linux-sunxi.org/index.php?title=Xunlong_Orange_Pi_PC&oldid=17753#CPU_clock_speed_limit

Thanks, I'll use these. I'm not sure what will happen if regulator is
not capable of providing the exact voltages specified in the operating
points, though. Will it do the sane thing? :)

Also LV6+ in the table is bellow specified minimum voltage in the
datasheet. But then Orange Pi works at much lower voltages for me.

Conversly LV1 is the absolute maximum. Recommended maximum is 1.4V So I
would not use that.

It might be nice to have something like that dram clock test, but for
cpux freq/voltage, and collect some statistics.

regards,
  Ondrej

> While undervolting is tempting because it helps to decrease the SoC
> temperature and avoid throttling, different units may have different
> tolerances and one needs to be very careful when picking defaults
> that are intended to work correctly on all boards. Some safety
> headroom exists there for a reason.
> 
> If I remember correctly, some people pushed for undervolting experiments
> at least twice in the past (on the Banana Pi and C.H.I.P.). In both
> cases this did not end up well and had to be fixed later to solve
> reliability problems.
> 
> In order to allow individual per-unit tuning, a concept of "speed
> grading" may be probably introduced later. So that the board is tested
> for reliability and then the speed grade rating is stored somewhere on
> the non-removable storage (EEPROM, SPI flash, eFUSE, ...). Some SoC
> manufacturers, such as Samsung, are already doing this with their chips.
> 

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160701/e09949b2/attachment.sig>
