From: neilb@suse.de (NeilBrown)
Date: Mon, 9 Jan 2012 17:15:54 +1100
Subject: [PATCH] ARM: omap: add rcu_locking to omap2_set_init_voltage.
Message-ID: <20120109171554.7f8538d6@notabene.brown>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


opp_find_freq_ceil and opp_get_voltage are documented as requiring
rcu_lock to be held.  So hold it.

Signed-off-by: NeilBrown <neilb@suse.de>

--
This time with the proper ARM: prefix  - sorry :-(


diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 00bff46..470976e 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -174,14 +174,17 @@ static int __init omap2_set_init_voltage(char *vdd_name, char *clk_name,
 	freq = clk->rate;
 	clk_put(clk);
 
+	rcu_read_lock();
 	opp = opp_find_freq_ceil(dev, &freq);
 	if (IS_ERR(opp)) {
+		rcu_read_unlock();
 		pr_err("%s: unable to find boot up OPP for vdd_%s\n",
 			__func__, vdd_name);
 		goto exit;
 	}
 
 	bootup_volt = opp_get_voltage(opp);
+	rcu_read_unlock();
 	if (!bootup_volt) {
 		pr_err("%s: unable to find voltage corresponding "
 			"to the bootup OPP for vdd_%s\n", __func__, vdd_name);

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 828 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120109/1a8b810b/attachment.sig>
