From: pankaj.dubey@samsung.com (pankaj.dubey)
Date: Mon, 14 Nov 2016 17:36:43 +0530
Subject: [PATCH 04/16] ARM: realview: use generic API for enabling SCU
In-Reply-To: <3587281.4kOCcW9Ryd@wuerfel>
References: <1479099731-28108-1-git-send-email-pankaj.dubey@samsung.com>
 <1479099731-28108-5-git-send-email-pankaj.dubey@samsung.com>
 <CGME20161114115637epcas2p33d703e738e457794b1362bd9d837a62d@epcas2p3.samsung.com>
 <3587281.4kOCcW9Ryd@wuerfel>
Message-ID: <95b10b29-2d51-9e96-c628-232f081e09f4@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Monday 14 November 2016 05:26 PM, Arnd Bergmann wrote:
> On Monday, November 14, 2016 10:31:59 AM CET Pankaj Dubey wrote:
>>  static const struct of_device_id realview_scu_match[] = {
>>         { .compatible = "arm,arm11mp-scu", },
>> -       { .compatible = "arm,cortex-a9-scu", },
>> -       { .compatible = "arm,cortex-a5-scu", },
>>         { }
>>  };
>>  
>> @@ -41,27 +39,18 @@ static void __init realview_smp_prepare_cpus(unsigned int max_cpus)
>>         struct device_node *np;
>>         void __iomem *scu_base;
>>         struct regmap *map;
>> -       unsigned int ncores;
>>         int i;
>>  
>> -       np = of_find_matching_node(NULL, realview_scu_match);
>> -       if (!np) {
>> -               pr_err("PLATSMP: No SCU base address\n");
>> -               return;
>> +       if (of_scu_enable()) {
>> +               np = of_find_matching_node(NULL, realview_scu_match);
>> +               scu_base = of_iomap(np, 0);
>> +               of_node_put(np);
>> +               if (!scu_base) {
>> +                       pr_err("PLATSMP: No SCU remap\n");
>> +                       return;
>> +               }
>> +               scu_enable(scu_base);
>>         }
>>
> 
> The only difference here seems to be that realview also needs to handle
> "arm,arm11mp-scu". Why not move that into the generic implementation?
> 

Do you mean "arm,arm11mp-scu" this is generic SCU specific to ARM?

If it's generic then it can be moved on the same line I moved a5-scu and
a9-scu.

I left it here in same file, as I understood it might be related with
very specific to realview platform.

Thanks,
Pankaj Dubey

> 	Arnd
> 
> 
> 
