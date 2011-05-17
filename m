From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 17 May 2011 21:22:14 +0800
Subject: [PATCH 2/4] arm: pxa3xx: cm-x300: GPIO cleanup
In-Reply-To: <1304941309-13288-2-git-send-email-grinberg@compulab.co.il>
References: <1304941309-13288-1-git-send-email-grinberg@compulab.co.il>
	<1304941309-13288-2-git-send-email-grinberg@compulab.co.il>
Message-ID: <BANLkTimpqnwNjKrNFamq3Q7gxGEFvKac-w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 9, 2011 at 7:41 PM, Igor Grinberg <grinberg@compulab.co.il> wrote:
> use gpio_request_<one|array>() instead of multiple gpiolib calls
>
> Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>

Applied.

> ---
> ?arch/arm/mach-pxa/cm-x300.c | ? 43 ++++++++++++++++++++-----------------------
> ?1 files changed, 20 insertions(+), 23 deletions(-)
>
> diff --git a/arch/arm/mach-pxa/cm-x300.c b/arch/arm/mach-pxa/cm-x300.c
> index 8a03487..880df33 100644
> --- a/arch/arm/mach-pxa/cm-x300.c
> +++ b/arch/arm/mach-pxa/cm-x300.c
> @@ -484,14 +484,14 @@ static int cm_x300_ulpi_phy_reset(void)
> ? ? ? ?int err;
>
> ? ? ? ?/* reset the PHY */
> - ? ? ? err = gpio_request(GPIO_ULPI_PHY_RST, "ulpi reset");
> + ? ? ? err = gpio_request_one(GPIO_ULPI_PHY_RST, GPIOF_OUT_INIT_LOW,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?"ulpi reset");
> ? ? ? ?if (err) {
> ? ? ? ? ? ? ? ?pr_err("%s: failed to request ULPI reset GPIO: %d\n",
> ? ? ? ? ? ? ? ? ? ? ? __func__, err);
> ? ? ? ? ? ? ? ?return err;
> ? ? ? ?}
>
> - ? ? ? gpio_direction_output(GPIO_ULPI_PHY_RST, 0);
> ? ? ? ?msleep(10);
> ? ? ? ?gpio_set_value(GPIO_ULPI_PHY_RST, 1);
> ? ? ? ?msleep(10);
> @@ -768,39 +768,36 @@ static void __init cm_x300_init_da9030(void)
> ? ? ? ?irq_set_irq_wake(IRQ_WAKEUP0, 1);
> ?}
>
> +/* wi2wi gpio setting for system_rev >= 130 */
> +static struct gpio cm_x300_wi2wi_gpios[] __initdata = {
> + ? ? ? { 71, GPIOF_OUT_INIT_HIGH, "wlan en" },
> + ? ? ? { 70, GPIOF_OUT_INIT_HIGH, "bt reset" },
> +};
> +
> ?static void __init cm_x300_init_wi2wi(void)
> ?{
> ? ? ? ?int bt_reset, wlan_en;
> ? ? ? ?int err;
>
> ? ? ? ?if (system_rev < 130) {
> - ? ? ? ? ? ? ? wlan_en = 77;
> - ? ? ? ? ? ? ? bt_reset = 78;
> - ? ? ? } else {
> - ? ? ? ? ? ? ? wlan_en = 71;
> - ? ? ? ? ? ? ? bt_reset = 70;
> + ? ? ? ? ? ? ? cm_x300_wi2wi_gpios[0].gpio = 77; ? ? ? /* wlan en */
> + ? ? ? ? ? ? ? cm_x300_wi2wi_gpios[1].gpio = 78; ? ? ? /* bt reset */
> ? ? ? ?}
>
> ? ? ? ?/* Libertas and CSR reset */
> - ? ? ? err = gpio_request(wlan_en, "wlan en");
> + ? ? ? err = gpio_request_array(ARRAY_AND_SIZE(cm_x300_wi2wi_gpios));
> ? ? ? ?if (err) {
> - ? ? ? ? ? ? ? pr_err("CM-X300: failed to request wlan en gpio: %d\n", err);
> - ? ? ? } else {
> - ? ? ? ? ? ? ? gpio_direction_output(wlan_en, 1);
> - ? ? ? ? ? ? ? gpio_free(wlan_en);
> + ? ? ? ? ? ? ? pr_err("CM-X300: failed to request wifi/bt gpios: %d\n", err);
> + ? ? ? ? ? ? ? return;
> ? ? ? ?}
>
> - ? ? ? err = gpio_request(bt_reset, "bt reset");
> - ? ? ? if (err) {
> - ? ? ? ? ? ? ? pr_err("CM-X300: failed to request bt reset gpio: %d\n", err);
> - ? ? ? } else {
> - ? ? ? ? ? ? ? gpio_direction_output(bt_reset, 1);
> - ? ? ? ? ? ? ? udelay(10);
> - ? ? ? ? ? ? ? gpio_set_value(bt_reset, 0);
> - ? ? ? ? ? ? ? udelay(10);
> - ? ? ? ? ? ? ? gpio_set_value(bt_reset, 1);
> - ? ? ? ? ? ? ? gpio_free(bt_reset);
> - ? ? ? }
> + ? ? ? udelay(10);
> + ? ? ? gpio_set_value(bt_reset, 0);
> + ? ? ? udelay(10);
> + ? ? ? gpio_set_value(bt_reset, 1);
> +
> + ? ? ? gpio_free(wlan_en);
> + ? ? ? gpio_free(bt_reset);
> ?}
>
> ?/* MFP */
> --
> 1.7.3.4
>
>
