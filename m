From: computersforpeace@gmail.com (Brian Norris)
Date: Fri, 13 Sep 2013 11:21:44 -0700
Subject: [PATCH 1/2] mtd: atmel_nand: remove unneeded ifdef CONFIG_OF
In-Reply-To: <5232DAAD.4020700@atmel.com>
References: <1378200028-15415-1-git-send-email-josh.wu@atmel.com>
 <20130911230207.GE4550@ld-irv-0074.broadcom.com>
 <5232DAAD.4020700@atmel.com>
Message-ID: <20130913182144.GF4550@ld-irv-0074.broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ devicetree at vger.kernel.org

On Fri, Sep 13, 2013 at 05:28:13PM +0800, Josh Wu wrote:
> On 9/12/2013 7:02 AM, Brian Norris wrote:
> >On Tue, Sep 03, 2013 at 05:20:27PM +0800, Josh Wu wrote:
> >>Since following commit
> >>   f3b391425d21e6138e57b2432d91134e0bc2b975

...

> >>   (of_mtd: Add no-op stubs to support CONFIG_OF=n)
> >>
> >>implements the stub for CONFIG_OF=n. Now we can safely remove all
> >>CONFIG_OF in atmel_nand. (Thanks to Ezequiel Garcia's for this protype)
> >I'm not quite so sure about this patch, as I was about the pxa3xx patch.
> >With pxa3xx, the compiler can easily tell that pxa3xx_nand_probe_dt()
> >will return 0 without doing anything in the !CONFIG_OF case (and so will
> >likely remove the dead code), so it's no benefit to have the #ifdef. But
> >in this driver, the atmel_of_init_port() function can't be trivially
> >determined to do nothing (and in fact, it does something in either
> >CONFIG_OF=y or =n case). It's only protected by the 'if
> >(pdev->dev.of_node)' check, which the compiler can't predict.
> 
> I understand your concern here.
> 
> >
> >So, I don't know if we should remove the #ifdef at the expense of likely
> >significantly larger code. I won't protest, but I won't merge it yet
> >either. Perhaps others have better ideas, or perhaps you can find a good
> >way to work around this -- e.g., check the of_* helpers for -ENOSYS early
> >in atmel_of_init_port()?
> 
> So what about to add one more check? "IS_ENABLE(CONFIG_OF)" in
> atmel_nand_probe().
> And which is compiler predictable.
> 
> if (IS_ENABLED(CONFIG_OF) && pdev->dev.of_node) {
> /* of_node can be parsed only when CONFIG_OF is enable */
> res = atmel_of_init_port(host, pdev->dev.of_node);
> if (res)
> goto err_nand_ioremap;
> } else {
> ... ...
> }

That looks good to me. And it has precedent, a nearly identical patch
here:

  commit e305062e94719ef543ae936dd56501b5a36406c6
  Author: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
  Date:   Tue Jun 18 12:29:49 2013 +0200

      gpio-rcar: Remove #ifdef CONFIG_OF around OF-specific sections

      All functions and data types used by OF-specific code paths are declared
      in <linux/of.h> regardless of CONFIG_OF. Replace the #ifdef CONFIG_OF
      guard with a if(IS_ENABLED(CONFIG_OF)) and let the compiler optimize
      the unused code away.

      Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
      Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Brian

(leaving context intact)

> 
> >
> >>Signed-off-by: Josh Wu <josh.wu@atmel.com>
> >>---
> >>  drivers/mtd/nand/atmel_nand.c |   14 +-------------
> >>  1 file changed, 1 insertion(+), 13 deletions(-)
> >>
> >>diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
> >>index 060feea..1ca0724 100644
> >>--- a/drivers/mtd/nand/atmel_nand.c
> >>+++ b/drivers/mtd/nand/atmel_nand.c
> >>@@ -1449,7 +1449,6 @@ static void atmel_nand_hwctl(struct mtd_info *mtd, int mode)
> >>  		ecc_writel(host->ecc, CR, ATMEL_ECC_RST);
> >>  }
> >>-#if defined(CONFIG_OF)
> >>  static int atmel_of_init_port(struct atmel_nand_host *host,
> >>  			      struct device_node *np)
> >>  {
> >>@@ -1457,7 +1456,7 @@ static int atmel_of_init_port(struct atmel_nand_host *host,
> >>  	u32 offset[2];
> >>  	int ecc_mode;
> >>  	struct atmel_nand_data *board = &host->board;
> >>-	enum of_gpio_flags flags;
> >>+	enum of_gpio_flags flags = 0;
> >>  	if (of_property_read_u32(np, "atmel,nand-addr-offset", &val) == 0) {
> >>  		if (val >= 32) {
> >>@@ -1540,13 +1539,6 @@ static int atmel_of_init_port(struct atmel_nand_host *host,
> >>  	return 0;
> >>  }
> >>-#else
> >>-static int atmel_of_init_port(struct atmel_nand_host *host,
> >>-			      struct device_node *np)
> >>-{
> >>-	return -EINVAL;
> >>-}
> >>-#endif
> >>  static int __init atmel_hw_nand_init_params(struct platform_device *pdev,
> >>  					 struct atmel_nand_host *host)
> >>@@ -2207,14 +2199,12 @@ static int __exit atmel_nand_remove(struct platform_device *pdev)
> >>  	return 0;
> >>  }
> >>-#if defined(CONFIG_OF)
> >>  static const struct of_device_id atmel_nand_dt_ids[] = {
> >>  	{ .compatible = "atmel,at91rm9200-nand" },
> >>  	{ /* sentinel */ }
> >>  };
> >>  MODULE_DEVICE_TABLE(of, atmel_nand_dt_ids);
> >>-#endif
> >>  static int atmel_nand_nfc_probe(struct platform_device *pdev)
> >>  {
> >>@@ -2253,12 +2243,10 @@ static int atmel_nand_nfc_probe(struct platform_device *pdev)
> >>  	return 0;
> >>  }
> >>-#if defined(CONFIG_OF)
> >>  static struct of_device_id atmel_nand_nfc_match[] = {
> >>  	{ .compatible = "atmel,sama5d3-nfc" },
> >>  	{ /* sentinel */ }
> >>  };
> >>-#endif
> >>  static struct platform_driver atmel_nand_nfc_driver = {
> >>  	.driver = {
