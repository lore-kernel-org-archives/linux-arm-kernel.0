From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Wed, 20 Apr 2016 08:37:26 +0200
Subject: [PATCH 2/3] ARM: pxa: add pxa25x device-tree support
References: <1460316600-15978-1-git-send-email-robert.jarzmik@free.fr>
 <1460316600-15978-2-git-send-email-robert.jarzmik@free.fr>
 <5954693.SgGqqDgWJO@wuerfel>
Message-ID: <871t60u6op.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> On Sunday 10 April 2016 21:29:59 Robert Jarzmik wrote:
>> +
>> +DT_MACHINE_START(PXA_DT, "Marvell PXA3xx (Device Tree Support)")
>> +       .map_io         = pxa3xx_map_io,
>> +       .init_irq       = pxa3xx_dt_init_irq,
>> +       .handle_irq     = pxa3xx_handle_irq,
>> +       .restart        = pxa_restart,
>> +       .dt_compat      = pxa3xx_dt_board_compat,
>> +MACHINE_END
>> 
>
> Nothing wrong with your series, it's a straightforward continuation of what
> you have for the other platforms, but I have a few comments on the method
> overall, and it might be good if you could work on improving those next,
> basically eliminating most of the machine descriptor contents in the long
> run:
>
> - It would be nice not to call map_io() at all and instead ensure that all
>   drivers that have DT bindings use ioremap. The main reason for this is
>   that relying on the hardwired mapping makes it easy to get things wrong
>   in the bindings, by leaving out required memory ranges.
Okay, that sounds good, I'll add it to my todo list.
I seem to remember some legacy driver relying on one of these mapping (cpufreq
for pxa relying on memory controller maybe ...), but that's a fix easy enough to
queue. Let's hope I'm not bitten by something else.

> - The init_irq()/handle_irq() callbacks can probably be replaced with
>   a IRQCHIP_DECLARE() statement per irqchip variant, which then goes
>   on to initialize the controller and set the handler.
Okay, I'll verify that, especially that the ordering is ensured, ie. that
interrupts are available at the same time that when it was the machine code
calling the irq init, and that's also going to my todo list.

>
> - The restart method is the least important here, but I guess we can
>   convert that into a driver, or use an existing one from DT, like
>   drivers/power/reset/gpio-restart.c
I think most of the required stuff is already done. The only remaining part is
the reset status clearing specific to pxa, which as you said would ask for a
very tiny driver.

As soon as I'm done with the ac97 rework and if no v4l2 pressure is applied to
pxa, I'll work on this and the MMP to pinctrl conversion.

Thanks for the comments, and cheers.

--
Robert
