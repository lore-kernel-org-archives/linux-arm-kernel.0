From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 6 Sep 2016 15:21:44 +0100
Subject: [PATCH 2/4] ARM: common/locomo: remove NO_IRQ check
In-Reply-To: <20160906135637.2622666-2-arnd@arndb.de>
References: <20160906135637.2622666-1-arnd@arndb.de>
 <20160906135637.2622666-2-arnd@arndb.de>
Message-ID: <20160906142144.GX1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 06, 2016 at 03:53:28PM +0200, Arnd Bergmann wrote:
> Since commit 489447380a29 ("[PATCH] handle errors returned by
> platform_get_irq*()") ten years ago, the locomo driver refuses to
> work without an interrupt line passed in its resources, so the
> check for NO_IRQ is unnecessary.

This description is inaccurate and misleading (it looks like it was
cut'n'pasted from patch 1.)

platform_get_irq() has nothing to do with your change, as your change
is more about the irq_base value passed through platform data, and
not through IRQ resources.

> We still check the irq_base argument for NO_IRQ, but as both
> platforms that use locomo (poodle and collie) provide both
> 'irq' and 'irq_base', this can be done more consistently
> by just checking that both are valid in the probe function
> and otherwise returning an error.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/common/locomo.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/common/locomo.c b/arch/arm/common/locomo.c
> index 0e97b4b871f9..81abb04e5254 100644
> --- a/arch/arm/common/locomo.c
> +++ b/arch/arm/common/locomo.c
> @@ -253,8 +253,7 @@ locomo_init_one_child(struct locomo *lchip, struct locomo_dev_info *info)
>  		dev->mapbase = 0;
>  	dev->length = info->length;
>  
> -	dev->irq[0] = (lchip->irq_base == NO_IRQ) ?
> -			NO_IRQ : lchip->irq_base + info->irq[0];
> +	dev->irq[0] = lchip->irq_base + info->irq[0];
>  
>  	ret = device_register(&dev->dev);
>  	if (ret) {
> @@ -376,6 +375,9 @@ __locomo_probe(struct device *me, struct resource *mem, int irq)
>  	unsigned long r;
>  	int i, ret = -ENODEV;
>  
> +	if (!pdata->irq_base)
> +		return ret;
> +
>  	lchip = kzalloc(sizeof(struct locomo), GFP_KERNEL);
>  	if (!lchip)
>  		return -ENOMEM;
> @@ -387,7 +389,7 @@ __locomo_probe(struct device *me, struct resource *mem, int irq)
>  
>  	lchip->phys = mem->start;
>  	lchip->irq = irq;
> -	lchip->irq_base = (pdata) ? pdata->irq_base : NO_IRQ;
> +	lchip->irq_base = pdata->irq_base;

This removes a NULL pointer check.  Before this change, a NULL pdata
would be accepted and would lead to the interrupts not being setup.
After this change, it results in a NULL pointer deference.

Thankfully, both collie and poodle supply platform data, and are the
only providers of the locomo device.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
