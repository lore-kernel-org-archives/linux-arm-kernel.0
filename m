From: atull@opensource.altera.com (atull)
Date: Sun, 13 Nov 2016 17:19:34 -0600
Subject: [PATCH fpga 8/9] fpga socfpga: Use the scatterlist interface
In-Reply-To: <1478732303-13718-9-git-send-email-jgunthorpe@obsidianresearch.com>
References: <1478732303-13718-1-git-send-email-jgunthorpe@obsidianresearch.com>
 <1478732303-13718-9-git-send-email-jgunthorpe@obsidianresearch.com>
Message-ID: <alpine.DEB.2.10.1611131712210.2735@atull-VirtualBox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 9 Nov 2016, Jason Gunthorpe wrote:

> socfpga just uses the CPU to memory copy the bitstream, so there is
> no reason it needs contiguous kernel memory. Switch to use the sg
> interface.
> 
> Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> ---
>  drivers/fpga/socfpga.c | 56 +++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 37 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/fpga/socfpga.c b/drivers/fpga/socfpga.c
> index 27d2ff28132c..f3f390b2eecf 100644
> --- a/drivers/fpga/socfpga.c
> +++ b/drivers/fpga/socfpga.c
> @@ -24,6 +24,7 @@
>  #include <linux/of_address.h>
>  #include <linux/of_irq.h>
>  #include <linux/pm.h>
> +#include <linux/scatterlist.h>
>  
>  /* Register offsets */
>  #define SOCFPGA_FPGMGR_STAT_OFST				0x0
> @@ -408,10 +409,22 @@ static int socfpga_fpga_reset(struct fpga_manager *mgr)
>   * Prepare the FPGA to receive the configuration data.
>   */
>  static int socfpga_fpga_ops_configure_init(struct fpga_manager *mgr, u32 flags,
> -					   const char *buf, size_t count)
> +					   struct sg_table *sgt)
>  {
>  	struct socfpga_fpga_priv *priv = mgr->priv;
> -	int ret;
> +	struct scatterlist *sg;
> +	int ret, i;
> +
> +	/* We use the CPU to read the bitstream 32 bits at a time, and thus
> +	 * require alignment.
> +	 */
> +	for_each_sg(sgt->sgl, sg, sgt->nents, i) {
> +		if ((sg->offset % 4) != 0) {
> +			dev_err(&mgr->dev,
> +				"Invalid bitstream, chunks must be aligned\n");
> +			return -EINVAL;
> +		}
> +	}
>  
>  	if (flags & FPGA_MGR_PARTIAL_RECONFIG) {
>  		dev_err(&mgr->dev, "Partial reconfiguration not supported.\n");
> @@ -440,40 +453,45 @@ static int socfpga_fpga_ops_configure_init(struct fpga_manager *mgr, u32 flags,
>  /*
>   * Step 9: write data to the FPGA data register
>   */
> -static int socfpga_fpga_ops_configure_write(struct fpga_manager *mgr,
> -					    const char *buf, size_t count)
> +static void socfpga_write_buf(struct socfpga_fpga_priv *priv, const u32 *buf,
> +			      size_t count)
>  {
> -	struct socfpga_fpga_priv *priv = mgr->priv;
> -	u32 *buffer_32 = (u32 *)buf;
>  	size_t i = 0;
>  
> -	if (count <= 0)
> -		return -EINVAL;
> -
>  	/* Write out the complete 32-bit chunks. */
>  	while (count >= sizeof(u32)) {
> -		socfpga_fpga_data_writel(priv, buffer_32[i++]);
> +		socfpga_fpga_data_writel(priv, buf[i++]);
>  		count -= sizeof(u32);
>  	}
>  
>  	/* Write out remaining non 32-bit chunks. */
>  	switch (count) {
>  	case 3:
> -		socfpga_fpga_data_writel(priv, buffer_32[i++] & 0x00ffffff);
> +		socfpga_fpga_data_writel(priv, buf[i++] & 0x00ffffff);
>  		break;
>  	case 2:
> -		socfpga_fpga_data_writel(priv, buffer_32[i++] & 0x0000ffff);
> +		socfpga_fpga_data_writel(priv, buf[i++] & 0x0000ffff);
>  		break;
>  	case 1:
> -		socfpga_fpga_data_writel(priv, buffer_32[i++] & 0x000000ff);
> -		break;
> -	case 0:
> +		socfpga_fpga_data_writel(priv, buf[i++] & 0x000000ff);
>  		break;
>  	default:
> -		/* This will never happen. */
> -		return -EFAULT;
> +		break;
>  	}
> +}
> +
> +static int socfpga_fpga_ops_configure_write(struct fpga_manager *mgr,
> +					    struct sg_table *sgt)
> +{
> +	struct socfpga_fpga_priv *priv = mgr->priv;
> +	struct sg_mapping_iter miter;
> +
> +	sg_miter_start(&miter, sgt->sgl, sgt->nents, SG_MITER_FROM_SG);
> +
> +	while (sg_miter_next(&miter))
> +		socfpga_write_buf(priv, miter.addr, miter.length);
>  
> +	sg_miter_stop(&miter);
>  	return 0;
>  }

Hi Jason,

Currently or soon we have 3 drivers that don't really use the sg
interface natively.  So this workaround ends up in each of them?
That's a lot of duplicated code.  Why can't this code be in the
fpga-mgr.c core for drivers that aren't using sg (to minimizing
duplication).

I will test this when I get time, may not be this week.  I just
moved to a new building and lab and am in a course all week and
so forth.

Alan

>  
> @@ -545,8 +563,8 @@ static enum fpga_mgr_states socfpga_fpga_ops_state(struct fpga_manager *mgr)
>  
>  static const struct fpga_manager_ops socfpga_fpga_ops = {
>  	.state = socfpga_fpga_ops_state,
> -	.write_init = socfpga_fpga_ops_configure_init,
> -	.write = socfpga_fpga_ops_configure_write,
> +	.write_init_sg = socfpga_fpga_ops_configure_init,
> +	.write_sg = socfpga_fpga_ops_configure_write,
>  	.write_complete = socfpga_fpga_ops_configure_complete,
>  };
>  
> -- 
> 2.1.4
> 
> 
