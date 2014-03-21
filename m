From: mturquette@linaro.org (Mike Turquette)
Date: Thu, 20 Mar 2014 20:12:56 -0700
Subject: [PATCH] clk: hisilicon: fix warning from smatch
In-Reply-To: <1394422400-17639-1-git-send-email-zhangfei.gao@linaro.org>
References: <1394422400-17639-1-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <20140321031256.21989.67304@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Zhangfei Gao (2014-03-09 20:33:20)
> drivers/clk/hisilicon/clk-hi3620.c:338
> mmc_clk_delay() warn: always true condition '(para >= 0) => (0-u32max >= 0)'
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>

Taken into clk-next.

Regards,
Mike

> ---
>  drivers/clk/hisilicon/clk-hi3620.c |   15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/clk/hisilicon/clk-hi3620.c b/drivers/clk/hisilicon/clk-hi3620.c
> index 38faa469d288..e75f742ca422 100644
> --- a/drivers/clk/hisilicon/clk-hi3620.c
> +++ b/drivers/clk/hisilicon/clk-hi3620.c
> @@ -335,15 +335,14 @@ static u32 mmc_clk_delay(u32 val, u32 para, u32 off, u32 len)
>  {
>         u32 i;
>  
> -       if (para >= 0) {
> -               for (i = 0; i < len; i++) {
> -                       if (para % 2)
> -                               val |= 1 << (off + i);
> -                       else
> -                               val &= ~(1 << (off + i));
> -                       para = para >> 1;
> -               }
> +       for (i = 0; i < len; i++) {
> +               if (para % 2)
> +                       val |= 1 << (off + i);
> +               else
> +                       val &= ~(1 << (off + i));
> +               para = para >> 1;
>         }
> +
>         return val;
>  }
>  
> -- 
> 1.7.9.5
> 
