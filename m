From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 20 Jun 2017 13:52:42 +1000
Subject: linux-next: manual merge of the tty tree with the arm-soc tree
Message-ID: <20170620135242.14ecdcb4@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

Today's linux-next merge of the tty tree got a conflict in:

  include/linux/platform_data/atmel.h

between commit:

  8a3d809373c6 ("ARM: at91: remove atmel_nand_data")

from the arm-soc tree and commit:

  92c8f7c0e109 ("tty/serial: atmel: make the driver DT only")

from the tty tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

-- 
Cheers,
Stephen Rothwell

diff --cc include/linux/platform_data/atmel.h
index 70c5c766628e,d36bc8d17e97..000000000000
--- a/include/linux/platform_data/atmel.h
+++ b/include/linux/platform_data/atmel.h
@@@ -7,8 -7,9 +7,6 @@@
  #ifndef __ATMEL_H__
  #define __ATMEL_H__
  
- #include <linux/serial.h>
 -#include <linux/mtd/nand.h>
 -#include <linux/mtd/partitions.h>
--
   /* Compact Flash */
  struct at91_cf_data {
  	int	irq_pin;		/* I/O IRQ */
@@@ -21,23 -22,26 +19,14 @@@
  #define AT91_IDE_SWAP_A0_A2	0x02
  };
  
-  /* Serial */
- struct atmel_uart_data {
- 	int			num;		/* port num */
- 	short			use_dma_tx;	/* use transmit DMA? */
- 	short			use_dma_rx;	/* use receive DMA? */
- 	void __iomem		*regs;		/* virt. base address, if any */
- 	struct serial_rs485	rs485;		/* rs485 settings */
 - /* NAND / SmartMedia */
 -struct atmel_nand_data {
 -	int		enable_pin;		/* chip enable */
 -	int		det_pin;		/* card detect */
 -	int		rdy_pin;		/* ready/busy */
 -	u8		rdy_pin_active_low;	/* rdy_pin value is inverted */
 -	u8		ale;			/* address line number connected to ALE */
 -	u8		cle;			/* address line number connected to CLE */
 -	u8		bus_width_16;		/* buswidth is 16 bit */
 -	u8		ecc_mode;		/* ecc mode */
 -	u8		on_flash_bbt;		/* bbt on flash */
 -	struct mtd_partition *parts;
 -	unsigned int	num_parts;
 -	bool		has_dma;		/* support dma transfer */
 -
 -	/* default is false, only for at32ap7000 chip is true */
 -	bool		need_reset_workaround;
--};
--
  /* FIXME: this needs a better location, but gets stuff building again */
 +#ifdef CONFIG_ATMEL_PM
  extern int at91_suspend_entering_slow_clock(void);
 +#else
 +static inline int at91_suspend_entering_slow_clock(void)
 +{
 +	return 0;
 +}
 +#endif
  
  #endif /* __ATMEL_H__ */
