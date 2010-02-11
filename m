From: baruch@tkos.co.il (Baruch Siach)
Date: Thu, 11 Feb 2010 20:58:04 +0200
Subject: [PATCH] imx serial driver: NULL pointer dereference in
	serial_imx_probe/remove
In-Reply-To: <4B74461A.1050403@novero.com>
References: <4B74461A.1050403@novero.com>
Message-ID: <20100211185804.GD10889@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bas,

On Thu, Feb 11, 2010 at 07:02:02PM +0100, Bas Vermeulen wrote:
> Check for NULL pointer before dereferencing, as it is possible and
> legal to pass in NULL for the platform data for a serial port.

Third time's the charm :-). This patch is already queued for .34 in Greg's tty 
quilt tree.

http://lists.infradead.org/pipermail/linux-arm-kernel/2010-January/007909.html
http://kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/gregkh-06-tty/serial-imx-fix-null-dereference-oops-when-pdata-null.patch
http://git.kernel.org/?p=linux/kernel/git/sfr/linux-next.git;a=commitdiff;h=ed8101ca0251cc0d05bedf577109bfb05b66f5dc

baruch

> Signed-off-by: Bas Vermeulen <bas.vermeulen@novero.com>
> 
> diff --git a/drivers/serial/imx.c b/drivers/serial/imx.c
> index 60d665a..d00fcf8 100644
> --- a/drivers/serial/imx.c
> +++ b/drivers/serial/imx.c
> @@ -1279,7 +1279,7 @@ static int serial_imx_probe(struct
> platform_device *pdev)
>          sport->use_irda = 1;
>  #endif
> 
> -    if (pdata->init) {
> +    if (pdata && pdata->init) {
>          ret = pdata->init(pdev);
>          if (ret)
>              goto clkput;
> @@ -1292,7 +1292,7 @@ static int serial_imx_probe(struct
> platform_device *pdev)
> 
>      return 0;
>  deinit:
> -    if (pdata->exit)
> +    if (pdata && pdata->exit)
>          pdata->exit(pdev);
>  clkput:
>      clk_put(sport->clk);
> @@ -1321,7 +1321,7 @@ static int serial_imx_remove(struct
> platform_device *pdev)
> 
>      clk_disable(sport->clk);
> 
> -    if (pdata->exit)
> +    if (pdata && pdata->exit)
>          pdata->exit(pdev);
> 
>      iounmap(sport->port.membase);

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
