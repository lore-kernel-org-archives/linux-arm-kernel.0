From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 06 Nov 2013 00:25:35 +0300
Subject: [PATCH] RM: shmobile: lager: phy fixup needs CONFIG_PHYLIB
In-Reply-To: <5272CC16.3020700@cogentembedded.com>
References: <1383201098-4258-1-git-send-email-horms+renesas@verge.net.au>
 <5272CC16.3020700@cogentembedded.com>
Message-ID: <5279624F.1030903@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 11/01/2013 12:31 AM, Sergei Shtylyov wrote:

>> Do not build the phy fixup unless CONFIG_PHYLIB is enabled.
>> Other than not being useful it is also not possible to compile

>     s/compile/link/.

>> the code under this condition as phy_register_fixup_for_id()
>> is not defined.

>     Not only this function is absent...

>> This problem was introduced by 48c8b96f21817aad
>> ("ARM: shmobile: Lager: add Micrel KSZ8041 PHY fixup")

>> Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
>> ---
>>   arch/arm/mach-shmobile/board-lager.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)

>> diff --git a/arch/arm/mach-shmobile/board-lager.c
>> b/arch/arm/mach-shmobile/board-lager.c
>> index 78a31b6..d1a8ddd 100644
>> --- a/arch/arm/mach-shmobile/board-lager.c
>> +++ b/arch/arm/mach-shmobile/board-lager.c
>> @@ -245,7 +245,9 @@ static void __init lager_init(void)
>>   {
>>       lager_add_standard_devices();
>>
>> -    phy_register_fixup_for_id("r8a7790-ether-ff:01", lager_ksz8041_fixup);
>> +    if (IS_ENABLED(CONFIG_PHYLIB))
>> +        phy_register_fixup_for_id("r8a7790-ether-ff:01",
>> +                      lager_ksz8041_fixup);

>     Perhaps you would consider enclosing the fixup function itself into #ifdef
> as it causes link errors as well?  Doesn't seem necessary as gcc probably
> drops it anyway but for completeness' sake...

    It's not necessary and it won't even work (causes compilation failure) as 
my testing has shown, so sorry for wasting your time on this suggestion.

WBR, Sergei
