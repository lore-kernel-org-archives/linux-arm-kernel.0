From: lkp@intel.com (kbuild test robot)
Date: Fri, 14 Apr 2017 15:42:31 +0800
Subject: [PATCH 3/4] net: macb: Add hardware PTP support
In-Reply-To: <1492090763-15686-1-git-send-email-rafalo@cadence.com>
Message-ID: <201704141535.hrXAVwQy%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rafal,

[auto build test ERROR on net-next/master]
[also build test ERROR on v4.11-rc6 next-20170413]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Rafal-Ozieblo/net-macb-Add-support-for-PTP-timestamps-in-DMA-descriptors/20170414-001330
config: arm64-defconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

Note: the linux-review/Rafal-Ozieblo/net-macb-Add-support-for-PTP-timestamps-in-DMA-descriptors/20170414-001330 HEAD 3b878618e04f866388fd62f6c44752e50b15658a builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

   drivers/built-in.o: In function `gem_ptp_do_rxstamp':
>> drivers/net/ethernet/cadence/macb.h:1108: undefined reference to `gem_ptp_rxstamp'
   drivers/net/ethernet/cadence/macb.h:1108:(.text+0x264604): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `gem_ptp_rxstamp'
   drivers/built-in.o: In function `gem_ptp_do_txstamp':
>> drivers/net/ethernet/cadence/macb.h:1100: undefined reference to `gem_ptp_txstamp'
   drivers/net/ethernet/cadence/macb.h:1100:(.text+0x266564): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `gem_ptp_txstamp'
   drivers/built-in.o: In function `macb_interrupt':
>> drivers/net/ethernet/cadence/macb.c:1332: undefined reference to `macb_ptp_int'
   drivers/net/ethernet/cadence/macb.c:1332:(.text+0x2666ac): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `macb_ptp_int'
   drivers/built-in.o:(.data+0x93fc8): undefined reference to `gem_ptp_init'
   drivers/built-in.o:(.data+0x93fd0): undefined reference to `gem_ptp_remove'
   drivers/built-in.o:(.data+0x93ff0): undefined reference to `gem_get_hwtst'
   drivers/built-in.o:(.data+0x93ff8): undefined reference to `gem_set_hwtst'

vim +1108 drivers/net/ethernet/cadence/macb.h

  1094	void macb_ptp_int(struct macb_queue *queue, u32 status);
  1095	static inline int gem_ptp_do_txstamp(struct macb_queue *queue, struct sk_buff *skb, struct macb_dma_desc *desc)
  1096	{
  1097		if (queue->bp->tstamp_config.tx_type == TSTAMP_DISABLED)
  1098			return -ENOTSUPP;
  1099	
> 1100		return gem_ptp_txstamp(queue, skb, desc);
  1101	}
  1102	
  1103	static inline void gem_ptp_do_rxstamp(struct macb *bp, struct sk_buff *skb, struct macb_dma_desc *desc)
  1104	{
  1105		if (bp->tstamp_config.rx_filter == TSTAMP_DISABLED)
  1106			return;
  1107	
> 1108		gem_ptp_rxstamp(bp, skb, desc);
  1109	}
  1110	int gem_get_hwtst(struct net_device *dev, struct ifreq *rq);
  1111	int gem_set_hwtst(struct net_device *dev, struct ifreq *ifr, int cmd);

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 34537 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170414/343318b5/attachment-0001.gz>
