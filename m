From: atull@opensource.altera.com (atull)
Date: Mon, 14 Nov 2016 08:06:52 -0600
Subject: [PATCH 1/4] fpga mgr: Introduce FPGA capabilities
In-Reply-To: <20161107001326.7395-2-moritz.fischer@ettus.com>
References: <20161107001326.7395-1-moritz.fischer@ettus.com>
 <20161107001326.7395-2-moritz.fischer@ettus.com>
Message-ID: <alpine.DEB.2.10.1611140801480.2786@atull-VirtualBox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 7 Nov 2016, Moritz Fischer wrote:

> Add FPGA capabilities as a way to express the capabilities
> of a given FPGA manager.
> 
> Removes code duplication by comparing the low-level driver's
> capabilities at the framework level rather than having each driver
> check for supported operations in the write_init() callback.
> 
> This allows for extending with additional capabilities, similar
> to the the dmaengine framework's implementation.
> 
> Signed-off-by: Moritz Fischer <moritz.fischer@ettus.com>
> Cc: Alan Tull <atull@opensource.altera.com>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: S?ren Brinkmann <soren.brinkmann@xilinx.com>
> Cc: linux-kernel at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> ---
> 
> Changes from RFC:
> * in the RFC the caps weren't actually stored into the struct fpga_mgr
> 
> Note:
> 
> If people disagree on the typedef being a 'false positive' I can fix
> that in a future rev of the patchset.
> 
> Thanks,
> 
>     Moritz
> 
> ---
>  drivers/fpga/fpga-mgr.c       | 15 ++++++++++++++
>  drivers/fpga/socfpga.c        | 10 +++++-----
>  drivers/fpga/zynq-fpga.c      |  7 ++++++-
>  include/linux/fpga/fpga-mgr.h | 46 ++++++++++++++++++++++++++++++++++++++++++-
>  4 files changed, 71 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
> index 953dc91..ed57c17 100644
> --- a/drivers/fpga/fpga-mgr.c
> +++ b/drivers/fpga/fpga-mgr.c
> @@ -49,6 +49,18 @@ int fpga_mgr_buf_load(struct fpga_manager *mgr, u32 flags, const char *buf,
>  	struct device *dev = &mgr->dev;
>  	int ret;
>  
> +	if (flags & FPGA_MGR_PARTIAL_RECONFIG &&
> +	    !fpga_mgr_has_cap(FPGA_MGR_CAP_PARTIAL_RECONF, mgr->caps)) {
> +		dev_err(dev, "Partial reconfiguration not supported\n");
> +		return -ENOTSUPP;
> +	}
> +
> +	if (flags & FPGA_MGR_FULL_RECONFIG &&
> +	    !fpga_mgr_has_cap(FPGA_MGR_CAP_FULL_RECONF, mgr->caps)) {
> +		dev_err(dev, "Full reconfiguration not supported\n");
> +		return -ENOTSUPP;
> +	}
> +

Could you move the checks to their own function like
'fpga_mgr_check_caps()' or something?  I really like it if we can keep
the functions short, like a screen or so where it's practicle to do
so and I could see the number of caps growing here.  The only
counter argument I could think of is if a cap affects the sequence
in this function.  Hmmm...

Alan
