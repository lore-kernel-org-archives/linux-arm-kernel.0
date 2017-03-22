From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 22 Mar 2017 14:12:49 -0700
Subject: [PATCH] ARM: dts: sun7i: lamobo-r1: Fix CPU port RGMII settings
In-Reply-To: <CAGb2v65KvoC9MUoErkGeHvmbm8Ocq-vhFBhxXvZu--=xT4zAeg@mail.gmail.com>
References: <20170319045039.6163-1-f.fainelli@gmail.com>
 <CAGb2v65KvoC9MUoErkGeHvmbm8Ocq-vhFBhxXvZu--=xT4zAeg@mail.gmail.com>
Message-ID: <3d32f497-e875-2a55-5908-78de880640bc@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Chen-Yu,

On 03/21/2017 09:06 PM, Chen-Yu Tsai wrote:
> Hi Florian,
> 
> On Sun, Mar 19, 2017 at 12:50 PM, Florian Fainelli <f.fainelli@gmail.com> wrote:
>> The CPU port of the BCM53125 is configured with RGMII (no delays) but
>> this should actually be RGMII with transmit delay (rgmii-txid) because
>> STMMAC takes care of inserting the transmitter delay. This fixes
>> occasional packet loss encountered.
>>
>> Fixes: d7b9eaff5f0c ("ARM: dts: sun7i: Add BCM53125 switch nodes to the lamobo-r1 board")
>> Reported-by: Hartmut Knaack <knaack.h@gmx.de>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>>  arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts b/arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts
>> index 72ec0d5ae052..bbf1c8cbaac6 100644
>> --- a/arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts
>> +++ b/arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts
>> @@ -167,7 +167,7 @@
>>                                         reg = <8>;
>>                                         label = "cpu";
>>                                         ethernet = <&gmac>;
>> -                                       phy-mode = "rgmii";
>> +                                       phy-mode = "rgmii-txid";
> 
> Just to clarify, the DT binding says:
> 
>   * "rgmii-txid" (RGMII with internal TX delay provided by the PHY, the MAC
>      should not add an TX delay in this case)
> 
> I'm assuming this applies from the device node's point of view?
> In this case the "PHY" is STMMAC, and the "MAC" is the switch chip?
> Is that right?

It's actually a MAC to MAC type of set up here, so the definition of the
property kind of still applies, with the caveat that we need to make
sure that if one side uses "rgmii", the other one uses "rgmii-txid"
which is what is being done here. I think I typoed in the commit message
in that it should read "STMMAC does not take care of inserting the
transmitter delay here" which is why the switch must do it.

Thanks!
-- 
Florian
