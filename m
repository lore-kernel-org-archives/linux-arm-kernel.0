From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 27 May 2013 20:43:38 +0800
Subject: [PATCH v3] ARM: at91: Fix link breakage when !CONFIG_PHYLIB
In-Reply-To: <51A34BF9.5000905@atmel.com>
References: <1369651702-9207-1-git-send-email-alexandre.belloni@free-electrons.com>
 <51A34BF9.5000905@atmel.com>
Message-ID: <DB6D19D2-3060-4DF5-BCA5-CD52349FC5E1@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On May 27, 2013, at 8:05 PM, Nicolas Ferre <nicolas.ferre@atmel.com> wrote:

> On 27/05/2013 12:48, Alexandre Belloni :
>> Fixes:
>> arch/arm/mach-at91/built-in.o: In function `ksz9021rn_phy_fixup':
>> :(.text+0x1174): undefined reference to `mdiobus_write'
>> :(.text+0x1188): undefined reference to `mdiobus_write'
>> :(.text+0x119c): undefined reference to `mdiobus_write'
>> :(.text+0x11b0): undefined reference to `mdiobus_write'
>> arch/arm/mach-at91/built-in.o: In function `sama5_dt_device_init':
>> :(.init.text+0x1e34): undefined reference to `phy_register_fixup_for_uid'
>> 
>> when CONFIG_PHYLIB is not selected.
>> 
>> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
>> Acked-by: Ludovic Desroches <ludovic.desroches@atmel.com>
>> ---
>> Changes in v3:
>> 	added SoB
>> 	added Acked-By
> 
> A v3 is not needed simply for this. Thanks, anyway!
> 
> One question though: why not just add
> 
>        select PHYLIB
> 
> In Kconfig entry:
> 
> config MACH_SAMA5_DT
> 
> ?
> 
> (note that I like to play with everybody's nerves ;-))
> 

I prefer this than the IS_BUILTIN


> Bye,
> 
>> Changes in v2:
>> 	use IS_BUILTIN
>> 	use CONFIG_PHYLIB and not CONFIG_PHY
>> 
>>  arch/arm/mach-at91/board-dt-sama5.c | 22 ++++++++++++----------
>>  1 file changed, 12 insertions(+), 10 deletions(-)
>> 
>> diff --git a/arch/arm/mach-at91/board-dt-sama5.c b/arch/arm/mach-at91/board-dt-sama5.c
>> index 705305e..e9ce541 100644
>> --- a/arch/arm/mach-at91/board-dt-sama5.c
>> +++ b/arch/arm/mach-at91/board-dt-sama5.c
>> @@ -47,22 +47,24 @@ static int ksz9021rn_phy_fixup(struct phy_device *phy)
>>  #define GMII_ERCR	11
>>  #define GMII_ERDWR	12
>> 
>> -	/* Set delay values */
>> -	value = GMII_RCCPSR | 0x8000;
>> -	phy_write(phy, GMII_ERCR, value);
>> -	value = 0xF2F4;
>> -	phy_write(phy, GMII_ERDWR, value);
>> -	value = GMII_RRDPSR | 0x8000;
>> -	phy_write(phy, GMII_ERCR, value);
>> -	value = 0x2222;
>> -	phy_write(phy, GMII_ERDWR, value);
>> +	if (IS_BUILTIN(CONFIG_PHYLIB)) {
>> +		/* Set delay values */
>> +		value = GMII_RCCPSR | 0x8000;
>> +		phy_write(phy, GMII_ERCR, value);
>> +		value = 0xF2F4;
>> +		phy_write(phy, GMII_ERDWR, value);
>> +		value = GMII_RRDPSR | 0x8000;
>> +		phy_write(phy, GMII_ERCR, value);
>> +		value = 0x2222;
>> +		phy_write(phy, GMII_ERDWR, value);
>> +	}
>> 
>>  	return 0;
>>  }
>> 
>>  static void __init sama5_dt_device_init(void)
>>  {
>> -	if (of_machine_is_compatible("atmel,sama5d3xcm"))
>> +	if (of_machine_is_compatible("atmel,sama5d3xcm") && IS_BUILTIN(CONFIG_PHYLIB))
>>  		phy_register_fixup_for_uid(PHY_ID_KSZ9021, MICREL_PHY_ID_MASK,
>>  			ksz9021rn_phy_fixup);
>> 
>> 
> 
> 
> -- 
> Nicolas Ferre
