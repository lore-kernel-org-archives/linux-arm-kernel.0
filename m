From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 11 Jan 2016 06:21:14 +0000
Subject: [PATCH] mfd: as3722: mark PM functions as __maybe_unused
In-Reply-To: <2162790.qeSmLiztNV@wuerfel>
References: <2162790.qeSmLiztNV@wuerfel>
Message-ID: <20160111062114.GO3331@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 08 Dec 2015, Arnd Bergmann wrote:

> The newly introduced as3722_i2c_suspend/resume functions are built
> unconditionally, but only used when power management is enabled,
> so we get a warning otherwise:
> 
> drivers/mfd/as3722.c:427:12: warning: 'as3722_i2c_suspend' defined but not used [-Wunused-function]
> drivers/mfd/as3722.c:438:12: warning: 'as3722_i2c_resume' defined but not used [-Wunused-function]
> 
> This marks them both as __maybe_unused, which avoids an ugly #ifdef
> and gives us best compile-time coverage. When they are unused, the
> compiler will silently drop the functions from its output.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 35deff7eb212 ("mfd: as3722: Handle interrupts on suspend")
> ---
>  drivers/mfd/as3722.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

> diff --git a/drivers/mfd/as3722.c b/drivers/mfd/as3722.c
> index 3b21eb4bc480..e1f597f97f86 100644
> --- a/drivers/mfd/as3722.c
> +++ b/drivers/mfd/as3722.c
> @@ -424,7 +424,7 @@ static int as3722_i2c_remove(struct i2c_client *i2c)
>  	return 0;
>  }
>  
> -static int as3722_i2c_suspend(struct device *dev)
> +static int __maybe_unused as3722_i2c_suspend(struct device *dev)
>  {
>  	struct as3722 *as3722 = dev_get_drvdata(dev);
>  
> @@ -435,7 +435,7 @@ static int as3722_i2c_suspend(struct device *dev)
>  	return 0;
>  }
>  
> -static int as3722_i2c_resume(struct device *dev)
> +static int __maybe_unused as3722_i2c_resume(struct device *dev)
>  {
>  	struct as3722 *as3722 = dev_get_drvdata(dev);
>  

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
