From: atull@opensource.altera.com (atull)
Date: Mon, 14 Nov 2016 20:42:19 -0600
Subject: [PATCH 3/4] fpga mgr: zynq: Add support for encrypted bitstreams
In-Reply-To: <20161107001326.7395-4-moritz.fischer@ettus.com>
References: <20161107001326.7395-1-moritz.fischer@ettus.com>
 <20161107001326.7395-4-moritz.fischer@ettus.com>
Message-ID: <alpine.DEB.2.10.1611142022380.6582@atull-VirtualBox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 7 Nov 2016, Moritz Fischer wrote:

Hi Moritz,

This looks good.  Probably the socfpga changes could get
folded into this patch (was patch 4/4) unless you thought of
a reason not to (after that patch is changed to see if the
MSEL bits are set to enable decrypt).

There also could be a uncompress cap as well since cyclone 5
supports both compressed and encrypted images and has bits
in the MSEL for them (I mentioned separately in my comments
about patch 4/4).

For the Zynq, does the encrypt bit denote a requirement that
the part will only take an encrypted image or is it an
option that it supports?  IIRC (and my brain is currently
pretty tired), if the MSEL for Cyclone5 is set for
encryption, the bitsream must be encrypted (same for
compress).  That might change the meaning of this stuff a
bit but probably doesn't necessitate a change in the
implementation.  It also makes the sysfs that much more
useful as it allows the users to know what type of image
they are required to provide.

Thanks,
Alan

> Add new flag FPGA_MGR_DECRYPT_BISTREAM as well as a matching
> capability FPGA_MGR_CAP_DECRYPT to allow for on-the-fly
> decryption of an encrypted bitstream.
> 
> If the system is not booted in secure mode AES & HMAC units
> are disabled by the boot ROM, therefore the capability
> is not available.
> 
> Signed-off-by: Moritz Fischer <moritz.fischer@ettus.com>
> Cc: Alan Tull <atull@opensource.altera.com>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: S?ren Brinkmann <soren.brinkmann@xilinx.com>
> Cc: linux-kernel at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> ---
>  drivers/fpga/fpga-mgr.c       |  7 +++++++
>  drivers/fpga/zynq-fpga.c      | 21 +++++++++++++++++++--
>  include/linux/fpga/fpga-mgr.h |  2 ++
>  3 files changed, 28 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
> index 98230b7..e4d08e1 100644
> --- a/drivers/fpga/fpga-mgr.c
> +++ b/drivers/fpga/fpga-mgr.c
> @@ -61,6 +61,12 @@ int fpga_mgr_buf_load(struct fpga_manager *mgr, u32 flags, const char *buf,
>  		return -ENOTSUPP;
>  	}
>  
> +	if (flags & FPGA_MGR_DECRYPT_BITSTREAM &&
> +	    !fpga_mgr_has_cap(FPGA_MGR_CAP_DECRYPT, mgr->caps)) {
> +		dev_err(dev, "Bitstream decryption not supported\n");
> +		return -ENOTSUPP;
> +	}
> +
>  	/*
>  	 * Call the low level driver's write_init function.  This will do the
>  	 * device-specific things to get the FPGA into the state where it is
> @@ -170,6 +176,7 @@ static const char * const state_str[] = {
>  static const char * const cap_str[] = {
>  	[FPGA_MGR_CAP_FULL_RECONF] = "Full reconfiguration",
>  	[FPGA_MGR_CAP_PARTIAL_RECONF] = "Partial reconfiguration",
> +	[FPGA_MGR_CAP_DECRYPT] = "Decrypt bitstream on the fly",
>  };
>  
>  static ssize_t name_show(struct device *dev,
> diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
> index 1d37ff0..0aa4705 100644
> --- a/drivers/fpga/zynq-fpga.c
> +++ b/drivers/fpga/zynq-fpga.c
> @@ -71,6 +71,10 @@
>  #define CTRL_PCAP_PR_MASK		BIT(27)
>  /* Enable PCAP */
>  #define CTRL_PCAP_MODE_MASK		BIT(26)
> +/* Needed to reduce clock rate for secure config */
> +#define CTRL_PCAP_RATE_EN_MASK		BIT(25)
> +/* System booted in secure mode */
> +#define CTRL_SEC_EN_MASK		BIT(7)
>  
>  /* Miscellaneous Control Register bit definitions */
>  /* Internal PCAP loopback */
> @@ -252,12 +256,20 @@ static int zynq_fpga_ops_write_init(struct fpga_manager *mgr, u32 flags,
>  
>  	/* set configuration register with following options:
>  	 * - enable PCAP interface
> -	 * - set throughput for maximum speed
> +	 * - set throughput for maximum speed (if we're not decrypting)
>  	 * - set CPU in user mode
>  	 */
>  	ctrl = zynq_fpga_read(priv, CTRL_OFFSET);
> -	zynq_fpga_write(priv, CTRL_OFFSET,
> +	if (flags & FPGA_MGR_DECRYPT_BITSTREAM) {
> +		zynq_fpga_write(priv, CTRL_OFFSET,
> +			(CTRL_PCAP_PR_MASK | CTRL_PCAP_MODE_MASK |
> +			 CTRL_PCAP_RATE_EN_MASK | ctrl));
> +
> +	} else {
> +		ctrl &= ~CTRL_PCAP_RATE_EN_MASK;
> +		zynq_fpga_write(priv, CTRL_OFFSET,
>  			(CTRL_PCAP_PR_MASK | CTRL_PCAP_MODE_MASK | ctrl));
> +	}
>  
>  	/* check that we have room in the command queue */
>  	status = zynq_fpga_read(priv, STATUS_OFFSET);
> @@ -412,6 +424,7 @@ static int zynq_fpga_probe(struct platform_device *pdev)
>  	struct resource *res;
>  	fpga_mgr_cap_mask_t caps;
>  	int err;
> +	u32 tmp;
>  
>  	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>  	if (!priv)
> @@ -466,6 +479,10 @@ static int zynq_fpga_probe(struct platform_device *pdev)
>  	fpga_mgr_cap_set(FPGA_MGR_CAP_FULL_RECONF, caps);
>  	fpga_mgr_cap_set(FPGA_MGR_CAP_PARTIAL_RECONF, caps);
>  
> +	/* only works if we booted in secure mode */
> +	tmp = zynq_fpga_read(priv, CTRL_OFFSET);
> +	if (tmp & CTRL_SEC_EN_MASK)
> +		fpga_mgr_cap_set(FPGA_MGR_CAP_DECRYPT, caps);
>  
>  	err = fpga_mgr_register(dev, "Xilinx Zynq FPGA Manager",
>  				&zynq_fpga_ops, caps, priv);
> diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
> index 9bb96a5..aabe258 100644
> --- a/include/linux/fpga/fpga-mgr.h
> +++ b/include/linux/fpga/fpga-mgr.h
> @@ -68,10 +68,12 @@ enum fpga_mgr_states {
>   */
>  #define FPGA_MGR_PARTIAL_RECONFIG	BIT(0)
>  #define FPGA_MGR_FULL_RECONFIG		BIT(1)
> +#define FPGA_MGR_DECRYPT_BITSTREAM	BIT(2)
>  
>  enum fpga_mgr_capability {
>  	FPGA_MGR_CAP_PARTIAL_RECONF,
>  	FPGA_MGR_CAP_FULL_RECONF,
> +	FPGA_MGR_CAP_DECRYPT,
>  
>  /* last capability type for creation of the capabilities mask */
>  	FPGA_MGR_CAP_END,
> -- 
> 2.10.0
> 
> 
