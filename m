From: atull@opensource.altera.com (atull)
Date: Sun, 13 Nov 2016 16:37:20 -0600
Subject: [PATCH 4/4] fpga mgr: socfpga: Expose support for encrypted
 bitstreams
In-Reply-To: <20161107001326.7395-5-moritz.fischer@ettus.com>
References: <20161107001326.7395-1-moritz.fischer@ettus.com>
 <20161107001326.7395-5-moritz.fischer@ettus.com>
Message-ID: <alpine.DEB.2.10.1611131630510.2735@atull-VirtualBox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 7 Nov 2016, Moritz Fischer wrote:

> Expose support for on the fly decryption of bitstreams.
> This needs no additional work or configuration,
> so just expose the new capability.

Hi Moritz,

When we talked about this, I was thinking about the arria10
support which I'd done more recently.  c5 and a10 are
quite different here.

The c5 datasheet:
  https://www.altera.com/literature/hb/cyclone-v/cv_5v4.pdf

Look for the 'stat' register on page 4-12 onwards.  This
register exposes the setting of the msel pins (are a dipswitch
on some boards).  The msel pins determine the programming
mode and whether it is expecting an encrypted and/or
compressed bitstream.  So you could read this reg and
set the capabilities accordingly.

For arria10, encryption is enabled and if the bitstream
says it's encrypted, the driver handles it.

Alan

> 
> Signed-off-by: Moritz Fischer <moritz.fischer@ettus.com>
> Cc: Alan Tull <atull@opensource.altera.com>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: S?ren Brinkmann <soren.brinkmann@xilinx.com>
> Cc: linux-kernel at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> ---
> 
> Alan,
> 
> can you please let me know if that works this way, or where to find
> information on encrypted bitstreams? I have a CycloneV SoCFPGA to test
> on ...
> 
> Cheers,
> 
> Moritz
> ---
>  drivers/fpga/socfpga.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/fpga/socfpga.c b/drivers/fpga/socfpga.c
> index fd9760c..ab57ec0c 100644
> --- a/drivers/fpga/socfpga.c
> +++ b/drivers/fpga/socfpga.c
> @@ -579,6 +579,7 @@ static int socfpga_fpga_probe(struct platform_device *pdev)
>  
>  	fpga_mgr_cap_zero(&caps);
>  	fpga_mgr_cap_set(FPGA_MGR_CAP_FULL_RECONF, caps);
> +	fpga_mgr_cap_set(FPGA_MGR_CAP_DECRYPT, caps);
>  
>  	return fpga_mgr_register(dev, "Altera SOCFPGA FPGA Manager",
>  				 &socfpga_fpga_ops, caps, priv);
> -- 
> 2.10.0
> 
> 
