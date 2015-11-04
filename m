From: lkp@intel.com (kbuild test robot)
Date: Wed, 4 Nov 2015 08:52:54 +0800
Subject: [PATCH 2/9] tty: xuartps: Use spinlock to serialize HW access
In-Reply-To: <1446596450-20918-3-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <201511040850.KOF8sWEr%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Soren,

[auto build test WARNING on v4.3-rc7]
[also WARNING on: next-20151103]

url:    https://github.com/0day-ci/linux/commits/Soren-Brinkmann/tty-xuartps-Beautify-read-modify-writes/20151104-082546
base:   https://github.com/0day-ci/linux Soren-Brinkmann/tty-xuartps-Beautify-read-modify-writes/20151104-082546
config: i386-allmodconfig (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All warnings (new ones prefixed by >>):

   drivers/tty/serial/xilinx_uartps.c: In function 'cdns_uart_poll_get_char':
>> drivers/tty/serial/xilinx_uartps.c:948:6: warning: unused variable 'imr' [-Wunused-variable]
     u32 imr;
         ^
   drivers/tty/serial/xilinx_uartps.c: In function 'cdns_uart_poll_put_char':
   drivers/tty/serial/xilinx_uartps.c:968:6: warning: unused variable 'imr' [-Wunused-variable]
     u32 imr;
         ^

vim +/imr +948 drivers/tty/serial/xilinx_uartps.c

19038ad9f Lars-Peter Clausen 2014-11-05  932  
19f22efdb Thomas Betker      2015-03-12  933  	val = readl(port->membase + CDNS_UART_MODEMCR_OFFSET);
19038ad9f Lars-Peter Clausen 2014-11-05  934  
19038ad9f Lars-Peter Clausen 2014-11-05  935  	val &= ~(CDNS_UART_MODEMCR_RTS | CDNS_UART_MODEMCR_DTR);
19038ad9f Lars-Peter Clausen 2014-11-05  936  
19038ad9f Lars-Peter Clausen 2014-11-05  937  	if (mctrl & TIOCM_RTS)
19038ad9f Lars-Peter Clausen 2014-11-05  938  		val |= CDNS_UART_MODEMCR_RTS;
19038ad9f Lars-Peter Clausen 2014-11-05  939  	if (mctrl & TIOCM_DTR)
19038ad9f Lars-Peter Clausen 2014-11-05  940  		val |= CDNS_UART_MODEMCR_DTR;
19038ad9f Lars-Peter Clausen 2014-11-05  941  
19f22efdb Thomas Betker      2015-03-12  942  	writel(val, port->membase + CDNS_UART_MODEMCR_OFFSET);
61ec90169 John Linn          2011-04-30  943  }
61ec90169 John Linn          2011-04-30  944  
6ee04c6c5 Vlad Lungu         2013-10-17  945  #ifdef CONFIG_CONSOLE_POLL
d9bb3fb12 Soren Brinkmann    2014-04-04  946  static int cdns_uart_poll_get_char(struct uart_port *port)
6ee04c6c5 Vlad Lungu         2013-10-17  947  {
6ee04c6c5 Vlad Lungu         2013-10-17 @948  	u32 imr;
6ee04c6c5 Vlad Lungu         2013-10-17  949  	int c;
c2fd7b9d5 Soren Brinkmann    2015-11-03  950  	unsigned long flags;
6ee04c6c5 Vlad Lungu         2013-10-17  951  
c2fd7b9d5 Soren Brinkmann    2015-11-03  952  	spin_lock_irqsave(&port->lock, flags);
6ee04c6c5 Vlad Lungu         2013-10-17  953  
6ee04c6c5 Vlad Lungu         2013-10-17  954  	/* Check if FIFO is empty */
19f22efdb Thomas Betker      2015-03-12  955  	if (readl(port->membase + CDNS_UART_SR_OFFSET) & CDNS_UART_SR_RXEMPTY)
6ee04c6c5 Vlad Lungu         2013-10-17  956  		c = NO_POLL_CHAR;

:::::: The code at line 948 was first introduced by commit
:::::: 6ee04c6c5488b2b7fdfa22c771c127411f86e610 tty: xuartps: Add polled mode support for xuartps

:::::: TO: Vlad Lungu <vlad.lungu@windriver.com>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 51591 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151104/4b67ff78/attachment-0001.obj>
