From: balbi@ti.com (Felipe Balbi)
Date: Tue, 2 Apr 2013 11:14:49 +0300
Subject: [PATCH V2 6/6] usb: mv_usb: remove clock name from pdata
In-Reply-To: <1364195217-1226-7-git-send-email-chao.xie@marvell.com>
References: <1364195217-1226-1-git-send-email-chao.xie@marvell.com>
 <1364195217-1226-7-git-send-email-chao.xie@marvell.com>
Message-ID: <20130402081449.GD30286@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Mar 25, 2013 at 03:06:57AM -0400, Chao Xie wrote:
> Using pdata to pass clock name is not correct.
> Directly get clock from usb drivers.
> 
> Signed-off-by: Chao Xie <chao.xie@marvell.com>
> ---
>  include/linux/platform_data/mv_usb.h |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/platform_data/mv_usb.h b/include/linux/platform_data/mv_usb.h
> index 944b01d..98b7925 100644
> --- a/include/linux/platform_data/mv_usb.h
> +++ b/include/linux/platform_data/mv_usb.h
> @@ -34,8 +34,6 @@ struct mv_usb_addon_irq {
>  };
>  
>  struct mv_usb_platform_data {
> -	unsigned int		clknum;
> -	char			**clkname;

this patch breaks mv_u3d_core.c, I have added another patch to the
series (see below), let me know if this isn't the right fix.

>From 49c1bfb43cbd1228abfffbc8d0ebb2e510b93bd7 Mon Sep 17 00:00:00 2001
From: Felipe Balbi <balbi@ti.com>
Date: Tue, 2 Apr 2013 11:12:11 +0300
Subject: [PATCH] usb: gadget: mv_u3d_core: remove unused clock

The origianl understanding of clock is wrong. The UDC controller
only have one clock input.
Passing clock name by pdata is wrong. The clock is defined by device
iteself.

Cc: Chao Xie <chao.xie@marvell.com>
Cc: Yu Xu <yuxu@marvell.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/usb/gadget/mv_u3d_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/mv_u3d_core.c b/drivers/usb/gadget/mv_u3d_core.c
index 9675227..58288e9 100644
--- a/drivers/usb/gadget/mv_u3d_core.c
+++ b/drivers/usb/gadget/mv_u3d_core.c
@@ -1821,7 +1821,7 @@ static int mv_u3d_probe(struct platform_device *dev)
 	u3d->dev = &dev->dev;
 	u3d->vbus = pdata->vbus;
 
-	u3d->clk = clk_get(&dev->dev, pdata->clkname[0]);
+	u3d->clk = clk_get(&dev->dev, NULL);
 	if (IS_ERR(u3d->clk)) {
 		retval = PTR_ERR(u3d->clk);
 		goto err_get_clk;
-- 
1.8.2

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130402/7a99e4ac/attachment.sig>
