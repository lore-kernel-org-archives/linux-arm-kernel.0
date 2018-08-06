From: lkp@intel.com (kbuild test robot)
Date: Mon, 6 Aug 2018 10:50:45 +0800
Subject: [arm:drm-tda998x-devel 4/10]
 drivers/gpu/drm/i2c/tda998x_drv.c:1837:14: error: 'struct drm_bridge' has no
 member named 'of_node'
Message-ID: <201808061042.0xuSXr6v%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   git://git.armlinux.org.uk/~rmk/linux-arm.git drm-tda998x-devel
head:   4eb47188dd4915df8b3047e2256774598ac73834
commit: 3737a26356118dd76066a6c1488d7ace68a22c69 [4/10] drm/i2c: tda998x: convert to bridge driver
config: x86_64-randconfig-s1-08060929 (attached as .config)
compiler: gcc-6 (Debian 6.4.0-9) 6.4.0 20171026
reproduce:
        git checkout 3737a26356118dd76066a6c1488d7ace68a22c69
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   drivers/gpu/drm/i2c/tda998x_drv.c: In function 'tda998x_create':
>> drivers/gpu/drm/i2c/tda998x_drv.c:1837:14: error: 'struct drm_bridge' has no member named 'of_node'
     priv->bridge.of_node = dev->of_node;
                 ^
   drivers/gpu/drm/i2c/tda998x_drv.c:1837:25: error: 'dev' undeclared (first use in this function)
     priv->bridge.of_node = dev->of_node;
                            ^~~
   drivers/gpu/drm/i2c/tda998x_drv.c:1837:25: note: each undeclared identifier is reported only once for each function it appears in

vim +1837 drivers/gpu/drm/i2c/tda998x_drv.c

  1664	
  1665	static int tda998x_create(struct i2c_client *client, struct tda998x_priv *priv)
  1666	{
  1667		struct device_node *np = client->dev.of_node;
  1668		struct i2c_board_info cec_info;
  1669		u32 video;
  1670		int rev_lo, rev_hi, ret;
  1671	
  1672		mutex_init(&priv->mutex);	/* protect the page access */
  1673		mutex_init(&priv->audio_mutex); /* protect access from audio thread */
  1674		mutex_init(&priv->edid_mutex);
  1675		INIT_LIST_HEAD(&priv->bridge.list);
  1676		init_waitqueue_head(&priv->edid_delay_waitq);
  1677		timer_setup(&priv->edid_delay_timer, tda998x_edid_delay_done, 0);
  1678		INIT_WORK(&priv->detect_work, tda998x_detect_work);
  1679	
  1680		priv->vip_cntrl_0 = VIP_CNTRL_0_SWAP_A(2) | VIP_CNTRL_0_SWAP_B(3);
  1681		priv->vip_cntrl_1 = VIP_CNTRL_1_SWAP_C(0) | VIP_CNTRL_1_SWAP_D(1);
  1682		priv->vip_cntrl_2 = VIP_CNTRL_2_SWAP_E(4) | VIP_CNTRL_2_SWAP_F(5);
  1683	
  1684		/* CEC I2C address bound to TDA998x I2C addr by configuration pins */
  1685		priv->cec_addr = 0x34 + (client->addr & 0x03);
  1686		priv->current_page = 0xff;
  1687		priv->hdmi = client;
  1688	
  1689		/* wake up the device: */
  1690		cec_write(priv, REG_CEC_ENAMODS,
  1691				CEC_ENAMODS_EN_RXSENS | CEC_ENAMODS_EN_HDMI);
  1692	
  1693		tda998x_reset(priv);
  1694	
  1695		/* read version: */
  1696		rev_lo = reg_read(priv, REG_VERSION_LSB);
  1697		if (rev_lo < 0) {
  1698			dev_err(&client->dev, "failed to read version: %d\n", rev_lo);
  1699			return rev_lo;
  1700		}
  1701	
  1702		rev_hi = reg_read(priv, REG_VERSION_MSB);
  1703		if (rev_hi < 0) {
  1704			dev_err(&client->dev, "failed to read version: %d\n", rev_hi);
  1705			return rev_hi;
  1706		}
  1707	
  1708		priv->rev = rev_lo | rev_hi << 8;
  1709	
  1710		/* mask off feature bits: */
  1711		priv->rev &= ~0x30; /* not-hdcp and not-scalar bit */
  1712	
  1713		switch (priv->rev) {
  1714		case TDA9989N2:
  1715			dev_info(&client->dev, "found TDA9989 n2");
  1716			break;
  1717		case TDA19989:
  1718			dev_info(&client->dev, "found TDA19989");
  1719			break;
  1720		case TDA19989N2:
  1721			dev_info(&client->dev, "found TDA19989 n2");
  1722			break;
  1723		case TDA19988:
  1724			dev_info(&client->dev, "found TDA19988");
  1725			break;
  1726		default:
  1727			dev_err(&client->dev, "found unsupported device: %04x\n",
  1728				priv->rev);
  1729			return -ENXIO;
  1730		}
  1731	
  1732		/* after reset, enable DDC: */
  1733		reg_write(priv, REG_DDC_DISABLE, 0x00);
  1734	
  1735		/* set clock on DDC channel: */
  1736		reg_write(priv, REG_TX3, 39);
  1737	
  1738		/* if necessary, disable multi-master: */
  1739		if (priv->rev == TDA19989)
  1740			reg_set(priv, REG_I2C_MASTER, I2C_MASTER_DIS_MM);
  1741	
  1742		cec_write(priv, REG_CEC_FRO_IM_CLK_CTRL,
  1743				CEC_FRO_IM_CLK_CTRL_GHOST_DIS | CEC_FRO_IM_CLK_CTRL_IMCLK_SEL);
  1744	
  1745		/* ensure interrupts are disabled */
  1746		cec_write(priv, REG_CEC_RXSHPDINTENA, 0);
  1747	
  1748		/* clear pending interrupts */
  1749		cec_read(priv, REG_CEC_RXSHPDINT);
  1750		reg_read(priv, REG_INT_FLAGS_0);
  1751		reg_read(priv, REG_INT_FLAGS_1);
  1752		reg_read(priv, REG_INT_FLAGS_2);
  1753	
  1754		/* initialize the optional IRQ */
  1755		if (client->irq) {
  1756			unsigned long irq_flags;
  1757	
  1758			/* init read EDID waitqueue and HDP work */
  1759			init_waitqueue_head(&priv->wq_edid);
  1760	
  1761			irq_flags =
  1762				irqd_get_trigger_type(irq_get_irq_data(client->irq));
  1763	
  1764			priv->cec_glue.irq_flags = irq_flags;
  1765	
  1766			irq_flags |= IRQF_SHARED | IRQF_ONESHOT;
  1767			ret = request_threaded_irq(client->irq, NULL,
  1768						   tda998x_irq_thread, irq_flags,
  1769						   "tda998x", priv);
  1770			if (ret) {
  1771				dev_err(&client->dev,
  1772					"failed to request IRQ#%u: %d\n",
  1773					client->irq, ret);
  1774				goto err_irq;
  1775			}
  1776	
  1777			/* enable HPD irq */
  1778			cec_write(priv, REG_CEC_RXSHPDINTENA, CEC_RXSHPDLEV_HPD);
  1779		}
  1780	
  1781		priv->cec_notify = cec_notifier_get(&client->dev);
  1782		if (!priv->cec_notify) {
  1783			ret = -ENOMEM;
  1784			goto fail;
  1785		}
  1786	
  1787		priv->cec_glue.parent = &client->dev;
  1788		priv->cec_glue.data = priv;
  1789		priv->cec_glue.init = tda998x_cec_hook_init;
  1790		priv->cec_glue.exit = tda998x_cec_hook_exit;
  1791		priv->cec_glue.open = tda998x_cec_hook_open;
  1792		priv->cec_glue.release = tda998x_cec_hook_release;
  1793	
  1794		/*
  1795		 * Some TDA998x are actually two I2C devices merged onto one piece
  1796		 * of silicon: TDA9989 and TDA19989 combine the HDMI transmitter
  1797		 * with a slightly modified TDA9950 CEC device.  The CEC device
  1798		 * is at the TDA9950 address, with the address pins strapped across
  1799		 * to the TDA998x address pins.  Hence, it always has the same
  1800		 * offset.
  1801		 */
  1802		memset(&cec_info, 0, sizeof(cec_info));
  1803		strlcpy(cec_info.type, "tda9950", sizeof(cec_info.type));
  1804		cec_info.addr = priv->cec_addr;
  1805		cec_info.platform_data = &priv->cec_glue;
  1806		cec_info.irq = client->irq;
  1807	
  1808		priv->cec = i2c_new_device(client->adapter, &cec_info);
  1809		if (!priv->cec) {
  1810			ret = -ENODEV;
  1811			goto fail;
  1812		}
  1813	
  1814		/* enable EDID read irq: */
  1815		reg_set(priv, REG_INT_FLAGS_2, INT_FLAGS_2_EDID_BLK_RD);
  1816	
  1817		if (np) {
  1818			/* get the device tree parameters */
  1819			ret = of_property_read_u32(np, "video-ports", &video);
  1820			if (ret == 0) {
  1821				priv->vip_cntrl_0 = video >> 16;
  1822				priv->vip_cntrl_1 = video >> 8;
  1823				priv->vip_cntrl_2 = video;
  1824			}
  1825	
  1826			ret = tda998x_get_audio_ports(priv, np);
  1827			if (ret)
  1828				goto fail;
  1829	
  1830			if (priv->audio_port[0].format != AFMT_UNUSED)
  1831				tda998x_audio_codec_init(priv, &client->dev);
  1832		} else if (client->dev.platform_data) {
  1833			tda998x_set_config(priv, client->dev.platform_data);
  1834		}
  1835	
  1836		priv->bridge.funcs = &tda998x_bridge_funcs;
> 1837		priv->bridge.of_node = dev->of_node;
  1838	
  1839		drm_bridge_add(&priv->bridge);
  1840	
  1841		return 0;
  1842	
  1843	fail:
  1844		tda998x_destroy(priv);
  1845	err_irq:
  1846		return ret;
  1847	}
  1848	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 26393 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180806/687f92a7/attachment-0001.gz>
