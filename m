From: chf.fritz@googlemail.com (Christoph Fritz)
Date: Thu, 23 Apr 2015 00:28:22 +0200
Subject: [BUG?] drivers: net:ethernet: cpsw: add support for VLAN
Message-ID: <1429741702.29353.28.camel@mars>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

 has commit 3b72c2fe0c6bbec42e ("drivers: net:ethernet: cpsw: add
support for VLAN") introduced a bug by defining CPSW_VLAN_AWARE as
BIT(1) instead of BIT(2)?

+#define CPSW_VLAN_AWARE		BIT(1)
<snip>
 	/* switch to vlan unaware mode */
-	cpsw_ale_control_set(priv->ale, 0, ALE_VLAN_AWARE, 0);
+	cpsw_ale_control_set(priv->ale, priv->host_port, ALE_VLAN_AWARE,
+			     CPSW_ALE_VLAN_AWARE);
+	control_reg = readl(&priv->regs->control);
+	control_reg |= CPSW_VLAN_AWARE;
+	writel(control_reg, &priv->regs->control);

See TRM [1] page 1980 (14.5.1.2 CONTROL Register), there bit
CPSW_VLAN_AWARE is number 2.

I didn't do any tests, just stumbled upon.

[1]: http://www.ti.com/lit/ug/spruh73l/spruh73l.pdf

Thanks
 -- Christoph
