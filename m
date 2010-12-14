From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 14 Dec 2010 22:07:24 +0800
Subject: [PATCH 10/17] ARM: pxa: Correct touch IRQ passing to UCB1400 on
	vpac270
In-Reply-To: <1288741914-21328-10-git-send-email-marek.vasut@gmail.com>
References: <1288741914-21328-1-git-send-email-marek.vasut@gmail.com>
	<1288741914-21328-10-git-send-email-marek.vasut@gmail.com>
Message-ID: <AANLkTinqb5wCEWHO+BsnLajvD5jgZ74Ouvo-wSSeG1V4@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 3, 2010 at 7:51 AM, Marek Vasut <marek.vasut@gmail.com> wrote:
> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
> ---
> ?arch/arm/mach-pxa/vpac270.c | ? 12 +++++-------
> ?1 files changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm/mach-pxa/vpac270.c b/arch/arm/mach-pxa/vpac270.c
> index b9b5797..5e206fd 100644
> --- a/arch/arm/mach-pxa/vpac270.c
> +++ b/arch/arm/mach-pxa/vpac270.c
> @@ -430,20 +430,18 @@ static inline void vpac270_eth_init(void) {}
> ?******************************************************************************/
> ?#if ? ?defined(CONFIG_TOUCHSCREEN_UCB1400) || \
> ? ? ? ?defined(CONFIG_TOUCHSCREEN_UCB1400_MODULE)
> -static pxa2xx_audio_ops_t vpac270_ac97_pdata = {
> - ? ? ? .reset_gpio ? ? = 95,
> -};
> -
> ?static struct ucb1400_pdata vpac270_ucb1400_pdata = {
> ? ? ? ?.irq ? ? ? ? ? ?= IRQ_GPIO(GPIO113_VPAC270_TS_IRQ),
> ?};
>
> +static pxa2xx_audio_ops_t vpac270_ac97_pdata = {
> + ? ? ? .reset_gpio ? ? = 95,
> + ? ? ? .codec_pdata ? ?= { &vpac270_ucb1400_pdata, },
> +};
> +
> ?static struct platform_device vpac270_ucb1400_device = {
> ? ? ? ?.name ? ? ? ? ? = "ucb1400_core",
> ? ? ? ?.id ? ? ? ? ? ? = -1,
> - ? ? ? .dev ? ? ? ? ? ?= {
> - ? ? ? ? ? ? ? .platform_data = &vpac270_ucb1400_pdata,
> - ? ? ? },
> ?};

It's a bit strange that a platform device version of ucb1400_core is
needed here as it's on AC97 bus. Could you please check if this
is necessary, and there seems to be same issue in other files.
