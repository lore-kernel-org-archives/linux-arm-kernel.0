From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Thu, 19 Jul 2012 15:28:12 +1000
Subject: linux-next: manual merge of the arm-soc tree with the i2c-embedded
 tree
Message-ID: <20120719152812.21ae228fd32fcc4a8ae651c1@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
drivers/i2c/busses/i2c-nomadik.c between commit 235602146ec9
("i2c-nomadik: turn the platform driver to an amba driver") from the
i2c-embedded tree and commit 98582d9562b4 ("ARM: ux500: Remove unused i2c
platform_data initialisation code") from the arm-soc tree.

Just context changes.  I fixed it up (see below) and can carry the fix as
necessary.
-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc drivers/i2c/busses/i2c-nomadik.c
index e6b93f3,a92440d..0000000
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@@ -969,12 -965,12 +969,11 @@@ static int nmk_i2c_probe(struct amba_de
  	adap->owner	= THIS_MODULE;
  	adap->class	= I2C_CLASS_HWMON | I2C_CLASS_SPD;
  	adap->algo	= &nmk_i2c_algo;
- 	adap->timeout	= pdata->timeout ? msecs_to_jiffies(pdata->timeout) :
- 		msecs_to_jiffies(20000);
+ 	adap->timeout	= msecs_to_jiffies(pdata->timeout);
 +	adap->nr = atomic_read(&adapter_id);
  	snprintf(adap->name, sizeof(adap->name),
 -		 "Nomadik I2C%d at %lx", pdev->id, (unsigned long)res->start);
 -
 -	/* fetch the controller id */
 -	adap->nr	= pdev->id;
 +		 "Nomadik I2C%d at %pR", adap->nr, &adev->res);
 +	atomic_inc(&adapter_id);
  
  	/* fetch the controller configuration from machine */
  	dev->cfg.clk_freq = pdata->clk_freq;
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120719/3098704a/attachment.sig>
