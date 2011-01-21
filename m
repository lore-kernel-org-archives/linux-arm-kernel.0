From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 21 Jan 2011 12:32:39 -0700
Subject: [PATCH 6/6] i2c/pxa2xx: pass of_node from platform driver to
	adapter and publish
In-Reply-To: <1294246263-31960-7-git-send-email-bigeasy@linutronix.de>
References: <1294246263-31960-1-git-send-email-bigeasy@linutronix.de>
	<1294246263-31960-7-git-send-email-bigeasy@linutronix.de>
Message-ID: <AANLkTinh4395wuWwH2E2kJG+rhMXUzFeGekeugyCSzWt@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 5, 2011 at 9:51 AM, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> the of_node will auto-publish devices which are added to the device
> tree.
>
> Commit 925bb9c6 aka ("of/i2c: Fix module load order issue caused by
> of_i2c.c) moved the of_i2c_register_devices() function from the i2c core
> back to the drivers. This patch does the same thing for the pxa driver.
>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Dirk Brandewie <dirk.brandewie@gmail.com>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

Ben, I'll leave you to pick this one up.

g.

> ---
> ?drivers/i2c/busses/i2c-pxa.c | ? ?5 +++++
> ?1 files changed, 5 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
> index bfd115d..a90739b 100644
> --- a/drivers/i2c/busses/i2c-pxa.c
> +++ b/drivers/i2c/busses/i2c-pxa.c
> @@ -29,6 +29,7 @@
> ?#include <linux/errno.h>
> ?#include <linux/interrupt.h>
> ?#include <linux/i2c-pxa.h>
> +#include <linux/of_i2c.h>
> ?#include <linux/platform_device.h>
> ?#include <linux/err.h>
> ?#include <linux/clk.h>
> @@ -1138,6 +1139,9 @@ static int i2c_pxa_probe(struct platform_device *dev)
>
> ? ? ? ?i2c->adap.algo_data = i2c;
> ? ? ? ?i2c->adap.dev.parent = &dev->dev;
> +#ifdef CONFIG_OF
> + ? ? ? i2c->adap.dev.of_node = dev->dev.of_node;
> +#endif
>
> ? ? ? ?if (i2c_type == REGS_CE4100)
> ? ? ? ? ? ? ? ?ret = i2c_add_adapter(&i2c->adap);
> @@ -1147,6 +1151,7 @@ static int i2c_pxa_probe(struct platform_device *dev)
> ? ? ? ? ? ? ? ?printk(KERN_INFO "I2C: Failed to add bus\n");
> ? ? ? ? ? ? ? ?goto eadapt;
> ? ? ? ?}
> + ? ? ? of_i2c_register_devices(&i2c->adap);
>
> ? ? ? ?platform_set_drvdata(dev, i2c);
>
> --
> 1.7.3.2
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
