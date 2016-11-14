From: atull@opensource.altera.com (atull)
Date: Mon, 14 Nov 2016 08:33:31 -0600
Subject: [PATCH 2/4] fpga mgr: Expose FPGA capabilities to userland via
 sysfs
In-Reply-To: <20161107001326.7395-3-moritz.fischer@ettus.com>
References: <20161107001326.7395-1-moritz.fischer@ettus.com>
 <20161107001326.7395-3-moritz.fischer@ettus.com>
Message-ID: <alpine.DEB.2.10.1611140829380.2786@atull-VirtualBox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 7 Nov 2016, Moritz Fischer wrote:

Hi Moritz,

One nit below.  Otherwise,

    Acked-by: Alan Tull <atull@opensource.altera.com>

Alan


> Expose FPGA capabilities to userland via sysfs.
> 
> Add Documentation for currently supported capabilities
> that get exported via sysfs.
> 
> Signed-off-by: Moritz Fischer <moritz.fischer@ettus.com>
> Cc: Alan Tull <atull@opensource.altera.com>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: S?ren Brinkmann <soren.brinkmann@xilinx.com>
> Cc: linux-kernel at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> ---
>  Documentation/ABI/testing/sysfs-class-fpga-manager | 16 ++++++++++++++++
>  drivers/fpga/fpga-mgr.c                            | 20 ++++++++++++++++++++
>  include/linux/fpga/fpga-mgr.h                      |  2 ++
>  3 files changed, 38 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-fpga-manager b/Documentation/ABI/testing/sysfs-class-fpga-manager
> index 23056c5..d9aee21 100644
> --- a/Documentation/ABI/testing/sysfs-class-fpga-manager
> +++ b/Documentation/ABI/testing/sysfs-class-fpga-manager
> @@ -35,3 +35,19 @@ Description:	Read fpga manager state as a string.
>  		* write complete	= Doing post programming steps
>  		* write complete error	= Error while doing post programming
>  		* operating		= FPGA is programmed and operating
> +
> +What: 		/sys/class/fpga_manager/fpga/capabilities
> +Date:		November 2016
> +KernelVersion:	4.9
> +Contact:	Moritz Fischer <moritz.fischer@ettus.com>
> +Description:	Read fpga manager capabilities as a string.
> +		The intent is to provide userspace with information on what
> +		operations the particular instance can execute.
> +
> +		Each line expresses a capability that is available on the
> +		particular instance of an fpga manager.
> +		Supported so far:
> +
> +		* Full reconfiguration
> +		* Partial reconfiguration
> +		* Decrypt bitstream on the fly

Decrypt gets added in a later patch.

> diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
> index ed57c17..98230b7 100644
> --- a/drivers/fpga/fpga-mgr.c
> +++ b/drivers/fpga/fpga-mgr.c
> @@ -167,6 +167,11 @@ static const char * const state_str[] = {
>  	[FPGA_MGR_STATE_OPERATING] =		"operating",
>  };
>  
> +static const char * const cap_str[] = {
> +	[FPGA_MGR_CAP_FULL_RECONF] = "Full reconfiguration",
> +	[FPGA_MGR_CAP_PARTIAL_RECONF] = "Partial reconfiguration",
> +};
> +
>  static ssize_t name_show(struct device *dev,
>  			 struct device_attribute *attr, char *buf)
>  {
> @@ -183,10 +188,25 @@ static ssize_t state_show(struct device *dev,
>  	return sprintf(buf, "%s\n", state_str[mgr->state]);
>  }
>  
> +static ssize_t capabilities_show(struct device *dev,
> +				 struct device_attribute *attr, char *buf)
> +{
> +	struct fpga_manager *mgr = to_fpga_manager(dev);
> +	char *start = buf;
> +	enum fpga_mgr_capability cap;
> +
> +	for_each_fpga_mgr_cap_mask(cap, mgr->caps)
> +		buf += sprintf(buf, "%s\n", cap_str[cap]);
> +
> +	return buf - start;
> +}
> +
> +static DEVICE_ATTR_RO(capabilities);
>  static DEVICE_ATTR_RO(name);
>  static DEVICE_ATTR_RO(state);
>  
>  static struct attribute *fpga_mgr_attrs[] = {
> +	&dev_attr_capabilities.attr,
>  	&dev_attr_name.attr,
>  	&dev_attr_state.attr,
>  	NULL,
> diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
> index e73429c..9bb96a5 100644
> --- a/include/linux/fpga/fpga-mgr.h
> +++ b/include/linux/fpga/fpga-mgr.h
> @@ -108,6 +108,8 @@ static inline void __fpga_mgr_cap_set(enum fpga_mgr_capability cap,
>  	set_bit(cap, mask->bits);
>  }
>  
> +#define for_each_fpga_mgr_cap_mask(cap, mask) \
> +	for_each_set_bit(cap, mask.bits, FPGA_MGR_CAP_END)
>  
>  /**
>   * struct fpga_manager_ops - ops for low level fpga manager drivers
> -- 
> 2.10.0
> 
> 
