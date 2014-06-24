From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 24 Jun 2014 11:46:32 -0400 (EDT)
Subject: [PATCH v6 2/4] arm: fiq: Allow EOI to be communicated to the intc
In-Reply-To: <1403623097-1153-3-git-send-email-daniel.thompson@linaro.org>
References: <1403174303-25456-1-git-send-email-daniel.thompson@linaro.org>
 <1403623097-1153-1-git-send-email-daniel.thompson@linaro.org>
 <1403623097-1153-3-git-send-email-daniel.thompson@linaro.org>
Message-ID: <alpine.LFD.2.11.1406241145590.16842@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 24 Jun 2014, Daniel Thompson wrote:

> Modern ARM systems require an EOI to be sent to the interrupt controller
> on completion of both IRQ and FIQ. The FIQ code currently does not provide
> any API to perform this. This patch provides this API, implemented by
> adding a callback to the fiq_chip structure.
> 
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Nicolas Pitre <nico@linaro.org>

Acked-by: Nicolas Pitre <nico@linaro.org>

> ---
>  arch/arm/include/asm/fiq.h | 6 ++++++
>  arch/arm/kernel/fiq.c      | 9 +++++++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/arch/arm/include/asm/fiq.h b/arch/arm/include/asm/fiq.h
> index a7806ef..e5d9458 100644
> --- a/arch/arm/include/asm/fiq.h
> +++ b/arch/arm/include/asm/fiq.h
> @@ -21,6 +21,11 @@
>  struct fiq_chip {
>  	void (*fiq_enable)(struct irq_data *data);
>  	void (*fiq_disable)(struct irq_data *data);
> +
> +	/* .fiq_eoi() will be called from the FIQ handler. For this
> +	 * reason it must not use spin locks (or any other locks).
> +	 */
> +	void (*fiq_eoi)(struct irq_data *data);
>  };
>  
>  struct fiq_handler {
> @@ -43,6 +48,7 @@ extern void release_fiq(struct fiq_handler *f);
>  extern void set_fiq_handler(void *start, unsigned int length);
>  extern void enable_fiq(int fiq);
>  extern void disable_fiq(int fiq);
> +extern void eoi_fiq(int fiq);
>  extern bool has_fiq(int fiq);
>  extern void fiq_register_mapping(int irq, struct fiq_chip *chip);
>  
> diff --git a/arch/arm/kernel/fiq.c b/arch/arm/kernel/fiq.c
> index 567f8fd..edde332 100644
> --- a/arch/arm/kernel/fiq.c
> +++ b/arch/arm/kernel/fiq.c
> @@ -183,6 +183,15 @@ void disable_fiq(int fiq)
>  	disable_irq(fiq + fiq_start);
>  }
>  
> +void eoi_fiq(int fiq)
> +{
> +	struct fiq_data *data = lookup_fiq_data(fiq);
> +
> +	if (data && data->fiq_chip->fiq_eoi)
> +		data->fiq_chip->fiq_eoi(data->irq_data);
> +}
> +EXPORT_SYMBOL(eoi_fiq);
> +
>  bool has_fiq(int fiq)
>  {
>  	struct fiq_data *data = lookup_fiq_data(fiq);
> -- 
> 1.9.3
> 
