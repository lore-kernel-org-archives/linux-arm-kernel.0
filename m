From: richard.genoud@gmail.com (Richard Genoud)
Date: Tue, 18 Feb 2014 10:59:56 +0100
Subject: [PATCH v3 1/7] tty/serial: Add GPIOLIB helpers for controlling
 modem lines
In-Reply-To: <1392662231.122430857@f359.i.mail.ru>
References: <1392656247-3351-1-git-send-email-richard.genoud@gmail.com>
 <1392656247-3351-2-git-send-email-richard.genoud@gmail.com>
 <1392662231.122430857@f359.i.mail.ru>
Message-ID: <53032F1C.2040607@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/02/2014 19:37, Alexander Shiyan wrote:
> Hello.
Hi !
> 
> A few comments below..
> 
> ???????????, 17 ??????? 2014, 17:57 +01:00 ?? Richard Genoud <richard.genoud@gmail.com>:
>> This patch add some helpers to control modem lines (CTS/RTS/DSR...) via
>> GPIO.
>> This will be useful for many boards which have a serial controller that
>> only handle CTS/RTS pins (or even just RX/TX).
>>
>> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
>> ---
> ...
>> diff --git a/drivers/tty/serial/serial_mctrl_gpio.c b/drivers/tty/serial/serial_mctrl_gpio.c
> ...
>> +static const struct {
>> +	const char *name;
>> +	unsigned int mctrl;
>> +	bool dir_out;
>> +} mctrl_gpios_desc[] = {
>> +	{ "cts", TIOCM_CTS, false, },
>> +	{ "dsr", TIOCM_DSR, false, },
>> +	{ "dcd", TIOCM_CD, false, },
>> +	{ "ri", TIOCM_RI, false, },
>> +	{ "rts", TIOCM_RTS, true, },
>> +	{ "dtr", TIOCM_DTR, true, },
>> +	{ "out1", TIOCM_OUT1, true, },
>> +	{ "out2", TIOCM_OUT2, true, },
>> +};
>> +
>> +void mctrl_gpio_set(struct mctrl_gpios *gpios, unsigned int mctrl)
>> +{
>> +	enum mctrl_gpio_idx i;
>> +
>> +	for (i = 0; i < UART_GPIO_MAX; i++)
> 
> Use ARRAY_SIZE(mctrl_gpios_desc) here and elsewhere below.
Could you explain why ARRAY_SIZE(mctrl_gpios_desc) seems better than
UART_GPIO_MAX ?

> 
>> +		if (!IS_ERR_OR_NULL(gpios->gpio[i]) &&
>> +		    mctrl_gpios_desc[i].dir_out)
>> +			gpiod_set_value(gpios->gpio[i],
>> +					!!(mctrl & mctrl_gpios_desc[i].mctrl));
>> +}
>> +EXPORT_SYMBOL_GPL(mctrl_gpio_set);
>> +
>> +unsigned int mctrl_gpio_get(struct mctrl_gpios *gpios, unsigned int *mctrl)
>> +{
> 
> Why you want to put mctrl as parameter here?
> Let's return mctrl from GPIOs, then handle this value as you want int the driver.
It's because I like when it's simple :).
Use case:
Your USART controller handles CTS/RTS, and you add DTR/DSR as gpios.
In get_mctrl() callback, with current implementation, you'll have
something like this: (cf atmel_get_mctrl() for a real life example)
{
unsigned int mctrl;
mctrl = usart_controller_get_mctrl(); /* driver specific */
return mctrl_gpio_get(gpios, &mctrl);
}
If I use as you suggest mctrl_gpio_get(struct mctrl_gpios *gpios), we'll
have:
{
unsigned int usart_mctrl;
unsigned int gpio_mctrl;
int i;

usart_mctrl = usart_controller_get_mctrl();
gpio_mctrl = mctrl_gpio_get(gpios);
if (!IS_ERR_OR_NULL(gpios->gpio[UART_GPIO_CTS]) {
	if (gpio_mctrl & TIOCM_CTS)
		usart_mctrl |= TIOCM_CTS;
	else
		usart_mctrl &= ~TIOCM_CTS;
}
if (!IS_ERR_OR_NULL(gpios->gpio[UART_GPIO_DSR]) {
	if (gpio_mctrl & TIOCM_DSR)
		usart_mctrl |= TIOCM_DSR;
	else
		usart_mctrl &= ~TIOCM_DSR;
}
etc...
}
Because when gpio_mctrl is returned, I don't know if a flag is not set
because a gpio is at 1 or because the gpio has not been requested.
In the later case, the value should not override the value retrieved by
the controller.

another solution would be to use a mask filled at startup:
init_gpios(...)
{
unsigned int driver_port_gpio_input_mask = 0;
mctrl_gpio_init(dev, &p->gpios);

if (!IS_ERR_OR_NULL(gpios->gpio[UART_GPIO_CTS])
	driver_port_gpio_mask |= TIOCM_CTS;
if (!IS_ERR_OR_NULL(gpios->gpio[UART_GPIO_DSR])
	driver_port_gpio_mask |= TIOCM_DSR;
if (!IS_ERR_OR_NULL(gpios->gpio[UART_GPIO_DCD])
	driver_port_gpio_mask |= TIOCM_DCD;
if (!IS_ERR_OR_NULL(gpios->gpio[UART_GPIO_RI])
	driver_port_gpio_mask |= TIOCM_RI;
}
and then, in get_mctrl():
{
unsigned int mctrl;
int i;

mctrl = usart_controller_get_mctrl();
mctrl &= ~driver_port_gpio_input_mask;
mctrl |= mctrl_gpio_get(gpios);
return mctrl;
}

But both solutions seems to me more complicated than the first one.


>> +	enum mctrl_gpio_idx i;
>> +
>> +	for (i = 0; i < UART_GPIO_MAX; i++) {
>> +		if (!IS_ERR_OR_NULL(gpios->gpio[i]) &&
>> +		    !mctrl_gpios_desc[i].dir_out) {
>> +			if (gpiod_get_value(gpios->gpio[i]))
>> +				*mctrl |= mctrl_gpios_desc[i].mctrl;
>> +			else
>> +				*mctrl &= ~mctrl_gpios_desc[i].mctrl;
>> +		}
>> +	}
>> +
>> +	return *mctrl;
>> +}
>> +EXPORT_SYMBOL_GPL(mctrl_gpio_get);
>> +
> 
>> +int mctrl_gpio_init(struct device *dev, struct mctrl_gpios *gpios)
>> +{
> 
> I suggest to allocate "gpios" here and return pointer to this structure
> or ERR_PTR(). Additionally, as I mentioned before, add "index" variable
> to specify port number.

I don't understand the benefit of dynamically allocating something that
has a fixed size...
Or maybe in the case no GPIO are used, the array is not allocated, and
I'll have to add "if (!gpios)" test in other functions. That could save
some bytes.

Could you explain a little more your idea of ""index" variable to
specify port number" ?
I'm not sure to get it.

>> +	enum mctrl_gpio_idx i;
>> +	int err = 0;
>> +	int ret = 0;
>> +
>> +	for (i = 0; i < UART_GPIO_MAX; i++) {
>> +		gpios->gpio[i] = devm_gpiod_get(dev, mctrl_gpios_desc[i].name);
>> +
>> +		/*
>> +		 * The GPIOs are maybe not all filled,
>> +		 * this is not an error.
>> +		 */
>> +		if (IS_ERR_OR_NULL(gpios->gpio[i]))
>> +			continue;
>> +
>> +		if (mctrl_gpios_desc[i].dir_out)
>> +			err = gpiod_direction_output(gpios->gpio[i], 0);
>> +		else
>> +			err = gpiod_direction_input(gpios->gpio[i]);
>> +		if (err) {
>> +			dev_err(dev, "Unable to set direction for %s GPIO",
>> +				mctrl_gpios_desc[i].name);
>> +			devm_gpiod_put(dev, gpios->gpio[i]);
>> +			gpios->gpio[i] = NULL;
>> +			ret--;
>> +		}
>> +	}
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(mctrl_gpio_init);
> ...
>> diff --git a/drivers/tty/serial/serial_mctrl_gpio.h b/drivers/tty/serial/serial_mctrl_gpio.h
> ...
>> +enum mctrl_gpio_idx {
>> +	UART_GPIO_CTS,
>> +	UART_GPIO_DSR,
>> +	UART_GPIO_DCD,
>> +	UART_GPIO_RI,
>> +	UART_GPIO_RTS,
>> +	UART_GPIO_DTR,
>> +	UART_GPIO_OUT1,
>> +	UART_GPIO_OUT2,
>> +	UART_GPIO_MAX,
>> +};
>> +
>> +struct mctrl_gpios {
>> +	struct gpio_desc *gpio[UART_GPIO_MAX];
> 
> struct gpio_desc *gpio;
> 
> ...
>> +static inline
>> +int mctrl_gpio_init(struct device *dev, struct mctrl_gpios *gpios)
>> +{
>> +	return -UART_GPIO_MAX;
> 
> return -ENOSYS;
yes, that's right.

> 
> ...
> 
> Thanks.
Thanks for your review !

Richard.
