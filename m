From: pratheesh@ti.com (TK, Pratheesh Gangadhar)
Date: Thu, 3 Mar 2011 14:54:12 +0530
Subject: [PATCH v8 1/1] PRUSS UIO driver support
In-Reply-To: <201103021422.27094.arnd@arndb.de>
References: <1299065886-30099-1-git-send-email-pratheesh@ti.com>
	<1299065886-30099-2-git-send-email-pratheesh@ti.com>
	<201103021422.27094.arnd@arndb.de>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024C008718@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd at arndb.de]
> Sent: Wednesday, March 02, 2011 6:52 PM
> On Wednesday 02 March 2011, Pratheesh Gangadhar wrote:
> > +
> > +static struct clk *pruss_clk;
> > +static struct uio_info *info;
> > +static dma_addr_t sram_paddr, ddr_paddr;
> > +static void *prussio_vaddr, *sram_vaddr, *ddr_vaddr;
> > +
> 
> To my initial comment about these being single-instance
> variables, you said you'd change that, which has not happened
> yet.
> 
I will do this in next version. Also realized that in next SoC, 
PRU INTC base offset is different, so plan to add a platform_data
variable to make this portable.

+#define PINTC_HIDISR	0x4038
+#define PINTC_HIPIR	0x4900
+#define PINTC_HIER	0x5500 

These hard coding also need to go to make it fully portable.
+int intr_bit = (irq - IRQ_DA8XX_EVTOUT0 + 2);
+p->irq = IRQ_DA8XX_EVTOUT0 + cnt;

> Also, I now noticed that the types are wrong, you are
> missing __iomem annotations for MMIO ranges. Please make
> sure that the code builds fine with sparse and "make C=1",
> which will tell you about these problems.
> 
Thanks, this also helped to identify 2 unused lines in the code.

+		p->mem[1].internal_addr = sram_vaddr;
+		p->mem[2].internal_addr = ddr_vaddr;

Pratheesh
