From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 5 Dec 2011 17:04:35 +0800
Subject: [PATCH] pcmcia: pxa: replace IRQ_GPIO() with gpio_to_irq()
In-Reply-To: <1323075548.20963.7.camel@phoenix>
References: <1323075548.20963.7.camel@phoenix>
Message-ID: <CAMPhdO8F8QLjfeJReXSHgJNg+iaJ+CQ9i50ozsqAOiPWxhfwNA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 5, 2011 at 4:59 PM, Axel Lin <axel.lin@gmail.com> wrote:
> Since commit 6384fd "ARM: pxa: rename IRQ_GPIO to PXA_GPIO_TO_IRQ",
> I got buid errors due to implicit declaration of function 'IRQ_GPIO'.
>
> Use common gpio_to_irq() to replace machine dependant macro IRQ_GPIO().
>
> Cc: Marek Vasut <marek.vasut@gmail.com>
> Cc: Ian Molton <spyro@f2s.com>
> Cc: Jonathan Cameron <jic23@cam.ac.uk>
> Cc: Haojian Zhuang <haojian.zhuang@marvell.com>
> Cc: Eric Miao <eric.y.miao@gmail.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

Looks fine to me.

Acked-by: Eric Miao <eric.y.miao@gmail.com>

> ---
> I got the build error on linux-next,
> this patch is against linux-next 20111205.
>
> Axel
> ?drivers/pcmcia/pxa2xx_e740.c ? ? ?| ? 11 +++++++----
> ?drivers/pcmcia/pxa2xx_palmld.c ? ?| ? ?2 +-
> ?drivers/pcmcia/pxa2xx_palmtc.c ? ?| ? ?2 +-
> ?drivers/pcmcia/pxa2xx_stargate2.c | ? ?6 ++++--
> ?drivers/pcmcia/pxa2xx_vpac270.c ? | ? ?4 ++--
> ?5 files changed, 15 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/pcmcia/pxa2xx_e740.c b/drivers/pcmcia/pxa2xx_e740.c
> index 8bfbd4d..17cd2ce 100644
> --- a/drivers/pcmcia/pxa2xx_e740.c
> +++ b/drivers/pcmcia/pxa2xx_e740.c
> @@ -26,20 +26,23 @@
> ?static struct pcmcia_irqs cd_irqs[] = {
> ? ? ? ?{
> ? ? ? ? ? ? ? ?.sock = 0,
> - ? ? ? ? ? ? ? .irq ?= IRQ_GPIO(GPIO_E740_PCMCIA_CD0),
> ? ? ? ? ? ? ? ?.str ?= "CF card detect"
> ? ? ? ?},
> ? ? ? ?{
> ? ? ? ? ? ? ? ?.sock = 1,
> - ? ? ? ? ? ? ? .irq ?= IRQ_GPIO(GPIO_E740_PCMCIA_CD1),
> ? ? ? ? ? ? ? ?.str ?= "Wifi switch"
> ? ? ? ?},
> ?};
>
> ?static int e740_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
> ?{
> - ? ? ? skt->socket.pci_irq = skt->nr == 0 ? IRQ_GPIO(GPIO_E740_PCMCIA_RDY0) :
> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? IRQ_GPIO(GPIO_E740_PCMCIA_RDY1);
> + ? ? ? if (skt->nr == 0)
> + ? ? ? ? ? ? ? skt->socket.pci_irq = gpio_to_irq(GPIO_E740_PCMCIA_RDY0);
> + ? ? ? else
> + ? ? ? ? ? ? ? skt->socket.pci_irq = gpio_to_irq(GPIO_E740_PCMCIA_RDY1);
> +
> + ? ? ? cd_irqs[0].irq = gpio_to_irq(GPIO_E740_PCMCIA_CD0);
> + ? ? ? cd_irqs[1].irq = gpio_to_irq(GPIO_E740_PCMCIA_CD1);
>
> ? ? ? ?return soc_pcmcia_request_irqs(skt, &cd_irqs[skt->nr], 1);
> ?}
> diff --git a/drivers/pcmcia/pxa2xx_palmld.c b/drivers/pcmcia/pxa2xx_palmld.c
> index d589ad1..6a8e011 100644
> --- a/drivers/pcmcia/pxa2xx_palmld.c
> +++ b/drivers/pcmcia/pxa2xx_palmld.c
> @@ -33,7 +33,7 @@ static int palmld_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
> ? ? ? ?ret = gpio_request_array(palmld_pcmcia_gpios,
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?ARRAY_SIZE(palmld_pcmcia_gpios));
>
> - ? ? ? skt->socket.pci_irq = IRQ_GPIO(GPIO_NR_PALMLD_PCMCIA_READY);
> + ? ? ? skt->socket.pci_irq = gpio_to_irq(GPIO_NR_PALMLD_PCMCIA_READY);
>
> ? ? ? ?return ret;
> ?}
> diff --git a/drivers/pcmcia/pxa2xx_palmtc.c b/drivers/pcmcia/pxa2xx_palmtc.c
> index 9c6a04b..9e38de7 100644
> --- a/drivers/pcmcia/pxa2xx_palmtc.c
> +++ b/drivers/pcmcia/pxa2xx_palmtc.c
> @@ -37,7 +37,7 @@ static int palmtc_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
> ? ? ? ?ret = gpio_request_array(palmtc_pcmcia_gpios,
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?ARRAY_SIZE(palmtc_pcmcia_gpios));
>
> - ? ? ? skt->socket.pci_irq = IRQ_GPIO(GPIO_NR_PALMTC_PCMCIA_READY);
> + ? ? ? skt->socket.pci_irq = gpio_to_irq(GPIO_NR_PALMTC_PCMCIA_READY);
>
> ? ? ? ?return ret;
> ?}
> diff --git a/drivers/pcmcia/pxa2xx_stargate2.c b/drivers/pcmcia/pxa2xx_stargate2.c
> index 9396222..6c2366b 100644
> --- a/drivers/pcmcia/pxa2xx_stargate2.c
> +++ b/drivers/pcmcia/pxa2xx_stargate2.c
> @@ -34,7 +34,7 @@
> ?#define SG2_S0_GPIO_READY ? ? ?81
>
> ?static struct pcmcia_irqs irqs[] = {
> - ? ? ? { 0, IRQ_GPIO(SG2_S0_GPIO_DETECT), "PCMCIA0 CD" },
> + ? ? ? {.sock = 0, .str = "PCMCIA0 CD" },
> ?};
>
> ?static struct gpio sg2_pcmcia_gpios[] = {
> @@ -44,7 +44,9 @@ static struct gpio sg2_pcmcia_gpios[] = {
>
> ?static int sg2_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
> ?{
> - ? ? ? skt->socket.pci_irq = IRQ_GPIO(SG2_S0_GPIO_READY);
> + ? ? ? skt->socket.pci_irq = gpio_to_irq(SG2_S0_GPIO_READY);
> + ? ? ? irqs[0].irq = gpio_to_irq(SG2_S0_GPIO_DETECT);
> +
> ? ? ? ?return soc_pcmcia_request_irqs(skt, irqs, ARRAY_SIZE(irqs));
> ?}
>
> diff --git a/drivers/pcmcia/pxa2xx_vpac270.c b/drivers/pcmcia/pxa2xx_vpac270.c
> index 66ab92c..61b17d2 100644
> --- a/drivers/pcmcia/pxa2xx_vpac270.c
> +++ b/drivers/pcmcia/pxa2xx_vpac270.c
> @@ -38,12 +38,10 @@ static struct gpio vpac270_cf_gpios[] = {
> ?static struct pcmcia_irqs cd_irqs[] = {
> ? ? ? ?{
> ? ? ? ? ? ? ? ?.sock = 0,
> - ? ? ? ? ? ? ? .irq ?= IRQ_GPIO(GPIO84_VPAC270_PCMCIA_CD),
> ? ? ? ? ? ? ? ?.str ?= "PCMCIA CD"
> ? ? ? ?},
> ? ? ? ?{
> ? ? ? ? ? ? ? ?.sock = 1,
> - ? ? ? ? ? ? ? .irq ?= IRQ_GPIO(GPIO17_VPAC270_CF_CD),
> ? ? ? ? ? ? ? ?.str ?= "CF CD"
> ? ? ? ?},
> ?};
> @@ -57,6 +55,7 @@ static int vpac270_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?ARRAY_SIZE(vpac270_pcmcia_gpios));
>
> ? ? ? ? ? ? ? ?skt->socket.pci_irq = gpio_to_irq(GPIO35_VPAC270_PCMCIA_RDY);
> + ? ? ? ? ? ? ? cd_irqs[0].irq = gpio_to_irq(GPIO84_VPAC270_PCMCIA_CD);
>
> ? ? ? ? ? ? ? ?if (!ret)
> ? ? ? ? ? ? ? ? ? ? ? ?ret = soc_pcmcia_request_irqs(skt, &cd_irqs[0], 1);
> @@ -65,6 +64,7 @@ static int vpac270_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?ARRAY_SIZE(vpac270_cf_gpios));
>
> ? ? ? ? ? ? ? ?skt->socket.pci_irq = gpio_to_irq(GPIO12_VPAC270_CF_RDY);
> + ? ? ? ? ? ? ? cd_irqs[1].irq = gpio_to_irq(GPIO17_VPAC270_CF_CD);
>
> ? ? ? ? ? ? ? ?if (!ret)
> ? ? ? ? ? ? ? ? ? ? ? ?ret = soc_pcmcia_request_irqs(skt, &cd_irqs[1], 1);
> --
> 1.7.5.4
>
>
>
