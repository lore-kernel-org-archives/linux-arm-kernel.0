From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 27 May 2014 10:52:48 +1000
Subject: linux-next: manual merge of the arm-soc tree with the arm tree
Message-ID: <20140527105248.546d95bf@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/mach-zynq/common.c between commit e1e4ccb5b1b6 ("ARM: l2c:
zynq: convert to generic l2c OF initialisation") from the arm tree and
commit 00f7dc636366 ("ARM: zynq: Add support for SOC_BUS") from the
arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-zynq/common.c
index d1e992e6403e,edbd9d83f407..000000000000
--- a/arch/arm/mach-zynq/common.c
+++ b/arch/arm/mach-zynq/common.c
@@@ -66,8 -105,43 +105,38 @@@ static int __init zynq_get_revision(voi
  static void __init zynq_init_machine(void)
  {
  	struct platform_device_info devinfo = { .name = "cpufreq-cpu0", };
+ 	struct soc_device_attribute *soc_dev_attr;
+ 	struct soc_device *soc_dev;
+ 	struct device *parent = NULL;
+ 
 -	/*
 -	 * 64KB way size, 8-way associativity, parity disabled
 -	 */
 -	l2x0_of_init(0x02060000, 0xF0F0FFFF);
 -
+ 	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
+ 	if (!soc_dev_attr)
+ 		goto out;
+ 
+ 	system_rev = zynq_get_revision();
+ 
+ 	soc_dev_attr->family = kasprintf(GFP_KERNEL, "Xilinx Zynq");
+ 	soc_dev_attr->revision = kasprintf(GFP_KERNEL, "0x%x", system_rev);
+ 	soc_dev_attr->soc_id = kasprintf(GFP_KERNEL, "0x%x",
+ 					 zynq_slcr_get_device_id());
+ 
+ 	soc_dev = soc_device_register(soc_dev_attr);
+ 	if (IS_ERR(soc_dev)) {
+ 		kfree(soc_dev_attr->family);
+ 		kfree(soc_dev_attr->revision);
+ 		kfree(soc_dev_attr->soc_id);
+ 		kfree(soc_dev_attr);
+ 		goto out;
+ 	}
+ 
+ 	parent = soc_device_to_device(soc_dev);
  
- 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+ out:
+ 	/*
+ 	 * Finished with the static registrations now; fill in the missing
+ 	 * devices
+ 	 */
+ 	of_platform_populate(NULL, of_default_bus_match_table, NULL, parent);
  
  	platform_device_register(&zynq_cpuidle_device);
  	platform_device_register_full(&devinfo);
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140527/29b40634/attachment.sig>
