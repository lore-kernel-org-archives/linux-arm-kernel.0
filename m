From: lkp@intel.com (kbuild test robot)
Date: Fri, 11 Mar 2016 19:28:18 +0800
Subject: [PATCH 4/6] net: arc: trivial: cleanup the emac driver
In-Reply-To: <1457693731-6966-5-git-send-email-wxt@rock-chips.com>
Message-ID: <201603111932.Q2YJVZSM%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Caesar,

[auto build test WARNING on next-20160311]
[also build test WARNING on v4.5-rc7]
[cannot apply to rockchip/for-next net-next/master v4.5-rc7 v4.5-rc6 v4.5-rc5]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Caesar-Wang/net-arc_emac-make-the-rockchip-emac-document-more-compatible/20160311-190611
config: alpha-allyesconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=alpha 

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/arc/emac_main.c: In function 'arc_emac_open':
>> drivers/net/ethernet/arc/emac_main.c:468:7: warning: overflow in implicit constant conversion [-Woverflow]
          (RX_BD_NUM << 24) | /* RX BD table length */
          ^

vim +468 drivers/net/ethernet/arc/emac_main.c

e4f2379d Alexey Brodkin    2013-06-24  452  	/* Clean Tx BD's */
e4f2379d Alexey Brodkin    2013-06-24  453  	memset(priv->txbd, 0, TX_RING_SZ);
e4f2379d Alexey Brodkin    2013-06-24  454  
e4f2379d Alexey Brodkin    2013-06-24  455  	/* Initialize logical address filter */
e4f2379d Alexey Brodkin    2013-06-24  456  	arc_reg_set(priv, R_LAFL, 0);
e4f2379d Alexey Brodkin    2013-06-24  457  	arc_reg_set(priv, R_LAFH, 0);
e4f2379d Alexey Brodkin    2013-06-24  458  
e4f2379d Alexey Brodkin    2013-06-24  459  	/* Set BD ring pointers for device side */
e4f2379d Alexey Brodkin    2013-06-24  460  	arc_reg_set(priv, R_RX_RING, (unsigned int)priv->rxbd_dma);
e4f2379d Alexey Brodkin    2013-06-24  461  	arc_reg_set(priv, R_TX_RING, (unsigned int)priv->txbd_dma);
e4f2379d Alexey Brodkin    2013-06-24  462  
e4f2379d Alexey Brodkin    2013-06-24  463  	/* Enable interrupts */
7ce7679d Beniamino Galvani 2014-09-10  464  	arc_reg_set(priv, R_ENABLE, RXINT_MASK | TXINT_MASK | ERR_MASK);
e4f2379d Alexey Brodkin    2013-06-24  465  
e4f2379d Alexey Brodkin    2013-06-24  466  	/* Set CONTROL */
e4f2379d Alexey Brodkin    2013-06-24  467  	arc_reg_set(priv, R_CTRL,
e4f2379d Alexey Brodkin    2013-06-24 @468  		    (RX_BD_NUM << 24) |	/* RX BD table length */
e4f2379d Alexey Brodkin    2013-06-24  469  		    (TX_BD_NUM << 16) |	/* TX BD table length */
e4f2379d Alexey Brodkin    2013-06-24  470  		    TXRN_MASK | RXRN_MASK);
e4f2379d Alexey Brodkin    2013-06-24  471  
e4f2379d Alexey Brodkin    2013-06-24  472  	napi_enable(&priv->napi);
e4f2379d Alexey Brodkin    2013-06-24  473  
e4f2379d Alexey Brodkin    2013-06-24  474  	/* Enable EMAC */
e4f2379d Alexey Brodkin    2013-06-24  475  	arc_reg_or(priv, R_CTRL, EN_MASK);
e4f2379d Alexey Brodkin    2013-06-24  476  

:::::: The code at line 468 was first introduced by commit
:::::: e4f2379db6c6823c5d4a4c2c912df00c65de51d7 ethernet/arc/arc_emac - Add new driver

:::::: TO: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 45778 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160311/05ee75f7/attachment-0001.obj>
