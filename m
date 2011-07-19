From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 19 Jul 2011 20:59:18 +0800
Subject: [PATCH] gpio/mxc/mxs: fix build error introduced by the reanming
	of irq_gc_ack()
In-Reply-To: <4E257ACD.6080608@ru.mvista.com>
References: <1311046444-25423-1-git-send-email-shawn.guo@linaro.org>
	<4E257ACD.6080608@ru.mvista.com>
Message-ID: <20110719125917.GK3838@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 19, 2011 at 04:38:37PM +0400, Sergei Shtylyov wrote:
> Hello.
> 
> On 19-07-2011 7:34, Shawn Guo wrote:
> 
> >The following commit renames irq_gc_ack() to irq_gc_ack_set_bit(),
> >and makes gpio-mxc and gpio-mxs fail to build.
> 
> >   659fb32d1b67476f4ade25e9ea0e2642a5b9c4b5
> >   genirq: replace irq_gc_ack() with {set,clr}_bit variants (fwd)
> 
> >Signed-off-by: Shawn Guo<shawn.guo@linaro.org>
> >---
> >The build error is being seen on linux-next.
> 
> >  drivers/gpio/gpio-mxc.c |    2 +-
> >  drivers/gpio/gpio-mxs.c |    2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> >diff --git a/drivers/gpio/gpio-mxc.c b/drivers/gpio/gpio-mxc.c
> >index 89fda58..4a46fbe 100644
> >--- a/drivers/gpio/gpio-mxc.c
> >+++ b/drivers/gpio/gpio-mxc.c
> >@@ -297,7 +297,7 @@ static void __init mxc_gpio_init_gc(struct mxc_gpio_port *port)
> >  	gc->private = port;
> >
> >  	ct = gc->chip_types;
> >-	ct->chip.irq_ack = irq_gc_ack,
> >+	ct->chip.irq_ack = irq_gc_ack_set_bit,
> 
>    There should be semicolon rathern than comma at the end.
> 
Thanks, Sergei.  I'm pretty surprised that gcc did not help me there.

Regards,
Shawn

> >  	ct->chip.irq_mask = irq_gc_mask_clr_bit;
> >  	ct->chip.irq_unmask = irq_gc_mask_set_bit;
> >  	ct->chip.irq_set_type = gpio_set_irq_type;
> >diff --git a/drivers/gpio/gpio-mxs.c b/drivers/gpio/gpio-mxs.c
> >index d8cafba..88f8506 100644
> >--- a/drivers/gpio/gpio-mxs.c
> >+++ b/drivers/gpio/gpio-mxs.c
> >@@ -156,7 +156,7 @@ static void __init mxs_gpio_init_gc(struct mxs_gpio_port *port)
> >  	gc->private = port;
> >
> >  	ct = gc->chip_types;
> >-	ct->chip.irq_ack = irq_gc_ack,
> >+	ct->chip.irq_ack = irq_gc_ack_set_bit,
> 
>    Same here.
> 
> WBR, Sergei
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
