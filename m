From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Thu, 29 Aug 2013 17:56:29 +1000
Subject: linux-next: manual merge of the arm-soc tree with the v4l-dvb tree
Message-ID: <20130829175629.2f0b6904c481690cc69a582c@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/mach-shmobile/setup-r8a7778.c between commit 803c2df21752
("[media] ARM: shmobile: r8a7778: add VIN support") from the v4l-dvb tree
and commits cfa66a81621d ("ARM: shmobile: bockw: add DT reference") and
a66c9744574c ("ARM: shmobile: r8a7778: cleanup registration of mmcif")
from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-shmobile/setup-r8a7778.c
index 0174f05,604cf36..0000000
--- a/arch/arm/mach-shmobile/setup-r8a7778.c
+++ b/arch/arm/mach-shmobile/setup-r8a7778.c
@@@ -319,55 -281,7 +281,41 @@@ void __init r8a7778_register_hspi(int i
  		hspi_resources + (2 * id), 2);
  }
  
- /* MMC */
- static struct resource mmc_resources[] __initdata = {
- 	DEFINE_RES_MEM(0xffe4e000, 0x100),
- 	DEFINE_RES_IRQ(gic_iid(0x5d)),
- };
- 
- void __init r8a7778_add_mmc_device(struct sh_mmcif_plat_data *info)
- {
- 	platform_device_register_resndata(
- 		&platform_bus, "sh_mmcif", -1,
- 		mmc_resources, ARRAY_SIZE(mmc_resources),
- 		info, sizeof(*info));
- }
- 
 +/* VIN */
 +#define R8A7778_VIN(idx)						\
 +static struct resource vin##idx##_resources[] __initdata = {		\
 +	DEFINE_RES_MEM(0xffc50000 + 0x1000 * (idx), 0x1000),		\
 +	DEFINE_RES_IRQ(gic_iid(0x5a)),					\
 +};									\
 +									\
 +static struct platform_device_info vin##idx##_info __initdata = {	\
 +	.parent		= &platform_bus,				\
 +	.name		= "r8a7778-vin",				\
 +	.id		= idx,						\
 +	.res		= vin##idx##_resources,				\
 +	.num_res	= ARRAY_SIZE(vin##idx##_resources),		\
 +	.dma_mask	= DMA_BIT_MASK(32),				\
 +}
 +
 +R8A7778_VIN(0);
 +R8A7778_VIN(1);
 +
 +static struct platform_device_info *vin_info_table[] __initdata = {
 +	&vin0_info,
 +	&vin1_info,
 +};
 +
 +void __init r8a7778_add_vin_device(int id, struct rcar_vin_platform_data *pdata)
 +{
 +	BUG_ON(id < 0 || id > 1);
 +
 +	vin_info_table[id]->data = pdata;
 +	vin_info_table[id]->size_data = sizeof(*pdata);
 +
 +	platform_device_register_full(vin_info_table[id]);
 +}
 +
- void __init r8a7778_add_standard_devices(void)
+ void __init r8a7778_add_dt_devices(void)
  {
  	int i;
  
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130829/515460d5/attachment.sig>
