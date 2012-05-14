From: shubhrajyoti@ti.com (Shubhrajyoti)
Date: Mon, 14 May 2012 16:56:19 +0530
Subject: [PATCHv9 06/10] I2C: OMAP: Fix the crash in i2c remove
In-Reply-To: <20120512181019.GA28973@pengutronix.de>
References: <1335969135-20858-1-git-send-email-shubhrajyoti@ti.com>
 <1335969135-20858-7-git-send-email-shubhrajyoti@ti.com>
 <20120512181019.GA28973@pengutronix.de>
Message-ID: <4FB0EBDB.3040902@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 12 May 2012 11:40 PM, Wolfram Sang wrote:
>> Cc: Kevin Hilman <khilman@ti.com>
>> > Cc: Rajendra Nayak <rnayak@ti.com>
>> > Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> I'd really like a comment from the PM experts if each and every driver
> has to ensure that the clocks are enabled on remove like this?
Just resent cc ing linux-pm

BTW also found that

Some others are also doing the same. eg:
 
drivers/mmc/host/omap_hsmmc.c
static int __devexit omap_hsmmc_remove(struct platform_device *pdev)
{
        struct omap_hsmmc_host *host = platform_get_drvdata(pdev);
        struct resource *res;

        pm_runtime_get_sync(host->dev);
        mmc_remove_host(host->mmc);

2. drivers/usb/musb/musb_core.c

static void musb_shutdown(struct platform_device *pdev)
{
        struct musb     *musb = dev_to_musb(&pdev->dev);
        unsigned long   flags;

        pm_runtime_get_sync(musb->controller);

Anyways will wait for feedback.




>
>> > ---
>> >  drivers/i2c/busses/i2c-omap.c |   
