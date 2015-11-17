From: michal.simek@xilinx.com (Michal Simek)
Date: Tue, 17 Nov 2015 18:53:12 +0100
Subject: [PATCH] fpga: zynq-fpga: Avoid hammering clk_{enable/disable}.
In-Reply-To: <1447780317-27758-1-git-send-email-moritz.fischer@ettus.com>
References: <1447780317-27758-1-git-send-email-moritz.fischer@ettus.com>
Message-ID: <564B6988.5020104@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17.11.2015 18:11, Moritz Fischer wrote:
> Replaced constant clock_{enable,disable} calls with pm_runtime
> hooks.
> 
> Signed-off-by: Moritz Fischer <moritz.fischer@ettus.com>
> ---
>  drivers/fpga/zynq-fpga.c | 79 +++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 62 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
> index c2fb412..5c03fb8 100644
> --- a/drivers/fpga/zynq-fpga.c
> +++ b/drivers/fpga/zynq-fpga.c
> @@ -28,6 +28,7 @@
>  #include <linux/of_address.h>
>  #include <linux/of_irq.h>
>  #include <linux/pm.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
>  #include <linux/string.h>
>  
> @@ -184,8 +185,8 @@ static int zynq_fpga_ops_write_init(struct fpga_manager *mgr, u32 flags,
>  
>  	priv = mgr->priv;
>  
> -	err = clk_enable(priv->clk);
> -	if (err)
> +	err = pm_runtime_get_sync(priv->dev);
> +	if (err < 0)
>  		return err;
>  
>  	/* don't globally reset PL if we're doing partial reconfig */
> @@ -271,12 +272,12 @@ static int zynq_fpga_ops_write_init(struct fpga_manager *mgr, u32 flags,
>  	ctrl = zynq_fpga_read(priv, MCTRL_OFFSET);
>  	zynq_fpga_write(priv, MCTRL_OFFSET, (~MCTRL_PCAP_LPBK_MASK & ctrl));
>  
> -	clk_disable(priv->clk);
> +	pm_runtime_put(priv->dev);
>  
>  	return 0;
>  
>  out_err:
> -	clk_disable(priv->clk);
> +	pm_runtime_put(priv->dev);
>  
>  	return err;
>  }
> @@ -301,9 +302,8 @@ static int zynq_fpga_ops_write(struct fpga_manager *mgr,
>  
>  	memcpy(kbuf, buf, count);
>  
> -	/* enable clock */
> -	err = clk_enable(priv->clk);
> -	if (err)
> +	err = pm_runtime_get_sync(priv->dev);
> +	if (err < 0)
>  		goto out_free;
>  
>  	zynq_fpga_write(priv, INT_STS_OFFSET, IXR_ALL_MASK);
> @@ -335,7 +335,7 @@ static int zynq_fpga_ops_write(struct fpga_manager *mgr,
>  		err = -EFAULT;
>  	}
>  
> -	clk_disable(priv->clk);
> +	pm_runtime_put(priv->dev);
>  
>  out_free:
>  	dma_free_coherent(priv->dev, in_count, kbuf, dma_addr);
> @@ -349,8 +349,8 @@ static int zynq_fpga_ops_write_complete(struct fpga_manager *mgr, u32 flags)
>  	int err;
>  	u32 intr_status;
>  
> -	err = clk_enable(priv->clk);
> -	if (err)
> +	err = pm_runtime_get_sync(priv->dev);
> +	if (err < 0)
>  		return err;
>  
>  	err = zynq_fpga_poll_timeout(priv, INT_STS_OFFSET, intr_status,
> @@ -358,7 +358,7 @@ static int zynq_fpga_ops_write_complete(struct fpga_manager *mgr, u32 flags)
>  				     INIT_POLL_DELAY,
>  				     INIT_POLL_TIMEOUT);
>  
> -	clk_disable(priv->clk);
> +	pm_runtime_put(priv->dev);
>  
>  	if (err)
>  		return err;
> @@ -385,12 +385,12 @@ static enum fpga_mgr_states zynq_fpga_ops_state(struct fpga_manager *mgr)
>  
>  	priv = mgr->priv;
>  
> -	err = clk_enable(priv->clk);
> -	if (err)
> +	err = pm_runtime_get_sync(priv->dev);
> +	if (err < 0)
>  		return FPGA_MGR_STATE_UNKNOWN;
>  
>  	intr_status = zynq_fpga_read(priv, INT_STS_OFFSET);
> -	clk_disable(priv->clk);
> +	pm_runtime_put(priv->dev);
>  
>  	if (intr_status & IXR_PCFG_DONE_MASK)
>  		return FPGA_MGR_STATE_OPERATING;
> @@ -457,19 +457,26 @@ static int zynq_fpga_probe(struct platform_device *pdev)
>  		return err;
>  	}
>  
> +	pm_runtime_get_noresume(&pdev->dev);
> +	pm_runtime_set_active(&pdev->dev);
> +	pm_runtime_enable(&pdev->dev);
> +
>  	/* unlock the device */
>  	zynq_fpga_write(priv, UNLOCK_OFFSET, UNLOCK_MASK);
>  
> -	clk_disable(priv->clk);
>  
>  	err = fpga_mgr_register(dev, "Xilinx Zynq FPGA Manager",
>  				&zynq_fpga_ops, priv);
>  	if (err) {
>  		dev_err(dev, "unable to register FPGA manager");
> -		clk_unprepare(priv->clk);
> +		clk_disable_unprepare(priv->clk);
> +		pm_runtime_put_noidle(&pdev->dev);
> +		pm_runtime_disable(&pdev->dev);
>  		return err;
>  	}
>  
> +	pm_runtime_put(&pdev->dev);
> +
>  	return 0;
>  }
>  
> @@ -483,11 +490,48 @@ static int zynq_fpga_remove(struct platform_device *pdev)
>  
>  	fpga_mgr_unregister(&pdev->dev);
>  
> -	clk_unprepare(priv->clk);
> +	pm_runtime_get_sync(&pdev->dev);
> +	clk_disable_unprepare(priv->clk);
> +	pm_runtime_put_noidle(&pdev->dev);
> +	pm_runtime_disable(&pdev->dev);
>  
>  	return 0;
>  }
>  
> +#ifdef CONFIG_PM

remove this

> +static int zynq_fpga_runtime_suspend(struct device *dev)

add __maybe_unused here

> +{
> +	struct zynq_fpga_priv *priv;
> +	struct fpga_manager *mgr;
> +
> +	mgr = dev_get_drvdata(dev);
> +	priv = mgr->priv;
> +
> +	clk_disable(priv->clk);
> +
> +	return 0;
> +}
> +
> +static int zynq_fpga_runtime_resume(struct device *dev)

and here

> +{
> +	struct zynq_fpga_priv *priv;
> +	struct fpga_manager *mgr;
> +
> +	mgr = dev_get_drvdata(dev);
> +	priv = mgr->priv;
> +
> +	clk_enable(priv->clk);
> +
> +	return 0;
> +}
> +
> +#endif

and remove this.

Body has nothing specific what it is available only for CONFIG_PM that's
why it should just work.

Thanks,
Michal
