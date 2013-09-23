From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 23 Sep 2013 17:28:24 +0100
Subject: [PATCH] clk: fix function name in devm_clk_put kernel-doc comment
In-Reply-To: <1379951159-8294-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1379951159-8294-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20130923162824.GV12758@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 23, 2013 at 05:45:59PM +0200, Uwe Kleine-K?nig wrote:
> The paragraph about clk_put already specifies this restriction about
> clk_put.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
> 
> I suspect that devm_clk_put is used more often than necessary. After some
> grepping around e.g. looking at drivers/tty/serial/clps711x.c it doesn't
> seem necessary to call it as the driver core already cares about calling
> the devm cleanup callbacks.

The one(s) you've left are in drivers/media/platform/marvell-ccic/mmp-driver.c:

static void mcam_deinit_clk(struct mcam_camera *mcam)
{
        unsigned int i;

        for (i = 0; i < NR_MCAM_CLK; i++) {
                if (!IS_ERR(mcam->clk[i])) {
                        if (mcam->clk[i])
                                devm_clk_put(mcam->dev, mcam->clk[i]);
                }
                mcam->clk[i] = NULL;
        }
}

static int mmpcam_probe(struct platform_device *pdev)
{
        cam = devm_kzalloc(&pdev->dev, sizeof(*cam), GFP_KERNEL);
...
        mcam = &cam->mcam;
...
        mcam->regs = devm_ioremap_resource(&pdev->dev, res);
...
        cam->power_regs = devm_ioremap_resource(&pdev->dev, res);
...
out_unregister:
        mccic_shutdown(mcam);
out_power_down:
        mmpcam_power_down(mcam);
out_deinit_clk:
        mcam_deinit_clk(mcam);
        return ret;
}

static int mmpcam_remove(struct mmp_camera *cam)
{
...
        mcam_deinit_clk(mcam);
        iounmap(cam->power_regs);
        iounmap(mcam->regs);
        kfree(cam);
        return 0;
}

So, mcam_deinit_clk() provides nothing useful and should be killed.

Second thing to spot from the above is that kfree() is broken.  As
are those iounmap()s.  The more I look at this, the more I find wrong.
gpio_free() too.

Quite honestly, I think this driver is quite broken as it stands -
anything you do to it (even patching it without build testing) is
IMHO likely to improve this driver!
