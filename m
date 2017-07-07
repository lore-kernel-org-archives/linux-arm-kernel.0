From: lkp@intel.com (kbuild test robot)
Date: Fri, 7 Jul 2017 09:45:46 +0800
Subject: [PATCH v2 2/6] serial: imx: Simplify DMA disablement
In-Reply-To: <20170705130706.10388-3-romain.perier@collabora.com>
Message-ID: <201707070953.ERVW92nK%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nandor,

[auto build test ERROR on tty/tty-testing]
[also build test ERROR on v4.12 next-20170706]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Romain-Perier/serial-imx-various-improvements/20170706-153226
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
config: arm-multi_v5_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

Note: the linux-review/Romain-Perier/serial-imx-various-improvements/20170706-153226 HEAD c99e6e0fd195719d99b5ce9a4f9a155243772578 builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

   drivers/tty/serial/imx.c: In function 'imx_disable_dma':
>> drivers/tty/serial/imx.c:1250:2: error: 'temp' undeclared (first use in this function)
     temp = readl(sport->port.membase + UCR2);
     ^~~~
   drivers/tty/serial/imx.c:1250:2: note: each undeclared identifier is reported only once for each function it appears in

vim +/temp +1250 drivers/tty/serial/imx.c

b4cdc8f6 Huang Shijie 2013-07-08  1244  static void imx_disable_dma(struct imx_port *sport)
b4cdc8f6 Huang Shijie 2013-07-08  1245  {
52fe0ee0 Nandor Han   2017-07-05  1246  	imx_stop_rx_dma(sport);
52fe0ee0 Nandor Han   2017-07-05  1247  	imx_stop_tx_dma(sport);
b4cdc8f6 Huang Shijie 2013-07-08  1248  
b4cdc8f6 Huang Shijie 2013-07-08  1249  	/* clear UCR2 */
b4cdc8f6 Huang Shijie 2013-07-08 @1250  	temp = readl(sport->port.membase + UCR2);
86a04ba6 Lucas Stach  2015-09-04  1251  	temp &= ~(UCR2_CTSC | UCR2_CTS | UCR2_ATEN);
b4cdc8f6 Huang Shijie 2013-07-08  1252  	writel(temp, sport->port.membase + UCR2);
b4cdc8f6 Huang Shijie 2013-07-08  1253  

:::::: The code at line 1250 was first introduced by commit
:::::: b4cdc8f61beb2a55c8c3d22dfcaf5f34a919fe9b serial: imx: add DMA support for imx6q

:::::: TO: Huang Shijie <b32955@freescale.com>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 29150 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170707/1a9907e3/attachment-0001.gz>
