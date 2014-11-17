From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 17 Nov 2014 10:39:40 +0100
Subject: [PATCH] gpio: mxs: implement get_direction callback
In-Reply-To: <5469BBBD.30003@elproma.com.pl>
References: <1416004026-9667-1-git-send-email-j.uzycki@elproma.com.pl>
 <20141114232601.GW27002@pengutronix.de>
 <5467A980.5090204@elproma.com.pl>
 <20141116214239.GX27002@pengutronix.de>
 <54693A51.5080907@elproma.com.pl> <54695654.3070209@elproma.com.pl>
 <20141117082848.GZ27002@pengutronix.de>
 <5469BBBD.30003@elproma.com.pl>
Message-ID: <20141117093940.GF27002@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, Nov 17, 2014 at 10:11:25AM +0100, Janusz U?ycki wrote:
> >On Mon, Nov 17, 2014 at 02:58:44AM +0100, Janusz U?ycki wrote:
> >>W dniu 2014-11-17 o 00:59, Janusz U?ycki pisze:
> >>>W dniu 2014-11-16 o 22:42, Uwe Kleine-K?nig pisze:
> >>>Thanks Uwe. I fully agree with you.
> >>>a) was just a starter to your suggestion. My options were too
> >>>conservative - I just
> >>>wanted to avoid tests on hardware I don't have.
> >That's something you have to live with and that's why there is a merge
> >window.
> >
> >>>I don't understand why gpiod_get_direction() always requires the callback
> >>>and b) would be broken (I'm not so familiar with gpiolib) but I
> >>>don't need it now.
> >>>
> >>>So, it looks we can drop the gpio-mxs patch, yes?
> >That patch is not wrong, just its motivation. IMHO the only valid
> >usecase for .get_direction is debugging.
> 
> OK, I will submit v2.
> 
> >
> >>>And, I or Richard should submit a patch for
> >>>mctrl_gpio/atmel_serial/mxs-auart
> >>>to introduce the irq helper, yes?
> >>>
> >>>You wrote passing uart_port is enough. Argument "name" for
> >>>request_irq() can be
> >>>recovered from dev_name(dev) or dev_driver_string(dev)  where dev
> >>>= port_uart->dev.
> >>>But irqhandler and mctrl_gpios must be passed to
> >You don't need irqhandler. struct mctrl_gpios is needed of course.
> 
> request_irq() needs a irqhandler. Do you thing about a mctrl_
> handler for gpios?
Right, there shouldn't be anything driver specific in the irq handler.
Using the same irq handler as for the uart irq is just non-optimal (to
say it nicely). Look at the atmel driver. It sets the full irq handler
atmel_interrupt for the gpio lines irq. For this to work this handler
has added complexity (several "if (irq == atmel_port->gpio_irq[...])")
instead of only handling the in-chip stuff and for the gpio lines just
do the necessary statistic update and
wake_up_interruptible(&port->state->port.delta_msr_wait).

Moreover atmel_interrupt is more complex as needed, which makes
following it harder than necessary. (atmel_handle_status could just test
for status != atmel_port->irq_status instead of determining the pending
mask.)


> >>>mctrl_gpio_request_irqs() helper.
> >>>The gpio_irq table could be hidden and moved into struct
> >>>mctrl_gpios. Then
> >>>a second helper function is required: mctrl_gpio_free_irqs().
> >yes.
> >
> >>After some coding...
> >>gpio_irq cannot be hidden - it is used by disable/enable_ms() and
> >>not only :/
> >mctrl_gpio_enable_ms(struct mctrl_gpios *gpios);
> 
> This makes unable to combine gpio's and chip's lines but it could be
> advantage
> to separate them.
This is still possible because mctrl_gpio_enable_ms only handles gpios
it is responsible for.

> >>>gpio_irq table initialized in mctrl_gpio_request_irqs().
> >>or it could be nicely done in mctrl_gpio_init() but the problem is
> >>next argument
> >>for the function :/
> >>eg.:
> >>struct mctrl_gpios *mctrl_gpio_init(struct device *dev, unsigned int
> >>idx, int *irqs)
> >What is idx about? I see it already in the mctrl_gpio API, but there is
> >no documentation about how it's used. Is it always 0?
> 
> dt index
> 
> >There is no need to pass an output parameter for irqs. Just save them in
> >struct mctrl_gpios.
> >
> >I'd go and change all struct device * parameters of the mctrl_gpio API
> >to struct uart_port for consistency or add struct uart_port to struct
> >mctrl_gpios.
> >
> >>>So finally the prototypes would be:
> >>>int mctrl_gpio_request_irqs(struct mctrl_gpios*, struct
> >>>uart_port*, irqhandler_t);
> >>>void mctrl_gpio_free_irqs(struct mctrl_gpios*);
> >I think:
> >
> >	struct mctrl_gpios {
> >		struct uart_port *port;
> >		struct {
> >			gpio_desc *gpio;
> >			unsigned int irq;
> >		} mctrl_line[UART_GPIO_MAX];
> >	};
> 
> Looks good. Richard, do you agree?
> 
> >	struct mctrl_gpios *mctrl_gpio_init(struct uart_port *port, unsigned int idx_if_needed);
> >	int mctrl_gpio_enable_ms(struct mctrl_gpios *gpios);
> >	int mctrl_gpio_disable_ms(struct mctrl_gpios *gpios);
> >	void mctrl_gpio_free(struct mctrl_gpios *gpios);
> >
> >I think mctrl_gpio_init should request the needed irqs, but not enable
> >them.
> 
> Yes. I tried to assign irq value in mctrl_gpio_init() only.
> There was another issue if CONFIG_GPIOLIB is not defined but it
> looks mctrl_ disable/enable_ms()
> and mctrl_ irq handler solve the problem.
> 
> >  Not sure there is a corresponding request_irq variant for that.
> 
> What would you propose?
Hmm
> 
> >Another open issue is how mctrl_gpio_init should find out about which
> >gpios to use if there is no device tree. This doesn't necessarily needs
> >to be solved now, but maybe rename mctrl_gpio_init to
> >mctrl_gpio_init_dt?
> 
> Right
> 
> best regards
> Janusz
> 
> >
> >Best regards
> >Uwe
> >
> 
> 

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
