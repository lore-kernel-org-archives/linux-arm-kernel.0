From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 26 Oct 2018 09:30:50 +0100
Subject: [PATCH 2/2 v2] mfd: ab8500-core: Return zero in
 get_register_interruptible()
In-Reply-To: <20181025124344.xw3phqnvrwq2nj7g@kili.mountain>
References: <20181025101037.GR4939@dell>
 <20181025124344.xw3phqnvrwq2nj7g@kili.mountain>
Message-ID: <20181026083050.GN4870@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 25 Oct 2018, Dan Carpenter wrote:

> This function is supposed to return zero on success or negative error
> codes on error.  Unfortunately, there is a bug so it sometimes returns
> non-zero, positive numbers on success.
> 
> I noticed this bug during review and I can't test it.  It does appear
> that the return is sometimes propogated back to _regmap_read() where all
> non-zero returns are treated as failure so this may affect run time.
> 
> Fixes: 47c1697508f2 ("mfd: Align ab8500 with the abx500 interface")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> v2: In v1, I introduced an new error path and forgot to drop the lock.
> 
>  drivers/mfd/ab8500-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Looks okay at first blush.

I'd really like Linus to review/test though.

> diff --git a/drivers/mfd/ab8500-core.c b/drivers/mfd/ab8500-core.c
> index 30d09d177171..11ab17f64c64 100644
> --- a/drivers/mfd/ab8500-core.c
> +++ b/drivers/mfd/ab8500-core.c
> @@ -261,7 +261,7 @@ static int get_register_interruptible(struct ab8500 *ab8500, u8 bank,
>  	mutex_unlock(&ab8500->lock);
>  	dev_vdbg(ab8500->dev, "rd: addr %#x => data %#x\n", addr, ret);
>  
> -	return ret;
> +	return (ret < 0) ? ret : 0;
>  }
>  
>  static int ab8500_get_register(struct device *dev, u8 bank,

-- 
Lee Jones [???]
Linaro Services Technical Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
