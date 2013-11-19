From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Tue, 19 Nov 2013 19:17:46 +0400
Subject: [PATCH 0/9] ARM: sa1100: Rework IRQ handling
In-Reply-To: <CACRpkdZU3_EqhBjV68+okJwh7QONuxWVjKkrUO4PkwJhKrP+mQ@mail.gmail.com>
References: <1384505280-25389-1-git-send-email-dbaryshkov@gmail.com>
 <CACRpkdZU3_EqhBjV68+okJwh7QONuxWVjKkrUO4PkwJhKrP+mQ@mail.gmail.com>
Message-ID: <528B811A.1030501@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/19/2013 05:00 PM, Linus Walleij wrote:
> On Fri, Nov 15, 2013 at 9:47 AM, Dmitry Eremin-Solenikov
> <dbaryshkov@gmail.com> wrote:
>
>> This is a considerable rework of my previous attempt to update sa1100 irq
>> handling. IRQ code is updated to support MULTI_IRQ_HANDLER and is mostly
>> prepared to be converted to irqchip driver (if the need arises in future).
>> I have integrated idea of Linus Waleij to use irq domains. GPIO irq handling
>> is split to gpio driver, which also undergo an update/rewrite.
>
> Overall this is looking very nice. However when I apply this on top
> of (a working and booting) mainline HEAD, I get this:

[skipped]

> This is caused by the patch:
> "ARM: sa1100: convert gpio driver to be a proper platform driver"
>
> The reason: UARTs are initialized *very* early and the UART quirk used on the
> h3600 is using GPIOs through the .set_mctrl hooks back into
> arch/arm/mach-sa1100/h3xxx.c functions
> h3xxx_uart_set_mctrl()
> h3xxx_uart_get_mctrl()
>
> And that happens before the GPIO driver gets registered -> crash.

That is not the issue. The real issue is h3xxx using those gpio's 
without previously calling gpio_request. Unfortunately sa1100 driver 
doesn't have a good place to request gpios. When faced this problem 
during locomo refactoring, I ended up with the following piece of code:

========== Cut here ============
static struct gpio collie_uart_gpio[] = {
         { COLLIE_GPIO_CTS, GPIOF_IN, "CTS" },
         { COLLIE_GPIO_RTS, GPIOF_OUT_INIT_LOW, "RTS" },
         { COLLIE_GPIO_DTR, GPIOF_OUT_INIT_LOW, "DTR" },
         { COLLIE_GPIO_DSR, GPIOF_IN, "DSR" },
};

static bool collie_uart_gpio_ok;

static void collie_uart_set_mctrl(struct uart_port *port, u_int mctrl)
{
         if (!collie_uart_gpio_ok) {
                 int rc = gpio_request_array(collie_uart_gpio,
                                 ARRAY_SIZE(collie_uart_gpio));
                 if (rc)
                         printk("collie_uart_set_mctrl: gpio request 
%d\n", rc);
                 else
                         collie_uart_gpio_ok = true;
         }

         if (collie_uart_gpio_ok) {
                 gpio_set_value(COLLIE_GPIO_RTS, !(mctrl & TIOCM_RTS));
                 gpio_set_value(COLLIE_GPIO_DTR, !(mctrl & TIOCM_DTR));
         }
}
=========== Cut here ===============

Same goes for get_mctr().

Russell, Linus, what do you think about the previous solution?


Another solution would be to make sa1100 distinguish between console 
output (where it doesn't have to control rts/dtr) and normal uart work 
(where 'modem' lines should be used).

I have the feeling that sa11x0-serial driver would need to be somewhat 
modified at least. I understand the conception behind unified 
"port_fns", but I think that those should be split to a per-port 
platform data.

> This is why the device is registered from the machine in the first place
> I think.
>
> I don't know what the proper solution is, but I think you can keep most
> of the platform device conversion if you also keep the special initialization
> call.


That would be possible solution if we can't come up with usefull way to 
handle h3xxx (and collie) gpios.

-- 
With best wishes
Dmitry
