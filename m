From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 01 Nov 2013 00:24:56 +0300
Subject: [PATCH 2/2] ARM: shmobile: Koelsch: add Ether support
In-Reply-To: <20131031050215.GH1603@verge.net.au>
References: <201310310216.28673.sergei.shtylyov@cogentembedded.com>
 <201310310219.58963.sergei.shtylyov@cogentembedded.com>
 <20131031050215.GH1603@verge.net.au>
Message-ID: <5272CAA8.8070407@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 10/31/2013 08:02 AM, Simon Horman wrote:

>> Register Ether platform device and pin data on  the  Koelsch board.
>> Register platform fixup for Micrel KSZ8041 PHY, just like on the Lager board.

>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

> Thanks, I have been able to use this to successfully boot a Koelsch board
> using nfsroot.  However, I believe there is a minor build problem which I
> have commented on below.

    Yes, there is. Unfortunately, I haven't tested the build with 
koelsch_defconfig...

>> ---
>>   arch/arm/mach-shmobile/board-koelsch.c |   61 ++++++++++++++++++++++++++++++++-
>>   1 file changed, 60 insertions(+), 1 deletion(-)

>> Index: renesas/arch/arm/mach-shmobile/board-koelsch.c
>> ===================================================================
>> --- renesas.orig/arch/arm/mach-shmobile/board-koelsch.c
>> +++ renesas/arch/arm/mach-shmobile/board-koelsch.c
[...]
>> @@ -83,6 +118,30 @@ static void __init koelsch_add_standard_
>>   				      sizeof(koelsch_keys_pdata));
>>   }
>>
>> +/*
>> + * Ether LEDs on the Koelsch board are named LINK and ACTIVE which corresponds
>> + * to non-default 01 setting of the Micrel KSZ8041 PHY control register 1 bits
>> + * 14-15. We have to set them back to 01 from the default 00 value each time
>> + * the PHY is reset. It's also important because the PHY's LED0 signal is
>> + * connected to SoC's ETH_LINK signal and in the PHY's default mode it will
>> + * bounce on and off after each packet, which we apparently want to avoid.
>> + */
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
>> +	phy_register_fixup_for_id("r8a7790-ether-ff:01", koelsch_ksz8041_fixup);

> It seems to me that this code requires CONFIG_PHYLIB in order to compile.

    Not really -- only in order to link.

> So I propose the following enhancement to this patch which replaces
> the line immediately above.

> 	if (IS_ENABLED(CONFIG_PHYLIB))
> 		phy_register_fixup_for_id("r8a7790-ether-ff:01",
> 					  koelsch_ksz8041_fixup);

    Strictly speaking, this is not enough. I'm getting:

arch/arm/mach-shmobile/built-in.o: In function `koelsch_ksz8041_fixup':
platsmp-apmu.c:(.text+0xb8): undefined reference to `mdiobus_read'
platsmp-apmu.c:(.text+0xd0): undefined reference to `mdiobus_write'
arch/arm/mach-shmobile/built-in.o: In function `koelsch_init':
platsmp-apmu.c:(.init.text+0xa90): undefined reference to 
`phy_register_fixup_for_id'

So I guess the fixup function should be enclosed into #ifdef CONFIG_PHYLIB 
too. However, in practice this change seems enough (gcc probably drops unused 
static functions?)...

> I believe a similar enhancement is also needed for board-lager.c
> which I just realised does not compile if CONFIG_PHYLIB is not set.

    I believe you meant to say it doesn't link too.

WBR, Sergei
