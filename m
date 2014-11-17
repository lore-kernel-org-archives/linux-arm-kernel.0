From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 17 Nov 2014 09:28:48 +0100
Subject: [PATCH] gpio: mxs: implement get_direction callback
In-Reply-To: <54695654.3070209@elproma.com.pl>
References: <1416004026-9667-1-git-send-email-j.uzycki@elproma.com.pl>
 <20141114232601.GW27002@pengutronix.de>
 <5467A980.5090204@elproma.com.pl>
 <20141116214239.GX27002@pengutronix.de>
 <54693A51.5080907@elproma.com.pl> <54695654.3070209@elproma.com.pl>
Message-ID: <20141117082848.GZ27002@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Janusz,

On Mon, Nov 17, 2014 at 02:58:44AM +0100, Janusz U?ycki wrote:
> 
> W dniu 2014-11-17 o 00:59, Janusz U?ycki pisze:
> >
> >W dniu 2014-11-16 o 22:42, Uwe Kleine-K?nig pisze:
> >Thanks Uwe. I fully agree with you.
> >a) was just a starter to your suggestion. My options were too
> >conservative - I just
> >wanted to avoid tests on hardware I don't have.
That's something you have to live with and that's why there is a merge
window.

> >I don't understand why gpiod_get_direction() always requires the callback
> >and b) would be broken (I'm not so familiar with gpiolib) but I
> >don't need it now.
> >
> >So, it looks we can drop the gpio-mxs patch, yes?
That patch is not wrong, just its motivation. IMHO the only valid
usecase for .get_direction is debugging.

> >And, I or Richard should submit a patch for
> >mctrl_gpio/atmel_serial/mxs-auart
> >to introduce the irq helper, yes?
> >
> >You wrote passing uart_port is enough. Argument "name" for
> >request_irq() can be
> >recovered from dev_name(dev) or dev_driver_string(dev)  where dev
> >= port_uart->dev.
> >But irqhandler and mctrl_gpios must be passed to
You don't need irqhandler. struct mctrl_gpios is needed of course.

> >mctrl_gpio_request_irqs() helper.
> >The gpio_irq table could be hidden and moved into struct
> >mctrl_gpios. Then
> >a second helper function is required: mctrl_gpio_free_irqs().
yes.

> After some coding...
> gpio_irq cannot be hidden - it is used by disable/enable_ms() and
> not only :/
mctrl_gpio_enable_ms(struct mctrl_gpios *gpios);

> >gpio_irq table initialized in mctrl_gpio_request_irqs().
> 
> or it could be nicely done in mctrl_gpio_init() but the problem is
> next argument
> for the function :/
> eg.:
> struct mctrl_gpios *mctrl_gpio_init(struct device *dev, unsigned int
> idx, int *irqs)
What is idx about? I see it already in the mctrl_gpio API, but there is
no documentation about how it's used. Is it always 0?

There is no need to pass an output parameter for irqs. Just save them in
struct mctrl_gpios.

I'd go and change all struct device * parameters of the mctrl_gpio API
to struct uart_port for consistency or add struct uart_port to struct
mctrl_gpios.

> >So finally the prototypes would be:
> >int mctrl_gpio_request_irqs(struct mctrl_gpios*, struct
> >uart_port*, irqhandler_t);
> >void mctrl_gpio_free_irqs(struct mctrl_gpios*);
I think:

	struct mctrl_gpios {
		struct uart_port *port;
		struct {
			gpio_desc *gpio;
			unsigned int irq;
		} mctrl_line[UART_GPIO_MAX];
	};

	struct mctrl_gpios *mctrl_gpio_init(struct uart_port *port, unsigned int idx_if_needed);
	int mctrl_gpio_enable_ms(struct mctrl_gpios *gpios);
	int mctrl_gpio_disable_ms(struct mctrl_gpios *gpios);
	void mctrl_gpio_free(struct mctrl_gpios *gpios);

I think mctrl_gpio_init should request the needed irqs, but not enable
them. Not sure there is a corresponding request_irq variant for that.
Another open issue is how mctrl_gpio_init should find out about which
gpios to use if there is no device tree. This doesn't necessarily needs
to be solved now, but maybe rename mctrl_gpio_init to
mctrl_gpio_init_dt?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
