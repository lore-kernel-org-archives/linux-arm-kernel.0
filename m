From: guillaume.tucker@collabora.com (Guillaume Tucker)
Date: Thu, 11 Jan 2018 10:44:19 +0000
Subject: net-next/master boot bisection: v4.15-rc7-1221-g45f8982 on
 sama53d #4343-staging
In-Reply-To: <1961011202.207.1515665766663.JavaMail.jenkins@ip-172-30-0-246>
References: <1961011202.207.1515665766663.JavaMail.jenkins@ip-172-30-0-246>
Message-ID: <33c642a0-ba8d-d942-14ae-8e112befd4d4@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Please see below - the kernelci.org automated bisection tool has
found this commit caused a boot failure on one platform in the
Free Electrons lab.  Several bisections pointed to the same
commit over the past couple of days, with various kernel configs.

More details about the boot failure can be found here:

   https://staging.kernelci.org/boot/all/job/net-next/branch/master/kernel/v4.15-rc5-999-gfea23fb-lava-bisect-v2-b-staging-4343-8/

Full boot log:

   http://staging-storage.kernelci.org/net-next/master/v4.15-rc5-999-gfea23fb-lava-bisect-v2-b-staging-4343-8/arm/multi_v7_defconfig/lab-free-electrons-dev/boot-at91-sama5d3_xplained.html

It looks like a network interface initialisation error on this
platform.  I haven't investigated any further and the automated
bisection tool is still experimental, so please take this with a
pinch of salt and sorry if this patch isn't the actual culprit.

Hope this helps!

Guillaume


On 11/01/18 10:16, kernelci.org bot wrote:
> Bisection result for net-next/master (v4.15-rc7-1221-g45f8982) on sama53d
> 
> Good known revision:
> 
>      72bca20 liquidio: Use zeroing memory allocator than allocator/memset
> 
> Bad known revision:
> 
>      45f8982 Merge branch 'hns3-next'
> 
> Extra parameters:
> 
>      Tree:      net-next
>      URL:       git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git
>      Branch:    master
>      Target:    sama53d
>      Lab:       lab-free-electrons
>      Defconfig: multi_v7_defconfig
>      Plan:      boot
> 
> 
> Breaking commit found:
> 
> -------------------------------------------------------------------------------
> commit fea23fb591cce99546baca043d2a068228e87a79
> Author: Russell King <rmk+kernel@armlinux.org.uk>
> Date:   Tue Jan 2 10:58:58 2018 +0000
> 
>      net: phy: convert read-modify-write to phy_modify()
>      
>      Convert read-modify-write sequences in at803x, Marvell and core phylib
>      to use phy_modify() to ensure safety.
>      
>      Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
>      Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>      Signed-off-by: David S. Miller <davem@davemloft.net>
> 
> diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
> index 1e190f3b..c271590 100644
> --- a/drivers/net/phy/at803x.c
> +++ b/drivers/net/phy/at803x.c
> @@ -215,34 +215,22 @@ static int at803x_suspend(struct phy_device *phydev)
>   	int value;
>   	int wol_enabled;
>   
> -	mutex_lock(&phydev->lock);
> -
>   	value = phy_read(phydev, AT803X_INTR_ENABLE);
>   	wol_enabled = value & AT803X_INTR_ENABLE_WOL;
>   
> -	value = phy_read(phydev, MII_BMCR);
> -
>   	if (wol_enabled)
> -		value |= BMCR_ISOLATE;
> +		value = BMCR_ISOLATE;
>   	else
> -		value |= BMCR_PDOWN;
> +		value = BMCR_PDOWN;
>   
> -	phy_write(phydev, MII_BMCR, value);
> -
> -	mutex_unlock(&phydev->lock);
> +	phy_modify(phydev, MII_BMCR, 0, value);
>   
>   	return 0;
>   }
>   
>   static int at803x_resume(struct phy_device *phydev)
>   {
> -	int value;
> -
> -	value = phy_read(phydev, MII_BMCR);
> -	value &= ~(BMCR_PDOWN | BMCR_ISOLATE);
> -	phy_write(phydev, MII_BMCR, value);
> -
> -	return 0;
> +	return phy_modify(phydev, MII_BMCR, ~(BMCR_PDOWN | BMCR_ISOLATE), 0);
>   }
>   
>   static int at803x_probe(struct phy_device *phydev)
> diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
> index ac39d90..2bd3896 100644
> --- a/drivers/net/phy/marvell.c
> +++ b/drivers/net/phy/marvell.c
> @@ -471,7 +471,7 @@ static int m88e1121_config_aneg(struct phy_device *phydev)
>   
>   	if (phy_interface_is_rgmii(phydev)) {
>   		err = m88e1121_config_aneg_rgmii_delays(phydev);
> -		if (err)
> +		if (err < 0)
>   			return err;
>   	}
>   
> @@ -664,19 +664,14 @@ static int m88e1116r_config_init(struct phy_device *phydev)
>   
>   static int m88e3016_config_init(struct phy_device *phydev)
>   {
> -	int reg;
> +	int ret;
>   
>   	/* Enable Scrambler and Auto-Crossover */
> -	reg = phy_read(phydev, MII_88E3016_PHY_SPEC_CTRL);
> -	if (reg < 0)
> -		return reg;
> -
> -	reg &= ~MII_88E3016_DISABLE_SCRAMBLER;
> -	reg |= MII_88E3016_AUTO_MDIX_CROSSOVER;
> -
> -	reg = phy_write(phydev, MII_88E3016_PHY_SPEC_CTRL, reg);
> -	if (reg < 0)
> -		return reg;
> +	ret = phy_modify(phydev, MII_88E3016_PHY_SPEC_CTRL,
> +			 ~MII_88E3016_DISABLE_SCRAMBLER,
> +			 MII_88E3016_AUTO_MDIX_CROSSOVER);
> +	if (ret < 0)
> +		return ret;
>   
>   	return marvell_config_init(phydev);
>   }
> @@ -685,42 +680,34 @@ static int m88e1111_config_init_hwcfg_mode(struct phy_device *phydev,
>   					   u16 mode,
>   					   int fibre_copper_auto)
>   {
> -	int temp;
> -
> -	temp = phy_read(phydev, MII_M1111_PHY_EXT_SR);
> -	if (temp < 0)
> -		return temp;
> -
> -	temp &= ~(MII_M1111_HWCFG_MODE_MASK |
> -		  MII_M1111_HWCFG_FIBER_COPPER_AUTO |
> -		  MII_M1111_HWCFG_FIBER_COPPER_RES);
> -	temp |= mode;
> -
>   	if (fibre_copper_auto)
> -		temp |= MII_M1111_HWCFG_FIBER_COPPER_AUTO;
> +		mode |= MII_M1111_HWCFG_FIBER_COPPER_AUTO;
>   
> -	return phy_write(phydev, MII_M1111_PHY_EXT_SR, temp);
> +	return phy_modify(phydev, MII_M1111_PHY_EXT_SR,
> +			  (u16)~(MII_M1111_HWCFG_MODE_MASK |
> +				 MII_M1111_HWCFG_FIBER_COPPER_AUTO |
> +				 MII_M1111_HWCFG_FIBER_COPPER_RES),
> +			  mode);
>   }
>   
>   static int m88e1111_config_init_rgmii_delays(struct phy_device *phydev)
>   {
> -	int temp;
> -
> -	temp = phy_read(phydev, MII_M1111_PHY_EXT_CR);
> -	if (temp < 0)
> -		return temp;
> +	int delay;
>   
>   	if (phydev->interface == PHY_INTERFACE_MODE_RGMII_ID) {
> -		temp |= (MII_M1111_RGMII_RX_DELAY | MII_M1111_RGMII_TX_DELAY);
> +		delay = MII_M1111_RGMII_RX_DELAY | MII_M1111_RGMII_TX_DELAY;
>   	} else if (phydev->interface == PHY_INTERFACE_MODE_RGMII_RXID) {
> -		temp &= ~MII_M1111_RGMII_TX_DELAY;
> -		temp |= MII_M1111_RGMII_RX_DELAY;
> +		delay = MII_M1111_RGMII_RX_DELAY;
>   	} else if (phydev->interface == PHY_INTERFACE_MODE_RGMII_TXID) {
> -		temp &= ~MII_M1111_RGMII_RX_DELAY;
> -		temp |= MII_M1111_RGMII_TX_DELAY;
> +		delay = MII_M1111_RGMII_TX_DELAY;
> +	} else {
> +		delay = 0;
>   	}
>   
> -	return phy_write(phydev, MII_M1111_PHY_EXT_CR, temp);
> +	return phy_modify(phydev, MII_M1111_PHY_EXT_CR,
> +			  (u16)~(MII_M1111_RGMII_RX_DELAY |
> +				 MII_M1111_RGMII_TX_DELAY),
> +			  delay);
>   }
>   
>   static int m88e1111_config_init_rgmii(struct phy_device *phydev)
> @@ -766,7 +753,7 @@ static int m88e1111_config_init_rtbi(struct phy_device *phydev)
>   	int err;
>   
>   	err = m88e1111_config_init_rgmii_delays(phydev);
> -	if (err)
> +	if (err < 0)
>   		return err;
>   
>   	err = m88e1111_config_init_hwcfg_mode(
> @@ -793,7 +780,7 @@ static int m88e1111_config_init(struct phy_device *phydev)
>   
>   	if (phy_interface_is_rgmii(phydev)) {
>   		err = m88e1111_config_init_rgmii(phydev);
> -		if (err)
> +		if (err < 0)
>   			return err;
>   	}
>   
> @@ -834,7 +821,6 @@ static int m88e1121_config_init(struct phy_device *phydev)
>   static int m88e1510_config_init(struct phy_device *phydev)
>   {
>   	int err;
> -	int temp;
>   
>   	/* SGMII-to-Copper mode initialization */
>   	if (phydev->interface == PHY_INTERFACE_MODE_SGMII) {
> @@ -846,16 +832,15 @@ static int m88e1510_config_init(struct phy_device *phydev)
>   			return err;
>   
>   		/* In reg 20, write MODE[2:0] = 0x1 (SGMII to Copper) */
> -		temp = phy_read(phydev, MII_88E1510_GEN_CTRL_REG_1);
> -		temp &= ~MII_88E1510_GEN_CTRL_REG_1_MODE_MASK;
> -		temp |= MII_88E1510_GEN_CTRL_REG_1_MODE_SGMII;
> -		err = phy_write(phydev, MII_88E1510_GEN_CTRL_REG_1, temp);
> +		err = phy_modify(phydev, MII_88E1510_GEN_CTRL_REG_1,
> +				 ~MII_88E1510_GEN_CTRL_REG_1_MODE_MASK,
> +				 MII_88E1510_GEN_CTRL_REG_1_MODE_SGMII);
>   		if (err < 0)
>   			return err;
>   
>   		/* PHY reset is necessary after changing MODE[2:0] */
> -		temp |= MII_88E1510_GEN_CTRL_REG_1_RESET;
> -		err = phy_write(phydev, MII_88E1510_GEN_CTRL_REG_1, temp);
> +		err = phy_modify(phydev, MII_88E1510_GEN_CTRL_REG_1, 0,
> +				 MII_88E1510_GEN_CTRL_REG_1_RESET);
>   		if (err < 0)
>   			return err;
>   
> @@ -961,7 +946,6 @@ static int m88e1149_config_init(struct phy_device *phydev)
>   
>   static int m88e1145_config_init_rgmii(struct phy_device *phydev)
>   {
> -	int temp;
>   	int err;
>   
>   	err = m88e1111_config_init_rgmii_delays(phydev);
> @@ -973,15 +957,9 @@ static int m88e1145_config_init_rgmii(struct phy_device *phydev)
>   		if (err < 0)
>   			return err;
>   
> -		temp = phy_read(phydev, 0x1e);
> -		if (temp < 0)
> -			return temp;
> -
> -		temp &= 0xf03f;
> -		temp |= 2 << 9;	/* 36 ohm */
> -		temp |= 2 << 6;	/* 39 ohm */
> -
> -		err = phy_write(phydev, 0x1e, temp);
> +		err = phy_modify(phydev, 0x1e, 0xf03f,
> +				 2 << 9 | /* 36 ohm */
> +				 2 << 6); /* 39 ohm */
>   		if (err < 0)
>   			return err;
>   
> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index be13b5d..2c5b2e0 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -1368,9 +1368,8 @@ static int genphy_config_eee_advert(struct phy_device *phydev)
>    */
>   int genphy_setup_forced(struct phy_device *phydev)
>   {
> -	int ctl = phy_read(phydev, MII_BMCR);
> +	u16 ctl = 0;
>   
> -	ctl &= BMCR_LOOPBACK | BMCR_ISOLATE | BMCR_PDOWN;
>   	phydev->pause = 0;
>   	phydev->asym_pause = 0;
>   
> @@ -1382,7 +1381,8 @@ int genphy_setup_forced(struct phy_device *phydev)
>   	if (DUPLEX_FULL == phydev->duplex)
>   		ctl |= BMCR_FULLDPLX;
>   
> -	return phy_write(phydev, MII_BMCR, ctl);
> +	return phy_modify(phydev, MII_BMCR,
> +			  BMCR_LOOPBACK | BMCR_ISOLATE | BMCR_PDOWN, ctl);
>   }
>   EXPORT_SYMBOL(genphy_setup_forced);
>   
> @@ -1392,17 +1392,9 @@ EXPORT_SYMBOL(genphy_setup_forced);
>    */
>   int genphy_restart_aneg(struct phy_device *phydev)
>   {
> -	int ctl = phy_read(phydev, MII_BMCR);
> -
> -	if (ctl < 0)
> -		return ctl;
> -
> -	ctl |= BMCR_ANENABLE | BMCR_ANRESTART;
> -
>   	/* Don't isolate the PHY if we're negotiating */
> -	ctl &= ~BMCR_ISOLATE;
> -
> -	return phy_write(phydev, MII_BMCR, ctl);
> +	return phy_modify(phydev, MII_BMCR, ~BMCR_ISOLATE,
> +			  BMCR_ANENABLE | BMCR_ANRESTART);
>   }
>   EXPORT_SYMBOL(genphy_restart_aneg);
>   
> @@ -1668,44 +1660,20 @@ EXPORT_SYMBOL(genphy_config_init);
>   
>   int genphy_suspend(struct phy_device *phydev)
>   {
> -	int value;
> -
> -	mutex_lock(&phydev->lock);
> -
> -	value = phy_read(phydev, MII_BMCR);
> -	phy_write(phydev, MII_BMCR, value | BMCR_PDOWN);
> -
> -	mutex_unlock(&phydev->lock);
> -
> -	return 0;
> +	return phy_modify(phydev, MII_BMCR, 0, BMCR_PDOWN);
>   }
>   EXPORT_SYMBOL(genphy_suspend);
>   
>   int genphy_resume(struct phy_device *phydev)
>   {
> -	int value;
> -
> -	value = phy_read(phydev, MII_BMCR);
> -	phy_write(phydev, MII_BMCR, value & ~BMCR_PDOWN);
> -
> -	return 0;
> +	return phy_modify(phydev, MII_BMCR, ~BMCR_PDOWN, 0);
>   }
>   EXPORT_SYMBOL(genphy_resume);
>   
>   int genphy_loopback(struct phy_device *phydev, bool enable)
>   {
> -	int value;
> -
> -	value = phy_read(phydev, MII_BMCR);
> -	if (value < 0)
> -		return value;
> -
> -	if (enable)
> -		value |= BMCR_LOOPBACK;
> -	else
> -		value &= ~BMCR_LOOPBACK;
> -
> -	return phy_write(phydev, MII_BMCR, value);
> +	return phy_modify(phydev, MII_BMCR, ~BMCR_LOOPBACK,
> +			  enable ? BMCR_LOOPBACK : 0);
>   }
>   EXPORT_SYMBOL(genphy_loopback);
> -------------------------------------------------------------------------------
> 
> 
> Git bisection log:
> 
> -------------------------------------------------------------------------------
> git bisect start
> # good: [72bca2084a21edda74b802bc076083d5951f67b4] liquidio: Use zeroing memory allocator than allocator/memset
> git bisect good 72bca2084a21edda74b802bc076083d5951f67b4
> # bad: [45f8982253ad3fd314e3580cb9209183ea3faa71] Merge branch 'hns3-next'
> git bisect bad 45f8982253ad3fd314e3580cb9209183ea3faa71
> # good: [44596f86826df00ab3ab1086b25f3cdcc11156a1] Merge tag 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma
> git bisect good 44596f86826df00ab3ab1086b25f3cdcc11156a1
> # bad: [0befd061af59c4ba426588930f09eb9ea2475534] netfilter: nf_tables: remove nft_dereference()
> git bisect bad 0befd061af59c4ba426588930f09eb9ea2475534
> # bad: [d0adb51edb73c94a595bfa9d9bd8b35977e74fbf] nfp: add basic multicast filtering
> git bisect bad d0adb51edb73c94a595bfa9d9bd8b35977e74fbf
> # bad: [8a4816cad00bf14642f0ed6043b32d29a05006ce] tg3: Add Macronix NVRAM support
> git bisect bad 8a4816cad00bf14642f0ed6043b32d29a05006ce
> # good: [34dc08e4be208539b7c4aa8154a610e1736705e8] net: mdiobus: add unlocked accessors
> git bisect good 34dc08e4be208539b7c4aa8154a610e1736705e8
> # bad: [ee7e16b66a766e8f922aafe5edf9353b9f37a424] net: mdio: Only perform gpio reset for PHYs
> git bisect bad ee7e16b66a766e8f922aafe5edf9353b9f37a424
> # good: [424ca4c5512173e42b4086322dafd33ee882baf3] net: phy: marvell: fix paged access races
> git bisect good 424ca4c5512173e42b4086322dafd33ee882baf3
> # bad: [fea23fb591cce99546baca043d2a068228e87a79] net: phy: convert read-modify-write to phy_modify()
> git bisect bad fea23fb591cce99546baca043d2a068228e87a79
> # good: [2b74e5be17d25fbca4be236a19efcd2ecae81cb2] net: phy: add phy_modify() accessor
> git bisect good 2b74e5be17d25fbca4be236a19efcd2ecae81cb2
> # first bad commit: [fea23fb591cce99546baca043d2a068228e87a79] net: phy: convert read-modify-write to phy_modify()
> -------------------------------------------------------------------------------
> 
