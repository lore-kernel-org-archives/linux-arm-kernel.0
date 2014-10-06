From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Mon, 6 Oct 2014 08:59:27 -0700
Subject: [PATCH 3/3] ARM: zynq: Extend SLCR driver to read OCM
 configuration
In-Reply-To: <586ef67a22005316fd65cebbbd4019a8a2094e07.1412595859.git.michal.simek@xilinx.com>
References: <565908c2d70764e281d6a9b28d9599cea87823a3.1412595859.git.michal.simek@xilinx.com>
 <586ef67a22005316fd65cebbbd4019a8a2094e07.1412595859.git.michal.simek@xilinx.com>
Message-ID: <30d758b569504e88a9b4a999f08be17b@BN1AFFO11FD055.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michal,

On Mon, 2014-10-06 at 01:44PM +0200, Michal Simek wrote:
> Get OCM configuration from SLCR.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
>  arch/arm/mach-zynq/slcr.c | 15 +++++++++++++++
>  include/soc/zynq/common.h |  1 +
>  2 files changed, 16 insertions(+)
> 
> diff --git a/arch/arm/mach-zynq/slcr.c b/arch/arm/mach-zynq/slcr.c
> index cb7c46165728..0c3e45090c09 100644
> --- a/arch/arm/mach-zynq/slcr.c
> +++ b/arch/arm/mach-zynq/slcr.c
> @@ -27,6 +27,7 @@
>  #define SLCR_A9_CPU_RST_CTRL_OFFSET	0x244 /* CPU Software Reset Control */
>  #define SLCR_REBOOT_STATUS_OFFSET	0x258 /* PS Reboot Status */
>  #define SLCR_PSS_IDCODE			0x530 /* PS IDCODE */
> +#define SLCR_OCM_CFG_OFFSET		0x910 /* OCM Address Mapping */
> 
>  #define SLCR_UNLOCK_MAGIC		0xDF0D
>  #define SLCR_A9_CPU_CLKSTOP		0x10
> @@ -126,6 +127,20 @@ void zynq_slcr_system_reset(void)
>  }
> 
>  /**
> + * zynq_slcr_get_ocm_config - Get SLCR OCM config
> + *
> + * Return:	OCM config bits
> + */
> +u32 zynq_slcr_get_ocm_config(void)
> +{
> +	u32 val;
> +
> +	zynq_slcr_read(&val, SLCR_OCM_CFG_OFFSET);
> +
> +	return val;
> +}

a different idea would be, instead of creating this specific API call
for the OCMC to let the OCMC driver use regmap and making git a subnode
of the SLCR.
In the long run that might be a better option otherwise we'll end up
with a whole bunch of zynq_slcr_get_foo() calls for each driver that
needs to read an SLCR register.

	Thanks,
	S?ren
