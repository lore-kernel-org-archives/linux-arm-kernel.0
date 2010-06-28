From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 28 Jun 2010 12:53:00 +0800
Subject: [PATCH 3/3] pxa2xx/cpufreq: Fix PCMCIA frequency scaling
In-Reply-To: <1277387833-5419-3-git-send-email-marek.vasut@gmail.com>
References: <1277387833-5419-1-git-send-email-marek.vasut@gmail.com>
	<1277387833-5419-3-git-send-email-marek.vasut@gmail.com>
Message-ID: <AANLkTil1i0RIW1-DizTnPHszKshRWIfj8BtJmgXg2jX6@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 24, 2010 at 9:57 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
> The MCxx values must be based off memory clock, not CPU core clock.
>
> This also fixes the bug where on some machines the LCD went crazy while using
> PCMCIA.
>
> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>

+ Reviewed-by: Robert Jarzmik <robert.jarzmik@free.fr>

Applied to 'fix'.

> ---
> ?drivers/pcmcia/pxa2xx_base.c | ? ?5 ++---
> ?1 files changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pcmcia/pxa2xx_base.c b/drivers/pcmcia/pxa2xx_base.c
> index df4532e..f370476 100644
> --- a/drivers/pcmcia/pxa2xx_base.c
> +++ b/drivers/pcmcia/pxa2xx_base.c
> @@ -178,7 +178,6 @@ pxa2xx_pcmcia_frequency_change(struct soc_pcmcia_socket *skt,
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? unsigned long val,
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? struct cpufreq_freqs *freqs)
> ?{
> -#warning "it's not clear if this is right since the core CPU (N) clock has no effect on the memory (L) clock"
> ? ? ? ?switch (val) {
> ? ? ? ?case CPUFREQ_PRECHANGE:
> ? ? ? ? ? ? ? ?if (freqs->new > freqs->old) {
> @@ -186,7 +185,7 @@ pxa2xx_pcmcia_frequency_change(struct soc_pcmcia_socket *skt,
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? "pre-updating\n",
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? freqs->new / 1000, (freqs->new / 100) % 10,
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? freqs->old / 1000, (freqs->old / 100) % 10);
> - ? ? ? ? ? ? ? ? ? ? ? pxa2xx_pcmcia_set_mcxx(skt, freqs->new);
> + ? ? ? ? ? ? ? ? ? ? ? pxa2xx_pcmcia_set_timing(skt);
> ? ? ? ? ? ? ? ?}
> ? ? ? ? ? ? ? ?break;
>
> @@ -196,7 +195,7 @@ pxa2xx_pcmcia_frequency_change(struct soc_pcmcia_socket *skt,
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? "post-updating\n",
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? freqs->new / 1000, (freqs->new / 100) % 10,
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? freqs->old / 1000, (freqs->old / 100) % 10);
> - ? ? ? ? ? ? ? ? ? ? ? pxa2xx_pcmcia_set_mcxx(skt, freqs->new);
> + ? ? ? ? ? ? ? ? ? ? ? pxa2xx_pcmcia_set_timing(skt);
> ? ? ? ? ? ? ? ?}
> ? ? ? ? ? ? ? ?break;
> ? ? ? ?}
> --
> 1.7.1
>
>
