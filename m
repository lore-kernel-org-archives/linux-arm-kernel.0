From: marek.vasut@gmail.com (Marek Vasut)
Date: Fri, 25 May 2018 02:30:14 +0200
Subject: [RFC][PATCH] ARM: shmobile: Rework the PMIC IRQ line quirk
In-Reply-To: <CAMuHMdXep2sdVK71i1FBkJTd+3aYj0LzCKsqp8vBKrewkaX1FA@mail.gmail.com>
References: <20180226101718.5353-1-marek.vasut+renesas@gmail.com>
 <CAMuHMdXep2sdVK71i1FBkJTd+3aYj0LzCKsqp8vBKrewkaX1FA@mail.gmail.com>
Message-ID: <80b21f1b-8454-4ed0-b66d-03c298e1c87b@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/26/2018 11:39 AM, Geert Uytterhoeven wrote:
> Hi Marek,

Hi,

> On Mon, Feb 26, 2018 at 11:17 AM, Marek Vasut <marek.vasut@gmail.com> wrote:
>> Rather than hard-coding the quirk topology, which stopped scaling,
>> parse the information from DT. The code looks for all compatible
>> PMICs -- da9036 and da9210 -- and checks if their IRQ line is tied
>> to the same pin. If so, the code sends a matching sequence to the
>> PMIC to deassert the IRQ.
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> 
> Thanks for your patch!
> 
> At first sight, the probing part looks good to me. I'll have a closer look,
> and will give it a try later.
> 
> A few early comment below.
> 
>> --- a/arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c
>> +++ b/arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c
> 
>> @@ -88,17 +103,21 @@ static int regulator_quirk_notify(struct notifier_block *nb,
>>         client = to_i2c_client(dev);
>>         dev_dbg(dev, "Detected %s\n", client->name);
>>
>> -       if ((client->addr == 0x58 && !strcmp(client->name, "da9063")) ||
>> -           (client->addr == 0x68 && !strcmp(client->name, "da9210")) ||
>> -           (client->addr == 0x70 && !strcmp(client->name, "da9210"))) {
>> -               int ret, len;
>> +       list_for_each_entry(pos, &quirk_list, list) {
>> +               if (pos->i2c_msg.addr != client->addr)
>> +                       continue;
>>
>> -               /* There are two DA9210 on Stout, one on the other boards. */
>> -               len = of_machine_is_compatible("renesas,stout") ? 3 : 2;
>> +               if (!of_device_is_compatible(dev->of_node, pos->id->compatible))
>> +                       continue;
>>
>> -               dev_info(&client->dev, "clearing da9063/da9210 interrupts\n");
>> -               ret = i2c_transfer(client->adapter, da9xxx_msgs, len);
>> -               if (ret != ARRAY_SIZE(da9xxx_msgs))
>> +               if (!pos->shared)
>> +                       continue;
>> +
>> +               dev_info(&client->dev, "clearing %s at 0x%02x interrupts\n",
>> +                        pos->id->compatible, pos->i2c_msg.addr);
>> +
>> +               ret = i2c_transfer(client->adapter, &pos->i2c_msg, 1);
>> +               if (ret != 1)
>>                         dev_err(&client->dev, "i2c error %d\n", ret);
>>         }
> 
> The loop above sents a clear message to a single device only, right?
> That won't work, as that will clear the interrupt for that single device only.
> All other devices may still have their interrupts asserted.
> Next step in probing will be binding the da9210 or da9063 driver, which will
> enable the shared irq, and boom!
> 
> Upon detecting the first affected device, you really have to send clear
> messages to all devices in the list for which shared == true.

This is even worse, the single-device part can be easily fixed. But what
if the devices are on different i2c bus ? Do we care about that case or
do we assume they are on the same bus (they are in the configurations we
know of).

>> @@ -122,7 +146,14 @@ static struct notifier_block regulator_quirk_nb = {
>>
>>  static int __init rcar_gen2_regulator_quirk(void)
>>  {
>> -       u32 mon;
>> +       struct device_node *np;
>> +       const struct of_device_id *id;
>> +       struct regulator_quirk *quirk;
>> +       struct regulator_quirk *pos;
>> +       struct of_phandle_args *argsa, *argsb;
>> +       u32 mon, addr, i;
>> +       bool match;
>> +       int ret;
>>
>>         if (!of_machine_is_compatible("renesas,koelsch") &&
>>             !of_machine_is_compatible("renesas,lager") &&
> 
>> @@ -130,6 +161,51 @@ static int __init rcar_gen2_regulator_quirk(void)
>>             !of_machine_is_compatible("renesas,gose"))
>>                 return -ENODEV;
> 
> We might drop the checks above, to handle other platforms based on the
> Renesas reference designs.

Are you sure that's a good idea ?

>>
>> +       for_each_matching_node_and_match(np, rcar_gen2_quirk_match, &id) {
>> +               if(!np || !of_device_is_available(np))
>> +                       break;
>> +
>> +               quirk = kzalloc(sizeof(*quirk), GFP_KERNEL);
>> +
>> +               argsa = &quirk->irq_args;
>> +               memcpy(&quirk->i2c_msg, id->data, sizeof(quirk->i2c_msg));
>> +
>> +               ret = of_property_read_u32(np, "reg", &addr);
>> +               if (ret)
>> +                       return ret;
>> +
>> +               quirk->id = id;
>> +               quirk->i2c_msg.addr = addr;
>> +               quirk->shared = false;
>> +
>> +               ret = of_irq_parse_one(np, 0, &quirk->irq_args);
>> +               if (ret)
>> +                       return ret;
>> +
>> +               list_for_each_entry(pos, &quirk_list, list) {
>> +                       argsa = &quirk->irq_args;
>> +                       argsb = &pos->irq_args;
>> +
>> +                       if (argsa->args_count != argsb->args_count)
>> +                               continue;
>> +
>> +                       match = true;
>> +                       for (i = 0; i < argsa->args_count; i++) {
>> +                               if (argsa->args[i] != argsb->args[i]) {
>> +                                       match = false;
>> +                                       break;
>> +                               }
>> +                       }
>> +
>> +                       if (match) {
> 
> The loop and check above can be replaced by
> 
>     if (!memcmp(argsa->args, argsb->args, argsa->args_count *
> sizeof(argsa->args[0]))

Fixed

-- 
Best regards,
Marek Vasut
