From: green@linuxhacker.ru (Oleg Drokin)
Date: Mon, 6 Jun 2011 11:45:29 -0400
Subject: [PATCH 1/2] cleanup regulator supply definitions in mach-omap2 to
	use REGULATOR_SUPPLY
In-Reply-To: <20110606092126.GG18731@legolas.emea.dhcp.ti.com>
References: <1307342762-25363-1-git-send-email-green@linuxhacker.ru>
	<1307342762-25363-2-git-send-email-green@linuxhacker.ru>
	<20110606092126.GG18731@legolas.emea.dhcp.ti.com>
Message-ID: <EA5D78AA-5A89-43AC-9D14-F378673F5D41@linuxhacker.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!
On Jun 6, 2011, at 5:21 AM, Felipe Balbi wrote:

>> -static struct regulator_consumer_supply sdp4430_vaux_supply[] = {
>> -	{
>> -		.supply = "vmmc",
>> -		.dev_name = "omap_hsmmc.1",
>> -	},
>> -};
>> +static struct regulator_consumer_supply sdp4430_vaux_supply =
>> +	REGULATOR_SUPPLY("vmmc", "omap_hsmmc.1");
> this should be an array, as it was before.

Only one is defined right now.
Whoever needs a second element can convert it to array, I think?
What;s the importance of having it as an array right now?

>> --- a/arch/arm/mach-omap2/board-cm-t35.c
>> +++ b/arch/arm/mach-omap2/board-cm-t35.c
>> @@ -337,13 +337,11 @@ static void __init cm_t35_init_display(void)
>> 	}
>> }
>> 
>> -static struct regulator_consumer_supply cm_t35_vmmc1_supply = {
>> -	.supply			= "vmmc",
>> -};
>> +static struct regulator_consumer_supply cm_t35_vmmc1_supply =
>> +	REGULATOR_SUPPLY("vmmc", "omap_hsmmc.0");
> 
> this should also be array. It should read as:
> 
> static struct regulator_consumer_supply cm_t35_vmmc1_supply[] =
> 	REGULATOR_SUPPLY("vmmc", "omap_hsmmc.0",
> };

Why this one should be an array? There is only one vmmc supply in
functionality-reduced implementation TWL used on this board.
(in fact this particular board files defines more supplies then there are in the TWL
and I planned to do another patch that would kill all the defined but not really
existing supplies next like vpll2 and such).

Bye,
    Oleg
