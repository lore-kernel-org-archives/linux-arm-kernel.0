From: lars@metafoo.de (Lars-Peter Clausen)
Date: Tue, 16 Feb 2016 16:47:37 +0100
Subject: [PATCH v2 1/5] MIPS: jz4740: remove broken irq_to_gpio() call
In-Reply-To: <1455637261-2920972-1-git-send-email-arnd@arndb.de>
References: <455637086-2794174-1-git-send-email-arnd@arndb.de>
 <1455637261-2920972-1-git-send-email-arnd@arndb.de>
Message-ID: <56C34499.5010704@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/16/2016 04:40 PM, Arnd Bergmann wrote:
> gpiolib has removed the irq_to_gpio() API several years ago,
> but the global header still provided a non-working stub.
> 
> With a MIPS-wide change to use the generic header file, the jz4740
> platform is now using the wrong stub implementation of irq_to_gpio(),
> which cannot work.
> 
> This uses an open-coded implementation in the only line it
> is used in.
> 
> Suggested-by: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: <stable@vger.kernel.org> # v4.3+
> Fixes: 832f5dacfa0b ("MIPS: Remove all the uses of custom gpio.h").

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

Thanks.

> ---
>  arch/mips/jz4740/gpio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/jz4740/gpio.c b/arch/mips/jz4740/gpio.c
> index 8c6d76c9b2d6..d9907e57e9b9 100644
> --- a/arch/mips/jz4740/gpio.c
> +++ b/arch/mips/jz4740/gpio.c
> @@ -270,7 +270,7 @@ uint32_t jz_gpio_port_get_value(int port, uint32_t mask)
>  }
>  EXPORT_SYMBOL(jz_gpio_port_get_value);
>  
> -#define IRQ_TO_BIT(irq) BIT(irq_to_gpio(irq) & 0x1f)
> +#define IRQ_TO_BIT(irq) BIT((irq - JZ4740_IRQ_GPIO(0)) & 0x1f)
>  
>  static void jz_gpio_check_trigger_both(struct jz_gpio_chip *chip, unsigned int irq)
>  {
> 
