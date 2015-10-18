From: joshc@ni.com (Josh Cartwright)
Date: Sun, 18 Oct 2015 13:02:59 -0500
Subject: [PATCHv2 3/3] fpga manager: Adding FPGA Manager support for
 Xilinx Zynq 7000
In-Reply-To: <1445035350-3569-4-git-send-email-moritz.fischer@ettus.com>
References: <1445035350-3569-1-git-send-email-moritz.fischer@ettus.com>
 <1445035350-3569-4-git-send-email-moritz.fischer@ettus.com>
Message-ID: <20151018180259.GI12756@jcartwri.amer.corp.natinst.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Moritz-

On Fri, Oct 16, 2015 at 03:42:30PM -0700, Moritz Fischer wrote:
> This commit adds FPGA Manager support for the Xilinx Zynq chip.
> The code borrows some from the xdevcfg driver in Xilinx'
> vendor tree.
> 
> Signed-off-by: Moritz Fischer <moritz.fischer@ettus.com>
> ---
> 
> v2:
>  - Replaced locking error flag and broken completion with irq masking
>    and changed completion handling
>  - Dealing with timeout cases
>  - Reworked clock handling
>  - Moved initialization from probe() to write_init()
>  - Fixed return value of devm_request_irq() check to check for non-zero
>  - Alphabetized includes ;-)
>  - Changed some of the comments, to better explain what's happening
[..]
> +static int zynq_fpga_probe(struct platform_device *pdev)
> +{
[..]
> +	priv->clk = devm_clk_get(dev, "ref_clk");
> +	if (IS_ERR(priv->clk)) {
> +		dev_err(dev, "input clock not found");
> +		return PTR_ERR(priv->clk);
> +	}
> +
> +	err = clk_prepare_enable(priv->clk);
> +	if (err) {
> +		dev_err(dev, "unable to enable clock");
> +		return err;
> +	}

prepare_cnt = 1, enable_cnt = 1

> +
> +	/* unlock the device */
> +	zynq_fpga_write(priv, UNLOCK_OFFSET, UNLOCK_MASK);
> +
> +	clk_disable(priv->clk);

prepare_cnt = 1, enable_cnt = 0
> +
> +	err = fpga_mgr_register(dev, "Xilinx Zynq FPGA Manager",
> +				&zynq_fpga_ops, priv);
> +	if (err) {
> +		dev_err(dev, "unable to register FPGA manager");
> +		clk_disable_unprepare(priv->clk);

prepare_cnt = 0, enable_cnt = -1 /* OOPS! */

Clock management is still wonky.  I think you only want clk_unprepare here.

> +		return err;
> +	}
> +

Assuming all goes well, you'll be leaving probe() with:

prepare_cnt = 1, enable_cnt = 0.

> +	return 0;
> +}
> +
> +static int zynq_fpga_remove(struct platform_device *pdev)
> +{
> +	struct zynq_fpga_priv *priv;
> +
> +	fpga_mgr_unregister(&pdev->dev);
> +
> +	priv = platform_get_drvdata(pdev);
> +
> +	clk_disable_unprepare(priv->clk);

Which means, symmetrically, you'll only want this to be a clk_unprepare().

  Josh
