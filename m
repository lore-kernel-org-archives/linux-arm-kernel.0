From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 6 Jun 2016 10:00:33 +0100
Subject: [PATCH 3/8] mfd: tps65218: Use mfd_add_devices instead of
 of_platform_populate
In-Reply-To: <57516549.6040102@ti.com>
References: <1462945691-904-1-git-send-email-j-keerthy@ti.com>
 <1462945691-904-4-git-send-email-j-keerthy@ti.com>
 <57516549.6040102@ti.com>
Message-ID: <20160606090033.GC1525@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 03 Jun 2016, Keerthy wrote:

> Hi Lee Jones,
> 
> On Wednesday 11 May 2016 11:18 AM, Keerthy wrote:
> >mfd_add_devices enables parsing device tree nodes without compatibles
> >for child nodes. Replace of_platform_populate with mfd_add_devices.
> >
> 
> A gentle ping on this patch.

Don't do that!

If you think it's forgotten then send a [RESEND].  However this patch
is in my "to review" queue and will be dealt with in due course.

> >Signed-off-by: Keerthy <j-keerthy@ti.com>
> >---
> >  drivers/mfd/tps65218.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >
> >diff --git a/drivers/mfd/tps65218.c b/drivers/mfd/tps65218.c
> >index f20a531..b8b3a58 100644
> >--- a/drivers/mfd/tps65218.c
> >+++ b/drivers/mfd/tps65218.c
> >@@ -33,6 +33,10 @@
> >
> >  #define TPS65218_PASSWORD_REGS_UNLOCK   0x7D
> >
> >+static const struct mfd_cell tps65218_cells[] = {
> >+	{ .name = "tps65218-regulator", },
> >+};
> >+
> >  /**
> >   * tps65218_reg_write: Write a single tps65218 register.
> >   *
> >@@ -236,8 +240,10 @@ static int tps65218_probe(struct i2c_client *client,
> >  	if (ret < 0)
> >  		return ret;
> >
> >-	ret = of_platform_populate(client->dev.of_node, NULL, NULL,
> >-				   &client->dev);
> >+	ret = mfd_add_devices(tps->dev, PLATFORM_DEVID_AUTO, tps65218_cells,
> >+			      ARRAY_SIZE(tps65218_cells), NULL, 0,
> >+			      regmap_irq_get_domain(tps->irq_data));
> >+
> >  	if (ret < 0)
> >  		goto err_irq;
> >
> >

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
