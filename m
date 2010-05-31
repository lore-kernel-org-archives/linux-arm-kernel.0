From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 31 May 2010 23:02:41 +0800
Subject: [PATCH] ARM: pxa/raumfeld: check charge state after resume
In-Reply-To: <1275314552-5214-1-git-send-email-daniel@caiaq.de>
References: <AANLkTikMrOtrwI82Y9sXEGU80TZJ7brruXuoE8wiUGLj@mail.gmail.com>
	<1275314552-5214-1-git-send-email-daniel@caiaq.de>
Message-ID: <AANLkTil2Wnec2wvF1_tSfQ5HeWroyMZ8nDBrIVWP4aOJ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 31, 2010 at 10:02 PM, Daniel Mack <daniel@caiaq.de> wrote:
> Use the resume callback of the pda_power supply framework to check for a
> 'charge finished' event that might have occured during the sleep phase.
>
> Signed-off-by: Daniel Mack <daniel@caiaq.de>
> Cc: Eric Miao <eric.y.miao@gmail.com>

Applied.

> ---
> ?arch/arm/mach-pxa/raumfeld.c | ? 29 +++++++++++++++++++++--------
> ?1 files changed, 21 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm/mach-pxa/raumfeld.c b/arch/arm/mach-pxa/raumfeld.c
> index 1c8cd39..7582a12 100644
> --- a/arch/arm/mach-pxa/raumfeld.c
> +++ b/arch/arm/mach-pxa/raumfeld.c
> @@ -750,13 +750,32 @@ static int raumfeld_is_usb_online(void)
>
> ?static char *raumfeld_power_supplicants[] = { "ds2760-battery.0" };
>
> +static void raumfeld_power_signal_charged(void)
> +{
> + ? ? ? struct power_supply *psy =
> + ? ? ? ? ? ? ? power_supply_get_by_name(raumfeld_power_supplicants[0]);
> +
> + ? ? ? if (psy)
> + ? ? ? ? ? ? ? power_supply_set_battery_charged(psy);
> +}
> +
> +static int raumfeld_power_resume(void)
> +{
> + ? ? ? /* check if GPIO_CHARGE_DONE went low while we were sleeping */
> + ? ? ? if (!gpio_get_value(GPIO_CHARGE_DONE))
> + ? ? ? ? ? ? ? raumfeld_power_signal_charged();
> +
> + ? ? ? return 0;
> +}
> +
> ?static struct pda_power_pdata power_supply_info = {
> ? ? ? ?.init ? ? ? ? ? ? ? ? ? = power_supply_init,
> ? ? ? ?.is_ac_online ? ? ? ? ? = raumfeld_is_ac_online,
> ? ? ? ?.is_usb_online ? ? ? ? ?= raumfeld_is_usb_online,
> ? ? ? ?.exit ? ? ? ? ? ? ? ? ? = power_supply_exit,
> ? ? ? ?.supplied_to ? ? ? ? ? ?= raumfeld_power_supplicants,
> - ? ? ? .num_supplicants ? ? ? ?= ARRAY_SIZE(raumfeld_power_supplicants)
> + ? ? ? .num_supplicants ? ? ? ?= ARRAY_SIZE(raumfeld_power_supplicants),
> + ? ? ? .resume ? ? ? ? ? ? ? ? = raumfeld_power_resume,
> ?};
>
> ?static struct resource power_supply_resources[] = {
> @@ -771,13 +790,7 @@ static struct resource power_supply_resources[] = {
>
> ?static irqreturn_t charge_done_irq(int irq, void *dev_id)
> ?{
> - ? ? ? struct power_supply *psy;
> -
> - ? ? ? psy = power_supply_get_by_name("ds2760-battery.0");
> -
> - ? ? ? if (psy)
> - ? ? ? ? ? ? ? power_supply_set_battery_charged(psy);
> -
> + ? ? ? raumfeld_power_signal_charged();
> ? ? ? ?return IRQ_HANDLED;
> ?}
>
> --
> 1.7.1
>
>
