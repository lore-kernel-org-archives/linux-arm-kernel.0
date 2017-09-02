From: lkp@intel.com (kbuild test robot)
Date: Sat, 2 Sep 2017 19:53:59 +0800
Subject: [net-next PATCHv6 2/2] net: socionext: Add NetSec driver
In-Reply-To: <1504088771-6255-1-git-send-email-jaswinder.singh@linaro.org>
Message-ID: <201709021953.EGQtVEDs%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jassi,

[auto build test WARNING on net-next/master]

url:    https://github.com/0day-ci/linux/commits/Jassi-Brar/net-ethernet-Socionext-Netsec/20170902-181854
config: i386-allmodconfig (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/socionext/netsec/netsec_netdev.c: In function 'netsec_configure_normal_mode':
>> drivers/net/ethernet/socionext/netsec/netsec_netdev.c:86:51: warning: left shift count >= width of type [-Wshift-count-overflow]
       netsec_desc_start_reg_addr_up[NETSEC_RING_TX]) << 32;
                                                      ^~
>> drivers/net/ethernet/socionext/netsec/netsec_netdev.c:92:51: warning: right shift count >= width of type [-Wshift-count-overflow]
            priv->desc_ring[NETSEC_RING_RX].desc_phys >> 32);
                                                      ^~
   drivers/net/ethernet/socionext/netsec/netsec_netdev.c:97:51: warning: right shift count >= width of type [-Wshift-count-overflow]
            priv->desc_ring[NETSEC_RING_TX].desc_phys >> 32);
                                                      ^~
   drivers/net/ethernet/socionext/netsec/netsec_netdev.c: In function 'netsec_change_mode_to_taiki':
   drivers/net/ethernet/socionext/netsec/netsec_netdev.c:148:39: warning: right shift count >= width of type [-Wshift-count-overflow]
            priv->scb_set_normal_tx_paddr >> 32);
                                          ^~
--
   drivers/net/ethernet/socionext/netsec/netsec_desc_ring_access.c: In function 'netsec_set_rx_de':
>> drivers/net/ethernet/socionext/netsec/netsec_desc_ring_access.c:184:40: warning: right shift count >= width of type [-Wshift-count-overflow]
     de->data_buf_addr_up = info->dma_addr >> 32;
                                           ^~
   drivers/net/ethernet/socionext/netsec/netsec_desc_ring_access.c: In function 'netsec_set_tx_desc_entry':
   drivers/net/ethernet/socionext/netsec/netsec_desc_ring_access.c:247:50: warning: right shift count >= width of type [-Wshift-count-overflow]
     tx_desc_entry.data_buf_addr_up = frag->dma_addr >> 32;
                                                     ^~

vim +86 drivers/net/ethernet/socionext/netsec/netsec_netdev.c

    78	
    79	static int netsec_configure_normal_mode(struct netsec_priv *priv)
    80	{
    81		int ret = 0;
    82		u32 value;
    83	
    84		/* save scb set value  */
    85		priv->scb_set_normal_tx_paddr = (phys_addr_t)netsec_readl(priv,
  > 86				netsec_desc_start_reg_addr_up[NETSEC_RING_TX]) << 32;
    87		priv->scb_set_normal_tx_paddr |= (phys_addr_t)netsec_readl(priv,
    88				netsec_desc_start_reg_addr_lw[NETSEC_RING_TX]);
    89	
    90		/* set desc_start addr */
    91		netsec_writel(priv, netsec_desc_start_reg_addr_up[NETSEC_RING_RX],
  > 92			      priv->desc_ring[NETSEC_RING_RX].desc_phys >> 32);
    93		netsec_writel(priv, netsec_desc_start_reg_addr_lw[NETSEC_RING_RX],
    94			      priv->desc_ring[NETSEC_RING_RX].desc_phys & 0xffffffff);
    95	
    96		netsec_writel(priv, netsec_desc_start_reg_addr_up[NETSEC_RING_TX],
    97			      priv->desc_ring[NETSEC_RING_TX].desc_phys >> 32);
    98		netsec_writel(priv, netsec_desc_start_reg_addr_lw[NETSEC_RING_TX],
    99			      priv->desc_ring[NETSEC_RING_TX].desc_phys & 0xffffffff);
   100	
   101		/* set normal tx desc ring config */
   102		value = (cpu_to_le32(1) == 1) << NETSEC_REG_DESC_ENDIAN |
   103			NETSEC_REG_DESC_RING_CONFIG_CFG_UP |
   104			NETSEC_REG_DESC_RING_CONFIG_CH_RST;
   105		netsec_writel(priv, desc_ads[NETSEC_RING_TX], value);
   106	
   107		value = (cpu_to_le32(1) == 1) << NETSEC_REG_DESC_ENDIAN |
   108			NETSEC_REG_DESC_RING_CONFIG_CFG_UP |
   109			NETSEC_REG_DESC_RING_CONFIG_CH_RST;
   110		netsec_writel(priv, desc_ads[NETSEC_RING_RX], value);
   111	
   112		if (netsec_wait_for_ring_config_ready(priv, NETSEC_RING_TX) ||
   113		    netsec_wait_for_ring_config_ready(priv, NETSEC_RING_RX))
   114			return -ETIMEDOUT;
   115	
   116		return ret;
   117	}
   118	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 61134 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170902/21d6f711/attachment-0001.gz>
