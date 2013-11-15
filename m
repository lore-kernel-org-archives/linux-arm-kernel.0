From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 16 Nov 2013 00:28:32 +0300
Subject: [PATCH v2 2/3] ARM: shmobile: Koelsch: add Ether support
In-Reply-To: <2664891.LKK7X6OLFJ@avalon>
References: <201311150217.23563.sergei.shtylyov@cogentembedded.com>
 <201311150221.12125.sergei.shtylyov@cogentembedded.com>
 <2664891.LKK7X6OLFJ@avalon>
Message-ID: <52869200.3080303@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 11/15/2013 02:06 AM, Laurent Pinchart wrote:

>> Register Ether platform device and pin data on  the  Koelsch board.
>> Register platform fixup for Micrel KSZ8041 PHY, just like on the Lager
>> board.

>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

>> ---
>> Changes in version 2:
>> - added *if* (IS_ENABLED(CONFIG_PHYLIB)) around phy_register_fixup_for_id()
>>    call;
>> - changed Ether device name to "r8a779x-ether".

>>   arch/arm/mach-shmobile/board-koelsch.c |   63 ++++++++++++++++++++++++++++-
>>   1 file changed, 62 insertions(+), 1 deletion(-)

>> Index: renesas/arch/arm/mach-shmobile/board-koelsch.c
>> ===================================================================
>> --- renesas.orig/arch/arm/mach-shmobile/board-koelsch.c
>> +++ renesas/arch/arm/mach-shmobile/board-koelsch.c
[...]
>> @@ -84,6 +119,32 @@ static void __init koelsch_add_standard_
>>   				      sizeof(koelsch_keys_pdata));
>>   }
>>
>> +/*
>> + * Ether LEDs on the Koelsch board are named LINK and ACTIVE which
>> corresponds + * to non-default 01 setting of the Micrel KSZ8041 PHY control
>> register 1 bits + * 14-15. We have to set them back to 01 from the default
>> 00 value each time + * the PHY is reset. It's also important because the
>> PHY's LED0 signal is + * connected to SoC's ETH_LINK signal and in the
>> PHY's default mode it will + * bounce on and off after each packet, which
>> we apparently want to avoid. + */
>> +static int koelsch_ksz8041_fixup(struct phy_device *phydev)
>> +{
>> +	u16 phyctrl1 = phy_read(phydev, 0x1e);
>> +
>> +	phyctrl1 &= ~0xc000;
>> +	phyctrl1 |= 0x4000;
>> +	return phy_write(phydev, 0x1e, phyctrl1);
>> +}
>> +
>> +static void __init koelsch_init(void)
>> +{
>> +	koelsch_add_standard_devices();
>> +
>> +	if (IS_ENABLED(CONFIG_PHYLIB))
>> +		phy_register_fixup_for_id("r8a779x-ether-ff:01",
>> +					  koelsch_ksz8041_fixup);

> This is fine with board code, but will break when we'll switch to DT. Would it
> be difficult to replace board code by using the existing micrel phy driver
> (drivers/net/phy/micrel.c) which should support the ksz8041 already and

    The first issue here is KSZ8041 on the BOCK-W/Lager/Koelsch boards uses 
undocumented PHY ID for some reason, so the current driver doesn't really 
support it. :-)

> extending it with support for register 0x1e which doesn't seem to be handled ?

    You probably didn't quite understand the purpose of the platform PHY 
fixup. It's designed to do the board-specific changes, not the driver-specific 
changes. In this case, the setting of the bits 14-15 of the PHY control 
register 1 (w/address 0x1E) purely depends on the board schematics and simply 
can't be selected by the PHY driver.
    It could have been set by the PHY driver iff we would find a way to pass 
the platform data to the PHY device (on the automatically probed MDIO bus).
    We can also ignore ETH_LINK signal altogether in the 'sh_eth' driver 
(because it would bounce on/off on each packet) and stop caring about the LED 
function matching to what's designed for the board.
    Also we can stop resetting PHY in the 'sh_eth' driver -- that should help 
(the platform fixup was mainly added to work around this reset but DaveM 
didn't take my simple 'sh_eth' patch), although not with PHY resets done via 
phy_mii_ioctl()...

WBR, Sergei
