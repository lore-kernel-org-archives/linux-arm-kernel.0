From: raghumag@gmail.com (raghu MG)
Date: Wed, 5 Aug 2015 10:37:08 +0530
Subject: Armadaxp GPIO interrupts
In-Reply-To: <20150804153439.GA28673@lunn.ch>
References: <CAG1O52Xg88OsifBzmpSdqvC8wQaOW78nC9nnfxugFv1VU1m1LQ@mail.gmail.com>
 <20150804153439.GA28673@lunn.ch>
Message-ID: <CAG1O52W2Gy_6_DfewtUqoK_J+Y=KwVGyygNaPu2xyPM_ZkLfcQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

Thanks for your quick response,dont mind for the delay(India,US timings).
I checked with both multi_v7_defconfig & mvebu_v7_defconfig , the result is same
"irq: Cannot allocate irq_descs @ IRQ47, assuming pre-allocated"

Pasting here the GPIO driver probe debug statements

armada-xp-pinctrl f1018000.pin-ctrl: registered pinctrl driver
drivers/gpio/gpio-mvebu.c mvebu_gpio_probe 680
mvebu_gpio_probe 682 match->name=
mvebu_gpio_probe 683 match->compatible=marvell,orion-gpio
drivers/gpio/gpio-mvebu.c mvebu_gpio_probe 727
drivers/gpio/gpio-mvebu.c mvebu_gpio_probe 734 res->start=f1018100
mvchip->membase=cf8c0100
drivers/gpio/gpio-mvebu.c mvebu_gpio_probe 747 soc_variant=1
drivers/gpio/gpio-mvebu.c mvebu_gpio_probe 785
drivers/gpio/gpio-mvebu.c mvebu_gpio_probe 788
drivers/gpio/gpio-mvebu.c mvebu_gpio_probe 805
drivers/gpio/gpio-mvebu.c mvebu_gpio_probe 840
drivers/gpio/gpio-mvebu.c mvebu_gpio_probe 844 mvchip->irqbase=47
irq: Cannot allocate irq_descs @ IRQ47, assuming pre-allocated
drivers/gpio/gpio-mvebu.c mvebu_gpio_probe 850 mvchip->domain->name=(null)
drivers/gpio/gpio-mvebu.c mvebu_gpio_probe 859
drivers/gpio/gpio-mvebu.c mvebu_gpio_probe 680
mvebu_gpio_probe 682 match->name=
mvebu_gpio_probe 683 match->compatible=marvell,orion-gpio
drivers/gpio/gpio-mvebu.c mvebu_gpio_probe 727
drivers/gpio/gpio-mvebu.c mvebu_gpio_probe 734 res->start=f1018140
mvchip->membase=cf8c2140
drivers/gpio/gpio-mvebu.c mvebu_gpio_probe 747 soc_variant=1
drivers/gpio/gpio-mvebu.c mvebu_gpio_probe 785
drivers/gpio/gpio-mvebu.c mvebu_gpio_probe 788
drivers/gpio/gpio-mvebu.c mvebu_gpio_probe 805
drivers/gpio/gpio-mvebu.c mvebu_gpio_probe 840
drivers/gpio/gpio-mvebu.c mvebu_gpio_probe 844 mvchip->irqbase=79
irq: Cannot allocate irq_descs @ IRQ79, assuming pre-allocated
drivers/gpio/gpio-mvebu.c mvebu_gpio_probe 850 mvchip->domain->name=(null)
drivers/gpio/gpio-mvebu.c mvebu_gpio_probe 859
drivers/gpio/gpio-mvebu.c mvebu_gpio_probe 680
mvebu_gpio_probe 682 match->name=
mvebu_gpio_probe 683 match->compatible=marvell,orion-gpio
drivers/gpio/gpio-mvebu.c mvebu_gpio_probe 727
drivers/gpio/gpio-mvebu.c mvebu_gpio_probe 734 res->start=f1018180
mvchip->membase=cf8c4180
drivers/gpio/gpio-mvebu.c mvebu_gpio_probe 747 soc_variant=1
drivers/gpio/gpio-mvebu.c mvebu_gpio_probe 785
drivers/gpio/gpio-mvebu.c mvebu_gpio_probe 788
drivers/gpio/gpio-mvebu.c mvebu_gpio_probe 805
drivers/gpio/gpio-mvebu.c mvebu_gpio_probe 840
drivers/gpio/gpio-mvebu.c mvebu_gpio_probe 844 mvchip->irqbase=111
irq: Cannot allocate irq_descs @ IRQ111, assuming pre-allocated
drivers/gpio/gpio-mvebu.c mvebu_gpio_probe 850 mvchip->domain->name=(null)
drivers/gpio/gpio-mvebu.c mvebu_gpio_probe 859



I will try to dig in more information in the probe & irq_domain_add_simple


On Tue, Aug 4, 2015 at 9:04 PM, Andrew Lunn <andrew@lunn.ch> wrote:
> On Tue, Aug 04, 2015 at 08:52:17PM +0530, raghu MG wrote:
>> Hello,
>>
>> I am working on a card which as GPIOs connected to external I/O's. The
>> board consists of ARMADAXP 78460 host cpu.
>>
>> Board currently runs Linux-4.1 with modified  armada-xp-gp.dtb for ArmadaXP.
>> I enabled "orion-gpio" driver to initialize GPIOs as given in
>> armada-xp-mv78460.
>
> What kernel configuration are you using? Do you have the same problem
> with multi_v7_defconfig and mvebu_v7_defconfig?
>
>> The driver while initializing calls irq_domain_add_simple which throws up
>> following warning
>> "irq: Cannot allocate irq_descs @ IRQ47, assuming pre-allocated"
>> The warning repeats for next set(32-63  & 64-66).
>>
>> Also the GPIO IRQs are not getting listed in cat /proc/interrupts
>
> irq_domain_add_simple() returning an error is fatal for the probe. The
> driver will not be loaded, so more than interrupts will be missing,
> all the gpios will be missing.
>
>     Andrew
