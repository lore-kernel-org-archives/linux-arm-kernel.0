From: atull@opensource.altera.com (atull)
Date: Thu, 22 Oct 2015 13:53:13 -0500
Subject: [PATCH] fpga: zynq-fpga: Fix issue with drvdata being overwritten.
In-Reply-To: <1445540169-20715-1-git-send-email-moritz.fischer@ettus.com>
References: <1445540169-20715-1-git-send-email-moritz.fischer@ettus.com>
Message-ID: <alpine.DEB.2.02.1510221351490.14856@linuxheads99>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 22 Oct 2015, Moritz Fischer wrote:

> Upon registering a FPGA Manager low level driver, FPGA Manager
> core overwrites the platform drvdata pointer. Prior to this commit
> zynq-fpga falsely relied on this pointer to still be valid at remove()
> time.
> 
> Reported-by: Alan Tull <atull@opensource.altera.com>
> Signed-off-by: Moritz Fischer <moritz.fischer@ettus.com>
> ---
>  drivers/fpga/zynq-fpga.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
> index 31db550..c2fb412 100644
> --- a/drivers/fpga/zynq-fpga.c
> +++ b/drivers/fpga/zynq-fpga.c
> @@ -416,7 +416,6 @@ static int zynq_fpga_probe(struct platform_device *pdev)
>  	if (!priv)
>  		return -ENOMEM;
>  
> -	platform_set_drvdata(pdev, priv);
>  	priv->dev = dev;
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> @@ -477,10 +476,12 @@ static int zynq_fpga_probe(struct platform_device *pdev)
>  static int zynq_fpga_remove(struct platform_device *pdev)
>  {
>  	struct zynq_fpga_priv *priv;
> +	struct fpga_manager *mgr;
>  
> -	fpga_mgr_unregister(&pdev->dev);
> +	mgr = platform_get_drvdata(pdev);
> +	priv = mgr->priv;
>  
> -	priv = platform_get_drvdata(pdev);
> +	fpga_mgr_unregister(&pdev->dev);
>  
>  	clk_unprepare(priv->clk);
>  

Hi Moritz,

Looks good!

Acked-by: Alan Tull <atull@opensource.altera.com>

Alan

> -- 
> 2.6.2
> 
> 
