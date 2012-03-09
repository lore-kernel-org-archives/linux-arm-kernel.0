From: tarun.kanti@ti.com (DebBarma, Tarun Kanti)
Date: Fri, 9 Mar 2012 14:16:52 +0530
Subject: [PATCH v3 05/13] gpio/omap: get rid of retrigger variable in
 gpio_irq_handler
In-Reply-To: <1331118963-26364-6-git-send-email-tarun.kanti@ti.com>
References: <1331118963-26364-1-git-send-email-tarun.kanti@ti.com>
 <1331118963-26364-6-git-send-email-tarun.kanti@ti.com>
Message-ID: <CAC83ZvJXK-FsiqyQT6BQxggRewkiHZkRBi44CVH15gb4dUbsjw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 7, 2012 at 4:45 PM, Tarun Kanti DebBarma <tarun.kanti@ti.com> wrote:
> This local variable is just assigned zero and then OR'ed
> with isr. It does not appear to serve any purpose and so
> removing it.
Missed following comments from Kevin given in v2. Sorry about that.
I have updated the change in:
git://gitorious.org/~tarunkanti/omap-sw-develoment/tarunkantis-linux-omap-dev
for_3.4/gpio_further_cleanup_fixes

"commit 672e302e3c (ARM: OMAP: use edge/level handlers from generic IRQ
framework) removed retrigger support in favor of using generic IRQ
framework.  This patch cleans up some unused remnants of that removal.
--
Tarun
>
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Acked-by: Felipe Balbi <balbi@ti.com>
> ---
> ?drivers/gpio/gpio-omap.c | ? ?3 ---
> ?1 files changed, 0 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index 3765654..de5fe8f 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -626,7 +626,6 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
> ? ? ? ?u32 isr;
> ? ? ? ?unsigned int gpio_irq, gpio_index;
> ? ? ? ?struct gpio_bank *bank;
> - ? ? ? u32 retrigger = 0;
> ? ? ? ?int unmasked = 0;
> ? ? ? ?struct irq_chip *chip = irq_desc_get_chip(desc);
>
> @@ -663,8 +662,6 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
> ? ? ? ? ? ? ? ? ? ? ? ?chained_irq_exit(chip, desc);
> ? ? ? ? ? ? ? ?}
>
> - ? ? ? ? ? ? ? isr |= retrigger;
> - ? ? ? ? ? ? ? retrigger = 0;
> ? ? ? ? ? ? ? ?if (!isr)
> ? ? ? ? ? ? ? ? ? ? ? ?break;
>
> --
> 1.7.0.4
>
