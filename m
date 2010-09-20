From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 20 Sep 2010 22:46:52 +0800
Subject: [PATCH 09/11] ARM: pxa: Correct touch IRQ passing to UCB1400 on
	vpac270
In-Reply-To: <1284604382-23683-9-git-send-email-marek.vasut@gmail.com>
References: <1284604382-23683-1-git-send-email-marek.vasut@gmail.com>
	<1284604382-23683-9-git-send-email-marek.vasut@gmail.com>
Message-ID: <AANLkTi=9Ftot-=UEFwCqFzq8F1QL+PzDKg80RW+Eui4y@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 16, 2010 at 10:33 AM, Marek Vasut <marek.vasut@gmail.com> wrote:
> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
> ---
> ?arch/arm/mach-pxa/vpac270.c | ? 12 +++++-------
> ?1 files changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm/mach-pxa/vpac270.c b/arch/arm/mach-pxa/vpac270.c
> index c9b747c..e851d13 100644
> --- a/arch/arm/mach-pxa/vpac270.c
> +++ b/arch/arm/mach-pxa/vpac270.c
> @@ -429,20 +429,18 @@ static inline void vpac270_eth_init(void) {}
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
>
> ?static void __init vpac270_ts_init(void)
> --
> 1.7.1
>
>

Looks good to me.
