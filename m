From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 31 Oct 2013 22:46:57 +0300
Subject: [PATCH 2/2] ARM: shmobile: Koelsch: add Ether support
In-Reply-To: <CANqRtoTNJAnqavonOwtqe5_HDdPwK1-JAixNuz5z7ttQw-T64Q@mail.gmail.com>
References: <201310310216.28673.sergei.shtylyov@cogentembedded.com>	<201310310219.58963.sergei.shtylyov@cogentembedded.com>
 <CANqRtoTNJAnqavonOwtqe5_HDdPwK1-JAixNuz5z7ttQw-T64Q@mail.gmail.com>
Message-ID: <5272B3B1.8090503@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 10/31/2013 11:10 AM, Magnus Damm wrote:

>> Register Ether platform device and pin data on  the  Koelsch board.
>> Register platform fixup for Micrel KSZ8041 PHY, just like on the Lager board.

>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

>> ---
>>   arch/arm/mach-shmobile/board-koelsch.c |   61 ++++++++++++++++++++++++++++++++-
>>   1 file changed, 60 insertions(+), 1 deletion(-)
>>
>> Index: renesas/arch/arm/mach-shmobile/board-koelsch.c
>> ===================================================================
>> --- renesas.orig/arch/arm/mach-shmobile/board-koelsch.c
>> +++ renesas/arch/arm/mach-shmobile/board-koelsch.c

>> @@ -70,11 +87,29 @@ static const struct gpio_keys_platform_d
>>          .nbuttons       = ARRAY_SIZE(gpio_buttons),
>>   };
>>
>> +static const struct pinctrl_map koelsch_pinctrl_map[] = {
>> +       /* Ether */
>> +       PIN_MAP_MUX_GROUP_DEFAULT("r8a7790-ether", "pfc-r8a7791",
>> +                                 "eth_link", "eth"),
>> +       PIN_MAP_MUX_GROUP_DEFAULT("r8a7790-ether", "pfc-r8a7791",
>> +                                 "eth_mdio", "eth"),
>> +       PIN_MAP_MUX_GROUP_DEFAULT("r8a7790-ether", "pfc-r8a7791",
>> +                                 "eth_rmii", "eth"),
>> +};

> Once again we seem to be using r8a7790 when the actual SoC is r8a7791.

    Note that the last time it was in the DT context which is not quite the 
same as platfrom device context.

> If you're going to go down the route of using the SoC name then please

    I don't have much choice here. Though we could have used used R-Car 
gen1/gen2 terminology (at least in the hindsight)...

> use the correct one at least.

    It wasn't me who used "r8a7790-ether" name in the first place, it was 
Simon. And as these 2 SoCs are indistinguishable at least from the 'sh_eth' 
driver's point of view, I wouldn't want to introduce another platform device 
ID, especially as it hasn't been done for R8A777[89] SoCs. What I can offer is 
renaming "r8a7790-ether" to "r8a779x-ether" if you really want.

> Cheers,

> / magnus

WBR, Sergei
