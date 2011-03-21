From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 21 Mar 2011 01:43:34 -0600
Subject: [PATCH 2/2] ARM: mx5/mx53_evk: Remove unneeded gpio_set_value call
In-Reply-To: <Pine.LNX.4.64.1103202201060.27008@ask.diku.dk>
References: <1300126869-14587-1-git-send-email-fabio.estevam@freescale.com>
	<1300126869-14587-2-git-send-email-fabio.estevam@freescale.com>
	<20110315090656.GC13316@pengutronix.de>
	<Pine.LNX.4.64.1103151039030.11859@ask.diku.dk>
	<20110315094946.GD13316@pengutronix.de>
	<Pine.LNX.4.64.1103151113420.8560@pc-004.diku.dk>
	<20110316083326.GF13316@pengutronix.de>
	<Pine.LNX.4.64.1103201850250.27008@ask.diku.dk>
	<20110320192451.GA19808@pengutronix.de>
	<Pine.LNX.4.64.1103202201060.27008@ask.diku.dk>
Message-ID: <AANLkTinponAhPonKeZ9rE1boqJEsVqyvBLKfHCt84Shm@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 20, 2011 at 3:04 PM, Julia Lawall <julia@diku.dk> wrote:
> In this case, I also ignore the !GPIOLIB issue. ?This semantic patch
> considers the case where the direction call has some error handling code.
> In this case, it just deletes that error handling code, so most of these
> cases are likely to need some manual cleanup, eg to get rid of unreachable
> error labels or to change the error message.
>
[...]
> diff -u -p a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
> --- a/arch/arm/mach-omap2/board-4430sdp.c 2011-03-20 18:17:22.000000000 +0100
> +++ b/arch/arm/mach-omap2/board-4430sdp.c 2011-03-20 22:00:22.000000000 +0100
> @@ -257,44 +257,26 @@ static int omap_ethernet_init(void)
>
> ? ? ? ?/* Request of GPIO lines */
>
> - ? ? ? status = gpio_request(ETH_KS8851_POWER_ON, "eth_power");
> + ? ? ? status = gpio_request_one(ETH_KS8851_POWER_ON, GPIOF_OUT_INIT_HIGH,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? "eth_power");
> ? ? ? ?if (status) {
> ? ? ? ? ? ? ? ?pr_err("Cannot request GPIO %d\n", ETH_KS8851_POWER_ON);
> ? ? ? ? ? ? ? ?return status;
> ? ? ? ?}
>
> - ? ? ? status = gpio_request(ETH_KS8851_QUART, "quart");
> + ? ? ? status = gpio_request_one(ETH_KS8851_QUART, GPIOF_OUT_INIT_HIGH,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? "quart");
> ? ? ? ?if (status) {
> ? ? ? ? ? ? ? ?pr_err("Cannot request GPIO %d\n", ETH_KS8851_QUART);
> ? ? ? ? ? ? ? ?goto error1;
> ? ? ? ?}
>
> - ? ? ? status = gpio_request(ETH_KS8851_IRQ, "eth_irq");
> + ? ? ? status = gpio_request_one(ETH_KS8851_IRQ, GPIOF_IN, "eth_irq");
> ? ? ? ?if (status) {
> ? ? ? ? ? ? ? ?pr_err("Cannot request GPIO %d\n", ETH_KS8851_IRQ);
> ? ? ? ? ? ? ? ?goto error2;
> ? ? ? ?}
>
> - ? ? ? /* Configuration of requested GPIO lines */
> -
> - ? ? ? status = gpio_direction_output(ETH_KS8851_POWER_ON, 1);
> - ? ? ? if (status) {
> - ? ? ? ? ? ? ? pr_err("Cannot set output GPIO %d\n", ETH_KS8851_IRQ);
> - ? ? ? ? ? ? ? goto error3;
> - ? ? ? }
> -
> - ? ? ? status = gpio_direction_output(ETH_KS8851_QUART, 1);
> - ? ? ? if (status) {
> - ? ? ? ? ? ? ? pr_err("Cannot set output GPIO %d\n", ETH_KS8851_QUART);
> - ? ? ? ? ? ? ? goto error3;
> - ? ? ? }
> -
> - ? ? ? status = gpio_direction_input(ETH_KS8851_IRQ);
> - ? ? ? if (status) {
> - ? ? ? ? ? ? ? pr_err("Cannot set input GPIO %d\n", ETH_KS8851_IRQ);
> - ? ? ? ? ? ? ? goto error3;
> - ? ? ? }
> -
> ? ? ? ?return 0;

This hunk is probably wrong.  If gpio pins are being requested, it is
important to verify that all gpios have been requested successfully
before actively changing the state on any of them.  This hunk changes
the behaviour.

> diff -u -p a/arch/arm/mach-pxa/cm-x270.c b/arch/arm/mach-pxa/cm-x270.c
> --- a/arch/arm/mach-pxa/cm-x270.c 2010-12-31 15:18:30.000000000 +0100
> +++ b/arch/arm/mach-pxa/cm-x270.c 2011-03-20 22:00:23.000000000 +0100
> @@ -327,22 +327,18 @@ static unsigned long cm_x270_libertas_pi
>
> ?static int cm_x270_libertas_setup(struct spi_device *spi)
> ?{
> - ? ? ? int err = gpio_request(GPIO19_WLAN_STRAP, "WLAN STRAP");
> + ? ? ? int err = gpio_request_one(GPIO19_WLAN_STRAP, GPIOF_OUT_INIT_HIGH,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?"WLAN STRAP");
> ? ? ? ?if (err)
> ? ? ? ? ? ? ? ?return err;
>
> - ? ? ? err = gpio_request(GPIO102_WLAN_RST, "WLAN RST");
> + ? ? ? err = gpio_request_one(GPIO102_WLAN_RST, GPIOF_OUT_INIT_LOW,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?"WLAN RST");
> ? ? ? ?if (err)
> ? ? ? ? ? ? ? ?goto err_free_strap;
>
> - ? ? ? err = gpio_direction_output(GPIO102_WLAN_RST, 0);
> - ? ? ? if (err)
> - ? ? ? ? ? ? ? goto err_free_strap;
> ? ? ? ?msleep(100);
>
> - ? ? ? err = gpio_direction_output(GPIO19_WLAN_STRAP, 1);
> - ? ? ? if (err)
> - ? ? ? ? ? ? ? goto err_free_strap;
> ? ? ? ?msleep(100);

Ditto here, and it also loses the msleep delays.

Overall, I'm nervious about this change.  Most of the *should* be
okay, but the original code isn't exactly wrong either.  I'd rather
just leave them be unless it can be tested.  I certainly don't want to
change them all wholesale.

g.
