From: balbi@ti.com (Felipe Balbi)
Date: Tue, 23 Oct 2012 22:09:14 +0300
Subject: [PATCH] gpio/omap: fix off-mode bug: clear debounce clock enable
 mask on disable
In-Reply-To: <1351015771-6308-1-git-send-email-khilman@deeprootsystems.com>
References: <1351015771-6308-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <20121023190914.GA853@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Oct 23, 2012 at 11:09:31AM -0700, Kevin Hilman wrote:
> From: Kevin Hilman <khilman@ti.com>
> 
> When debounce clocks are disabled, ensure that the banks
> dbck_enable_mask is cleared also.  Otherwise, context restore on
> subsequent off-mode transition will restore previous value from the
> shadow copies (bank->context.debounce*) leading to mismatch state
> between driver state and hardware state.
> 
> This was discovered when board code was doing
> 
>   gpio_request_one()
>   gpio_set_debounce()
>   gpio_free()
> 
> which was leaving the GPIO debounce settings in a confused state.
> Then, enabling off mode causing bogus state to be restored, leaving
> GPIO debounce enabled which then prevented the CORE powerdomain from
> transitioning.
> 
> Reported-by: Paul Walmsley <paul@pwsan.com>
> Cc: Igor Grinberg <grinberg@compulab.co.il>
> Signed-off-by: Kevin Hilman <khilman@ti.com>

looks like this deserves a Cc: stable at vger.kernel.org tag.

> ---
> Applies on v3.7-rc2, targetted for v3.7.
> 
>  drivers/gpio/gpio-omap.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index 94cbc84..dee2856 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -187,6 +187,7 @@ static inline void _gpio_dbck_disable(struct gpio_bank *bank)
>  		 * to detect events and generate interrupts at least on OMAP3.
>  		 */
>  		__raw_writel(0, bank->base + bank->regs->debounce_en);
> +		bank->dbck_enable_mask = 0;

shouldn't omap_gpio_restore_context() check for dbck_enabled instead of
the mask ? I mean:

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 94cbc84..b3a39a7 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1371,7 +1371,7 @@ static void omap_gpio_restore_context(struct gpio_bank *bank)
 				bank->base + bank->regs->dataout);
 	__raw_writel(bank->context.oe, bank->base + bank->regs->direction);
 
-	if (bank->dbck_enable_mask) {
+	if (bank->dbck_enabled) {
 		__raw_writel(bank->context.debounce, bank->base +
 					bank->regs->debounce);
 		__raw_writel(bank->context.debounce_en,

the outcome would be the same, so it doesn't really matter. Just that,
at least to me, it would look better.

No strong feelings though.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121023/607d8ee1/attachment.sig>
