From: dwmw2@infradead.org (David Woodhouse)
Date: Fri, 30 Aug 2013 21:23:53 +0100
Subject: [PATCH] mtd: atmel_nand: fix the warning when CONFIG_OF is not
 defined
In-Reply-To: <1375846569-9499-1-git-send-email-josh.wu@atmel.com>
References: <1375846569-9499-1-git-send-email-josh.wu@atmel.com>
Message-ID: <1377894233.22372.86.camel@shinybook.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-08-07 at 11:36 +0800, Josh Wu wrote:
> This patch fix following warning:
> 
> drivers/mtd/nand/atmel_nand.c:2007: warning: 'atmel_nand_nfc_match' defined but not used
> 
> This patch add '#if defined(CONFIG_OF)' block to guard around the definition of
> atmel_nand_nfc_match, in order to avoid the warning when kernel is configurated
> as non-dt supported.

Ick. This driver is littered with CONFIG_OF checks. Yet I've just seen a
patch to pxa3xx_nand which *removes* ifdefs, on the basis that all the
of_match_ functions/macros will just 'do the right thing'. Can't we do
that here too? We might just need to add __maybe_unused?

> +#if defined(CONFIG_OF)
>  static struct of_device_id atmel_nand_nfc_match[] = {
>  	{ .compatible = "atmel,sama5d3-nfc" },
>  	{ /* sentinel */ }
>  };
> +#endif

Also, why doesn't this one appear in a MODULE_DEVICE_TABLE() ? 

-- 
David Woodhouse                            Open Source Technology Centre
David.Woodhouse at intel.com                              Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 5745 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130830/c9bddb5e/attachment.bin>
