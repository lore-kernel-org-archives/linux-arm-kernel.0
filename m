From: holler@ahsoftware.de (Alexander Holler)
Date: Thu, 12 Sep 2013 12:28:17 +0200
Subject: [PATCH] RFC: interrupt consistency check for OF GPIO IRQs
In-Reply-To: <5231934D.4060706@collabora.co.uk>
References: <1375101368-17645-1-git-send-email-linus.walleij@linaro.org>
 <CACxGe6uNJNMdZ1HYGgCtLM2t2TWGCR6btjOHVmP=vDXXvvFfRg@mail.gmail.com>
 <CACRpkdYjJL6FZwEbB7XLnb9QtjB=3LeE9Ny6KQ4PkM3zpdNqqg@mail.gmail.com>
 <344239800.bDEkDg48ZQ@avalon>
 <CACRpkdavR=fv+y1RCNfdgQypPuRbO6isOSwGsABDrYiGeMdyZw@mail.gmail.com>
 <52308C91.2000105@ahsoftware.de> <523096FE.8080901@collabora.co.uk>
 <5230AB6E.1070807@ahsoftware.de> <5231817F.8000901@ahsoftware.de>
 <5231934D.4060706@collabora.co.uk>
Message-ID: <52319741.5050407@ahsoftware.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 12.09.2013 12:11, schrieb Javier Martinez Canillas:
> On 09/12/2013 10:55 AM, Alexander Holler wrote:

...
>>
>> By the way, how do you define two GPIOs/IRQs from different
>> gpio-banks/irq-controllers wuth that scheme?
>>
>
> That is indeed a very good question and I don't have a definite answer.
>
>> Would that be like below?
>>
>>   ethernet at 5,0 {
>>            compatible = "smsc,lan9221", "smsc,lan9115";
>>            interrupt-parent = <&gpio6>;
>>            interrupts = <16 8>;
>>            interrupt-parent = <&gpio7>;
>>            interrupts = <1 IRQF_TRIGGER_FALLING>; /* GPIO7_1 */
>>   };
>>

...

> So, if I understood the code correctly the DT IRQ core doesn't expect a device
> node to have more than one "interrupt-parent" property.
>
> It *should* work though if you have multiple "interrupts" properties defined and
> all of them have the same "interrupt-parent":
>
>         interrupt-parent = <&gpio6>;
>         interrupts = <1 IRQF_TRIGGER_HIGH>; /* GPIO6_1 */
>         interrupts = <2 IRQF_TRIGGER_LOW>; /* GPIO6_2 */
>
> since of_irq_map_one() will be called for each "interrupts" and the correct
> "interrupt-parent" will get obtained by of_irq_find_parent().

I assumed that answer. So to make such a scenario possible, something 
like this might be neccessary:

          interrupts = <&gpio6 1 IRQF_TRIGGER_HIGH>; /* GPIO6_1 */
          interrupts = <&gpio7 2 IRQF_TRIGGER_LOW>; /* GPIO7_2 */

or, to be compatible

          interrupts = <1 IRQF_TRIGGER_HIGH &gpio6>; /* GPIO6_1 */
          interrupts = <1 IRQF_TRIGGER_LOW &gpio7>; /* GPIO7_1 */

Another problem is the naming. In all the above cases, the driver would 
not know which IRQ he should use for what. Maybe the order defines it, 
but that wouldn't be very verbose. And I think just changing the name 
would make travelling the tree impossible, as only the driver itself 
would know the name and it's meaning.

Regards,

Alexander Holler
