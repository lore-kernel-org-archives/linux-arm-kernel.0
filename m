From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 2 Dec 2012 00:11:41 +0000
Subject: [PATCH] ARM: ixp4xx: Add "ask" handler for timer interrupts
In-Reply-To: <20121201214525.GI12509@titan.lakedaemon.net>
References: <1354347213-22237-1-git-send-email-shc_work@mail.ru>
 <201212012125.51935.arnd@arndb.de>
 <20121201214525.GI12509@titan.lakedaemon.net>
Message-ID: <201212020011.42105.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 01 December 2012, Jason Cooper wrote:
> On Sat, Dec 01, 2012 at 09:25:51PM +0000, Arnd Bergmann wrote:
> > On Saturday 01 December 2012, Alexander Shiyan wrote:
> > > +       switch (d->irq) {
> > > +       case IRQ_IXP4XX_TIMER1:
> > > +               *IXP4XX_OSST = IXP4XX_OSST_TIMER_1_PEND;
> > > +               break;
> > > +       case IRQ_IXP4XX_TIMER2:
> > > +               *IXP4XX_OSST = IXP4XX_OSST_TIMER_2_PEND;
> > > +               break;
> > > +       case IRQ_IXP4XX_TIMESTAMP:
> > > +               *IXP4XX_OSST = IXP4XX_OSST_TIMER_TS_PEND;
> > > +               break;
> > > +       case IRQ_IXP4XX_WDOG:
> > > +               *IXP4XX_OSST = IXP4XX_OSST_TIMER_WDOG_PEND;
> > > +               break;
> > 
> > Since you are touching these lines, it probably makes sense to convert them
> > to use writel_relaxed() in the process. Dereferencing a volatile pointer
> > in order to do MMIO is strongly discouraged, see
> > Documentation/volatile-considered-harmful.txt
> 
> Arnd,
> 
> I took a quick look at the ixp4xx code when I saw this.  It appears the
> entire sub-arch is written this way :-(  Perhaps it would be better to
> do a cleanup patch before this one?  I didn't mention it in my initial
> comment because it looks like quite a bit of work.
> 
> In either case, it's all cleanup, so it shouldn't cause a dependency
> headache.
> 
> Alexander, if you're so inclined, a cleanup series would be much
> appreciated.  If you don't have the time, no problem, just make the
> changes suggested by Arnd and I and we'll get to the cleanup eventually.

I got curious to how hard this would be and ended up with a patch.

	Arnd

8<--------
[PATCH] ARM: ixp4xx: use proper __iomem annotations consistently

The ixp4xx platform on ARM is one of the remaining locations still using
direct pointer dereferences for MMIO access. This patch should convert
all known instances to use readl_relaxed/writel_relaxed.

I could not find a nice solution for mach/hardware.h, which is included
by mach/io.h indirectly but actually requires MMIO accesses as defined
in asm/io.h. Using a macro as a workaround helps, but the better solution
in the long run would be to have a proper gpiolib driver rather than
using a private API to do GPIO.

I did not touch the definitions used in drivers/usb/gadget/pxa25x_udc.c,
they are shared with the pxa platform and ever more screwed up than the
other ones in ixp4xx that I fixed.

In the process of doing this patch, I noticed that indirect PCI access
on ixp4xx is broken since the PCIBIOS_MIN_MEM consolidateion, and this
does not get fixed here.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/arch/arm/mach-ixp4xx/avila-setup.c b/arch/arm/mach-ixp4xx/avila-setup.c
index 90e42e9..6cb33b9 100644
--- a/arch/arm/mach-ixp4xx/avila-setup.c
+++ b/arch/arm/mach-ixp4xx/avila-setup.c
@@ -78,7 +78,7 @@ static struct resource avila_uart_resources[] = {
 static struct plat_serial8250_port avila_uart_data[] = {
 	{
 		.mapbase	= IXP4XX_UART1_BASE_PHYS,
-		.membase	= (char *)IXP4XX_UART1_BASE_VIRT + REG_OFFSET,
+		.membase	= IXP4XX_UART1_BASE_VIRT + REG_OFFSET,
 		.irq		= IRQ_IXP4XX_UART1,
 		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST,
 		.iotype		= UPIO_MEM,
@@ -87,7 +87,7 @@ static struct plat_serial8250_port avila_uart_data[] = {
 	},
 	{
 		.mapbase	= IXP4XX_UART2_BASE_PHYS,
-		.membase	= (char *)IXP4XX_UART2_BASE_VIRT + REG_OFFSET,
+		.membase	= IXP4XX_UART2_BASE_VIRT + REG_OFFSET,
 		.irq		= IRQ_IXP4XX_UART2,
 		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST,
 		.iotype		= UPIO_MEM,
diff --git a/arch/arm/mach-ixp4xx/common-pci.c b/arch/arm/mach-ixp4xx/common-pci.c
index 1694f01..05b5722 100644
--- a/arch/arm/mach-ixp4xx/common-pci.c
+++ b/arch/arm/mach-ixp4xx/common-pci.c
@@ -63,8 +63,8 @@ static void crp_read(u32 ad_cbe, u32 *data)
 {
 	unsigned long flags;
 	raw_spin_lock_irqsave(&ixp4xx_pci_lock, flags);
-	*PCI_CRP_AD_CBE = ad_cbe;
-	*data = *PCI_CRP_RDATA;
+	writel_relaxed(ad_cbe, PCI_CRP_AD_CBE);
+	*data = readl_relaxed(PCI_CRP_RDATA);
 	raw_spin_unlock_irqrestore(&ixp4xx_pci_lock, flags);
 }
 
@@ -75,19 +75,19 @@ static void crp_write(u32 ad_cbe, u32 data)
 { 
 	unsigned long flags;
 	raw_spin_lock_irqsave(&ixp4xx_pci_lock, flags);
-	*PCI_CRP_AD_CBE = CRP_AD_CBE_WRITE | ad_cbe;
-	*PCI_CRP_WDATA = data;
+	writel_relaxed(CRP_AD_CBE_WRITE | ad_cbe, PCI_CRP_AD_CBE);
+	writel_relaxed(data, PCI_CRP_WDATA);
 	raw_spin_unlock_irqrestore(&ixp4xx_pci_lock, flags);
 }
 
 static inline int check_master_abort(void)
 {
 	/* check Master Abort bit after access */
-	unsigned long isr = *PCI_ISR;
+	unsigned long isr = readl_relaxed(PCI_ISR);
 
 	if (isr & PCI_ISR_PFE) {
 		/* make sure the Master Abort bit is reset */    
-		*PCI_ISR = PCI_ISR_PFE;
+		writel_relaxed(PCI_ISR_PFE, PCI_ISR);
 		pr_debug("%s failed\n", __func__);
 		return 1;
 	}
@@ -103,16 +103,16 @@ int ixp4xx_pci_read_errata(u32 addr, u32 cmd, u32* data)
 
 	raw_spin_lock_irqsave(&ixp4xx_pci_lock, flags);
 
-	*PCI_NP_AD = addr;
+	writel_relaxed(addr, PCI_NP_AD);
 
 	/* 
 	 * PCI workaround  - only works if NP PCI space reads have 
 	 * no side effects!!! Read 8 times. last one will be good.
 	 */
 	for (i = 0; i < 8; i++) {
-		*PCI_NP_CBE = cmd;
-		*data = *PCI_NP_RDATA;
-		*data = *PCI_NP_RDATA;
+		writel_relaxed(cmd, PCI_NP_CBE);
+		*data = readl_relaxed(PCI_NP_RDATA);
+		*data = readl_relaxed(PCI_NP_RDATA);
 	}
 
 	if(check_master_abort())
@@ -129,13 +129,13 @@ int ixp4xx_pci_read_no_errata(u32 addr, u32 cmd, u32* data)
 
 	raw_spin_lock_irqsave(&ixp4xx_pci_lock, flags);
 
-	*PCI_NP_AD = addr;
+	writel_relaxed(addr, PCI_NP_AD);
 
-	/* set up and execute the read */    
-	*PCI_NP_CBE = cmd;
+	/* set up and execute the read */
+	writel_relaxed(cmd, PCI_NP_CBE);
 
 	/* the result of the read is now in NP_RDATA */
-	*data = *PCI_NP_RDATA; 
+	*data = readl_relaxed(PCI_NP_RDATA);
 
 	if(check_master_abort())
 		retval = 1;
@@ -151,13 +151,13 @@ int ixp4xx_pci_write(u32 addr, u32 cmd, u32 data)
 
 	raw_spin_lock_irqsave(&ixp4xx_pci_lock, flags);
 
-	*PCI_NP_AD = addr;
+	writel_relaxed(addr, PCI_NP_AD);
 
 	/* set up the write */
-	*PCI_NP_CBE = cmd;
+	writel_relaxed(cmd, PCI_NP_CBE);
 
 	/* execute the write by writing to NP_WDATA */
-	*PCI_NP_WDATA = data;
+	writel_relaxed(data, PCI_NP_WDATA);
 
 	if(check_master_abort())
 		retval = 1;
@@ -295,13 +295,13 @@ static int abort_handler(unsigned long addr, unsigned int fsr, struct pt_regs *r
 {
 	u32 isr, status;
 
-	isr = *PCI_ISR;
+	isr = readl_relaxed(PCI_ISR);
 	local_read_config(PCI_STATUS, 2, &status);
 	pr_debug("PCI: abort_handler addr = %#lx, isr = %#x, "
 		"status = %#x\n", addr, isr, status);
 
 	/* make sure the Master Abort bit is reset */    
-	*PCI_ISR = PCI_ISR_PFE;
+	writel_relaxed(PCI_ISR_PFE, PCI_ISR);
 	status |= PCI_STATUS_REC_MASTER_ABORT;
 	local_write_config(PCI_STATUS, 2, status);
 
@@ -373,19 +373,19 @@ void __init ixp4xx_pci_preinit(void)
 	 * We use identity AHB->PCI address translation
 	 * in the 0x48000000 to 0x4bffffff address space
 	 */
-	*PCI_PCIMEMBASE = 0x48494A4B;
+	writel_relaxed(0x48494A4B, PCI_PCIMEMBASE);
 
 	/*
 	 * We also use identity PCI->AHB address translation
 	 * in 4 16MB BARs that begin at the physical memory start
 	 */
-	*PCI_AHBMEMBASE = (PHYS_OFFSET & 0xFF000000) +
+	writel_relaxed((PHYS_OFFSET & 0xFF000000) +
 		((PHYS_OFFSET & 0xFF000000) >> 8) +
 		((PHYS_OFFSET & 0xFF000000) >> 16) +
 		((PHYS_OFFSET & 0xFF000000) >> 24) +
-		0x00010203;
+		0x00010203, PCI_AHBMEMBASE);
 
-	if (*PCI_CSR & PCI_CSR_HOST) {
+	if (readl_relaxed(PCI_CSR) & PCI_CSR_HOST) {
 		printk("PCI: IXP4xx is host\n");
 
 		pr_debug("setup BARs in controller\n");
@@ -423,7 +423,7 @@ void __init ixp4xx_pci_preinit(void)
 		);
 
 	pr_debug("clear error bits in ISR\n");
-	*PCI_ISR = PCI_ISR_PSE | PCI_ISR_PFE | PCI_ISR_PPE | PCI_ISR_AHBE;
+	writel_relaxed(PCI_ISR_PSE | PCI_ISR_PFE | PCI_ISR_PPE | PCI_ISR_AHBE, PCI_ISR);
 
 	/*
 	 * Set Initialize Complete in PCI Control Register: allow IXP4XX to
@@ -432,9 +432,10 @@ void __init ixp4xx_pci_preinit(void)
 	 * little-endian PCI and the big-endian AHB bus 
 	 */
 #ifdef __ARMEB__
-	*PCI_CSR = PCI_CSR_IC | PCI_CSR_ABE | PCI_CSR_PDS | PCI_CSR_ADS;
+	writel_relaxed(PCI_CSR_IC | PCI_CSR_ABE | PCI_CSR_PDS |
+	PCI_CSR_ADS, PCI_CSR);
 #else
-	*PCI_CSR = PCI_CSR_IC | PCI_CSR_ABE;
+	writel_relaxed(PCI_CSR_IC | PCI_CSR_ABE, PCI_CSR);
 #endif
 
 	pr_debug("DONE\n");
diff --git a/arch/arm/mach-ixp4xx/common.c b/arch/arm/mach-ixp4xx/common.c
index fdf91a1..ecc2f32 100644
--- a/arch/arm/mach-ixp4xx/common.c
+++ b/arch/arm/mach-ixp4xx/common.c
@@ -32,7 +32,6 @@
 
 #include <mach/udc.h>
 #include <mach/hardware.h>
-#include <mach/io.h>
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
 #include <asm/page.h>
@@ -135,7 +134,7 @@ static int ixp4xx_set_irq_type(struct irq_data *d, unsigned int type)
 	int line = irq2gpio[d->irq];
 	u32 int_style;
 	enum ixp4xx_irq_type irq_type;
-	volatile u32 *int_reg;
+	u32 __iomem *int_reg;
 
 	/*
 	 * Only for GPIO IRQs
@@ -181,13 +180,16 @@ static int ixp4xx_set_irq_type(struct irq_data *d, unsigned int type)
 	}
 
 	/* Clear the style for the appropriate pin */
-	*int_reg &= ~(IXP4XX_GPIO_STYLE_CLEAR <<
-	    		(line * IXP4XX_GPIO_STYLE_SIZE));
+	writel_relaxed(readl_relaxed(int_reg) &
+			~IXP4XX_GPIO_STYLE_CLEAR << (line *
+			IXP4XX_GPIO_STYLE_SIZE), int_reg);
 
-	*IXP4XX_GPIO_GPISR = (1 << line);
+	writel_relaxed(1 << line, IXP4XX_GPIO_GPISR);
 
 	/* Set the new style */
-	*int_reg |= (int_style << (line * IXP4XX_GPIO_STYLE_SIZE));
+	writel_relaxed(readl_relaxed(int_reg) |
+			(int_style << (line * IXP4XX_GPIO_STYLE_SIZE)),
+			int_reg);
 
 	/* Configure the line as an input */
 	gpio_line_config(irq2gpio[d->irq], IXP4XX_GPIO_IN);
@@ -198,9 +200,9 @@ static int ixp4xx_set_irq_type(struct irq_data *d, unsigned int type)
 static void ixp4xx_irq_mask(struct irq_data *d)
 {
 	if ((cpu_is_ixp46x() || cpu_is_ixp43x()) && d->irq >= 32)
-		*IXP4XX_ICMR2 &= ~(1 << (d->irq - 32));
+		writel_relaxed(readl_relaxed(IXP4XX_ICMR2) & ~(1 << (d->irq - 32)), IXP4XX_ICMR2);
 	else
-		*IXP4XX_ICMR &= ~(1 << d->irq);
+		writel_relaxed(readl_relaxed(IXP4XX_ICMR) & ~(1 << (d->irq - 32)), IXP4XX_ICMR);
 }
 
 static void ixp4xx_irq_ack(struct irq_data *d)
@@ -208,7 +210,7 @@ static void ixp4xx_irq_ack(struct irq_data *d)
 	int line = (d->irq < 32) ? irq2gpio[d->irq] : -1;
 
 	if (line >= 0)
-		*IXP4XX_GPIO_GPISR = (1 << line);
+		writel_relaxed(1 << line, IXP4XX_GPIO_GPISR);
 }
 
 /*
@@ -221,9 +223,9 @@ static void ixp4xx_irq_unmask(struct irq_data *d)
 		ixp4xx_irq_ack(d);
 
 	if ((cpu_is_ixp46x() || cpu_is_ixp43x()) && d->irq >= 32)
-		*IXP4XX_ICMR2 |= (1 << (d->irq - 32));
+		writel_relaxed(readl_relaxed(IXP4XX_ICMR2) | (1 << (d->irq - 32)), IXP4XX_ICMR2);
 	else
-		*IXP4XX_ICMR |= (1 << d->irq);
+		writel_relaxed(readl_relaxed(IXP4XX_ICMR) | (1 << (d->irq - 32)), IXP4XX_ICMR);
 }
 
 static struct irq_chip ixp4xx_irq_chip = {
@@ -245,17 +247,17 @@ void __init ixp4xx_init_irq(void)
 	disable_hlt();
 
 	/* Route all sources to IRQ instead of FIQ */
-	*IXP4XX_ICLR = 0x0;
+	writel_relaxed(0, IXP4XX_ICLR);
 
 	/* Disable all interrupt */
-	*IXP4XX_ICMR = 0x0; 
+	writel_relaxed(0, IXP4XX_ICMR);
 
 	if (cpu_is_ixp46x() || cpu_is_ixp43x()) {
 		/* Route upper 32 sources to IRQ instead of FIQ */
-		*IXP4XX_ICLR2 = 0x00;
+		writel_relaxed(0, IXP4XX_ICLR2);
 
 		/* Disable upper 32 interrupts */
-		*IXP4XX_ICMR2 = 0x00;
+		writel_relaxed(0, IXP4XX_ICMR2);
 	}
 
         /* Default to all level triggered */
@@ -278,7 +280,7 @@ static irqreturn_t ixp4xx_timer_interrupt(int irq, void *dev_id)
 	struct clock_event_device *evt = dev_id;
 
 	/* Clear Pending Interrupt by writing '1' to it */
-	*IXP4XX_OSST = IXP4XX_OSST_TIMER_1_PEND;
+	writel_relaxed(IXP4XX_OSST_TIMER_1_PEND, IXP4XX_OSST);
 
 	evt->event_handler(evt);
 
@@ -295,13 +297,13 @@ static struct irqaction ixp4xx_timer_irq = {
 void __init ixp4xx_timer_init(void)
 {
 	/* Reset/disable counter */
-	*IXP4XX_OSRT1 = 0;
+	writel_relaxed(0, IXP4XX_OSRT1);
 
 	/* Clear Pending Interrupt by writing '1' to it */
-	*IXP4XX_OSST = IXP4XX_OSST_TIMER_1_PEND;
+	writel_relaxed(IXP4XX_OSST_TIMER_1_PEND, IXP4XX_OSST);
 
 	/* Reset time-stamp counter */
-	*IXP4XX_OSTS = 0;
+	writel_relaxed(0, IXP4XX_OSTS);
 
 	/* Connect the interrupt handler and enable the interrupt */
 	setup_irq(IRQ_IXP4XX_TIMER1, &ixp4xx_timer_irq);
@@ -440,7 +442,7 @@ void __init ixp4xx_sys_init(void)
 				ARRAY_SIZE(ixp46x_devices));
 
 		for (region = 0; region < 7; region++) {
-			if((*(IXP4XX_EXP_REG(0x4 * region)) & 0x200)) {
+			if((readl_relaxed(IXP4XX_EXP_REG(0x4 * region)) & 0x200)) {
 				ixp4xx_exp_bus_size = SZ_32M;
 				break;
 			}
@@ -456,7 +458,7 @@ void __init ixp4xx_sys_init(void)
  */
 static u32 notrace ixp4xx_read_sched_clock(void)
 {
-	return *IXP4XX_OSTS;
+	return readl_relaxed(IXP4XX_OSTS);
 }
 
 /*
@@ -465,7 +467,7 @@ static u32 notrace ixp4xx_read_sched_clock(void)
 
 static cycle_t ixp4xx_clocksource_read(struct clocksource *c)
 {
-	return *IXP4XX_OSTS;
+	return readl_relaxed(IXP4XX_OSTS);
 }
 
 unsigned long ixp4xx_timer_freq = IXP4XX_TIMER_FREQ;
@@ -484,9 +486,9 @@ static void __init ixp4xx_clocksource_init(void)
 static int ixp4xx_set_next_event(unsigned long evt,
 				 struct clock_event_device *unused)
 {
-	unsigned long opts = *IXP4XX_OSRT1 & IXP4XX_OST_RELOAD_MASK;
+	unsigned long opts = readl_relaxed(IXP4XX_OSRT1) & IXP4XX_OST_RELOAD_MASK;
 
-	*IXP4XX_OSRT1 = (evt & ~IXP4XX_OST_RELOAD_MASK) | opts;
+	writel_relaxed((evt & ~IXP4XX_OST_RELOAD_MASK) | opts, IXP4XX_OSRT1);
 
 	return 0;
 }
@@ -494,8 +496,8 @@ static int ixp4xx_set_next_event(unsigned long evt,
 static void ixp4xx_set_mode(enum clock_event_mode mode,
 			    struct clock_event_device *evt)
 {
-	unsigned long opts = *IXP4XX_OSRT1 & IXP4XX_OST_RELOAD_MASK;
-	unsigned long osrt = *IXP4XX_OSRT1 & ~IXP4XX_OST_RELOAD_MASK;
+	unsigned long opts = readl_relaxed(IXP4XX_OSRT1) & IXP4XX_OST_RELOAD_MASK;
+	unsigned long osrt = readl_relaxed(IXP4XX_OSRT1) & ~IXP4XX_OST_RELOAD_MASK;
 
 	switch (mode) {
 	case CLOCK_EVT_MODE_PERIODIC:
@@ -519,7 +521,7 @@ static void ixp4xx_set_mode(enum clock_event_mode mode,
 		break;
 	}
 
-	*IXP4XX_OSRT1 = osrt | opts;
+	writel_relaxed(osrt | opts, IXP4XX_OSRT1);
 }
 
 static struct clock_event_device clockevent_ixp4xx = {
@@ -555,12 +557,12 @@ void ixp4xx_restart(char mode, const char *cmd)
 		/* set the "key" register to enable access to
 		 * "timer" and "enable" registers
 		 */
-		*IXP4XX_OSWK = IXP4XX_WDT_KEY;
+		writel_relaxed(IXP4XX_WDT_KEY, IXP4XX_OSWK);
 
 		/* write 0 to the timer register for an immediate reset */
-		*IXP4XX_OSWT = 0;
+		writel_relaxed(0, IXP4XX_OSWT);
 
-		*IXP4XX_OSWE = IXP4XX_WDT_RESET_ENABLE | IXP4XX_WDT_COUNT_ENABLE;
+		writel_relaxed(IXP4XX_WDT_RESET_ENABLE | IXP4XX_WDT_COUNT_ENABLE, IXP4XX_OSWE);
 	}
 }
 
diff --git a/arch/arm/mach-ixp4xx/coyote-setup.c b/arch/arm/mach-ixp4xx/coyote-setup.c
index 1b83110..02a1e98 100644
--- a/arch/arm/mach-ixp4xx/coyote-setup.c
+++ b/arch/arm/mach-ixp4xx/coyote-setup.c
@@ -61,7 +61,7 @@ static struct resource coyote_uart_resource = {
 static struct plat_serial8250_port coyote_uart_data[] = {
 	{
 		.mapbase	= IXP4XX_UART2_BASE_PHYS,
-		.membase	= (char *)IXP4XX_UART2_BASE_VIRT + REG_OFFSET,
+		.membase	= IXP4XX_UART2_BASE_VIRT + REG_OFFSET,
 		.irq		= IRQ_IXP4XX_UART2,
 		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST,
 		.iotype		= UPIO_MEM,
@@ -93,12 +93,11 @@ static void __init coyote_init(void)
 	coyote_flash_resource.start = IXP4XX_EXP_BUS_BASE(0);
 	coyote_flash_resource.end = IXP4XX_EXP_BUS_BASE(0) + SZ_32M - 1;
 
-	*IXP4XX_EXP_CS0 |= IXP4XX_FLASH_WRITABLE;
-	*IXP4XX_EXP_CS1 = *IXP4XX_EXP_CS0;
+	writel_relaxed(readl_relaxed(IXP4XX_EXP_CS0) | IXP4XX_FLASH_WRITABLE, IXP4XX_EXP_CS0);
+	writel_relaxed(readl_relaxed(IXP4XX_EXP_CS0), IXP4XX_EXP_CS1);
 
 	if (machine_is_ixdpg425()) {
-		coyote_uart_data[0].membase =
-			(char*)(IXP4XX_UART1_BASE_VIRT + REG_OFFSET);
+		coyote_uart_data[0].membase = IXP4XX_UART1_BASE_VIRT + REG_OFFSET;
 		coyote_uart_data[0].mapbase = IXP4XX_UART1_BASE_PHYS;
 		coyote_uart_data[0].irq = IRQ_IXP4XX_UART1;
 	}
diff --git a/arch/arm/mach-ixp4xx/dsmg600-setup.c b/arch/arm/mach-ixp4xx/dsmg600-setup.c
index 97a0af8..2f24df1 100644
--- a/arch/arm/mach-ixp4xx/dsmg600-setup.c
+++ b/arch/arm/mach-ixp4xx/dsmg600-setup.c
@@ -24,6 +24,7 @@
 #include <linux/serial_8250.h>
 #include <linux/leds.h>
 #include <linux/reboot.h>
+#include <linux/io.h>
 #include <linux/i2c.h>
 #include <linux/i2c-gpio.h>
 
@@ -124,7 +125,7 @@ static struct resource dsmg600_uart_resources[] = {
 static struct plat_serial8250_port dsmg600_uart_data[] = {
 	{
 		.mapbase	= IXP4XX_UART1_BASE_PHYS,
-		.membase	= (char *)IXP4XX_UART1_BASE_VIRT + REG_OFFSET,
+		.membase	= IXP4XX_UART1_BASE_VIRT + REG_OFFSET,
 		.irq		= IRQ_IXP4XX_UART1,
 		.flags		= UPF_BOOT_AUTOCONF,
 		.iotype		= UPIO_MEM,
@@ -133,7 +134,7 @@ static struct plat_serial8250_port dsmg600_uart_data[] = {
 	},
 	{
 		.mapbase	= IXP4XX_UART2_BASE_PHYS,
-		.membase	= (char *)IXP4XX_UART2_BASE_VIRT + REG_OFFSET,
+		.membase	= IXP4XX_UART2_BASE_VIRT + REG_OFFSET,
 		.irq		= IRQ_IXP4XX_UART2,
 		.flags		= UPF_BOOT_AUTOCONF,
 		.iotype		= UPIO_MEM,
@@ -235,7 +236,7 @@ static void __init dsmg600_init(void)
 	ixp4xx_sys_init();
 
 	/* Make sure that GPIO14 and GPIO15 are not used as clocks */
-	*IXP4XX_GPIO_GPCLKR = 0;
+	writel_relaxed(0, IXP4XX_GPIO_GPCLKR);
 
 	dsmg600_flash_resource.start = IXP4XX_EXP_BUS_BASE(0);
 	dsmg600_flash_resource.end =
diff --git a/arch/arm/mach-ixp4xx/fsg-setup.c b/arch/arm/mach-ixp4xx/fsg-setup.c
index 9175a25..d3b0737 100644
--- a/arch/arm/mach-ixp4xx/fsg-setup.c
+++ b/arch/arm/mach-ixp4xx/fsg-setup.c
@@ -89,7 +89,7 @@ static struct resource fsg_uart_resources[] = {
 static struct plat_serial8250_port fsg_uart_data[] = {
 	{
 		.mapbase	= IXP4XX_UART1_BASE_PHYS,
-		.membase	= (char *)IXP4XX_UART1_BASE_VIRT + REG_OFFSET,
+		.membase	= IXP4XX_UART1_BASE_VIRT + REG_OFFSET,
 		.irq		= IRQ_IXP4XX_UART1,
 		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST,
 		.iotype		= UPIO_MEM,
@@ -98,7 +98,7 @@ static struct plat_serial8250_port fsg_uart_data[] = {
 	},
 	{
 		.mapbase	= IXP4XX_UART2_BASE_PHYS,
-		.membase	= (char *)IXP4XX_UART2_BASE_VIRT + REG_OFFSET,
+		.membase	= IXP4XX_UART2_BASE_VIRT + REG_OFFSET,
 		.irq		= IRQ_IXP4XX_UART2,
 		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST,
 		.iotype		= UPIO_MEM,
@@ -190,11 +190,11 @@ static void __init fsg_init(void)
 	fsg_flash_resource.end =
 		IXP4XX_EXP_BUS_BASE(0) + ixp4xx_exp_bus_size - 1;
 
-	*IXP4XX_EXP_CS0 |= IXP4XX_FLASH_WRITABLE;
-	*IXP4XX_EXP_CS1 = *IXP4XX_EXP_CS0;
+	writel_relaxed(readl_relaxed(IXP4XX_EXP_CS0) | IXP4XX_FLASH_WRITABLE, IXP4XX_EXP_CS0);
+	writel_relaxed(readl_relaxed(IXP4XX_EXP_CS0), IXP4XX_EXP_CS1);
 
 	/* Configure CS2 for operation, 8bit and writable */
-	*IXP4XX_EXP_CS2 = 0xbfff0002;
+	writel_relaxed(0xbfff0002, IXP4XX_EXP_CS2);
 
 	i2c_register_board_info(0, fsg_i2c_board_info,
 				ARRAY_SIZE(fsg_i2c_board_info));
diff --git a/arch/arm/mach-ixp4xx/gateway7001-setup.c b/arch/arm/mach-ixp4xx/gateway7001-setup.c
index 033c717..57a58ea 100644
--- a/arch/arm/mach-ixp4xx/gateway7001-setup.c
+++ b/arch/arm/mach-ixp4xx/gateway7001-setup.c
@@ -55,7 +55,7 @@ static struct resource gateway7001_uart_resource = {
 static struct plat_serial8250_port gateway7001_uart_data[] = {
 	{
 		.mapbase	= IXP4XX_UART2_BASE_PHYS,
-		.membase	= (char *)IXP4XX_UART2_BASE_VIRT + REG_OFFSET,
+		.membase	= IXP4XX_UART2_BASE_VIRT + REG_OFFSET,
 		.irq		= IRQ_IXP4XX_UART2,
 		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST,
 		.iotype		= UPIO_MEM,
@@ -87,8 +87,8 @@ static void __init gateway7001_init(void)
 	gateway7001_flash_resource.start = IXP4XX_EXP_BUS_BASE(0);
 	gateway7001_flash_resource.end = IXP4XX_EXP_BUS_BASE(0) + SZ_32M - 1;
 
-	*IXP4XX_EXP_CS0 |= IXP4XX_FLASH_WRITABLE;
-	*IXP4XX_EXP_CS1 = *IXP4XX_EXP_CS0;
+	writel_relaxed(readl_relaxed(IXP4XX_EXP_CS0) | IXP4XX_FLASH_WRITABLE, IXP4XX_EXP_CS0);
+	writel_relaxed(readl_relaxed(IXP4XX_EXP_CS0), IXP4XX_EXP_CS1);
 
 	platform_add_devices(gateway7001_devices, ARRAY_SIZE(gateway7001_devices));
 }
diff --git a/arch/arm/mach-ixp4xx/goramo_mlr.c b/arch/arm/mach-ixp4xx/goramo_mlr.c
index b800a03..9e52b88 100644
--- a/arch/arm/mach-ixp4xx/goramo_mlr.c
+++ b/arch/arm/mach-ixp4xx/goramo_mlr.c
@@ -11,6 +11,7 @@
 #include <linux/kernel.h>
 #include <linux/pci.h>
 #include <linux/serial_8250.h>
+#include <asm/system_info.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/flash.h>
diff --git a/arch/arm/mach-ixp4xx/gtwx5715-setup.c b/arch/arm/mach-ixp4xx/gtwx5715-setup.c
index 18ebc6b..62e3dee 100644
--- a/arch/arm/mach-ixp4xx/gtwx5715-setup.c
+++ b/arch/arm/mach-ixp4xx/gtwx5715-setup.c
@@ -107,7 +107,7 @@ static struct resource gtwx5715_uart_resources[] = {
 static struct plat_serial8250_port gtwx5715_uart_platform_data[] = {
 	{
 	.mapbase	= IXP4XX_UART2_BASE_PHYS,
-	.membase	= (char *)IXP4XX_UART2_BASE_VIRT + REG_OFFSET,
+	.membase	= IXP4XX_UART2_BASE_VIRT + REG_OFFSET,
 	.irq		= IRQ_IXP4XX_UART2,
 	.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST,
 	.iotype		= UPIO_MEM,
diff --git a/arch/arm/mach-ixp4xx/include/mach/io.h b/arch/arm/mach-ixp4xx/include/mach/io.h
index 5cf30d1..795988d 100644
--- a/arch/arm/mach-ixp4xx/include/mach/io.h
+++ b/arch/arm/mach-ixp4xx/include/mach/io.h
@@ -75,7 +75,7 @@ static inline void __indirect_writeb(u8 value, volatile void __iomem *p)
 	u32 n, byte_enables, data;
 
 	if (!is_pci_memory(addr)) {
-		__raw_writeb(value, addr);
+		__raw_writeb(value, p);
 		return;
 	}
 
@@ -98,7 +98,7 @@ static inline void __indirect_writew(u16 value, volatile void __iomem *p)
 	u32 n, byte_enables, data;
 
 	if (!is_pci_memory(addr)) {
-		__raw_writew(value, addr);
+		__raw_writew(value, p);
 		return;
 	}
 
@@ -140,7 +140,7 @@ static inline unsigned char __indirect_readb(const volatile void __iomem *p)
 	u32 n, byte_enables, data;
 
 	if (!is_pci_memory(addr))
-		return __raw_readb(addr);
+		return __raw_readb(p);
 
 	n = addr % 4;
 	byte_enables = (0xf & ~BIT(n)) << IXP4XX_PCI_NP_CBE_BESL;
@@ -163,7 +163,7 @@ static inline unsigned short __indirect_readw(const volatile void __iomem *p)
 	u32 n, byte_enables, data;
 
 	if (!is_pci_memory(addr))
-		return __raw_readw(addr);
+		return __raw_readw(p);
 
 	n = addr % 4;
 	byte_enables = (0xf & ~(BIT(n) | BIT(n+1))) << IXP4XX_PCI_NP_CBE_BESL;
diff --git a/arch/arm/mach-ixp4xx/include/mach/ixp4xx-regs.h b/arch/arm/mach-ixp4xx/include/mach/ixp4xx-regs.h
index eb68b61..2522ab0 100644
--- a/arch/arm/mach-ixp4xx/include/mach/ixp4xx-regs.h
+++ b/arch/arm/mach-ixp4xx/include/mach/ixp4xx-regs.h
@@ -92,7 +92,7 @@
 /*
  * Expansion Bus Controller registers.
  */
-#define IXP4XX_EXP_REG(x) ((volatile u32 __iomem *)(IXP4XX_EXP_CFG_BASE_VIRT+(x)))
+#define IXP4XX_EXP_REG(x) (IXP4XX_EXP_CFG_BASE_VIRT+(x))
 
 #define IXP4XX_EXP_CS0      IXP4XX_EXP_REG(IXP4XX_EXP_CS0_OFFSET)
 #define IXP4XX_EXP_CS1      IXP4XX_EXP_REG(IXP4XX_EXP_CS1_OFFSET)
@@ -182,7 +182,7 @@
  * Interrupt Controller Register Definitions.
  */
 
-#define IXP4XX_INTC_REG(x) ((volatile u32 *)(IXP4XX_INTC_BASE_VIRT+(x)))
+#define IXP4XX_INTC_REG(x) (IXP4XX_INTC_BASE_VIRT+(x))
 
 #define IXP4XX_ICPR	IXP4XX_INTC_REG(IXP4XX_ICPR_OFFSET)
 #define IXP4XX_ICMR     IXP4XX_INTC_REG(IXP4XX_ICMR_OFFSET)
@@ -215,7 +215,7 @@
  * GPIO Register Definitions.
  * [Only perform 32bit reads/writes]
  */
-#define IXP4XX_GPIO_REG(x) ((volatile u32 *)(IXP4XX_GPIO_BASE_VIRT+(x)))
+#define IXP4XX_GPIO_REG(x) (IXP4XX_GPIO_BASE_VIRT+(x))
 
 #define IXP4XX_GPIO_GPOUTR	IXP4XX_GPIO_REG(IXP4XX_GPIO_GPOUTR_OFFSET)
 #define IXP4XX_GPIO_GPOER       IXP4XX_GPIO_REG(IXP4XX_GPIO_GPOER_OFFSET)
@@ -261,7 +261,7 @@
  * Operating System Timer Register Definitions.
  */
 
-#define IXP4XX_TIMER_REG(x) ((volatile u32 *)(IXP4XX_TIMER_BASE_VIRT+(x)))
+#define IXP4XX_TIMER_REG(x) (IXP4XX_TIMER_BASE_VIRT+(x))
 
 #define IXP4XX_OSTS	IXP4XX_TIMER_REG(IXP4XX_OSTS_OFFSET)
 #define IXP4XX_OST1	IXP4XX_TIMER_REG(IXP4XX_OST1_OFFSET)
@@ -323,7 +323,7 @@
 /*
  * PCI Control/Status Registers
  */
-#define IXP4XX_PCI_CSR(x) ((volatile u32 *)(IXP4XX_PCI_CFG_BASE_VIRT+(x)))
+#define IXP4XX_PCI_CSR(x) (IXP4XX_PCI_CFG_BASE_VIRT+(x))
 
 #define PCI_NP_AD               IXP4XX_PCI_CSR(PCI_NP_AD_OFFSET)
 #define PCI_NP_CBE              IXP4XX_PCI_CSR(PCI_NP_CBE_OFFSET)
@@ -411,7 +411,7 @@
  * IXP4XX_ naming convetions.
  *
  */
-# define IXP4XX_USB_REG(x)       (*((volatile u32 *)(x)))
+# define IXP4XX_USB_REG(x)       (*((volatile u32 __iomem *)(x)))
 
 /* UDC Undocumented - Reserved1 */
 #define UDC_RES1	IXP4XX_USB_REG(IXP4XX_USB_BASE_VIRT+0x0004)  
diff --git a/arch/arm/mach-ixp4xx/include/mach/platform.h b/arch/arm/mach-ixp4xx/include/mach/platform.h
index 5bce94a..2d3e3f1 100644
--- a/arch/arm/mach-ixp4xx/include/mach/platform.h
+++ b/arch/arm/mach-ixp4xx/include/mach/platform.h
@@ -81,8 +81,8 @@ extern unsigned long ixp4xx_exp_bus_size;
  * passed as platform_data.
  */
 struct ixp4xx_pata_data {
-	volatile u32	*cs0_cfg;
-	volatile u32	*cs1_cfg;
+	u32 __iomem	*cs0_cfg;
+	u32 __iomem	*cs1_cfg;
 	unsigned long	cs0_bits;
 	unsigned long	cs1_bits;
 	void __iomem	*cs0;
@@ -150,26 +150,29 @@ extern struct pci_ops ixp4xx_ops;
 #define IXP4XX_GPIO_CLK_0		14
 #define IXP4XX_GPIO_CLK_1		15
 
-static inline void gpio_line_config(u8 line, u32 direction)
-{
-	if (direction == IXP4XX_GPIO_IN)
-		*IXP4XX_GPIO_GPOER |= (1 << line);
-	else
-		*IXP4XX_GPIO_GPOER &= ~(1 << line);
-}
-
-static inline void gpio_line_get(u8 line, int *value)
-{
-	*value = (*IXP4XX_GPIO_GPINR >> line) & 0x1;
-}
-
-static inline void gpio_line_set(u8 line, int value)
-{
-	if (value == IXP4XX_GPIO_HIGH)
-	    *IXP4XX_GPIO_GPOUTR |= (1 << line);
-	else if (value == IXP4XX_GPIO_LOW)
-	    *IXP4XX_GPIO_GPOUTR &= ~(1 << line);
-}
+/* using macros here to work around circular dependency with asm/io.h */
+#define gpio_line_config(line, direction)	\
+do {						\
+	u8 __line = (line);			\
+	if ((direction) == IXP4XX_GPIO_IN)	\
+		writel_relaxed(readl_relaxed(IXP4XX_GPIO_GPOER) | (1 << __line), IXP4XX_GPIO_GPOER); \
+	else					\
+		writel_relaxed(readl_relaxed(IXP4XX_GPIO_GPOER) & ~(1 << __line), IXP4XX_GPIO_GPOER); \
+} while (0)
+
+#define gpio_line_get(line, value)	\
+do {					\
+	*(value) = (readl_relaxed(IXP4XX_GPIO_GPINR) >> (line)) & 0x1; \
+} while(0)
+
+#define gpio_line_set(line, value)		\
+do {						\
+	u8 __line = (line);			\
+	if ((value) == IXP4XX_GPIO_HIGH)	\
+		writel_relaxed(readl_relaxed(IXP4XX_GPIO_GPOUTR) | (1 << __line), IXP4XX_GPIO_GPOUTR); \
+	else if ((value) == IXP4XX_GPIO_LOW)	\
+		writel_relaxed(readl_relaxed(IXP4XX_GPIO_GPOUTR) & ~(1 << __line), IXP4XX_GPIO_GPOUTR); \
+} while (0)
 
 #endif // __ASSEMBLY__
 
diff --git a/arch/arm/mach-ixp4xx/include/mach/timex.h b/arch/arm/mach-ixp4xx/include/mach/timex.h
index c9e930f..0396d89 100644
--- a/arch/arm/mach-ixp4xx/include/mach/timex.h
+++ b/arch/arm/mach-ixp4xx/include/mach/timex.h
@@ -3,7 +3,7 @@
  * 
  */
 
-#include <mach/hardware.h>
+#include <mach/ixp4xx-regs.h>
 
 /*
  * We use IXP425 General purpose timer for our timer needs, it runs at 
diff --git a/arch/arm/mach-ixp4xx/ixdp425-setup.c b/arch/arm/mach-ixp4xx/ixdp425-setup.c
index 108a9d3..399c5e3 100644
--- a/arch/arm/mach-ixp4xx/ixdp425-setup.c
+++ b/arch/arm/mach-ixp4xx/ixdp425-setup.c
@@ -150,7 +150,7 @@ static struct resource ixdp425_uart_resources[] = {
 static struct plat_serial8250_port ixdp425_uart_data[] = {
 	{
 		.mapbase	= IXP4XX_UART1_BASE_PHYS,
-		.membase	= (char *)IXP4XX_UART1_BASE_VIRT + REG_OFFSET,
+		.membase	= IXP4XX_UART1_BASE_VIRT + REG_OFFSET,
 		.irq		= IRQ_IXP4XX_UART1,
 		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST,
 		.iotype		= UPIO_MEM,
@@ -159,7 +159,7 @@ static struct plat_serial8250_port ixdp425_uart_data[] = {
 	},
 	{
 		.mapbase	= IXP4XX_UART2_BASE_PHYS,
-		.membase	= (char *)IXP4XX_UART2_BASE_VIRT + REG_OFFSET,
+		.membase	= IXP4XX_UART2_BASE_VIRT + REG_OFFSET,
 		.irq		= IRQ_IXP4XX_UART2,
 		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST,
 		.iotype		= UPIO_MEM,
diff --git a/arch/arm/mach-ixp4xx/ixp4xx_qmgr.c b/arch/arm/mach-ixp4xx/ixp4xx_qmgr.c
index 852f7c9..f0e1169 100644
--- a/arch/arm/mach-ixp4xx/ixp4xx_qmgr.c
+++ b/arch/arm/mach-ixp4xx/ixp4xx_qmgr.c
@@ -55,14 +55,14 @@ static irqreturn_t qmgr_irq1_a0(int irq, void *pdev)
 	u32 en_bitmap, src, stat;
 
 	/* ACK - it may clear any bits so don't rely on it */
-	__raw_writel(0xFFFFFFFF, &qmgr_regs->irqstat[0]);
+	writel_relaxed(0xFFFFFFFF, &qmgr_regs->irqstat[0]);
 
-	en_bitmap = qmgr_regs->irqen[0];
+	en_bitmap = readl_relaxed(&qmgr_regs->irqen[0]);
 	while (en_bitmap) {
 		i = __fls(en_bitmap); /* number of the last "low" queue */
 		en_bitmap &= ~BIT(i);
-		src = qmgr_regs->irqsrc[i >> 3];
-		stat = qmgr_regs->stat1[i >> 3];
+		src = readl_relaxed(&qmgr_regs->irqsrc[i >> 3]);
+		stat = readl_relaxed(&qmgr_regs->stat1[i >> 3]);
 		if (src & 4) /* the IRQ condition is inverted */
 			stat = ~stat;
 		if (stat & BIT(src & 3)) {
@@ -80,9 +80,9 @@ static irqreturn_t qmgr_irq2_a0(int irq, void *pdev)
 	u32 req_bitmap;
 
 	/* ACK - it may clear any bits so don't rely on it */
-	__raw_writel(0xFFFFFFFF, &qmgr_regs->irqstat[1]);
+	writel_relaxed(0xFFFFFFFF, &qmgr_regs->irqstat[1]);
 
-	req_bitmap = qmgr_regs->irqen[1] & qmgr_regs->statne_h;
+	req_bitmap = readl_relaxed(&qmgr_regs->irqen[1]) & readl_relaxed(&qmgr_regs->statne_h);
 	while (req_bitmap) {
 		i = __fls(req_bitmap); /* number of the last "high" queue */
 		req_bitmap &= ~BIT(i);
diff --git a/arch/arm/mach-ixp4xx/nas100d-setup.c b/arch/arm/mach-ixp4xx/nas100d-setup.c
index 33cb095..647d377 100644
--- a/arch/arm/mach-ixp4xx/nas100d-setup.c
+++ b/arch/arm/mach-ixp4xx/nas100d-setup.c
@@ -129,7 +129,7 @@ static struct resource nas100d_uart_resources[] = {
 static struct plat_serial8250_port nas100d_uart_data[] = {
 	{
 		.mapbase	= IXP4XX_UART1_BASE_PHYS,
-		.membase	= (char *)IXP4XX_UART1_BASE_VIRT + REG_OFFSET,
+		.membase	= IXP4XX_UART1_BASE_VIRT + REG_OFFSET,
 		.irq		= IRQ_IXP4XX_UART1,
 		.flags		= UPF_BOOT_AUTOCONF,
 		.iotype		= UPIO_MEM,
@@ -138,7 +138,7 @@ static struct plat_serial8250_port nas100d_uart_data[] = {
 	},
 	{
 		.mapbase	= IXP4XX_UART2_BASE_PHYS,
-		.membase	= (char *)IXP4XX_UART2_BASE_VIRT + REG_OFFSET,
+		.membase	= IXP4XX_UART2_BASE_VIRT + REG_OFFSET,
 		.irq		= IRQ_IXP4XX_UART2,
 		.flags		= UPF_BOOT_AUTOCONF,
 		.iotype		= UPIO_MEM,
@@ -250,7 +250,7 @@ static void __init nas100d_init(void)
 	ixp4xx_sys_init();
 
 	/* gpio 14 and 15 are _not_ clocks */
-	*IXP4XX_GPIO_GPCLKR = 0;
+	writel_relaxed(0, IXP4XX_GPIO_GPCLKR);
 
 	nas100d_flash_resource.start = IXP4XX_EXP_BUS_BASE(0);
 	nas100d_flash_resource.end =
diff --git a/arch/arm/mach-ixp4xx/nslu2-setup.c b/arch/arm/mach-ixp4xx/nslu2-setup.c
index e2903fa..ada1175 100644
--- a/arch/arm/mach-ixp4xx/nslu2-setup.c
+++ b/arch/arm/mach-ixp4xx/nslu2-setup.c
@@ -141,7 +141,7 @@ static struct resource nslu2_uart_resources[] = {
 static struct plat_serial8250_port nslu2_uart_data[] = {
 	{
 		.mapbase	= IXP4XX_UART1_BASE_PHYS,
-		.membase	= (char *)IXP4XX_UART1_BASE_VIRT + REG_OFFSET,
+		.membase	= IXP4XX_UART1_BASE_VIRT + REG_OFFSET,
 		.irq		= IRQ_IXP4XX_UART1,
 		.flags		= UPF_BOOT_AUTOCONF,
 		.iotype		= UPIO_MEM,
@@ -150,7 +150,7 @@ static struct plat_serial8250_port nslu2_uart_data[] = {
 	},
 	{
 		.mapbase	= IXP4XX_UART2_BASE_PHYS,
-		.membase	= (char *)IXP4XX_UART2_BASE_VIRT + REG_OFFSET,
+		.membase	= IXP4XX_UART2_BASE_VIRT + REG_OFFSET,
 		.irq		= IRQ_IXP4XX_UART2,
 		.flags		= UPF_BOOT_AUTOCONF,
 		.iotype		= UPIO_MEM,
diff --git a/arch/arm/mach-ixp4xx/omixp-setup.c b/arch/arm/mach-ixp4xx/omixp-setup.c
index 158ddb7..6a0be72 100644
--- a/arch/arm/mach-ixp4xx/omixp-setup.c
+++ b/arch/arm/mach-ixp4xx/omixp-setup.c
@@ -17,6 +17,7 @@
 #include <linux/serial_8250.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
+#include <linux/io.h>
 #ifdef CONFIG_LEDS_CLASS
 #include <linux/leds.h>
 #endif
@@ -125,7 +126,7 @@ static struct resource omixp_uart_resources[] = {
 static struct plat_serial8250_port omixp_uart_data[] = {
 	{
 		.mapbase	= IXP4XX_UART2_BASE_PHYS,
-		.membase	= (char *)IXP4XX_UART2_BASE_VIRT + REG_OFFSET,
+		.membase	= IXP4XX_UART2_BASE_VIRT + REG_OFFSET,
 		.irq		= IRQ_IXP4XX_UART2,
 		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST,
 		.iotype		= UPIO_MEM,
@@ -133,7 +134,7 @@ static struct plat_serial8250_port omixp_uart_data[] = {
 		.uartclk	= IXP4XX_UART_XTAL,
 	}, {
 		.mapbase	= IXP4XX_UART1_BASE_PHYS,
-		.membase	= (char *)IXP4XX_UART1_BASE_VIRT + REG_OFFSET,
+		.membase	= IXP4XX_UART1_BASE_VIRT + REG_OFFSET,
 		.irq		= IRQ_IXP4XX_UART1,
 		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST,
 		.iotype		= UPIO_MEM,
diff --git a/arch/arm/mach-ixp4xx/vulcan-setup.c b/arch/arm/mach-ixp4xx/vulcan-setup.c
index 2798f43..846192d 100644
--- a/arch/arm/mach-ixp4xx/vulcan-setup.c
+++ b/arch/arm/mach-ixp4xx/vulcan-setup.c
@@ -77,7 +77,7 @@ static struct resource vulcan_uart_resources[] = {
 static struct plat_serial8250_port vulcan_uart_data[] = {
 	[0] = {
 		.mapbase	= IXP4XX_UART1_BASE_PHYS,
-		.membase	= (char *)IXP4XX_UART1_BASE_VIRT + REG_OFFSET,
+		.membase	= IXP4XX_UART1_BASE_VIRT + REG_OFFSET,
 		.irq		= IRQ_IXP4XX_UART1,
 		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST,
 		.iotype		= UPIO_MEM,
@@ -86,7 +86,7 @@ static struct plat_serial8250_port vulcan_uart_data[] = {
 	},
 	[1] = {
 		.mapbase	= IXP4XX_UART2_BASE_PHYS,
-		.membase	= (char *)IXP4XX_UART2_BASE_VIRT + REG_OFFSET,
+		.membase	= IXP4XX_UART2_BASE_VIRT + REG_OFFSET,
 		.irq		= IRQ_IXP4XX_UART2,
 		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST,
 		.iotype		= UPIO_MEM,
@@ -190,46 +190,46 @@ static void __init vulcan_init(void)
 	/* Flash is spread over both CS0 and CS1 */
 	vulcan_flash_resource.start	 = IXP4XX_EXP_BUS_BASE(0);
 	vulcan_flash_resource.end	 = IXP4XX_EXP_BUS_BASE(0) + SZ_32M - 1;
-	*IXP4XX_EXP_CS0 = IXP4XX_EXP_BUS_CS_EN		|
+	writel_relaxed(IXP4XX_EXP_BUS_CS_EN		|
 			  IXP4XX_EXP_BUS_STROBE_T(3)	|
 			  IXP4XX_EXP_BUS_SIZE(0xF)	|
 			  IXP4XX_EXP_BUS_BYTE_RD16	|
-			  IXP4XX_EXP_BUS_WR_EN;
-	*IXP4XX_EXP_CS1 = *IXP4XX_EXP_CS0;
+			  IXP4XX_EXP_BUS_WR_EN, IXP4XX_EXP_CS0);
+	writel_relaxed(readl_relaxed(IXP4XX_EXP_CS0), IXP4XX_EXP_CS1);
 
 	/* SRAM on CS2, (256kB, 8bit, writable) */
 	vulcan_sram_resource.start	= IXP4XX_EXP_BUS_BASE(2);
 	vulcan_sram_resource.end	= IXP4XX_EXP_BUS_BASE(2) + SZ_256K - 1;
-	*IXP4XX_EXP_CS2 = IXP4XX_EXP_BUS_CS_EN		|
+	writel_relaxed(IXP4XX_EXP_BUS_CS_EN		|
 			  IXP4XX_EXP_BUS_STROBE_T(1)	|
 			  IXP4XX_EXP_BUS_HOLD_T(2)	|
 			  IXP4XX_EXP_BUS_SIZE(9)	|
 			  IXP4XX_EXP_BUS_SPLT_EN	|
 			  IXP4XX_EXP_BUS_WR_EN		|
-			  IXP4XX_EXP_BUS_BYTE_EN;
+			  IXP4XX_EXP_BUS_BYTE_EN, IXP4XX_EXP_CS2);
 
 	/* XR16L2551 on CS3 (Moto style, 512 bytes, 8bits, writable) */
 	vulcan_uart_resources[2].start	= IXP4XX_EXP_BUS_BASE(3);
 	vulcan_uart_resources[2].end	= IXP4XX_EXP_BUS_BASE(3) + 16 - 1;
 	vulcan_uart_data[2].mapbase	= vulcan_uart_resources[2].start;
 	vulcan_uart_data[3].mapbase	= vulcan_uart_data[2].mapbase + 8;
-	*IXP4XX_EXP_CS3 = IXP4XX_EXP_BUS_CS_EN		|
+	writel_relaxed(IXP4XX_EXP_BUS_CS_EN		|
 			  IXP4XX_EXP_BUS_STROBE_T(3)	|
 			  IXP4XX_EXP_BUS_CYCLES(IXP4XX_EXP_BUS_CYCLES_MOTOROLA)|
 			  IXP4XX_EXP_BUS_WR_EN		|
-			  IXP4XX_EXP_BUS_BYTE_EN;
+			  IXP4XX_EXP_BUS_BYTE_EN, IXP4XX_EXP_CS3);
 
 	/* GPIOS on CS4 (512 bytes, 8bits, writable) */
-	*IXP4XX_EXP_CS4 = IXP4XX_EXP_BUS_CS_EN		|
+	writel_relaxed(IXP4XX_EXP_BUS_CS_EN		|
 			  IXP4XX_EXP_BUS_WR_EN		|
-			  IXP4XX_EXP_BUS_BYTE_EN;
+			  IXP4XX_EXP_BUS_BYTE_EN, IXP4XX_EXP_CS4);
 
 	/* max6369 on CS5 (512 bytes, 8bits, writable) */
 	vulcan_max6369_resource.start	= IXP4XX_EXP_BUS_BASE(5);
 	vulcan_max6369_resource.end	= IXP4XX_EXP_BUS_BASE(5);
-	*IXP4XX_EXP_CS5 = IXP4XX_EXP_BUS_CS_EN		|
+	writel_relaxed(IXP4XX_EXP_BUS_CS_EN		|
 			  IXP4XX_EXP_BUS_WR_EN		|
-			  IXP4XX_EXP_BUS_BYTE_EN;
+			  IXP4XX_EXP_BUS_BYTE_EN, IXP4XX_EXP_CS5);
 
 	platform_add_devices(vulcan_devices, ARRAY_SIZE(vulcan_devices));
 }
diff --git a/arch/arm/mach-ixp4xx/wg302v2-setup.c b/arch/arm/mach-ixp4xx/wg302v2-setup.c
index a785175..93f7948 100644
--- a/arch/arm/mach-ixp4xx/wg302v2-setup.c
+++ b/arch/arm/mach-ixp4xx/wg302v2-setup.c
@@ -56,7 +56,7 @@ static struct resource wg302v2_uart_resource = {
 static struct plat_serial8250_port wg302v2_uart_data[] = {
 	{
 		.mapbase	= IXP4XX_UART2_BASE_PHYS,
-		.membase	= (char *)IXP4XX_UART2_BASE_VIRT + REG_OFFSET,
+		.membase	= IXP4XX_UART2_BASE_VIRT + REG_OFFSET,
 		.irq		= IRQ_IXP4XX_UART2,
 		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST,
 		.iotype		= UPIO_MEM,
@@ -88,8 +88,8 @@ static void __init wg302v2_init(void)
 	wg302v2_flash_resource.start = IXP4XX_EXP_BUS_BASE(0);
 	wg302v2_flash_resource.end = IXP4XX_EXP_BUS_BASE(0) + SZ_32M - 1;
 
-	*IXP4XX_EXP_CS0 |= IXP4XX_FLASH_WRITABLE;
-	*IXP4XX_EXP_CS1 = *IXP4XX_EXP_CS0;
+	writel_relaxed(readl_relaxed(IXP4XX_EXP_CS0) | IXP4XX_FLASH_WRITABLE, IXP4XX_EXP_CS0);
+	writel_relaxed(readl_relaxed(IXP4XX_EXP_CS0), IXP4XX_EXP_CS1);
 
 	platform_add_devices(wg302v2_devices, ARRAY_SIZE(wg302v2_devices));
 }
diff --git a/drivers/input/misc/ixp4xx-beeper.c b/drivers/input/misc/ixp4xx-beeper.c
index 50e2830..d6d17e5 100644
--- a/drivers/input/misc/ixp4xx-beeper.c
+++ b/drivers/input/misc/ixp4xx-beeper.c
@@ -39,12 +39,12 @@ static void ixp4xx_spkr_control(unsigned int pin, unsigned int count)
 		gpio_line_config(pin, IXP4XX_GPIO_OUT);
 		gpio_line_set(pin, IXP4XX_GPIO_LOW);
 
-		*IXP4XX_OSRT2 = (count & ~IXP4XX_OST_RELOAD_MASK) | IXP4XX_OST_ENABLE;
+		writel_relaxed((count & ~IXP4XX_OST_RELOAD_MASK) | IXP4XX_OST_ENABLE, IXP4XX_OSRT2);
 	} else {
 		gpio_line_config(pin, IXP4XX_GPIO_IN);
 		gpio_line_set(pin, IXP4XX_GPIO_HIGH);
 
-		*IXP4XX_OSRT2 = 0;
+		writel_relaxed(0, IXP4XX_OSRT2);
 	}
 
 	spin_unlock_irqrestore(&beep_lock, flags);
@@ -79,10 +79,10 @@ static int ixp4xx_spkr_event(struct input_dev *dev, unsigned int type, unsigned
 static irqreturn_t ixp4xx_spkr_interrupt(int irq, void *dev_id)
 {
 	/* clear interrupt */
-	*IXP4XX_OSST = IXP4XX_OSST_TIMER_2_PEND;
+	writel_relaxed(IXP4XX_OSST_TIMER_2_PEND, IXP4XX_OSST);
 
 	/* flip the beeper output */
-	*IXP4XX_GPIO_GPOUTR ^= (1 << (unsigned int) dev_id);
+	writel_relaxed(readl_relaxed(IXP4XX_GPIO_GPOUTR) ^ (1 << (unsigned int) dev_id), IXP4XX_GPIO_GPOUTR);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/watchdog/ixp4xx_wdt.c b/drivers/watchdog/ixp4xx_wdt.c
index 5580b4f..f5ade39 100644
--- a/drivers/watchdog/ixp4xx_wdt.c
+++ b/drivers/watchdog/ixp4xx_wdt.c
@@ -41,20 +41,20 @@ static DEFINE_SPINLOCK(wdt_lock);
 static void wdt_enable(void)
 {
 	spin_lock(&wdt_lock);
-	*IXP4XX_OSWK = IXP4XX_WDT_KEY;
-	*IXP4XX_OSWE = 0;
-	*IXP4XX_OSWT = WDT_TICK_RATE * heartbeat;
-	*IXP4XX_OSWE = IXP4XX_WDT_COUNT_ENABLE | IXP4XX_WDT_RESET_ENABLE;
-	*IXP4XX_OSWK = 0;
+	writel_relaxed(IXP4XX_WDT_KEY, IXP4XX_OSWK);
+	writel_relaxed(0, IXP4XX_OSWE);
+	writel_relaxed(WDT_TICK_RATE * heartbeat, IXP4XX_OSWT);
+	writel_relaxed(IXP4XX_WDT_COUNT_ENABLE | IXP4XX_WDT_RESET_ENABLE, IXP4XX_OSWE);
+	writel_relaxed(0, IXP4XX_OSWK);
 	spin_unlock(&wdt_lock);
 }
 
 static void wdt_disable(void)
 {
 	spin_lock(&wdt_lock);
-	*IXP4XX_OSWK = IXP4XX_WDT_KEY;
-	*IXP4XX_OSWE = 0;
-	*IXP4XX_OSWK = 0;
+	writel_relaxed(IXP4XX_WDT_KEY, IXP4XX_OSWK);
+	writel_relaxed(0, IXP4XX_OSWE);
+	writel_relaxed(0, IXP4XX_OSWK);
 	spin_unlock(&wdt_lock);
 }
 
@@ -181,7 +181,7 @@ static int __init ixp4xx_wdt_init(void)
 
 		return -ENODEV;
 	}
-	boot_status = (*IXP4XX_OSST & IXP4XX_OSST_TIMER_WARM_RESET) ?
+	boot_status = (readl_relaxed(IXP4XX_OSST) & IXP4XX_OSST_TIMER_WARM_RESET) ?
 			WDIOF_CARDRESET : 0;
 	ret = misc_register(&ixp4xx_wdt_miscdev);
 	if (ret == 0)
