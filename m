From: marvin24@gmx.de (Marc Dietrich)
Date: Mon, 7 Mar 2011 20:59:10 +0100
Subject: [PATCH 1/2] Add initial support for the Toshiba AC100/Dynabook AZ
	netbook
In-Reply-To: <AANLkTinncQdKy-POUN2QQJYhc20Kg6z-grUBqehu7k8x@mail.gmail.com>
References: <1299421906-7366-1-git-send-email-marvin24@gmx.de>
	<1299421906-7366-2-git-send-email-marvin24@gmx.de>
	<AANLkTinncQdKy-POUN2QQJYhc20Kg6z-grUBqehu7k8x@mail.gmail.com>
Message-ID: <201103072059.11231.marvin24@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Monday 07 March 2011 09:37:26 Olof Johansson wrote:
> On Sun, Mar 6, 2011 at 6:31 AM, Marc Dietrich <marvin24@gmx.de> wrote:
> > Signed-off-by: Marc Dietrich <marvin24@gmx.de>
> 
> As Colin said, a short patch description would be appreciated.

ok.
 
> > diff --git a/arch/arm/mach-tegra/board-paz00-pinmux.c b/arch/arm/mach-tegra/board-paz00-pinmux.c
> > new file mode 100644
> > index 0000000..347a919
> > --- /dev/null
> > +++ b/arch/arm/mach-tegra/board-paz00-pinmux.c
> [...]
> > +static struct tegra_gpio_table gpio_table[] = {
> > +       { .gpio = TEGRA_GPIO_PV5,       .enable = true  }, /* mmc2 cd   */
> > +       { .gpio = TEGRA_GPIO_PH1,       .enable = true  }, /* mmc2 wp   */
> > +       { .gpio = TEGRA_GPIO_PT3,       .enable = true  }, /* mmc2 pwr  */
> > +       { .gpio = TEGRA_GPIO_PH2,       .enable = true  }, /* mmc4 cd   */
> > +       { .gpio = TEGRA_GPIO_PH3,       .enable = true  }, /* mmc4 wp   */
> > +       { .gpio = TEGRA_GPIO_PI6,       .enable = true  }, /* mmc4 pwr  */
> > +};
> 
> Stephen Warren cleaned up Harmony and Seaboard and moved the GPIO
> definitions to board-<board>.h and gave them symbolic names. Would you
> mind doing that for these as well, please?

will do.

> > diff --git a/arch/arm/mach-tegra/board-paz00.c b/arch/arm/mach-tegra/board-paz00.c
> > new file mode 100644
> > index 0000000..a33ce98
> > --- /dev/null
> > +++ b/arch/arm/mach-tegra/board-paz00.c
> [...]
> > +static struct tegra_sdhci_platform_data sdhci_pdata1 = {
> > +       .cd_gpio        = -1,
> > +       .wp_gpio        = -1,
> > +       .power_gpio     = -1,
> > +};
> > +
> > +static struct tegra_sdhci_platform_data sdhci_pdata2 = {
> > +       .cd_gpio        = TEGRA_GPIO_PV5,
> > +       .wp_gpio        = TEGRA_GPIO_PH1,
> > +       .power_gpio     = TEGRA_GPIO_PT3,
> > +};
> > +
> > +static struct tegra_sdhci_platform_data sdhci_pdata4 = {
> > +       .cd_gpio        = TEGRA_GPIO_PH2,
> > +       .wp_gpio        = TEGRA_GPIO_PH3,
> > +       .power_gpio     = TEGRA_GPIO_PI6,
> > +       .is_8bit        = 1,
> > +};
> 
> Weird, the internal eMMC has CD and WP gpios?!

Yes that's strange. On the other hand, harmony has these gpios, the Toshiba 
source defines them, and they don't hurt. So I vote for keeping them for 
consistency reasons.

It was good that you mentioned these gpios as I found an error in my original
post. On AC100, the external mmc is connected to the first sdhci, not the 
second. Even Toshiba/Compal seem to were confused as they also added a wrong 
comment to the source (which I blindly followed).

I'll send an updated version soon, which also adds PAZ00 to tegra_defconfig.

Thanks!

Marc
