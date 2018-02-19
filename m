From: marek.vasut@gmail.com (Marek Vasut)
Date: Mon, 19 Feb 2018 09:51:00 +0100
Subject: [PATCH 2/2] ARM: shmobile: porter: enable R-Car Gen2 regulator
 quirk
In-Reply-To: <CAMuHMdVu2LvxtvUYDOrW3Yhqujk4+=bN0sg-aJhxX_g0Kbpx6g@mail.gmail.com>
References: <20180217020642.21375-1-marek.vasut+renesas@gmail.com>
 <20180217020642.21375-2-marek.vasut+renesas@gmail.com>
 <CAMuHMdVu2LvxtvUYDOrW3Yhqujk4+=bN0sg-aJhxX_g0Kbpx6g@mail.gmail.com>
Message-ID: <3a527612-59ab-8bc5-1277-7eb41fb5b53e@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/19/2018 09:42 AM, Geert Uytterhoeven wrote:
> On Sat, Feb 17, 2018 at 3:06 AM, Marek Vasut <marek.vasut@gmail.com> wrote:
>> Porter needs the regulator quirk, just like the other boards,
>> the DA9063 and DA9210 IRQ line is connected to CPU IRQ2 . But
>> unlike the other boards, the DA9063 is at 0x5a on Porter.
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
>> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
>> Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>> Cc: Simon Horman <horms+renesas@verge.net.au>
>> Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
>> ---
>>  arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c b/arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c
>> index 862f7757ef5d..7963f0eea9e1 100644
>> --- a/arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c
>> +++ b/arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c
>> @@ -132,11 +132,16 @@ static int __init rcar_gen2_regulator_quirk(void)
>>         u32 mon;
>>
>>         if (!of_machine_is_compatible("renesas,koelsch") &&
>> +           !of_machine_is_compatible("renesas,porter") &&
>>             !of_machine_is_compatible("renesas,lager") &&
>>             !of_machine_is_compatible("renesas,stout") &&
>>             !of_machine_is_compatible("renesas,gose"))
>>                 return -ENODEV;
>>
>> +       /* DA9063 on M2W Porter is at 0x5a */
>> +       if (of_machine_is_compatible("renesas,porter"))
>> +               da9xxx_msgs[0].addr = 0x5a;
>> +
>>         irqc = ioremap(IRQC_BASE, PAGE_SIZE);
>>         if (!irqc)
>>                 return -ENOMEM;
> 
> Doing the same of_machine_is_compatible() check again is an indicator that
> you should switch to an of_device_id-based match interface...

Indeed. Also cfr my other suggestion in reply to WSA in this thread.
Thoughts on that welcome.

-- 
Best regards,
Marek Vasut
