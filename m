From: radu.pirea@microchip.com (Radu Pirea)
Date: Tue, 15 May 2018 12:25:10 +0300
Subject: [PATCH v3 5/6] spi: at91-usart: add driver for at91-usart as spi
In-Reply-To: <CAHp75Ve3Ugnjjm8EZkPQTZSvH1qad1e5SqjOn8zz5syHSQea_g@mail.gmail.com>
References: <20180511103822.31698-1-radu.pirea@microchip.com>
 <20180511103822.31698-6-radu.pirea@microchip.com>
 <CAHp75Ve3Ugnjjm8EZkPQTZSvH1qad1e5SqjOn8zz5syHSQea_g@mail.gmail.com>
Message-ID: <49c13a964f517c9c90e61beda327d4174fd1358c.camel@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2018-05-13 at 16:33 +0300, Andy Shevchenko wrote:
> On Fri, May 11, 2018 at 1:38 PM, Radu Pirea <radu.pirea@microchip.com
> > wrote:
> > This is the driver for at91-usart in spi mode. The USART IP can be
> > configured
> > to work in many modes and one of them is SPI.
> > +#include <linux/gpio.h>
> > +#include <linux/gpio/consumer.h>
> 
> Here is something wrong. You need to use latter one in new code.
> 
> > +#include <linux/interrupt.h>
> > +#include <linux/io.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/of_device.h>
> > +#include <linux/of_gpio.h>
> 
> Hmm... Do you need all of them?
> 
> > +static inline void at91_usart_spi_cs_activate(struct spi_device
> > *spi)
> > +{
> 
> ...
> > +       gpiod_set_value(ausd->npcs_pin, active);
> > +       aus->cs_active = true;
> > +}
> > +
> > +static inline void at91_usart_spi_cs_deactivate(struct spi_device
> > *spi)
> > +{
> 
> ...
> > +       gpiod_set_value(ausd->npcs_pin, !active);
> > +       aus->cs_active = false;
> > +}
> 
> ...
> > +       if (!ausd) {
> > +               if (gpio_is_valid(spi->cs_gpio)) {
> > +                       npcs_pin = gpio_to_desc(spi->cs_gpio);
> 
> ...
> > +               }
> 
> ...
> > +               gpiod_direction_output(npcs_pin, !(spi->mode &
> > SPI_CS_HIGH));
> > +
> > +               ausd->npcs_pin = npcs_pin;
> 
> ...
> > +       }
> 
> I will refer to above as (1) later on.
> 
> > +       dev_dbg(&spi->dev, "new message %p submitted for %s\n",
> > +               msg, dev_name(&spi->dev));
> 
> %p does make a very little sense.
> 
> > +       list_for_each_entry(xfer, &msg->transfers, transfer_list) {
> > +               ret = at91_usart_spi_one_transfer(controller, msg,
> > xfer);
> > +               if (ret)
> > +                       goto msg_done;
> > +       }
> 
> Cant SPI core do this for your?
> 
> > +static void at91_usart_spi_cleanup(struct spi_device *spi)
> > +{
> > +       struct at91_usart_spi_device *ausd = spi->controller_state;
> > +
> > +       if (!ausd)
> > +               return;
> 
> Is it even possible?
> 
> Anyway the code below will work fine even if it's the case.
> 
> > +
> > +       spi->controller_state = NULL;
> > +       kfree(ausd);
> > +}
> > +static int at91_usart_spi_gpio_cs(struct platform_device *pdev)
> > +{
> > +       struct spi_controller *controller =
> > platform_get_drvdata(pdev);
> > +       struct device_node *np = controller->dev.parent->of_node;
> > +       struct gpio_desc *cs_gpio;
> > +       int nb;
> > +       int i;
> > +
> > +       if (!np)
> > +               return 0;
> > +
> > +       nb = of_gpio_named_count(np, "cs-gpios");
> > +       for (i = 0; i < nb; i++) {
> > +               cs_gpio = devm_gpiod_get_from_of_node(&pdev->dev,
> > +                                                     pdev-
> > >dev.parent->of_node,
> > +                                                     "cs-gpios",
> > +                                                     i,
> > GPIOD_OUT_HIGH,
> > +                                                     dev_name(&pde
> > v->dev));
> > +               if (IS_ERR(cs_gpio))
> > +                       return PTR_ERR(cs_gpio);
> > +       }
> > +
> > +       controller->num_chipselect = nb;
> > +
> > +       return 0;
> > +}
> 
> The question is, why you didn't utilize what SPI core provides you?
> 
> > +       spi_writel(aus, MR, US_MR_SPI_MASTER | US_MR_CHRL |
> > US_MR_CLKO |
> > +                       US_MR_WRDBT);
> > +       spi_writel(aus, CR, US_CR_RXDIS | US_CR_TXDIS | US_CR_RSTRX
> > |
> > +                       US_CR_RSTTX);
> 
> I didn't check over, but it seems like you might have duplication in
> these bitwise ORs. Consider to unify them into another (shorter)
> definitions and reuse all over the code.
> 
> > +       regs = platform_get_resource(to_platform_device(pdev-
> > >dev.parent),
> > +                                    IORESOURCE_MEM, 0);
> > +       if (!regs)
> > +               return -ENXIO;
> 
> Strange error code for getting MMIO resource. ENOMEM sounds better.
> 
> > +       dev_info(&pdev->dev,
> > +                "Atmel USART SPI Controller version 0x%x at
> > 0x%08lx (irq %d)\n",
> > +                spi_readl(aus, VERSION),
> > +                (unsigned long)regs->start, irq);
> 
> If you do explicit casting when printing something you are doing
> wrong.
> Please use %pR or %pr in this case.
> 
> > +static struct platform_driver at91_usart_spi_driver = {
> > +       .driver = {
> > +               .name = "at91_usart_spi",
> > +               .of_match_table =
> > of_match_ptr(at91_usart_spi_dt_ids),
> 
> Can it work as pure platform driver? If no, of_match_ptr() is
> redundant.

This driver can not work as pure platform driver, but I the way I used
to probe it from MFD(by compatbile string).
Do you know another way?

> 
> > +       },
> > +       .probe = at91_usart_spi_probe,
> > +       .remove = at91_usart_spi_remove, };
> 
> Two lines at one. Split.
> 
