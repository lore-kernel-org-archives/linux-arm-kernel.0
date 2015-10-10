From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Sat, 10 Oct 2015 15:08:52 +0900
Subject: [PATCH v2 3/4] i2c: s3c2410: enable RuntimePM before registering
 to the core
In-Reply-To: <1444383567-18113-3-git-send-email-wsa@the-dreams.de>
References: <1444383567-18113-1-git-send-email-wsa@the-dreams.de>
 <1444383567-18113-3-git-send-email-wsa@the-dreams.de>
Message-ID: <5618AB74.2070001@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

W dniu 09.10.2015 o 18:39, Wolfram Sang pisze:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> The core may register clients attached to this master which may use
> funtionality from the master. So, RuntimePM must be enabled before, otherwise
> this will fail. While here, move drvdata, too.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/i2c/busses/i2c-s3c2410.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
> index 50bfd8cef5f224..336e34e1ca597d 100644
> --- a/drivers/i2c/busses/i2c-s3c2410.c
> +++ b/drivers/i2c/busses/i2c-s3c2410.c
> @@ -1243,19 +1243,21 @@ static int s3c24xx_i2c_probe(struct platform_device *pdev)
>  	i2c->adap.nr = i2c->pdata->bus_num;
>  	i2c->adap.dev.of_node = pdev->dev.of_node;
>  
> +	platform_set_drvdata(pdev, i2c);
> +
> +	pm_runtime_enable(&pdev->dev);
> +	pm_runtime_enable(&i2c->adap.dev);
> +
>  	ret = i2c_add_numbered_adapter(&i2c->adap);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "failed to add bus to i2c core\n");
> +		pm_runtime_disable(&i2c->adap.dev);
> +		pm_runtime_disable(&pdev->dev);
>  		s3c24xx_i2c_deregister_cpufreq(i2c);
>  		clk_unprepare(i2c->clk);
>  		return ret;
>  	}
>  
> -	platform_set_drvdata(pdev, i2c);
> -
> -	pm_runtime_enable(&pdev->dev);
> -	pm_runtime_enable(&i2c->adap.dev);
> -
>  	dev_info(&pdev->dev, "%s: S3C I2C adapter\n", dev_name(&i2c->adap.dev));
>  	return 0;
>  }
> 

Hi,

Unfortunately on Odroid XU3, Exynos5420, samsung,s3c2440-i2c,
next-20151009-1-ga93b1a6f5055:

[    0.437678] s3c-i2c 12c80000.i2c: slave address 0x00
[    0.437748] s3c-i2c 12c80000.i2c: bus frequency set to 65 KHz
[    0.438136] INFO: trying to register non-static key.
[    0.438180] the code is fine but needs lockdep annotation.
[    0.438225] turning off the locking correctness validator.
[    0.438277] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.3.0-rc4-next-20151009-00001-ga93b1a6f5055-dirty #237
[    0.438353] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[    0.438427] [<c0016780>] (unwind_backtrace) from [<c00132f0>] (show_stack+0x10/0x14)
[    0.438512] [<c00132f0>] (show_stack) from [<c0224884>] (dump_stack+0x70/0xbc)
[    0.438590] [<c0224884>] (dump_stack) from [<c006be20>] (__lock_acquire+0xa84/0xb18)
[    0.438667] [<c006be20>] (__lock_acquire) from [<c006c238>] (lock_acquire+0x70/0x90)
[    0.438746] [<c006c238>] (lock_acquire) from [<c05e8c88>] (_raw_spin_lock_irqsave+0x48/0x5c)
[    0.438830] [<c05e8c88>] (_raw_spin_lock_irqsave) from [<c02fea68>] (pm_runtime_enable+0x14/0x5c)
[    0.438921] [<c02fea68>] (pm_runtime_enable) from [<c03eee9c>] (s3c24xx_i2c_probe+0x450/0x5f0)
[    0.439006] [<c03eee9c>] (s3c24xx_i2c_probe) from [<c02f8180>] (platform_drv_probe+0x50/0xac)
[    0.439086] [<c02f8180>] (platform_drv_probe) from [<c02f683c>] (driver_probe_device+0x1e0/0x418)
[    0.439165] [<c02f683c>] (driver_probe_device) from [<c02f6b08>] (__driver_attach+0x94/0x98)
[    0.439250] [<c02f6b08>] (__driver_attach) from [<c02f4be8>] (bus_for_each_dev+0x54/0x88)
[    0.439332] [<c02f4be8>] (bus_for_each_dev) from [<c02f5da8>] (bus_add_driver+0x178/0x254)
[    0.439411] [<c02f5da8>] (bus_add_driver) from [<c02f72f8>] (driver_register+0x78/0xf4)
[    0.439488] [<c02f72f8>] (driver_register) from [<c00097f4>] (do_one_initcall+0xb0/0x1f4)
[    0.439571] [<c00097f4>] (do_one_initcall) from [<c0852dc4>] (kernel_init_freeable+0x11c/0x1e8)
[    0.439660] [<c0852dc4>] (kernel_init_freeable) from [<c05e2e04>] (kernel_init+0x8/0xec)
[    0.439740] [<c05e2e04>] (kernel_init) from [<c0010350>] (ret_from_fork+0x14/0x24)
[    0.439810]  (null): Unbalanced pm_runtime_enable!
[    0.440965] s3c-i2c 12c80000.i2c: i2c-2: S3C I2C adapter

The message appears after second pm_runtime_enable().

Next without the patch works.

Best regards,
Krzysztof
