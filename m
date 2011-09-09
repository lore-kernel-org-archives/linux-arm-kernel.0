From: eric.y.miao@gmail.com (Eric Miao)
Date: Thu, 8 Sep 2011 20:22:40 -0700
Subject: [PATCH 3/4] ARM: pxa: add irq ack for gpio irq
In-Reply-To: <1315541894-19504-3-git-send-email-chao.xie@marvell.com>
References: <1315541894-19504-1-git-send-email-chao.xie@marvell.com>
	<1315541894-19504-3-git-send-email-chao.xie@marvell.com>
Message-ID: <CAMPhdO_Pu8uZcyMtDu=ZfD1++aGX+NkoKk_nyE_Po5BwFOAhXQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 8, 2011 at 9:18 PM, Chao Xie <chao.xie@marvell.com> wrote:
> For previous pxa3xx and pxa168, pxa9xx, the interrupt controller does
> not need any ack for the interrupt.
> For next ARM V7 SMP core, it will use GIC, and it need ack for the
> interrupt.
>
> Signed-off-by: Chao Xie <chao.xie@marvell.com>
> ---
> ?arch/arm/plat-pxa/gpio.c | ? ?4 ++++
> ?1 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/plat-pxa/gpio.c b/arch/arm/plat-pxa/gpio.c
> index 15de09d..66ae80a 100644
> --- a/arch/arm/plat-pxa/gpio.c
> +++ b/arch/arm/plat-pxa/gpio.c
> @@ -19,6 +19,7 @@
> ?#include <linux/slab.h>
>
> ?#include <mach/gpio.h>
> +#include <asm/mach/irq.h>
>
> ?int pxa_last_gpio;
>
> @@ -206,7 +207,9 @@ static void pxa_gpio_demux_handler(unsigned int irq, struct irq_desc *desc)
> ? ? ? ?struct pxa_gpio_chip *c;
> ? ? ? ?int loop, gpio, gpio_base, n;
> ? ? ? ?unsigned long gedr;
> + ? ? ? struct irq_chip *chip = irq_get_chip(irq);
>
> + ? ? ? chained_irq_enter(chip, desc);
> ? ? ? ?do {
> ? ? ? ? ? ? ? ?loop = 0;
> ? ? ? ? ? ? ? ?for_each_gpio_chip(gpio, c) {
> @@ -225,6 +228,7 @@ static void pxa_gpio_demux_handler(unsigned int irq, struct irq_desc *desc)
> ? ? ? ? ? ? ? ? ? ? ? ?}
> ? ? ? ? ? ? ? ?}
> ? ? ? ?} while (loop);
> + ? ? ? chained_irq_exit(chip, desc);
> ?}
>
> ?static void pxa_ack_muxed_gpio(struct irq_data *d)

Looks good to me.
