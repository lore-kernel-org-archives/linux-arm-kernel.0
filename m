From: shawn.gsc@gmail.com (Shawn Guo)
Date: Fri, 10 Dec 2010 23:32:40 +0800
Subject: [PATCH v3 07/15] ARM: mxs: Add gpio support
In-Reply-To: <20101210081126.GE17441@pengutronix.de>
References: <1290754154-9428-1-git-send-email-shawn.guo@freescale.com>
	<1291907569-8925-7-git-send-email-shawn.guo@freescale.com>
	<19713.2074.562086.117710@ipc1.ka-ro>
	<AANLkTi=r_HNk1Xsv8yAXZ54-NNn_awA3qR204NMKu6rB@mail.gmail.com>
	<AANLkTin=urFhXb1DRcHjeTZ-MM4Ae0_OHbsfP0KzPmiK@mail.gmail.com>
	<20101210081126.GE17441@pengutronix.de>
Message-ID: <AANLkTinWKNmUZ3vjpE9DvJ0ursJPkUMbFxaPvzSJcD6d@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

2010/12/10 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> Hello Shawn,
>
> On Fri, Dec 10, 2010 at 03:23:13PM +0800, Shawn Guo wrote:
>> On Fri, Dec 10, 2010 at 3:06 PM, Shawn Guo <shawn.gsc@gmail.com> wrote:
>> > On Fri, Dec 10, 2010 at 12:47 AM, Lothar Wa?mann <LW@karo-electronics.de> wrote:
>> >> Shawn Guo writes:
>> >>> +static void _set_gpio_irqenable(struct mxs_gpio_port *port, u32 index,
>> >>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? int enable)
>> >>> +{
>> >>> + ? ? if (enable == 0) {
>> >>> + ? ? ? ? ? ? __raw_writel(1 << index,
>> >>> + ? ? ? ? ? ? ? ? ? ? port->base + PINCTRL_PIN2IRQ(port->id) + MXS_CLR_ADDR);
>> >>> + ? ? ? ? ? ? __raw_writel(1 << index,
>> >>> + ? ? ? ? ? ? ? ? ? ? port->base + PINCTRL_IRQEN(port->id) + MXS_CLR_ADDR);
>> >> This will loose interrupt pulses that happen while IRQs are disabled.
>> >> IMO PIN2IRQ should only be cleared when an IRQ is freed, not when it
>> >> is disabled.
>> >>
>> > What about leaving PIN2IRQ always be 1 and only using IRQEN to
>> > enable/disable IRQ? ?I consulted the designer it's no problem no
>> > matter what the pin function is.
>> >
>> The code will be like:
>>
>> static void _set_gpio_irqenable(struct mxs_gpio_port *port, u32 index,
>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? int enable)
>> {
>> ? ? ? ? if (enable) {
>> ? ? ? ? ? ? ? ? __raw_writel(1 << index,
>> ? ? ? ? ? ? ? ? ? ? ? ? port->base + PINCTRL_IRQEN(port->id) + MXS_SET_ADDR);
>> ? ? ? ? ? ? ? ? __raw_writel(1 << index,
>> ? ? ? ? ? ? ? ? ? ? ? ? port->base + PINCTRL_PIN2IRQ(port->id) + MXS_SET_ADDR);
>> ? ? ? ? } else {
>> ? ? ? ? ? ? ? ? __raw_writel(1 << index,
>> ? ? ? ? ? ? ? ? ? ? ? ? port->base + PINCTRL_IRQEN(port->id) + MXS_CLR_ADDR);
>> ? ? ? ? }
>> }
> If I understood Lothar correctly the best way is to set and clear
> PINCTRL_PIN2IRQ in the irqchips irq_startup and irq_shutdown routine.
>
Is there any problem with the current code to address Lothar's
concern?  If no, I would not introduce two more irq_chip routines into
the file.

-- 
Regards,
Shawn
