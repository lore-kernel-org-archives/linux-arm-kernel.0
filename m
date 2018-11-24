From: lkp@intel.com (kbuild test robot)
Date: Sat, 24 Nov 2018 16:30:06 +0800
Subject: [PATCH v2 15/15] MAINTAINERS: Add entry for RDA Micro SoC
 architecture
In-Reply-To: <20181121033652.12247-16-manivannan.sadhasivam@linaro.org>
References: <20181121033652.12247-16-manivannan.sadhasivam@linaro.org>
Message-ID: <201811241627.2eQKZPBL%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Manivannan,

I love your patch! Perhaps something to improve:

[auto build test WARNING on robh/for-next]
[also build test WARNING on v4.20-rc3 next-20181123]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Manivannan-Sadhasivam/Add-initial-RDA8810PL-SoC-and-Orange-Pi-boards-support/20181123-125507
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: x86_64-allmodconfig (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All warnings (new ones prefixed by >>):

>> drivers/tty/serial/rda-uart.c:619:28: warning: context imbalance in 'rda_uart_port_write' - unexpected unlock

vim +/rda_uart_port_write +619 drivers/tty/serial/rda-uart.c

efb19753 Manivannan Sadhasivam 2018-11-21  588  
efb19753 Manivannan Sadhasivam 2018-11-21  589  static void rda_uart_port_write(struct uart_port *port, const char *s,
efb19753 Manivannan Sadhasivam 2018-11-21  590  				u_int count)
efb19753 Manivannan Sadhasivam 2018-11-21  591  {
efb19753 Manivannan Sadhasivam 2018-11-21  592  	u32 old_irq_mask;
efb19753 Manivannan Sadhasivam 2018-11-21  593  	unsigned long flags;
efb19753 Manivannan Sadhasivam 2018-11-21  594  	int locked;
efb19753 Manivannan Sadhasivam 2018-11-21  595  
efb19753 Manivannan Sadhasivam 2018-11-21  596  	local_irq_save(flags);
efb19753 Manivannan Sadhasivam 2018-11-21  597  
efb19753 Manivannan Sadhasivam 2018-11-21  598  	if (port->sysrq) {
efb19753 Manivannan Sadhasivam 2018-11-21  599  		locked = 0;
efb19753 Manivannan Sadhasivam 2018-11-21  600  	} else if (oops_in_progress) {
efb19753 Manivannan Sadhasivam 2018-11-21  601  		locked = spin_trylock(&port->lock);
efb19753 Manivannan Sadhasivam 2018-11-21  602  	} else {
efb19753 Manivannan Sadhasivam 2018-11-21  603  		spin_lock(&port->lock);
efb19753 Manivannan Sadhasivam 2018-11-21  604  		locked = 1;
efb19753 Manivannan Sadhasivam 2018-11-21  605  	}
efb19753 Manivannan Sadhasivam 2018-11-21  606  
efb19753 Manivannan Sadhasivam 2018-11-21  607  	old_irq_mask = rda_uart_read(port, RDA_UART_IRQ_MASK);
efb19753 Manivannan Sadhasivam 2018-11-21  608  	rda_uart_write(port, 0, RDA_UART_IRQ_MASK);
efb19753 Manivannan Sadhasivam 2018-11-21  609  
efb19753 Manivannan Sadhasivam 2018-11-21  610  	uart_console_write(port, s, count, rda_console_putchar);
efb19753 Manivannan Sadhasivam 2018-11-21  611  
efb19753 Manivannan Sadhasivam 2018-11-21  612  	/* wait until all contents have been sent out */
efb19753 Manivannan Sadhasivam 2018-11-21  613  	while (!(rda_uart_read(port, RDA_UART_STATUS) & RDA_UART_TX_FIFO_MASK))
efb19753 Manivannan Sadhasivam 2018-11-21  614  		cpu_relax();
efb19753 Manivannan Sadhasivam 2018-11-21  615  
efb19753 Manivannan Sadhasivam 2018-11-21  616  	rda_uart_write(port, old_irq_mask, RDA_UART_IRQ_MASK);
efb19753 Manivannan Sadhasivam 2018-11-21  617  
efb19753 Manivannan Sadhasivam 2018-11-21  618  	if (locked)
efb19753 Manivannan Sadhasivam 2018-11-21 @619  		spin_unlock(&port->lock);
efb19753 Manivannan Sadhasivam 2018-11-21  620  
efb19753 Manivannan Sadhasivam 2018-11-21  621  	local_irq_restore(flags);
efb19753 Manivannan Sadhasivam 2018-11-21  622  }
efb19753 Manivannan Sadhasivam 2018-11-21  623  

:::::: The code at line 619 was first introduced by commit
:::::: efb197538a7e148635e096850a818e3b29b1c4b2 tty: serial: Add RDA8810PL UART driver

:::::: TO: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
:::::: CC: 0day robot <lkp@intel.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 66615 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181124/e9bedca7/attachment-0001.gz>
