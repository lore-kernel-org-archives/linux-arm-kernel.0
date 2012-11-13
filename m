From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 13 Nov 2012 15:15:36 +1100
Subject: linux-next: manual merge of the arm-soc tree with the net-next tree
Message-ID: <20121113151536.50d0292e8cb88b10686b576e@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
drivers/net/ethernet/cadence/at91_ether.c between various commits from
the net-next tree and commit bcd2360c1ff9 ("arm: at91: move platfarm_data
to include/linux/platform_data/atmel.h") from the arm-soc tree.

I fixed it up (I think - see below) and can carry the fix as necessary
(no action is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc drivers/net/ethernet/cadence/at91_ether.c
index e7a476c,35fc6edb..0000000
--- a/drivers/net/ethernet/cadence/at91_ether.c
+++ b/drivers/net/ethernet/cadence/at91_ether.c
@@@ -25,53 -31,728 +25,54 @@@
  #include <linux/clk.h>
  #include <linux/gfp.h>
  #include <linux/phy.h>
 +#include <linux/io.h>
 +#include <linux/of.h>
 +#include <linux/of_device.h>
 +#include <linux/of_net.h>
 +#include <linux/pinctrl/consumer.h>
+ #include <linux/platform_data/atmel.h>
  
 -#include <asm/io.h>
 -#include <asm/uaccess.h>
 -#include <asm/mach-types.h>
 -
 -#include <mach/at91rm9200_emac.h>
 -#include <asm/gpio.h>
 -
 -#include "at91_ether.h"
 -
 -#define DRV_NAME	"at91_ether"
 -#define DRV_VERSION	"1.0"
 -
 -#define LINK_POLL_INTERVAL	(HZ)
 -
 -/* ..................................................................... */
 -
 -/*
 - * Read from a EMAC register.
 - */
 -static inline unsigned long at91_emac_read(struct at91_private *lp, unsigned int reg)
 -{
 -	return __raw_readl(lp->emac_base + reg);
 -}
 -
 -/*
 - * Write to a EMAC register.
 - */
 -static inline void at91_emac_write(struct at91_private *lp, unsigned int reg, unsigned long value)
 -{
 -	__raw_writel(value, lp->emac_base + reg);
 -}
 -
 -/* ........................... PHY INTERFACE ........................... */
 -
 -/*
 - * Enable the MDIO bit in MAC control register
 - * When not called from an interrupt-handler, access to the PHY must be
 - *  protected by a spinlock.
 - */
 -static void enable_mdi(struct at91_private *lp)
 -{
 -	unsigned long ctl;
 -
 -	ctl = at91_emac_read(lp, AT91_EMAC_CTL);
 -	at91_emac_write(lp, AT91_EMAC_CTL, ctl | AT91_EMAC_MPE);	/* enable management port */
 -}
 -
 -/*
 - * Disable the MDIO bit in the MAC control register
 - */
 -static void disable_mdi(struct at91_private *lp)
 -{
 -	unsigned long ctl;
 -
 -	ctl = at91_emac_read(lp, AT91_EMAC_CTL);
 -	at91_emac_write(lp, AT91_EMAC_CTL, ctl & ~AT91_EMAC_MPE);	/* disable management port */
 -}
 -
 -/*
 - * Wait until the PHY operation is complete.
 - */
 -static inline void at91_phy_wait(struct at91_private *lp)
 -{
 -	unsigned long timeout = jiffies + 2;
 -
 -	while (!(at91_emac_read(lp, AT91_EMAC_SR) & AT91_EMAC_SR_IDLE)) {
 -		if (time_after(jiffies, timeout)) {
 -			printk("at91_ether: MIO timeout\n");
 -			break;
 -		}
 -		cpu_relax();
 -	}
 -}
 -
 -/*
 - * Write value to the a PHY register
 - * Note: MDI interface is assumed to already have been enabled.
 - */
 -static void write_phy(struct at91_private *lp, unsigned char phy_addr, unsigned char address, unsigned int value)
 -{
 -	at91_emac_write(lp, AT91_EMAC_MAN, AT91_EMAC_MAN_802_3 | AT91_EMAC_RW_W
 -		| ((phy_addr & 0x1f) << 23) | (address << 18) | (value & AT91_EMAC_DATA));
 -
 -	/* Wait until IDLE bit in Network Status register is cleared */
 -	at91_phy_wait(lp);
 -}
 -
 -/*
 - * Read value stored in a PHY register.
 - * Note: MDI interface is assumed to already have been enabled.
 - */
 -static void read_phy(struct at91_private *lp, unsigned char phy_addr, unsigned char address, unsigned int *value)
 -{
 -	at91_emac_write(lp, AT91_EMAC_MAN, AT91_EMAC_MAN_802_3 | AT91_EMAC_RW_R
 -		| ((phy_addr & 0x1f) << 23) | (address << 18));
 -
 -	/* Wait until IDLE bit in Network Status register is cleared */
 -	at91_phy_wait(lp);
 -
 -	*value = at91_emac_read(lp, AT91_EMAC_MAN) & AT91_EMAC_DATA;
 -}
 -
 -/* ........................... PHY MANAGEMENT .......................... */
 -
 -/*
 - * Access the PHY to determine the current link speed and mode, and update the
 - * MAC accordingly.
 - * If no link or auto-negotiation is busy, then no changes are made.
 - */
 -static void update_linkspeed(struct net_device *dev, int silent)
 -{
 -	struct at91_private *lp = netdev_priv(dev);
 -	unsigned int bmsr, bmcr, lpa, mac_cfg;
 -	unsigned int speed, duplex;
 -
 -	if (!mii_link_ok(&lp->mii)) {		/* no link */
 -		netif_carrier_off(dev);
 -		if (!silent)
 -			printk(KERN_INFO "%s: Link down.\n", dev->name);
 -		return;
 -	}
 -
 -	/* Link up, or auto-negotiation still in progress */
 -	read_phy(lp, lp->phy_address, MII_BMSR, &bmsr);
 -	read_phy(lp, lp->phy_address, MII_BMCR, &bmcr);
 -	if (bmcr & BMCR_ANENABLE) {				/* AutoNegotiation is enabled */
 -		if (!(bmsr & BMSR_ANEGCOMPLETE))
 -			return;			/* Do nothing - another interrupt generated when negotiation complete */
 -
 -		read_phy(lp, lp->phy_address, MII_LPA, &lpa);
 -		if ((lpa & LPA_100FULL) || (lpa & LPA_100HALF)) speed = SPEED_100;
 -		else speed = SPEED_10;
 -		if ((lpa & LPA_100FULL) || (lpa & LPA_10FULL)) duplex = DUPLEX_FULL;
 -		else duplex = DUPLEX_HALF;
 -	} else {
 -		speed = (bmcr & BMCR_SPEED100) ? SPEED_100 : SPEED_10;
 -		duplex = (bmcr & BMCR_FULLDPLX) ? DUPLEX_FULL : DUPLEX_HALF;
 -	}
 -
 -	/* Update the MAC */
 -	mac_cfg = at91_emac_read(lp, AT91_EMAC_CFG) & ~(AT91_EMAC_SPD | AT91_EMAC_FD);
 -	if (speed == SPEED_100) {
 -		if (duplex == DUPLEX_FULL)		/* 100 Full Duplex */
 -			mac_cfg |= AT91_EMAC_SPD | AT91_EMAC_FD;
 -		else					/* 100 Half Duplex */
 -			mac_cfg |= AT91_EMAC_SPD;
 -	} else {
 -		if (duplex == DUPLEX_FULL)		/* 10 Full Duplex */
 -			mac_cfg |= AT91_EMAC_FD;
 -		else {}					/* 10 Half Duplex */
 -	}
 -	at91_emac_write(lp, AT91_EMAC_CFG, mac_cfg);
 -
 -	if (!silent)
 -		printk(KERN_INFO "%s: Link now %i-%s\n", dev->name, speed, (duplex == DUPLEX_FULL) ? "FullDuplex" : "HalfDuplex");
 -	netif_carrier_on(dev);
 -}
 -
 -/*
 - * Handle interrupts from the PHY
 - */
 -static irqreturn_t at91ether_phy_interrupt(int irq, void *dev_id)
 -{
 -	struct net_device *dev = (struct net_device *) dev_id;
 -	struct at91_private *lp = netdev_priv(dev);
 -	unsigned int phy;
 -
 -	/*
 -	 * This hander is triggered on both edges, but the PHY chips expect
 -	 * level-triggering.  We therefore have to check if the PHY actually has
 -	 * an IRQ pending.
 -	 */
 -	enable_mdi(lp);
 -	if ((lp->phy_type == MII_DM9161_ID) || (lp->phy_type == MII_DM9161A_ID)) {
 -		read_phy(lp, lp->phy_address, MII_DSINTR_REG, &phy);	/* ack interrupt in Davicom PHY */
 -		if (!(phy & (1 << 0)))
 -			goto done;
 -	}
 -	else if (lp->phy_type == MII_LXT971A_ID) {
 -		read_phy(lp, lp->phy_address, MII_ISINTS_REG, &phy);	/* ack interrupt in Intel PHY */
 -		if (!(phy & (1 << 2)))
 -			goto done;
 -	}
 -	else if (lp->phy_type == MII_BCM5221_ID) {
 -		read_phy(lp, lp->phy_address, MII_BCMINTR_REG, &phy);	/* ack interrupt in Broadcom PHY */
 -		if (!(phy & (1 << 0)))
 -			goto done;
 -	}
 -	else if (lp->phy_type == MII_KS8721_ID) {
 -		read_phy(lp, lp->phy_address, MII_TPISTATUS, &phy);		/* ack interrupt in Micrel PHY */
 -		if (!(phy & ((1 << 2) | 1)))
 -			goto done;
 -	}
 -	else if (lp->phy_type == MII_T78Q21x3_ID) {					/* ack interrupt in Teridian PHY */
 -		read_phy(lp, lp->phy_address, MII_T78Q21INT_REG, &phy);
 -		if (!(phy & ((1 << 2) | 1)))
 -			goto done;
 -	}
 -	else if (lp->phy_type == MII_DP83848_ID) {
 -		read_phy(lp, lp->phy_address, MII_DPPHYSTS_REG, &phy);	/* ack interrupt in DP83848 PHY */
 -		if (!(phy & (1 << 7)))
 -			goto done;
 -	}
 -
 -	update_linkspeed(dev, 0);
 -
 -done:
 -	disable_mdi(lp);
 -
 -	return IRQ_HANDLED;
 -}
 -
 -/*
 - * Initialize and enable the PHY interrupt for link-state changes
 - */
 -static void enable_phyirq(struct net_device *dev)
 -{
 -	struct at91_private *lp = netdev_priv(dev);
 -	unsigned int dsintr, irq_number;
 -	int status;
 -
 -	if (!gpio_is_valid(lp->board_data.phy_irq_pin)) {
 -		/*
 -		 * PHY doesn't have an IRQ pin (RTL8201, DP83847, AC101L),
 -		 * or board does not have it connected.
 -		 */
 -		mod_timer(&lp->check_timer, jiffies + LINK_POLL_INTERVAL);
 -		return;
 -	}
 -
 -	irq_number = gpio_to_irq(lp->board_data.phy_irq_pin);
 -	status = request_irq(irq_number, at91ether_phy_interrupt, 0, dev->name, dev);
 -	if (status) {
 -		printk(KERN_ERR "at91_ether: PHY IRQ %d request failed - status %d!\n", irq_number, status);
 -		return;
 -	}
 -
 -	spin_lock_irq(&lp->lock);
 -	enable_mdi(lp);
 -
 -	if ((lp->phy_type == MII_DM9161_ID) || (lp->phy_type == MII_DM9161A_ID)) {	/* for Davicom PHY */
 -		read_phy(lp, lp->phy_address, MII_DSINTR_REG, &dsintr);
 -		dsintr = dsintr & ~0xf00;		/* clear bits 8..11 */
 -		write_phy(lp, lp->phy_address, MII_DSINTR_REG, dsintr);
 -	}
 -	else if (lp->phy_type == MII_LXT971A_ID) {	/* for Intel PHY */
 -		read_phy(lp, lp->phy_address, MII_ISINTE_REG, &dsintr);
 -		dsintr = dsintr | 0xf2;			/* set bits 1, 4..7 */
 -		write_phy(lp, lp->phy_address, MII_ISINTE_REG, dsintr);
 -	}
 -	else if (lp->phy_type == MII_BCM5221_ID) {	/* for Broadcom PHY */
 -		dsintr = (1 << 15) | ( 1 << 14);
 -		write_phy(lp, lp->phy_address, MII_BCMINTR_REG, dsintr);
 -	}
 -	else if (lp->phy_type == MII_KS8721_ID) {	/* for Micrel PHY */
 -		dsintr = (1 << 10) | ( 1 << 8);
 -		write_phy(lp, lp->phy_address, MII_TPISTATUS, dsintr);
 -	}
 -	else if (lp->phy_type == MII_T78Q21x3_ID) {	/* for Teridian PHY */
 -		read_phy(lp, lp->phy_address, MII_T78Q21INT_REG, &dsintr);
 -		dsintr = dsintr | 0x500;		/* set bits 8, 10 */
 -		write_phy(lp, lp->phy_address, MII_T78Q21INT_REG, dsintr);
 -	}
 -	else if (lp->phy_type == MII_DP83848_ID) {	/* National Semiconductor DP83848 PHY */
 -		read_phy(lp, lp->phy_address, MII_DPMISR_REG, &dsintr);
 -		dsintr = dsintr | 0x3c;			/* set bits 2..5 */
 -		write_phy(lp, lp->phy_address, MII_DPMISR_REG, dsintr);
 -		read_phy(lp, lp->phy_address, MII_DPMICR_REG, &dsintr);
 -		dsintr = dsintr | 0x3;			/* set bits 0,1 */
 -		write_phy(lp, lp->phy_address, MII_DPMICR_REG, dsintr);
 -	}
 -
 -	disable_mdi(lp);
 -	spin_unlock_irq(&lp->lock);
 -}
 -
 -/*
 - * Disable the PHY interrupt
 - */
 -static void disable_phyirq(struct net_device *dev)
 -{
 -	struct at91_private *lp = netdev_priv(dev);
 -	unsigned int dsintr;
 -	unsigned int irq_number;
 -
 -	if (!gpio_is_valid(lp->board_data.phy_irq_pin)) {
 -		del_timer_sync(&lp->check_timer);
 -		return;
 -	}
 -
 -	spin_lock_irq(&lp->lock);
 -	enable_mdi(lp);
 -
 -	if ((lp->phy_type == MII_DM9161_ID) || (lp->phy_type == MII_DM9161A_ID)) {	/* for Davicom PHY */
 -		read_phy(lp, lp->phy_address, MII_DSINTR_REG, &dsintr);
 -		dsintr = dsintr | 0xf00;			/* set bits 8..11 */
 -		write_phy(lp, lp->phy_address, MII_DSINTR_REG, dsintr);
 -	}
 -	else if (lp->phy_type == MII_LXT971A_ID) {	/* for Intel PHY */
 -		read_phy(lp, lp->phy_address, MII_ISINTE_REG, &dsintr);
 -		dsintr = dsintr & ~0xf2;			/* clear bits 1, 4..7 */
 -		write_phy(lp, lp->phy_address, MII_ISINTE_REG, dsintr);
 -	}
 -	else if (lp->phy_type == MII_BCM5221_ID) {	/* for Broadcom PHY */
 -		read_phy(lp, lp->phy_address, MII_BCMINTR_REG, &dsintr);
 -		dsintr = ~(1 << 14);
 -		write_phy(lp, lp->phy_address, MII_BCMINTR_REG, dsintr);
 -	}
 -	else if (lp->phy_type == MII_KS8721_ID) {	/* for Micrel PHY */
 -		read_phy(lp, lp->phy_address, MII_TPISTATUS, &dsintr);
 -		dsintr = ~((1 << 10) | (1 << 8));
 -		write_phy(lp, lp->phy_address, MII_TPISTATUS, dsintr);
 -	}
 -	else if (lp->phy_type == MII_T78Q21x3_ID) {	/* for Teridian PHY */
 -		read_phy(lp, lp->phy_address, MII_T78Q21INT_REG, &dsintr);
 -		dsintr = dsintr & ~0x500;			/* clear bits 8, 10 */
 -		write_phy(lp, lp->phy_address, MII_T78Q21INT_REG, dsintr);
 -	}
 -	else if (lp->phy_type == MII_DP83848_ID) {	/* National Semiconductor DP83848 PHY */
 -		read_phy(lp, lp->phy_address, MII_DPMICR_REG, &dsintr);
 -		dsintr = dsintr & ~0x3;				/* clear bits 0, 1 */
 -		write_phy(lp, lp->phy_address, MII_DPMICR_REG, dsintr);
 -		read_phy(lp, lp->phy_address, MII_DPMISR_REG, &dsintr);
 -		dsintr = dsintr & ~0x3c;			/* clear bits 2..5 */
 -		write_phy(lp, lp->phy_address, MII_DPMISR_REG, dsintr);
 -	}
 -
 -	disable_mdi(lp);
 -	spin_unlock_irq(&lp->lock);
 -
 -	irq_number = gpio_to_irq(lp->board_data.phy_irq_pin);
 -	free_irq(irq_number, dev);			/* Free interrupt handler */
 -}
 -
 -/*
 - * Perform a software reset of the PHY.
 - */
 -#if 0
 -static void reset_phy(struct net_device *dev)
 -{
 -	struct at91_private *lp = netdev_priv(dev);
 -	unsigned int bmcr;
 -
 -	spin_lock_irq(&lp->lock);
 -	enable_mdi(lp);
 -
 -	/* Perform PHY reset */
 -	write_phy(lp, lp->phy_address, MII_BMCR, BMCR_RESET);
 -
 -	/* Wait until PHY reset is complete */
 -	do {
 -		read_phy(lp, lp->phy_address, MII_BMCR, &bmcr);
 -	} while (!(bmcr & BMCR_RESET));
 -
 -	disable_mdi(lp);
 -	spin_unlock_irq(&lp->lock);
 -}
 -#endif
 -
 -static void at91ether_check_link(unsigned long dev_id)
 -{
 -	struct net_device *dev = (struct net_device *) dev_id;
 -	struct at91_private *lp = netdev_priv(dev);
 -
 -	enable_mdi(lp);
 -	update_linkspeed(dev, 1);
 -	disable_mdi(lp);
 -
 -	mod_timer(&lp->check_timer, jiffies + LINK_POLL_INTERVAL);
 -}
 -
 -/*
 - * Perform any PHY-specific initialization.
 - */
 -static void __init initialize_phy(struct at91_private *lp)
 -{
 -	unsigned int val;
 -
 -	spin_lock_irq(&lp->lock);
 -	enable_mdi(lp);
 -
 -	if ((lp->phy_type == MII_DM9161_ID) || (lp->phy_type == MII_DM9161A_ID)) {
 -		read_phy(lp, lp->phy_address, MII_DSCR_REG, &val);
 -		if ((val & (1 << 10)) == 0)			/* DSCR bit 10 is 0 -- fiber mode */
 -			lp->phy_media = PORT_FIBRE;
 -	} else if (machine_is_csb337()) {
 -		/* mix link activity status into LED2 link state */
 -		write_phy(lp, lp->phy_address, MII_LEDCTRL_REG, 0x0d22);
 -	} else if (machine_is_ecbat91())
 -		write_phy(lp, lp->phy_address, MII_LEDCTRL_REG, 0x156A);
 -
 -	disable_mdi(lp);
 -	spin_unlock_irq(&lp->lock);
 -}
 -
 -/* ......................... ADDRESS MANAGEMENT ........................ */
 -
 -/*
 - * NOTE: Your bootloader must always set the MAC address correctly before
 - * booting into Linux.
 - *
 - * - It must always set the MAC address after reset, even if it doesn't
 - *   happen to access the Ethernet while it's booting.  Some versions of
 - *   U-Boot on the AT91RM9200-DK do not do this.
 - *
 - * - Likewise it must store the addresses in the correct byte order.
 - *   MicroMonitor (uMon) on the CSB337 does this incorrectly (and
 - *   continues to do so, for bug-compatibility).
 - */
 -
 -static short __init unpack_mac_address(struct net_device *dev, unsigned int hi, unsigned int lo)
 -{
 -	char addr[6];
 -
 -	if (machine_is_csb337()) {
 -		addr[5] = (lo & 0xff);			/* The CSB337 bootloader stores the MAC the wrong-way around */
 -		addr[4] = (lo & 0xff00) >> 8;
 -		addr[3] = (lo & 0xff0000) >> 16;
 -		addr[2] = (lo & 0xff000000) >> 24;
 -		addr[1] = (hi & 0xff);
 -		addr[0] = (hi & 0xff00) >> 8;
 -	}
 -	else {
 -		addr[0] = (lo & 0xff);
 -		addr[1] = (lo & 0xff00) >> 8;
 -		addr[2] = (lo & 0xff0000) >> 16;
 -		addr[3] = (lo & 0xff000000) >> 24;
 -		addr[4] = (hi & 0xff);
 -		addr[5] = (hi & 0xff00) >> 8;
 -	}
 -
 -	if (is_valid_ether_addr(addr)) {
 -		memcpy(dev->dev_addr, &addr, 6);
 -		return 1;
 -	}
 -	return 0;
 -}
 -
 -/*
 - * Set the ethernet MAC address in dev->dev_addr
 - */
 -static void __init get_mac_address(struct net_device *dev)
 -{
 -	struct at91_private *lp = netdev_priv(dev);
 -
 -	/* Check Specific-Address 1 */
 -	if (unpack_mac_address(dev, at91_emac_read(lp, AT91_EMAC_SA1H), at91_emac_read(lp, AT91_EMAC_SA1L)))
 -		return;
 -	/* Check Specific-Address 2 */
 -	if (unpack_mac_address(dev, at91_emac_read(lp, AT91_EMAC_SA2H), at91_emac_read(lp, AT91_EMAC_SA2L)))
 -		return;
 -	/* Check Specific-Address 3 */
 -	if (unpack_mac_address(dev, at91_emac_read(lp, AT91_EMAC_SA3H), at91_emac_read(lp, AT91_EMAC_SA3L)))
 -		return;
 -	/* Check Specific-Address 4 */
 -	if (unpack_mac_address(dev, at91_emac_read(lp, AT91_EMAC_SA4H), at91_emac_read(lp, AT91_EMAC_SA4L)))
 -		return;
 -
 -	printk(KERN_ERR "at91_ether: Your bootloader did not configure a MAC address.\n");
 -}
 -
 -/*
 - * Program the hardware MAC address from dev->dev_addr.
 - */
 -static void update_mac_address(struct net_device *dev)
 -{
 -	struct at91_private *lp = netdev_priv(dev);
 -
 -	at91_emac_write(lp, AT91_EMAC_SA1L, (dev->dev_addr[3] << 24) | (dev->dev_addr[2] << 16) | (dev->dev_addr[1] << 8) | (dev->dev_addr[0]));
 -	at91_emac_write(lp, AT91_EMAC_SA1H, (dev->dev_addr[5] << 8) | (dev->dev_addr[4]));
 -
 -	at91_emac_write(lp, AT91_EMAC_SA2L, 0);
 -	at91_emac_write(lp, AT91_EMAC_SA2H, 0);
 -}
 -
 -/*
 - * Store the new hardware address in dev->dev_addr, and update the MAC.
 - */
 -static int set_mac_address(struct net_device *dev, void* addr)
 -{
 -	struct sockaddr *address = addr;
 -
 -	if (!is_valid_ether_addr(address->sa_data))
 -		return -EADDRNOTAVAIL;
 -
 -	memcpy(dev->dev_addr, address->sa_data, dev->addr_len);
 -	update_mac_address(dev);
 +#include "macb.h"
  
 -	printk("%s: Setting MAC address to %pM\n", dev->name,
 -	       dev->dev_addr);
 +/* 1518 rounded up */
 +#define MAX_RBUFF_SZ	0x600
 +/* max number of receive buffers */
 +#define MAX_RX_DESCR	9
  
 -	return 0;
 -}
 -
 -static int inline hash_bit_value(int bitnr, __u8 *addr)
 -{
 -	if (addr[bitnr / 8] & (1 << (bitnr % 8)))
 -		return 1;
 -	return 0;
 -}
 -
 -/*
 - * The hash address register is 64 bits long and takes up two locations in the memory map.
 - * The least significant bits are stored in EMAC_HSL and the most significant
 - * bits in EMAC_HSH.
 - *
 - * The unicast hash enable and the multicast hash enable bits in the network configuration
 - *  register enable the reception of hash matched frames. The destination address is
 - *  reduced to a 6 bit index into the 64 bit hash register using the following hash function.
 - * The hash function is an exclusive or of every sixth bit of the destination address.
 - *   hash_index[5] = da[5] ^ da[11] ^ da[17] ^ da[23] ^ da[29] ^ da[35] ^ da[41] ^ da[47]
 - *   hash_index[4] = da[4] ^ da[10] ^ da[16] ^ da[22] ^ da[28] ^ da[34] ^ da[40] ^ da[46]
 - *   hash_index[3] = da[3] ^ da[09] ^ da[15] ^ da[21] ^ da[27] ^ da[33] ^ da[39] ^ da[45]
 - *   hash_index[2] = da[2] ^ da[08] ^ da[14] ^ da[20] ^ da[26] ^ da[32] ^ da[38] ^ da[44]
 - *   hash_index[1] = da[1] ^ da[07] ^ da[13] ^ da[19] ^ da[25] ^ da[31] ^ da[37] ^ da[43]
 - *   hash_index[0] = da[0] ^ da[06] ^ da[12] ^ da[18] ^ da[24] ^ da[30] ^ da[36] ^ da[42]
 - * da[0] represents the least significant bit of the first byte received, that is, the multicast/
 - *  unicast indicator, and da[47] represents the most significant bit of the last byte
 - *  received.
 - * If the hash index points to a bit that is set in the hash register then the frame will be
 - *  matched according to whether the frame is multicast or unicast.
 - * A multicast match will be signalled if the multicast hash enable bit is set, da[0] is 1 and
 - *  the hash index points to a bit set in the hash register.
 - * A unicast match will be signalled if the unicast hash enable bit is set, da[0] is 0 and the
 - *  hash index points to a bit set in the hash register.
 - * To receive all multicast frames, the hash register should be set with all ones and the
 - *  multicast hash enable bit should be set in the network configuration register.
 - */
 -
 -/*
 - * Return the hash index value for the specified address.
 - */
 -static int hash_get_index(__u8 *addr)
 -{
 -	int i, j, bitval;
 -	int hash_index = 0;
 -
 -	for (j = 0; j < 6; j++) {
 -		for (i = 0, bitval = 0; i < 8; i++)
 -			bitval ^= hash_bit_value(i*6 + j, addr);
 -
 -		hash_index |= (bitval << j);
 -	}
 -
 -	return hash_index;
 -}
 -
 -/*
 - * Add multicast addresses to the internal multicast-hash table.
 - */
 -static void at91ether_sethashtable(struct net_device *dev)
 +/* Initialize and start the Receiver and Transmit subsystems */
 +static int at91ether_start(struct net_device *dev)
  {
 -	struct at91_private *lp = netdev_priv(dev);
 -	struct netdev_hw_addr *ha;
 -	unsigned long mc_filter[2];
 -	unsigned int bitnr;
 -
 -	mc_filter[0] = mc_filter[1] = 0;
 -
 -	netdev_for_each_mc_addr(ha, dev) {
 -		bitnr = hash_get_index(ha->addr);
 -		mc_filter[bitnr >> 5] |= 1 << (bitnr & 31);
 -	}
 -
 -	at91_emac_write(lp, AT91_EMAC_HSL, mc_filter[0]);
 -	at91_emac_write(lp, AT91_EMAC_HSH, mc_filter[1]);
 -}
 +	struct macb *lp = netdev_priv(dev);
 +	dma_addr_t addr;
 +	u32 ctl;
 +	int i;
  
 -/*
 - * Enable/Disable promiscuous and multicast modes.
 - */
 -static void at91ether_set_multicast_list(struct net_device *dev)
 -{
 -	struct at91_private *lp = netdev_priv(dev);
 -	unsigned long cfg;
 -
 -	cfg = at91_emac_read(lp, AT91_EMAC_CFG);
 -
 -	if (dev->flags & IFF_PROMISC)			/* Enable promiscuous mode */
 -		cfg |= AT91_EMAC_CAF;
 -	else if (dev->flags & (~IFF_PROMISC))		/* Disable promiscuous mode */
 -		cfg &= ~AT91_EMAC_CAF;
 -
 -	if (dev->flags & IFF_ALLMULTI) {		/* Enable all multicast mode */
 -		at91_emac_write(lp, AT91_EMAC_HSH, -1);
 -		at91_emac_write(lp, AT91_EMAC_HSL, -1);
 -		cfg |= AT91_EMAC_MTI;
 -	} else if (!netdev_mc_empty(dev)) { /* Enable specific multicasts */
 -		at91ether_sethashtable(dev);
 -		cfg |= AT91_EMAC_MTI;
 -	} else if (dev->flags & (~IFF_ALLMULTI)) {	/* Disable all multicast mode */
 -		at91_emac_write(lp, AT91_EMAC_HSH, 0);
 -		at91_emac_write(lp, AT91_EMAC_HSL, 0);
 -		cfg &= ~AT91_EMAC_MTI;
 +	lp->rx_ring = dma_alloc_coherent(&lp->pdev->dev,
 +					MAX_RX_DESCR * sizeof(struct macb_dma_desc),
 +					&lp->rx_ring_dma, GFP_KERNEL);
 +	if (!lp->rx_ring) {
 +		netdev_err(dev, "unable to alloc rx ring DMA buffer\n");
 +		return -ENOMEM;
  	}
  
 -	at91_emac_write(lp, AT91_EMAC_CFG, cfg);
 -}
 -
 -/* ......................... ETHTOOL SUPPORT ........................... */
 -
 -static int mdio_read(struct net_device *dev, int phy_id, int location)
 -{
 -	struct at91_private *lp = netdev_priv(dev);
 -	unsigned int value;
 -
 -	read_phy(lp, phy_id, location, &value);
 -	return value;
 -}
 -
 -static void mdio_write(struct net_device *dev, int phy_id, int location, int value)
 -{
 -	struct at91_private *lp = netdev_priv(dev);
 -
 -	write_phy(lp, phy_id, location, value);
 -}
 -
 -static int at91ether_get_settings(struct net_device *dev, struct ethtool_cmd *cmd)
 -{
 -	struct at91_private *lp = netdev_priv(dev);
 -	int ret;
 -
 -	spin_lock_irq(&lp->lock);
 -	enable_mdi(lp);
 -
 -	ret = mii_ethtool_gset(&lp->mii, cmd);
 -
 -	disable_mdi(lp);
 -	spin_unlock_irq(&lp->lock);
 +	lp->rx_buffers = dma_alloc_coherent(&lp->pdev->dev,
 +					MAX_RX_DESCR * MAX_RBUFF_SZ,
 +					&lp->rx_buffers_dma, GFP_KERNEL);
 +	if (!lp->rx_buffers) {
 +		netdev_err(dev, "unable to alloc rx data DMA buffer\n");
  
 -	if (lp->phy_media == PORT_FIBRE) {		/* override media type since mii.c doesn't know */
 -		cmd->supported = SUPPORTED_FIBRE;
 -		cmd->port = PORT_FIBRE;
 +		dma_free_coherent(&lp->pdev->dev,
 +					MAX_RX_DESCR * sizeof(struct macb_dma_desc),
 +					lp->rx_ring, lp->rx_ring_dma);
 +		lp->rx_ring = NULL;
 +		return -ENOMEM;
  	}
  
 -	return ret;
 -}
 -
 -static int at91ether_set_settings(struct net_device *dev, struct ethtool_cmd *cmd)
 -{
 -	struct at91_private *lp = netdev_priv(dev);
 -	int ret;
 -
 -	spin_lock_irq(&lp->lock);
 -	enable_mdi(lp);
 -
 -	ret = mii_ethtool_sset(&lp->mii, cmd);
 -
 -	disable_mdi(lp);
 -	spin_unlock_irq(&lp->lock);
 -
 -	return ret;
 -}
 -
 -static int at91ether_nwayreset(struct net_device *dev)
 -{
 -	struct at91_private *lp = netdev_priv(dev);
 -	int ret;
 -
 -	spin_lock_irq(&lp->lock);
 -	enable_mdi(lp);
 -
 -	ret = mii_nway_restart(&lp->mii);
 -
 -	disable_mdi(lp);
 -	spin_unlock_irq(&lp->lock);
 -
 -	return ret;
 -}
 -
 -static void at91ether_get_drvinfo(struct net_device *dev, struct ethtool_drvinfo *info)
 -{
 -	strlcpy(info->driver, DRV_NAME, sizeof(info->driver));
 -	strlcpy(info->version, DRV_VERSION, sizeof(info->version));
 -	strlcpy(info->bus_info, dev_name(dev->dev.parent), sizeof(info->bus_info));
 -}
 -
 -static const struct ethtool_ops at91ether_ethtool_ops = {
 -	.get_settings	= at91ether_get_settings,
 -	.set_settings	= at91ether_set_settings,
 -	.get_drvinfo	= at91ether_get_drvinfo,
 -	.nway_reset	= at91ether_nwayreset,
 -	.get_link	= ethtool_op_get_link,
 -};
 -
 -static int at91ether_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 -{
 -	struct at91_private *lp = netdev_priv(dev);
 -	int res;
 -
 -	if (!netif_running(dev))
 -		return -EINVAL;
 -
 -	spin_lock_irq(&lp->lock);
 -	enable_mdi(lp);
 -	res = generic_mii_ioctl(&lp->mii, if_mii(rq), cmd, NULL);
 -	disable_mdi(lp);
 -	spin_unlock_irq(&lp->lock);
 -
 -	return res;
 -}
 -
 -/* ................................ MAC ................................ */
 -
 -/*
 - * Initialize and start the Receiver and Transmit subsystems
 - */
 -static void at91ether_start(struct net_device *dev)
 -{
 -	struct at91_private *lp = netdev_priv(dev);
 -	struct recv_desc_bufs *dlist, *dlist_phys;
 -	int i;
 -	unsigned long ctl;
 -
 -	dlist = lp->dlist;
 -	dlist_phys = lp->dlist_phys;
 -
 +	addr = lp->rx_buffers_dma;
  	for (i = 0; i < MAX_RX_DESCR; i++) {
 -		dlist->descriptors[i].addr = (unsigned int) &dlist_phys->recv_buf[i][0];
 -		dlist->descriptors[i].size = 0;
 +		lp->rx_ring[i].addr = addr;
 +		lp->rx_ring[i].ctrl = 0;
 +		addr += MAX_RBUFF_SZ;
  	}
  
  	/* Set the Wrap bit on the last descriptor */
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121113/578b083b/attachment-0001.sig>
