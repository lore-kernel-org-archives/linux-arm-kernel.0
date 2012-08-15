From: balbi@ti.com (Felipe Balbi)
Date: Wed, 15 Aug 2012 09:03:13 +0300
Subject: [PATCHv6 24/24] i2c: omap: Prevent NULL pointer dereference in
 remove
In-Reply-To: <1344953946-13005-25-git-send-email-shubhrajyoti@ti.com>
References: <1344953946-13005-1-git-send-email-shubhrajyoti@ti.com>
 <1344953946-13005-25-git-send-email-shubhrajyoti@ti.com>
Message-ID: <20120815060312.GE23637@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 14, 2012 at 07:49:06PM +0530, Shubhrajyoti D wrote:
> Prevent the NULL pointer access by moving the platform_set_drvdata function
> after the access of the pdev.
> 
> [  654.961761] Unable to handle kernel NULL pointer dereference at virtual address 00000070
> [  654.970611] pgd = df254000
> [  654.973480] [00000070] *pgd=9f1da831, *pte=00000000, *ppte=00000000
> [  654.980163] Internal error: Oops: 17 [#1] SMP ARM
> [  654.985076] Modules linked in:
> [  654.988281] CPU: 1    Not tainted  (3.6.0-rc1-00031-ge547de1-dirty #339)
> [  654.995330] PC is at omap_i2c_runtime_resume+0x8/0x148
> [  655.000732] LR is at omap_i2c_runtime_resume+0x8/0x148
> 
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> ---
>  drivers/i2c/busses/i2c-omap.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 3df6f92..49dbff1 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -1217,8 +1217,6 @@ static int __devexit omap_i2c_remove(struct platform_device *pdev)
>  	struct omap_i2c_dev	*dev = platform_get_drvdata(pdev);
>  	int ret;
>  
> -	platform_set_drvdata(pdev, NULL);
> -
>  	i2c_del_adapter(&dev->adapter);
>  	ret = pm_runtime_get_sync(&pdev->dev);
>  	if (IS_ERR_VALUE(ret))
> @@ -1227,6 +1225,8 @@ static int __devexit omap_i2c_remove(struct platform_device *pdev)
>  	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
>  	pm_runtime_put(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);
> +	platform_set_drvdata(pdev, NULL);

in fact this platform_set_drvdata(pdev, NULL) can be removed. The
platform_device object will be destroyed anyway.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120815/2049d19c/attachment-0001.sig>
