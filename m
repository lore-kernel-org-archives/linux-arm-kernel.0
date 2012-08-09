From: bryan.wu@canonical.com (Bryan Wu)
Date: Thu, 9 Aug 2012 14:15:29 +0800
Subject: [PATCH 10/10] leds: renesas: fix error handling
In-Reply-To: <1344461278-28245-11-git-send-email-arnd@arndb.de>
References: <1344461278-28245-1-git-send-email-arnd@arndb.de>
 <1344461278-28245-11-git-send-email-arnd@arndb.de>
Message-ID: <CAK5ve-LXaA1xi5NDWTUxeVnr6DpDFv4LMzx0knHvO=1bzJO9jQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 9, 2012 at 5:27 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> bfe4c041 "leds: convert Renesas TPU LED driver to devm_kzalloc() and
> cleanup error exit path" introduced a possible case in which r_tpu_probe
> calls iounmap on a wild pointer. This changes the one case that was
> missed in the same way as the other error paths.
>
> Without this patch, building kota2_defconfig results in:
>
> drivers/leds/leds-renesas-tpu.c: In function 'r_tpu_probe':
> drivers/leds/leds-renesas-tpu.c:246:6: warning: 'ret' may be used uninitialized in this function [-Wuninitialized]
> drivers/leds/leds-renesas-tpu.c:308:17: warning: 'p' may be used uninitialized in this function [-Wuninitialized]
>

Thanks, Arnd. If you don't mind, I will apply this fixing through my led tree.

-Bryan

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Bryan Wu <bryan.wu@canonical.com>
> Cc: Magnus Damm <damm@opensource.se>
>
> --- a/drivers/leds/leds-renesas-tpu.c
> +++ b/drivers/leds/leds-renesas-tpu.c
> @@ -247,7 +247,7 @@ static int __devinit r_tpu_probe(struct platform_device *pdev)
>
>         if (!cfg) {
>                 dev_err(&pdev->dev, "missing platform data\n");
> -               goto err0;
> +               return -ENODEV;
>         }
>
>         p = devm_kzalloc(&pdev->dev, sizeof(*p), GFP_KERNEL);
> ---
>  drivers/leds/leds-renesas-tpu.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/leds/leds-renesas-tpu.c b/drivers/leds/leds-renesas-tpu.c
> index 9ee12c2..771ea06 100644
> --- a/drivers/leds/leds-renesas-tpu.c
> +++ b/drivers/leds/leds-renesas-tpu.c
> @@ -247,7 +247,7 @@ static int __devinit r_tpu_probe(struct platform_device *pdev)
>
>         if (!cfg) {
>                 dev_err(&pdev->dev, "missing platform data\n");
> -               goto err0;
> +               return -ENODEV;
>         }
>
>         p = devm_kzalloc(&pdev->dev, sizeof(*p), GFP_KERNEL);
> --
> 1.7.10
>



-- 
Bryan Wu <bryan.wu@canonical.com>
Kernel Developer    +86.186-168-78255 Mobile
Canonical Ltd.      www.canonical.com
Ubuntu - Linux for human beings | www.ubuntu.com
