From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Mon, 14 Nov 2016 18:49:36 +0530
Subject: [PATCH 04/16] ARM: realview: use generic API for enabling SCU
In-Reply-To: <3587281.4kOCcW9Ryd@wuerfel>
References: <1479099731-28108-1-git-send-email-pankaj.dubey@samsung.com>
 <1479099731-28108-5-git-send-email-pankaj.dubey@samsung.com>
 <3587281.4kOCcW9Ryd@wuerfel>
Message-ID: <CAGcde9EkwhnxsvSuFatGAm0AgKRvdtkFQgxcAR+gXLz_57FNcQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 14 November 2016 at 17:26, Arnd Bergmann <arnd@arndb.de> wrote:
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

Just checked scu binding documentation for "arm,arm11mp-scu" and came
to know its for ARM11 MPCore based SoC's SCU. So as you said, it can
surely be moved to genenric imeplemenation. Will do this change and
resubmit again.

Thanks,
Pankaj Dubey

>         Arnd
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
