From: robh+dt@kernel.org (Rob Herring)
Date: Thu, 3 Dec 2015 09:14:12 -0600
Subject: [PATCH v3 1/6] of/irq: Export of_irq_find_parent again
In-Reply-To: <1448987062-31225-2-git-send-email-carlo@caione.org>
References: <1448987062-31225-1-git-send-email-carlo@caione.org>
 <1448987062-31225-2-git-send-email-carlo@caione.org>
Message-ID: <CAL_JsqK55+3FQk-bzELZ3zNKRrrNYE+Khqf9wj_GpG2V8mWroA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 1, 2015 at 10:24 AM, Carlo Caione <carlo@caione.org> wrote:
> From: Carlo Caione <carlo@endlessm.com>
>
> of_irq_find_parent was made static since it had no users outside of
> of_irq.c. Export it again since we are going to use it again.
>
> Signed-off-by: Carlo Caione <carlo@endlessm.com>
> ---
>  drivers/of/irq.c       | 3 ++-
>  include/linux/of_irq.h | 6 ++++++
>  2 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/of/irq.c b/drivers/of/irq.c
> index 902b89b..4fa916d 100644
> --- a/drivers/of/irq.c
> +++ b/drivers/of/irq.c
> @@ -53,7 +53,7 @@ EXPORT_SYMBOL_GPL(irq_of_parse_and_map);
>   * Returns a pointer to the interrupt parent node, or NULL if the interrupt
>   * parent could not be determined.
>   */
> -static struct device_node *of_irq_find_parent(struct device_node *child)
> +struct device_node *of_irq_find_parent(struct device_node *child)
>  {
>         struct device_node *p;
>         const __be32 *parp;
> @@ -77,6 +77,7 @@ static struct device_node *of_irq_find_parent(struct device_node *child)
>
>         return p;
>  }
> +EXPORT_SYMBOL_GPL(of_irq_find_parent);
>
>  /**
>   * of_irq_parse_raw - Low level interrupt tree parsing
> diff --git a/include/linux/of_irq.h b/include/linux/of_irq.h
> index 039f2ee..6f879c6 100644
> --- a/include/linux/of_irq.h
> +++ b/include/linux/of_irq.h
> @@ -94,6 +94,7 @@ static inline void of_msi_configure(struct device *dev, struct device_node *np)
>   */
>  extern unsigned int irq_of_parse_and_map(struct device_node *node, int index);
>  u32 of_msi_map_rid(struct device *dev, struct device_node *msi_np, u32 rid_in);
> +extern struct device_node *of_irq_find_parent(struct device_node *child);

The whole reason this got removed started with there was a problem
with building for OF=y and OF_IRQ=n, so you need to move the
declarations to the OF_IRQ if/else section.

Given multiple people needing this, I'm going to apply this for 4.4 if
we can get this sorted out.

Rob
