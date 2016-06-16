From: horms@verge.net.au (Simon Horman)
Date: Thu, 16 Jun 2016 10:26:03 +0900
Subject: [PATCH v2 0/4] ARM: dts: r8a7790: lager: use demuxer for I2C
In-Reply-To: <20160613143134.GB1603@katana>
References: <1465370066-8450-1-git-send-email-horms+renesas@verge.net.au>
 <20160613143134.GB1603@katana>
Message-ID: <20160616012600.GA4745@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 13, 2016 at 04:31:34PM +0200, Wolfram Sang wrote:
> 
> >    # ./exercise-i2c-demux.sh
> >    I2C Demux: i2c-8
> >      Master: 1:/i2c at e650800
> >    [   97.694487] i2c-rcar e6508000.i2c: probed 0 (1)
> >      Master: 0:/i2c at e650000
> >    [  102.706365] i2c-demux-pinctrl i2c-8: failed to setup demux-adapter 0 (-19) 0 (0)
> 
> Confirmed :( Got today only this far that the ENODEV comes from the PFC
> driver. CONFIG_DEBUG_PINCTRL is a good idea for further debugging
> probably.

I tried to track this down and my findings so far are a bit puzzling.

It seems to me that the first and only item of the "pinctrl-names" property
(a.k.a. statename) retrieved for i2c at e6508000 changes from i2c-exio0 to
i2c-exio1. Perhaps it really is overwritten for some reason. Or perhaps
there is a stale pointer.  Or perhaps I am chasing the wrong thing. But in
any case my observation is illustrated using the debug patch below.

I am testing using only the first two patches of the series applied on top
of renesas-devel-20160614-v4.7-rc3, that is the only demux devices are
i2c-exio0 and i2c-exio1.

I am using shmobile_defconfig, with CONFIG_DEBUG_PINCTRL enabled.

I am examining only i2c-8, i2c-exio0.

1. At probe time the first parent, 0:/i2c at e6500000

   i2c-demux-pinctrl i2c-8: i2c_demux_activate_master chan:0 bus_name:i2c-exio0 np->full_name/i2c at e6500000 np:ef7db76c statename:i2c-exio0
   i2c-demux-pinctrl i2c-8: i2c_demux_activate_master chan:1 bus_name:i2c-exio0 np->full_name/i2c at e6508000 np:ef7dabfc statename:i2c-exio0

2. At run time I select the second parent, 1:/i2c at e6508000.
   This works. But the statename of i2c at e6500000 is already i2c-exio1.

   i2c-demux-pinctrl i2c-8: i2c_demux_deactivate_master chan:0 bus_name:i2c-exio0 np->full_name:/i2c at e6500000 np:ef7db76c statename:i2c-exio1
   i2c-demux-pinctrl i2c-8: i2c_demux_deactivate_master chan:1 bus_name:i2c-exio0 np->full_name:/i2c at e6508000 np:ef7dabfc statename:i2c-exio0

   i2c-demux-pinctrl i2c-8: i2c_demux_activate_master chan:0 bus_name:i2c-exio0 np->full_name:/i2c at e6500000 np:ef7db76c statename:i2c-exio1
   i2c-demux-pinctrl i2c-8: i2c_demux_activate_master chan:1 bus_name:i2c-exio0 np->full_name:/i2c at e6508000 np:ef7dabfc statename:i2c-exio0

3. At run time I re-select the first parent, 0:/i2c at e6500000.
   This fails as described above. The new debug code shows.

   i2c-demux-pinctrl i2c-8: i2c_demux_deactivate_master chan:0 bus_name:i2c-exio0 np->full_name:/i2c at e6500000 np:ef7db76c statename:i2c-exio1
   34.700444] i2c-demux-pinctrl i2c-8: i2c_demux_deactivate_master chan:1 bus_name:i2c-exio0 np->full_name:/i2c at e6508000 np:ef7dabfc statename:i2c-exio0

   [i2c_demux_deactivate_master exits before reaching debug code,
    but I have previously observed that statename is i2c-exio1
    for i2c at e6500000]


> >    3.1 Unfortunately it fails for the I2C2 dmux if the GPIO fallback is
> >        present.
> 
> Hopefully the same issue.

Hopefully :)

> >    3.2 The test also fails for the I2C3 demux but that appears to be due
> >        to a shortcoming in the voltage regulator code which does not
> >        appear to like being reinitialised. The kernel complains as follows:
> 
> Yes, the demuxer trigger re-bind cycles which are not well considered
> and/or tested. E.g. for soc-camera, this patch needed to go upstream:
> 
> https://patchwork.linuxtv.org/patch/32473/

Understood. It looks like there is some more work to be done but from my
point of view fixing individual drivers is less critical than resolving
the switching issue(s) above. I think the order things are described
is probably the order in which they should be addressed.


diff --git a/drivers/i2c/muxes/i2c-demux-pinctrl.c b/drivers/i2c/muxes/i2c-demux-pinctrl.c
index 8de073aed001..8a54380a9e0c 100644
--- a/drivers/i2c/muxes/i2c-demux-pinctrl.c
+++ b/drivers/i2c/muxes/i2c-demux-pinctrl.c
@@ -55,6 +55,27 @@ static u32 i2c_demux_functionality(struct i2c_adapter *adap)
 	return parent->algo->functionality(parent);
 }
 
+static int dbg_show(const char *prefix, struct i2c_demux_pinctrl_priv *priv)
+{
+	int i;
+
+	for (i = 0; i < priv->num_chan; i++) {
+		struct device_node *np;
+		const char *statename;
+		int ret;
+
+		np = priv->chan[i].parent_np;
+
+		ret = of_property_read_string_index(np, "pinctrl-names",
+						    0, &statename);
+		if (ret)
+			statename = "<error>";
+		dev_err(priv->dev, "%s chan:%d bus_name:%s np->full_name:%s "
+			"np:%p statename:%s\n", prefix, i, priv->bus_name,
+			np->full_name, np, statename);
+	}
+}
+
 static int i2c_demux_activate_master(struct i2c_demux_pinctrl_priv *priv, u32 new_chan)
 {
 	struct i2c_adapter *adap;
@@ -99,6 +120,7 @@ static int i2c_demux_activate_master(struct i2c_demux_pinctrl_priv *priv, u32 ne
 	if (ret < 0)
 		goto err_with_put;
 
+	dbg_show(__func__, priv);
 	return 0;
 
  err_with_put:
@@ -115,6 +137,8 @@ static int i2c_demux_deactivate_master(struct i2c_demux_pinctrl_priv *priv)
 	if (cur < 0)
 		return 0;
 
+	dbg_show(__func__, priv);
+
 	i2c_del_adapter(&priv->cur_adap);
 	i2c_put_adapter(priv->chan[cur].parent_adap);
 
