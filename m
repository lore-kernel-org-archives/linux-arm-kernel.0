From: neilb@suse.de (NeilBrown)
Date: Thu, 14 Jun 2012 10:15:41 +1000
Subject: [GIT PULL] gpio/omap: cleanups for v3.5
In-Reply-To: <874nrmtf47.fsf@ti.com>
References: <874nrmtf47.fsf@ti.com>
Message-ID: <20120614101541.39f50aee@notabene.brown>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 11 May 2012 17:30:48 -0700 Kevin Hilman <khilman@ti.com> wrote:

> Hi Grant,
> 
> Here's the final round of GPIO cleanups for v3.5.  This branch is based
> on my for_3.5/fixes/gpio branch you just pulled.
> 
> Kevin

Hi.

 I'm not sure if it was this series or the following cleanups which broke
 things for me, but I've been trying 3.5-rc2 on my GTA04 and the serial
 console (ttyO2) dies as soon as the omap-gpio driver initialises.

 After some digging I came up with this patch to gpio-omap.c

@@ -1124,6 +1124,9 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, bank);
 
+	if (bank->get_context_loss_count)
+		bank->context_loss_count =
+				bank->get_context_loss_count(bank->dev);
 	pm_runtime_enable(bank->dev);
 	pm_runtime_irq_safe(bank->dev);
 	pm_runtime_get_sync(bank->dev);

which fixes it.

What was happening  was that when omap_gpio_probe calls pm_runtime_get_sync,
it calls 
  _od_runtime_resume -> pm_generic_runtime_resume -> omap_gpio_runtime_resume
  -> omap_gpio_restore_context

and then the serial port stops.
I reasoned that the context probably hadn't been set up yet, so restoring
from it broke things.
Initialising bank->context_loss_count seems sensible and would ensure that
we didn't try to restore the context until it has actually been lost.

Thanks,
NeilBrown
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 828 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120614/a6c9c2c9/attachment.sig>
