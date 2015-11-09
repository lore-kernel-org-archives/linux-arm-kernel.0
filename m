From: okaya@codeaurora.org (Sinan Kaya)
Date: Mon, 9 Nov 2015 17:29:58 -0500
Subject: [PATCH] acpi: add support for extended IRQ to PCI link
In-Reply-To: <CAHp75VfH9-OpQdX_aoraLEcHewdRPFoR5My8mN2jU30ittS7oA@mail.gmail.com>
References: <1446998832-7023-1-git-send-email-okaya@codeaurora.org>
 <CAHp75VfH9-OpQdX_aoraLEcHewdRPFoR5My8mN2jU30ittS7oA@mail.gmail.com>
Message-ID: <56411E66.2030104@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/8/2015 3:35 PM, Andy Shevchenko wrote:
> On Sun, Nov 8, 2015 at 6:07 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
>> The ACPI compiler uses the extended format when
>> used interrupt numbers are greater than 256.
>> The PCI link code currently only supports simple
>> interrupt format. The IRQ numbers are represented
>> using 32 bits when extended IRQ syntax. This patch
>> changes the interrupt number type to 32 bits and
>> places an upper limit of 1020 as possible interrupt
>> id. Additional checks have been placed to prevent
>> out of bounds writes.
>
> In commit messages and in comments I see this narrow lines, any reason
> to make them short, except increasing number of lines?
>

done

>>          if (acpi_irq_balance || !link->irq.active) {
>> -               /*
>> -                * Select the best IRQ.  This is done in reverse to promote
>> -                * the use of IRQs 9, 10, 11, and >15.
>> -                */
>> -               for (i = (link->irq.possible_count - 1); i >= 0; i--) {
>> -                       if (acpi_irq_penalty[irq] >
>> -                           acpi_irq_penalty[link->irq.possible[i]])
>> -                               irq = link->irq.possible[i];
>> +
>> +               if (irq < ACPI_MAX_IRQS) {
>> +                       /*
>> +                        * Select the best IRQ.  This is done in reverse to
>> +                        * promote the use of IRQs 9, 10, 11, and >15.
>> +                        */
>> +                       for (i = (link->irq.possible_count - 1); i >= 0;
>> +                               i--) {
>
> Why not
>
> if ((acpi_irq_balance || !link->irq.active) && irq < ACPI_MAX_IRQS) {
>   int i = link->irq.possible_count;
>
>   while (--i) {
>   ?
>   }
> }

done

>
>> +                               if ((link->irq.possible[i] < ACPI_MAX_IRQS) &&
>> +                                   (acpi_irq_penalty[irq] >
>> +                                   acpi_irq_penalty[link->irq.possible[i]]))
>> +                                       irq = link->irq.possible[i];
>> +                       }
>>                  }
>>          }
>>          if (acpi_irq_penalty[irq] >= PIRQ_PENALTY_ISA_ALWAYS) {
>

-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a 
Linux Foundation Collaborative Project
