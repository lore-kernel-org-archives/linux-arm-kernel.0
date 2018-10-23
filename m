From: mdf@kernel.org (Moritz Fischer)
Date: Tue, 23 Oct 2018 10:01:19 +0100
Subject: [PATCH] zynq-fpga: Only route PR via PCAP when required
In-Reply-To: <1540276279-2903-1-git-send-email-mike.looijmans@topic.nl>
References: <1540276279-2903-1-git-send-email-mike.looijmans@topic.nl>
Message-ID: <20181023090119.GA2205@archbook>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

seems like a good usecase (though uncommon), question below

On Tue, Oct 23, 2018 at 08:31:19AM +0200, Mike Looijmans wrote:
> The Xilinx Zynq FPGA driver takes ownership of the PR interface, making
> it impossible to use the ICAP interface for partial reconfiguration.
> 
> This patch changes the driver to only activate PR over PCAP while the
> device is actively being accessed by the driver for programming.
> 
> This allows both PCAP and ICAP interfaces to be used for PR.
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> ---
>  drivers/fpga/zynq-fpga.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
> index 3110e00..f6c205a 100644
> --- a/drivers/fpga/zynq-fpga.c
> +++ b/drivers/fpga/zynq-fpga.c
> @@ -497,6 +497,10 @@ static int zynq_fpga_ops_write_complete(struct fpga_manager *mgr,
>  	int err;
>  	u32 intr_status;
>  
> +	/* Release 'PR' control back to the ICAP */
> +	zynq_fpga_write(priv, CTRL_OFFSET,
> +		zynq_fpga_read(priv, CTRL_OFFSET) & ~CTRL_PCAP_PR_MASK);
> +

Shouldn't that be after the below stanza that enables the clock?

>  	err = clk_enable(priv->clk);
>  	if (err)
>  		return err;
> -- 
> 1.9.1
> 

Cheers,

Moritz
