From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Sun, 23 Jan 2011 15:39:23 +0300
Subject: [PATCH v9 18/18] OMAP2,3: DSS2: Get DSS IRQ from platform device
In-Reply-To: <1295690758-5845-19-git-send-email-sumit.semwal@ti.com>
References: <1295690758-5845-1-git-send-email-sumit.semwal@ti.com>
	<1295690758-5845-19-git-send-email-sumit.semwal@ti.com>
Message-ID: <4D3C217B.9020301@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 22-01-2011 13:05, Sumit Semwal wrote:

> From: Senthilvadivu Guruswamy<svadivu@ti.com>

> DSS IRQ number can be obtained from platform_get_irq().  This API in turn
> picks the right IRQ number belonging to HW IP from the hwmod database.
> So hardcoding of IRQ number could be removed.
>
> Reviewed-by: Paul Walmsley<paul@pwsan.com>
> Reviewed-by: Kevin Hilman<khilman@ti.com>
> Tested-by: Kevin Hilman<khilman@ti.com>
> Signed-off-by: Senthilvadivu Guruswamy<svadivu@ti.com>
> Signed-off-by: Sumit Semwal<sumit.semwal@ti.com>
[...]

> diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
> index 4d7a816..22690e9 100644
> --- a/drivers/video/omap2/dss/dss.c
> +++ b/drivers/video/omap2/dss/dss.c
[...]
> @@ -609,15 +609,18 @@ static int dss_init(bool skip_init)
>   	REG_FLD_MOD(DSS_CONTROL, 0, 2, 2);	/* venc clock mode = normal */
>   #endif
>
> -	r = request_irq(INT_24XX_DSS_IRQ,
> +	dss_irq = platform_get_irq(dss.pdev, 0);
> +	if (dss_irq != -ENXIO) {

    Better just 'dss_irq > 0', IMHO.

WBR, Sergei
