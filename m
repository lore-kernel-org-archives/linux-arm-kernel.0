From: marek.vasut@gmail.com (Marek Vasut)
Date: Tue, 18 Sep 2018 14:24:32 +0200
Subject: [PATCH V5] ARM: shmobile: Rework the PMIC IRQ line quirk
In-Reply-To: <CAMuHMdUuUwP2NAkHFsnuLigRRfEJVa8xBQ5Ee-jxU9MK8_8PZA@mail.gmail.com>
References: <20180611121513.9673-1-marek.vasut+renesas@gmail.com>
 <CAMuHMdUuUwP2NAkHFsnuLigRRfEJVa8xBQ5Ee-jxU9MK8_8PZA@mail.gmail.com>
Message-ID: <b450eb7b-3846-9b79-0e5f-6ebf185fbd5d@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/05/2018 01:55 PM, Geert Uytterhoeven wrote:
> Hi Marek,
> 
> On Mon, Jun 11, 2018 at 2:15 PM Marek Vasut <marek.vasut@gmail.com> wrote:
>> Rather than hard-coding the quirk topology, which stopped scaling,
>> parse the information from DT. The code looks for all compatible
>> PMICs -- da9063 and da9210 -- and checks if their IRQ line is tied
>> to the same pin. If so, the code sends a matching sequence to the
>> PMIC to deassert the IRQ.
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
>> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
>> Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>> Cc: Simon Horman <horms+renesas@verge.net.au>
>> Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
>> Cc: linux-renesas-soc at vger.kernel.org
>> Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be> (on Koelsch)
>> ---
>> V2: - Replace the DT shared IRQ check loop with memcmp()
>>     - Send the I2C message to deassert the IRQ line to all PMICs
>>       in the list with shared IRQ line instead of just one
>>     - Add comment that this works only in case all the PMICs are
>>       on the same I2C bus
>> V3: - Drop the addr = 0x00 init
>>     - Drop reinit of argsa in rcar_gen2_regulator_quirk
>> V4: - Squash regulator_quirk on single line
>>     - Drop !np check in for_each_matching_node_and_match()
>>     - Use argsa in of_irq_parse_one
>> V5: - Check kzalloc failure
>>     - Rename da...._msgs to da...._msg
>>     - Don't reinit quirk->shared
> 
> Thanks for the update!
> 
>> --- a/arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c
>> +++ b/arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c
> 
>> @@ -122,7 +142,12 @@ static struct notifier_block regulator_quirk_nb = {
>>
>>  static int __init rcar_gen2_regulator_quirk(void)
>>  {
>> -       u32 mon;
>> +       struct regulator_quirk *quirk, *pos, *tmp;
>> +       struct of_phandle_args *argsa, *argsb;
>> +       const struct of_device_id *id;
>> +       struct device_node *np;
>> +       u32 mon, addr;
>> +       int ret;
>>
>>         if (!of_machine_is_compatible("renesas,koelsch") &&
>>             !of_machine_is_compatible("renesas,lager") &&
>> @@ -130,22 +155,76 @@ static int __init rcar_gen2_regulator_quirk(void)
>>             !of_machine_is_compatible("renesas,gose"))
>>                 return -ENODEV;
>>
>> +       for_each_matching_node_and_match(np, rcar_gen2_quirk_match, &id) {
>> +               if (!of_device_is_available(np))
>> +                       break;
>> +
>> +               quirk = kzalloc(sizeof(*quirk), GFP_KERNEL);
>> +               if (!quirk) {
>> +                       ret = -ENOMEM;
>> +                       goto err_mem;
>> +               }
>> +
>> +               argsa = &quirk->irq_args;
>> +               memcpy(&quirk->i2c_msg, id->data, sizeof(quirk->i2c_msg));
>> +
>> +               ret = of_property_read_u32(np, "reg", &addr);
>> +               if (ret)
>> +                       return ret;
> 
> I think it's safer to skip this entry and continue, after calling
> kfree(quirk), of course.

This can be shifted above the kzalloc() . That said, I sent V6, so
please review it one more time.

-- 
Best regards,
Marek Vasut
