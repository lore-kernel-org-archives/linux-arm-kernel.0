From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 26 Nov 2012 21:16:08 +1100
Subject: linux-next: manual merge of the arm-soc tree with the l2-mtd tree
Message-ID: <20121126211608.136f1371f3b662907a89deee@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
drivers/mtd/nand/mxc_nand.c between commit 06f255106923 ("mtd: remove use
of __devinit") from the l2-mtd tree and commit 4d62435f0601 ("mtd:
mxc_nand: remove cpu_is_xxx by using platform_device_id") from the
arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc drivers/mtd/nand/mxc_nand.c
index 4aef6a3,022dcdc..0000000
--- a/drivers/mtd/nand/mxc_nand.c
+++ b/drivers/mtd/nand/mxc_nand.c
@@@ -1337,33 -1378,7 +1378,7 @@@ static int __init mxcnd_probe_dt(struc
  }
  #endif
  
- static int __init mxcnd_probe_pdata(struct mxc_nand_host *host)
- {
- 	struct mxc_nand_platform_data *pdata = host->dev->platform_data;
- 
- 	if (!pdata)
- 		return -ENODEV;
- 
- 	host->pdata = *pdata;
- 
- 	if (nfc_is_v1()) {
- 		if (cpu_is_mx21())
- 			host->devtype_data = &imx21_nand_devtype_data;
- 		else
- 			host->devtype_data = &imx27_nand_devtype_data;
- 	} else if (nfc_is_v21()) {
- 		host->devtype_data = &imx25_nand_devtype_data;
- 	} else if (nfc_is_v3_2a()) {
- 		host->devtype_data = &imx51_nand_devtype_data;
- 	} else if (nfc_is_v3_2b()) {
- 		host->devtype_data = &imx53_nand_devtype_data;
- 	} else
- 		BUG();
- 
- 	return 0;
- }
- 
 -static int __devinit mxcnd_probe(struct platform_device *pdev)
 +static int mxcnd_probe(struct platform_device *pdev)
  {
  	struct nand_chip *this;
  	struct mtd_info *mtd;
@@@ -1555,8 -1578,9 +1578,9 @@@ static struct platform_driver mxcnd_dri
  		   .owner = THIS_MODULE,
  		   .of_match_table = of_match_ptr(mxcnd_dt_ids),
  	},
+ 	.id_table = mxcnd_devtype,
  	.probe = mxcnd_probe,
 -	.remove = __devexit_p(mxcnd_remove),
 +	.remove = mxcnd_remove,
  };
  module_platform_driver(mxcnd_driver);
  
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121126/5d86f9ad/attachment.sig>
