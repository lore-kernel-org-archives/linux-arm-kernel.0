From: shc_work@mail.ru (Alexander Shiyan)
Date: Tue, 18 Feb 2014 19:26:20 +0400
Subject: [PATCH v3 1/7] tty/serial: Add GPIOLIB helpers for controlling
 modem lines
In-Reply-To: <53032F1C.2040607@gmail.com>
References: <1392656247-3351-1-git-send-email-richard.genoud@gmail.com>
 <1392656247-3351-2-git-send-email-richard.genoud@gmail.com>
 <1392662231.122430857@f359.i.mail.ru> <53032F1C.2040607@gmail.com>
Message-ID: <20140218192620.12ad4b94cb63135e8665cf45@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 18 Feb 2014 10:59:56 +0100
Richard Genoud <richard.genoud@gmail.com> wrote:

> On 17/02/2014 19:37, Alexander Shiyan wrote:
> > Hello.
> Hi !
> > 
> > A few comments below..
> > 
> > ???????????, 17 ??????? 2014, 17:57 +01:00 ?? Richard Genoud <richard.genoud@gmail.com>:
> >> This patch add some helpers to control modem lines (CTS/RTS/DSR...) via
> >> GPIO.
> >> This will be useful for many boards which have a serial controller that
> >> only handle CTS/RTS pins (or even just RX/TX).
> >>
> >> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
> >> ---
> > ...
> >> diff --git a/drivers/tty/serial/serial_mctrl_gpio.c b/drivers/tty/serial/serial_mctrl_gpio.c
> > ...
> >> +static const struct {
> >> +	const char *name;
> >> +	unsigned int mctrl;
> >> +	bool dir_out;
> >> +} mctrl_gpios_desc[] = {
> >> +	{ "cts", TIOCM_CTS, false, },
> >> +	{ "dsr", TIOCM_DSR, false, },
> >> +	{ "dcd", TIOCM_CD, false, },
> >> +	{ "ri", TIOCM_RI, false, },
> >> +	{ "rts", TIOCM_RTS, true, },
> >> +	{ "dtr", TIOCM_DTR, true, },
> >> +	{ "out1", TIOCM_OUT1, true, },
> >> +	{ "out2", TIOCM_OUT2, true, },
> >> +};
> >> +
> >> +void mctrl_gpio_set(struct mctrl_gpios *gpios, unsigned int mctrl)
> >> +{
> >> +	enum mctrl_gpio_idx i;
> >> +
> >> +	for (i = 0; i < UART_GPIO_MAX; i++)
> > 
> > Use ARRAY_SIZE(mctrl_gpios_desc) here and elsewhere below.
> Could you explain why ARRAY_SIZE(mctrl_gpios_desc) seems better than
> UART_GPIO_MAX ?

Because you iterate through the array.
I do not see the use of UART_GPIO_MAX in this module. You use UART_GPIO_MAX
in the at91 serial driver only, here we must be sure that we are within the
boundaries of the array.

...
> >> +unsigned int mctrl_gpio_get(struct mctrl_gpios *gpios, unsigned int *mctrl)
> >> +{
> > 
> > Why you want to put mctrl as parameter here?
> > Let's return mctrl from GPIOs, then handle this value as you want int the driver.
> It's because I like when it's simple :).
> Use case:
> Your USART controller handles CTS/RTS, and you add DTR/DSR as gpios.
> In get_mctrl() callback, with current implementation, you'll have
> something like this: (cf atmel_get_mctrl() for a real life example)
> {
> unsigned int mctrl;
> mctrl = usart_controller_get_mctrl(); /* driver specific */
> return mctrl_gpio_get(gpios, &mctrl);
> }
> If I use as you suggest mctrl_gpio_get(struct mctrl_gpios *gpios), we'll
> have:
> {
> unsigned int usart_mctrl;
> unsigned int gpio_mctrl;
> int i;
> 
> usart_mctrl = usart_controller_get_mctrl();
> gpio_mctrl = mctrl_gpio_get(gpios);
> if (!IS_ERR_OR_NULL(gpios->gpio[UART_GPIO_CTS]) {
> 	if (gpio_mctrl & TIOCM_CTS)
> 		usart_mctrl |= TIOCM_CTS;
> 	else
> 		usart_mctrl &= ~TIOCM_CTS;
> }
> if (!IS_ERR_OR_NULL(gpios->gpio[UART_GPIO_DSR]) {
> 	if (gpio_mctrl & TIOCM_DSR)
> 		usart_mctrl |= TIOCM_DSR;
> 	else
> 		usart_mctrl &= ~TIOCM_DSR;
> }

No, just like this:
{
  unsigned int mctrl = usart_controller_get_mctrl(); /* driver specific */
  mctrl |= mctrl_gpio_get(gpios, mctrl) & ~(TIOCM_CTS | TIOCM_DSR);
  return mctrl;
}

or in reverse order:
{
  unsigned int mctrl = mctrl_gpio_get(gpios, mctrl);
  return mctrl | usart_controller_get_mctrl(); /* driver specific */
}

...
> >> +int mctrl_gpio_init(struct device *dev, struct mctrl_gpios *gpios)
> >> +{
> > 
> > I suggest to allocate "gpios" here and return pointer to this structure
> > or ERR_PTR(). Additionally, as I mentioned before, add "index" variable
> > to specify port number.
> 
> I don't understand the benefit of dynamically allocating something that
> has a fixed size...
> Or maybe in the case no GPIO are used, the array is not allocated, and
> I'll have to add "if (!gpios)" test in other functions. That could save
> some bytes.

Yes, but basically this able to use just a pointer in your driver data,
this will not depend on GPIOLIB, since without GPIOLIB we do not know storage
size of struct gpio_desc.

> Could you explain a little more your idea of ""index" variable to
> specify port number" ?
> I'm not sure to get it.

Index can be used for drivers which allocate more than one port for one device.
In your implementation you should just replace devm_gpiod_get() to
devm_gpiod_get_index() and add an additional parameter to mctrl_gpio_init().
For at91 serial this parameter should be 0.

> 
> >> +	enum mctrl_gpio_idx i;
> >> +	int err = 0;
> >> +	int ret = 0;
> >> +
> >> +	for (i = 0; i < UART_GPIO_MAX; i++) {
> >> +		gpios->gpio[i] = devm_gpiod_get(dev, mctrl_gpios_desc[i].name);
...

-- 
Alexander Shiyan <shc_work@mail.ru>
