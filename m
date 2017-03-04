From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sat, 4 Mar 2017 10:15:04 +0200
Subject: [PATCH] pinctrl: samsung: fix segfault when using external
 interrupts on s3c24xx
In-Reply-To: <1488489799-18136-1-git-send-email-sergio.prado@e-labworks.com>
References: <1488489799-18136-1-git-send-email-sergio.prado@e-labworks.com>
Message-ID: <20170304081504.unv6sihbmp76ynfy@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 02, 2017 at 06:23:19PM -0300, Sergio Prado wrote:
> We are getting a NULL pointer dereference when working with external
> interrupts on s3c24xx:
> 
> Unable to handle kernel NULL pointer dereference at virtual address 000000a8
> pgd = c0104000
> [000000a8] *pgd=00000000
> Internal error: Oops: 5 [#1] ARM
> Modules linked in:
> CPU: 0 PID: 0 Comm: swapper Not tainted 4.10.0-rc8mini2440-sub-00047-g0722f57bfae9-dirty #3
> Hardware name: Samsung S3C2416 (Flattened Device Tree)
> task: c07399f8 task.stack: c0734000
> PC is at s3c24xx_demux_eint4_7+0x24/0x10c
> LR is at s3c24xx_demux_eint4_7+0x108/0x10c
> 
> The problem is in the function s3c24xx_demux_eint() when dereferencing
> bank->eint_base.
> 
> At this point, we cannot get the bank pointer from the irq_desc
> structure since it is pointing to the hardware irq, not virq.
> 
> So let's get the bank pointer directly from data->drvdata.
> 
> This is a regression from commit 8b1bd11c1f8f529057369c5b3702d13fd24e2765.

Checkpatch should complain here about commit format.

> 
> Tested on FriendlyARM mini2440.
> 

Please add:
  Fixes: 8b1bd11c1f8f ("pinctrl: samsung: Add the support the multiple IORESOURCE_MEM for one pin-bank")
  Cc: <stable@vger.kernel.org>

> Signed-off-by: Sergio Prado <sergio.prado@e-labworks.com>
> ---
>  drivers/pinctrl/samsung/pinctrl-s3c24xx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pinctrl/samsung/pinctrl-s3c24xx.c b/drivers/pinctrl/samsung/pinctrl-s3c24xx.c
> index b82a003546ae..1b8d887796e8 100644
> --- a/drivers/pinctrl/samsung/pinctrl-s3c24xx.c
> +++ b/drivers/pinctrl/samsung/pinctrl-s3c24xx.c
> @@ -356,8 +356,8 @@ static inline void s3c24xx_demux_eint(struct irq_desc *desc,
>  {
>  	struct s3c24xx_eint_data *data = irq_desc_get_handler_data(desc);
>  	struct irq_chip *chip = irq_desc_get_chip(desc);
> -	struct irq_data *irqd = irq_desc_get_irq_data(desc);
> -	struct samsung_pin_bank *bank = irq_data_get_irq_chip_data(irqd);
> +	struct samsung_pinctrl_drv_data *d = data->drvdata;
> +	struct samsung_pin_bank *bank = d->pin_banks;

I think 'pin_banks' point to all banks of given controller not to the
currently accessed one.


Best regards,
Krzysztof
