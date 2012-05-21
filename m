From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 21 May 2012 17:09:52 +1000
Subject: linux-next: manual merge of the arm-soc tree with the gpio tree
Message-ID: <20120521170952.7cd6e01690000b93db80b2b9@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
drivers/gpio/gpio-mxs.c between commit 3e11f7b840b4 ("gpio/generic:
initialize basic_mmio_gpio shadow variables properly") from the gpio tree
and commit 164387d2b4ae ("gpio/mxs: get rid of the use of cpu_is_xxx")
from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary.
-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc drivers/gpio/gpio-mxs.c
index b413650,429228b..0000000
--- a/drivers/gpio/gpio-mxs.c
+++ b/drivers/gpio/gpio-mxs.c
@@@ -242,11 -283,11 +283,11 @@@ static int __devinit mxs_gpio_probe(str
  	irq_set_handler_data(port->irq, port);
  
  	err = bgpio_init(&port->bgc, &pdev->dev, 4,
- 			 port->base + PINCTRL_DIN(port->id),
- 			 port->base + PINCTRL_DOUT(port->id), NULL,
- 			 port->base + PINCTRL_DOE(port->id), NULL, 0);
+ 			 port->base + PINCTRL_DIN(port),
+ 			 port->base + PINCTRL_DOUT(port), NULL,
 -			 port->base + PINCTRL_DOE(port), NULL, false);
++			 port->base + PINCTRL_DOE(port), NULL, 0);
  	if (err)
- 		goto out_iounmap;
+ 		return err;
  
  	port->bgc.gc.to_irq = mxs_gpio_to_irq;
  	port->bgc.gc.base = port->id * 32;
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120521/58883331/attachment.sig>
