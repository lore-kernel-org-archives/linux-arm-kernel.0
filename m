From: balajitk@ti.com (T Krishnamoorthy, Balaji)
Date: Thu, 21 Jul 2011 13:44:25 +0530
Subject: [PATCH 5/5] OMAP: I2C: Restore only if context is lost
In-Reply-To: <1311231185-5503-6-git-send-email-shubhrajyoti@ti.com>
References: <1311231185-5503-1-git-send-email-shubhrajyoti@ti.com>
	<1311231185-5503-6-git-send-email-shubhrajyoti@ti.com>
Message-ID: <CANrkHUbRh0GG2XN4xDm84c3vV7U-4Am3a9CPLx+G-cR4X841GA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 21, 2011 at 12:23 PM, Shubhrajyoti D <shubhrajyoti@ti.com> wrote:
> Currently restore is done always.
> Adding conditional restore.The restore is done only if the context is lost.
>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> ---
> @@ -261,6 +263,18 @@ static inline u16 omap_i2c_read_reg(struct omap_i2c_dev *i2c_dev, int reg)
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?(i2c_dev->regs[reg] << i2c_dev->reg_shift));
> ?}
>
> +
spurious line

> +static void omap_i2c_restore(struct omap_i2c_dev *dev)
> +{
> + ? ? ? omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
> + ? ? ? omap_i2c_write_reg(dev, OMAP_I2C_PSC_REG, dev->pscstate);
> + ? ? ? omap_i2c_write_reg(dev, OMAP_I2C_SCLL_REG, dev->scllstate);
> + ? ? ? omap_i2c_write_reg(dev, OMAP_I2C_SCLH_REG, dev->sclhstate);
> + ? ? ? omap_i2c_write_reg(dev, OMAP_I2C_BUF_REG, dev->bufstate);
> + ? ? ? omap_i2c_write_reg(dev, OMAP_I2C_WE_REG, dev->westate);
> + ? ? ? omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, OMAP_I2C_CON_EN);
> +}
> +
> ?static void omap_i2c_unidle(struct omap_i2c_dev *dev)
> ?{
> ? ? ? ?struct platform_device *pdev;
> @@ -274,14 +288,11 @@ static void omap_i2c_unidle(struct omap_i2c_dev *dev)
> ? ? ? ?pm_runtime_get_sync(&pdev->dev);
>
> ? ? ? ?if (pdata->flags & OMAP_I2C_FLAG_RESET_REGS_POSTIDLE) {
> - ? ? ? ? ? ? ? omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
> - ? ? ? ? ? ? ? omap_i2c_write_reg(dev, OMAP_I2C_PSC_REG, dev->pscstate);
> - ? ? ? ? ? ? ? omap_i2c_write_reg(dev, OMAP_I2C_SCLL_REG, dev->scllstate);
> - ? ? ? ? ? ? ? omap_i2c_write_reg(dev, OMAP_I2C_SCLH_REG, dev->sclhstate);
> - ? ? ? ? ? ? ? omap_i2c_write_reg(dev, OMAP_I2C_BUF_REG, dev->bufstate);
> - ? ? ? ? ? ? ? omap_i2c_write_reg(dev, OMAP_I2C_WE_REG, dev->westate);
> - ? ? ? ? ? ? ? omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, OMAP_I2C_CON_EN);
> + ? ? ? ? ? ? ? u32 loss_cnt = omap_device_get_context_loss_count(pdev);
> + ? ? ? ? ? ? ? if (dev->dev_lost_count != loss_cnt)
> + ? ? ? ? ? ? ? ? ? ? ? omap_i2c_restore(dev);
> ? ? ? ?}
> +
> ? ? ? ?dev->idle = 0;
>
> ? ? ? ?/*
> @@ -318,7 +329,7 @@ static void omap_i2c_idle(struct omap_i2c_dev *dev)
> ? ? ? ? ? ? ? ?omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
> ? ? ? ?}
> ? ? ? ?dev->idle = 1;
> -
> + ? ? ? dev->dev_lost_count = omap_device_get_context_loss_count(pdev);
> ? ? ? ?pm_runtime_put_sync(&pdev->dev);
> ?}
>
> @@ -574,6 +585,7 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
> ? ? ? ? ? ? ? ? ? ? ? ?r = dev->device_reset(dev->dev);
> ? ? ? ? ? ? ? ? ? ? ? ?if (r < 0)
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?dev_err(dev->dev, "reset failed\n");
> + ? ? ? ? ? ? ? ? ? ? ? omap_i2c_restore(dev);
> ? ? ? ? ? ? ? ?}
> ? ? ? ? ? ? ? ?omap_i2c_init(dev);

Are you sure you need both omap_i2c_restore, omap_i2c_init calls here ?

> ? ? ? ? ? ? ? ?return -ETIMEDOUT;
> @@ -589,6 +601,7 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
> ? ? ? ? ? ? ? ? ? ? ? ?r = dev->device_reset(dev->dev);
> ? ? ? ? ? ? ? ? ? ? ? ?if (r < 0)
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?dev_err(dev->dev, "reset failed\n");
> + ? ? ? ? ? ? ? ? ? ? ? omap_i2c_restore(dev);

same comment here

> ? ? ? ? ? ? ? ?}
> ? ? ? ? ? ? ? ?omap_i2c_init(dev);
> ? ? ? ? ? ? ? ?return -EIO;
> --
> 1.7.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>
