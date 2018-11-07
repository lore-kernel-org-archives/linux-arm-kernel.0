From: horia.geanta@nxp.com (Horia Geanta)
Date: Wed, 7 Nov 2018 12:07:40 +0000
Subject: [PATCH v1 1/2] bus: mc-bus: Add support for mapping shareable
 portals
References: <1540931418-10697-1-git-send-email-roy.pledge@nxp.com>
 <1540931418-10697-2-git-send-email-roy.pledge@nxp.com>
Message-ID: <VI1PR0402MB3485275B1CB9D52F5E902D2398C40@VI1PR0402MB3485.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/30/2018 10:31 PM, Roy Pledge wrote:
> Starting with v5 of NXP QBMan devices the hardware supports using
> regular cacheable/shareable memory as the backing store for the
> portals.
> 
> This patch adds support for the new portal mode by switching to
> use the DPRC get object region v2 command which returns both
> a base address and offset for the portal memory. The new portal
> region is identified as shareable through the addition of a new
> flag.
> 
> Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
> ---
>  drivers/bus/fsl-mc/dprc.c           |  3 ++-
>  drivers/bus/fsl-mc/fsl-mc-bus.c     | 14 ++++++++++++--
>  drivers/bus/fsl-mc/fsl-mc-private.h | 17 ++++++++++++++---
>  3 files changed, 28 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/bus/fsl-mc/dprc.c b/drivers/bus/fsl-mc/dprc.c
> index 1c3f621..bde856d 100644
> --- a/drivers/bus/fsl-mc/dprc.c
> +++ b/drivers/bus/fsl-mc/dprc.c
> @@ -461,8 +461,9 @@ int dprc_get_obj_region(struct fsl_mc_io *mc_io,
>  
>  	/* retrieve response parameters */
>  	rsp_params = (struct dprc_rsp_get_obj_region *)cmd.params;
> -	region_desc->base_offset = le64_to_cpu(rsp_params->base_addr);
> +	region_desc->base_offset = le64_to_cpu(rsp_params->base_offset);
>  	region_desc->size = le32_to_cpu(rsp_params->size);
> +	region_desc->base_address = le64_to_cpu(rsp_params->base_addr);
>  
>  	return 0;
>  }
> diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
> index f0404c6..25ad422 100644
> --- a/drivers/bus/fsl-mc/fsl-mc-bus.c
> +++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
> @@ -487,10 +487,18 @@ static int fsl_mc_device_get_mmio_regions(struct fsl_mc_device *mc_dev,
>  				"dprc_get_obj_region() failed: %d\n", error);
>  			goto error_cleanup_regions;
>  		}
> -
> -		error = translate_mc_addr(mc_dev, mc_region_type,
> +		/* Older MC only returned region offset and no base address
Nitpick: comment style is not consistent with existing code in fsl-mc.

> +		 * If base address is in the region_desc use it otherwise
> +		 * revert to old mechanism
> +		 */
> +		if (region_desc.base_address)
> +			regions[i].start = region_desc.base_address +
> +						region_desc.base_offset;
> +		else
> +			error = translate_mc_addr(mc_dev, mc_region_type,
>  					  region_desc.base_offset,
>  					  &regions[i].start);
> +
>  		if (error < 0) {
>  			dev_err(parent_dev,
>  				"Invalid MC offset: %#x (for %s.%d\'s region %d)\n",
> @@ -504,6 +512,8 @@ static int fsl_mc_device_get_mmio_regions(struct fsl_mc_device *mc_dev,
>  		regions[i].flags = IORESOURCE_IO;
>  		if (region_desc.flags & DPRC_REGION_CACHEABLE)
>  			regions[i].flags |= IORESOURCE_CACHEABLE;
> +		if (region_desc.flags & DPRC_REGION_SHAREABLE)
> +			regions[i].flags |= IORESOURCE_MEM;
>  	}
>  
>  	mc_dev->regions = regions;
> diff --git a/drivers/bus/fsl-mc/fsl-mc-private.h b/drivers/bus/fsl-mc/fsl-mc-private.h
> index ea11b4f..28e40d1 100644
> --- a/drivers/bus/fsl-mc/fsl-mc-private.h
> +++ b/drivers/bus/fsl-mc/fsl-mc-private.h
> @@ -79,9 +79,11 @@ int dpmcp_reset(struct fsl_mc_io *mc_io,
>  
>  /* DPRC command versioning */
>  #define DPRC_CMD_BASE_VERSION			1
> +#define DPRC_CMD_2ND_VERSION			2
>  #define DPRC_CMD_ID_OFFSET			4
>  
>  #define DPRC_CMD(id)	(((id) << DPRC_CMD_ID_OFFSET) | DPRC_CMD_BASE_VERSION)
> +#define DPRC_CMD_V2(id)	(((id) << DPRC_CMD_ID_OFFSET) | DPRC_CMD_2ND_VERSION)
>  
>  /* DPRC command IDs */
>  #define DPRC_CMDID_CLOSE                        DPRC_CMD(0x800)
> @@ -99,7 +101,7 @@ int dpmcp_reset(struct fsl_mc_io *mc_io,
>  #define DPRC_CMDID_GET_CONT_ID                  DPRC_CMD(0x830)
>  #define DPRC_CMDID_GET_OBJ_COUNT                DPRC_CMD(0x159)
>  #define DPRC_CMDID_GET_OBJ                      DPRC_CMD(0x15A)
> -#define DPRC_CMDID_GET_OBJ_REG                  DPRC_CMD(0x15E)
> +#define DPRC_CMDID_GET_OBJ_REG                  DPRC_CMD_V2(0x15E)
>  #define DPRC_CMDID_SET_OBJ_IRQ                  DPRC_CMD(0x15F)
>  
>  struct dprc_cmd_open {
> @@ -199,9 +201,15 @@ struct dprc_rsp_get_obj_region {
>  	/* response word 0 */
>  	__le64 pad;
>  	/* response word 1 */
> -	__le64 base_addr;
> +	__le64 base_offset;
>  	/* response word 2 */
>  	__le32 size;
> +	u8 pad2[3];
Padding size (3B) is incorrect.

Either add 4B of padding:
__le32 pad2;

or expose the "type" field:
u8 type;
u8 pad2[3];

> +	/* response word 3 */
> +	__le32 flags;
> +	__le32 pad3;
> +	/* response word 4 */
> +	__le64 base_addr;
>  };
>  
>  struct dprc_cmd_set_obj_irq {
> @@ -334,6 +342,7 @@ int dprc_set_obj_irq(struct fsl_mc_io *mc_io,
>  /* Region flags */
>  /* Cacheable - Indicates that region should be mapped as cacheable */
>  #define DPRC_REGION_CACHEABLE	0x00000001
> +#define DPRC_REGION_SHAREABLE	0x00000002
>  
The new flag should be added in documentation (DPAA2 UM).

Regards,
Horia
