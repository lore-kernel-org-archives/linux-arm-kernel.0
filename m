From: lkp@intel.com (kbuild test robot)
Date: Sat, 7 Jul 2018 15:08:30 +0800
Subject: [PATCH 4/6] drm/i2c: tda998x: convert to bridge driver
In-Reply-To: <E1fbSCO-00076p-OV@rmk-PC.armlinux.org.uk>
References: <E1fbSCO-00076p-OV@rmk-PC.armlinux.org.uk>
Message-ID: <201807071346.QrTz1ocv%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

I love your patch! Yet something to improve:

[auto build test ERROR on arm/drm-tda998x-devel]
[cannot apply to v4.18-rc3 next-20180706]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Russell-King/drm-i2c-tda998x-find-the-drm_device-via-the-drm_connector/20180707-030507
base:   git://git.armlinux.org.uk/~rmk/linux-arm.git drm-tda998x-devel
config: i386-randconfig-x018-201826 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   drivers/gpu/drm/i2c/tda998x_drv.c: In function 'tda998x_bridge_disable':
   drivers/gpu/drm/i2c/tda998x_drv.c:1336:7: error: 'priv' undeclared (first use in this function); did you mean 'pid'?
     if (!priv->is_on) {
          ^~~~
          pid
   drivers/gpu/drm/i2c/tda998x_drv.c:1336:7: note: each undeclared identifier is reported only once for each function it appears in
   drivers/gpu/drm/i2c/tda998x_drv.c: In function 'tda998x_create':
>> drivers/gpu/drm/i2c/tda998x_drv.c:1827:14: error: 'struct drm_bridge' has no member named 'of_node'
     priv->bridge.of_node = dev->of_node;
                 ^
   drivers/gpu/drm/i2c/tda998x_drv.c:1827:25: error: 'dev' undeclared (first use in this function); did you mean 'cdev'?
     priv->bridge.of_node = dev->of_node;
                            ^~~
                            cdev
   drivers/gpu/drm/i2c/tda998x_drv.c: In function 'tda998x_bind':
   drivers/gpu/drm/i2c/tda998x_drv.c:1908:1: warning: label 'err_encoder' defined but not used [-Wunused-label]
    err_encoder:
    ^~~~~~~~~~~

vim +1827 drivers/gpu/drm/i2c/tda998x_drv.c

  1650	
  1651	static int tda998x_create(struct i2c_client *client, struct tda998x_priv *priv)
  1652	{
  1653		struct device_node *np = client->dev.of_node;
  1654		struct i2c_board_info cec_info;
  1655		u32 video;
  1656		int rev_lo, rev_hi, ret;
  1657	
  1658		mutex_init(&priv->mutex);	/* protect the page access */
  1659		mutex_init(&priv->audio_mutex); /* protect access from audio thread */
  1660		mutex_init(&priv->edid_mutex);
  1661		INIT_LIST_HEAD(&priv->bridge.list);
  1662		init_waitqueue_head(&priv->edid_delay_waitq);
  1663		timer_setup(&priv->edid_delay_timer, tda998x_edid_delay_done, 0);
  1664		INIT_WORK(&priv->detect_work, tda998x_detect_work);
  1665	
  1666		priv->vip_cntrl_0 = VIP_CNTRL_0_SWAP_A(2) | VIP_CNTRL_0_SWAP_B(3);
  1667		priv->vip_cntrl_1 = VIP_CNTRL_1_SWAP_C(0) | VIP_CNTRL_1_SWAP_D(1);
  1668		priv->vip_cntrl_2 = VIP_CNTRL_2_SWAP_E(4) | VIP_CNTRL_2_SWAP_F(5);
  1669	
  1670		/* CEC I2C address bound to TDA998x I2C addr by configuration pins */
  1671		priv->cec_addr = 0x34 + (client->addr & 0x03);
  1672		priv->current_page = 0xff;
  1673		priv->hdmi = client;
  1674	
  1675		/* wake up the device: */
  1676		cec_write(priv, REG_CEC_ENAMODS,
  1677				CEC_ENAMODS_EN_RXSENS | CEC_ENAMODS_EN_HDMI);
  1678	
  1679		tda998x_reset(priv);
  1680	
  1681		/* read version: */
  1682		rev_lo = reg_read(priv, REG_VERSION_LSB);
  1683		if (rev_lo < 0) {
  1684			dev_err(&client->dev, "failed to read version: %d\n", rev_lo);
  1685			return rev_lo;
  1686		}
  1687	
  1688		rev_hi = reg_read(priv, REG_VERSION_MSB);
  1689		if (rev_hi < 0) {
  1690			dev_err(&client->dev, "failed to read version: %d\n", rev_hi);
  1691			return rev_hi;
  1692		}
  1693	
  1694		priv->rev = rev_lo | rev_hi << 8;
  1695	
  1696		/* mask off feature bits: */
  1697		priv->rev &= ~0x30; /* not-hdcp and not-scalar bit */
  1698	
  1699		switch (priv->rev) {
  1700		case TDA9989N2:
  1701			dev_info(&client->dev, "found TDA9989 n2");
  1702			break;
  1703		case TDA19989:
  1704			dev_info(&client->dev, "found TDA19989");
  1705			break;
  1706		case TDA19989N2:
  1707			dev_info(&client->dev, "found TDA19989 n2");
  1708			break;
  1709		case TDA19988:
  1710			dev_info(&client->dev, "found TDA19988");
  1711			break;
  1712		default:
  1713			dev_err(&client->dev, "found unsupported device: %04x\n",
  1714				priv->rev);
  1715			return -ENXIO;
  1716		}
  1717	
  1718		/* after reset, enable DDC: */
  1719		reg_write(priv, REG_DDC_DISABLE, 0x00);
  1720	
  1721		/* set clock on DDC channel: */
  1722		reg_write(priv, REG_TX3, 39);
  1723	
  1724		/* if necessary, disable multi-master: */
  1725		if (priv->rev == TDA19989)
  1726			reg_set(priv, REG_I2C_MASTER, I2C_MASTER_DIS_MM);
  1727	
  1728		cec_write(priv, REG_CEC_FRO_IM_CLK_CTRL,
  1729				CEC_FRO_IM_CLK_CTRL_GHOST_DIS | CEC_FRO_IM_CLK_CTRL_IMCLK_SEL);
  1730	
  1731		/* ensure interrupts are disabled */
  1732		cec_write(priv, REG_CEC_RXSHPDINTENA, 0);
  1733	
  1734		/* clear pending interrupts */
  1735		cec_read(priv, REG_CEC_RXSHPDINT);
  1736		reg_read(priv, REG_INT_FLAGS_0);
  1737		reg_read(priv, REG_INT_FLAGS_1);
  1738		reg_read(priv, REG_INT_FLAGS_2);
  1739	
  1740		/* initialize the optional IRQ */
  1741		if (client->irq) {
  1742			unsigned long irq_flags;
  1743	
  1744			/* init read EDID waitqueue and HDP work */
  1745			init_waitqueue_head(&priv->wq_edid);
  1746	
  1747			irq_flags =
  1748				irqd_get_trigger_type(irq_get_irq_data(client->irq));
  1749	
  1750			priv->cec_glue.irq_flags = irq_flags;
  1751	
  1752			irq_flags |= IRQF_SHARED | IRQF_ONESHOT;
  1753			ret = request_threaded_irq(client->irq, NULL,
  1754						   tda998x_irq_thread, irq_flags,
  1755						   "tda998x", priv);
  1756			if (ret) {
  1757				dev_err(&client->dev,
  1758					"failed to request IRQ#%u: %d\n",
  1759					client->irq, ret);
  1760				goto err_irq;
  1761			}
  1762	
  1763			/* enable HPD irq */
  1764			cec_write(priv, REG_CEC_RXSHPDINTENA, CEC_RXSHPDLEV_HPD);
  1765		}
  1766	
  1767		priv->cec_notify = cec_notifier_get(&client->dev);
  1768		if (!priv->cec_notify) {
  1769			ret = -ENOMEM;
  1770			goto fail;
  1771		}
  1772	
  1773		priv->cec_glue.parent = &client->dev;
  1774		priv->cec_glue.data = priv;
  1775		priv->cec_glue.init = tda998x_cec_hook_init;
  1776		priv->cec_glue.exit = tda998x_cec_hook_exit;
  1777		priv->cec_glue.open = tda998x_cec_hook_open;
  1778		priv->cec_glue.release = tda998x_cec_hook_release;
  1779	
  1780		/*
  1781		 * Some TDA998x are actually two I2C devices merged onto one piece
  1782		 * of silicon: TDA9989 and TDA19989 combine the HDMI transmitter
  1783		 * with a slightly modified TDA9950 CEC device.  The CEC device
  1784		 * is at the TDA9950 address, with the address pins strapped across
  1785		 * to the TDA998x address pins.  Hence, it always has the same
  1786		 * offset.
  1787		 */
  1788		memset(&cec_info, 0, sizeof(cec_info));
  1789		strlcpy(cec_info.type, "tda9950", sizeof(cec_info.type));
  1790		cec_info.addr = priv->cec_addr;
  1791		cec_info.platform_data = &priv->cec_glue;
  1792		cec_info.irq = client->irq;
  1793	
  1794		priv->cec = i2c_new_device(client->adapter, &cec_info);
  1795		if (!priv->cec) {
  1796			ret = -ENODEV;
  1797			goto fail;
  1798		}
  1799	
  1800		/* enable EDID read irq: */
  1801		reg_set(priv, REG_INT_FLAGS_2, INT_FLAGS_2_EDID_BLK_RD);
  1802	
  1803		if (np) {
  1804			/* get the device tree parameters */
  1805			ret = of_property_read_u32(np, "video-ports", &video);
  1806			if (ret == 0) {
  1807				priv->vip_cntrl_0 = video >> 16;
  1808				priv->vip_cntrl_1 = video >> 8;
  1809				priv->vip_cntrl_2 = video;
  1810			}
  1811	
  1812			ret = tda998x_get_audio_ports(priv, np);
  1813			if (ret)
  1814				goto fail;
  1815	
  1816			if (priv->audio_port[0].format != AFMT_UNUSED)
  1817				tda998x_audio_codec_init(priv, &client->dev);
  1818		} else {
  1819			struct tda998x_encoder_params *params;
  1820	
  1821			params = client->dev.platform_data;
  1822			if (params)
  1823				tda998x_set_config(priv, params);
  1824		}
  1825	
  1826		priv->bridge.funcs = &tda998x_bridge_funcs;
> 1827		priv->bridge.of_node = dev->of_node;
  1828	
  1829		drm_bridge_add(&priv->bridge);
  1830	
  1831		return 0;
  1832	
  1833	fail:
  1834		tda998x_destroy(priv);
  1835	err_irq:
  1836		return ret;
  1837	}
  1838	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 30360 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180707/c930f838/attachment-0001.gz>
