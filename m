From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 1 Sep 2012 18:32:47 +0000
Subject: [PATCH 2/6 v2] ARM: integrator: check PL010 device name rather
 than base address
In-Reply-To: <1346471760-23993-2-git-send-email-linus.walleij@linaro.org>
References: <1346471760-23993-1-git-send-email-linus.walleij@linaro.org>
 <1346471760-23993-2-git-send-email-linus.walleij@linaro.org>
Message-ID: <201209011832.47805.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 01 September 2012, Linus Walleij wrote:
> In the PL010 UART callback a comparison against the base address is
> done to figure out which UART is doing the callback. This does not
> play well with device tree, so let's check the dev_name() of the
> device instead.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Hmm, I think the dev_name would also not be that nice, because it changes
after the conversion to DT is complete.

>  arch/arm/mach-integrator/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-integrator/core.c b/arch/arm/mach-integrator/core.c
> index 5ba4bc8..67ea181 100644
> --- a/arch/arm/mach-integrator/core.c
> +++ b/arch/arm/mach-integrator/core.c
> @@ -100,7 +100,7 @@ static void integrator_uart_set_mctrl(struct amba_device *dev, void __iomem *bas
>  {
>         unsigned int ctrls = 0, ctrlc = 0, rts_mask, dtr_mask;
>  
> -       if (dev == &uart0_device) {
> +       if (!strcmp(dev_name(&dev->dev), "uart0")) {
>                 rts_mask = 1 << 4;
>                 dtr_mask = 1 << 5;
>         } else {

Maybe it's possible to compare the base pointer against INTEGRATOR_UART0_BASE instead?

	Arnd
