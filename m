From: frieder.schrempf@exceet.de (Frieder Schrempf)
Date: Mon, 1 Oct 2018 08:18:21 +0200
Subject: [PATCH v3 1/5] spi: spi-mem: Add driver for NXP FlexSPI controller
In-Reply-To: <20180929174023.51b1e284@bbrezillon>
References: <1537525323-20730-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <1537525323-20730-2-git-send-email-yogeshnarayan.gaur@nxp.com>
 <20180929174023.51b1e284@bbrezillon>
Message-ID: <7c10ced6-91af-187a-0c34-ce9b3e897e2e@exceet.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

On 29.09.2018 17:40, Boris Brezillon wrote:
> Hi Yogesh,
> 
> On Fri, 21 Sep 2018 15:51:59 +0530
> Yogesh Gaur <yogeshnarayan.gaur@nxp.com> wrote:
> 
>> +/* Registers used by the driver */
>> +#define FSPI_MCR0			0x00
>> +#define FSPI_MCR0_AHB_TIMEOUT_SHIFT	24
>> +#define FSPI_MCR0_AHB_TIMEOUT_MASK	(0xFF << FSPI_MCR0_AHB_TIMEOUT_SHIFT)
>> +#define FSPI_MCR0_IP_TIMEOUT_SHIFT	16
>> +#define FSPI_MCR0_IP_TIMEOUT_MASK	(0xFF << FSPI_MCR0_IP_TIMEOUT_SHIFT)
>> +#define FSPI_MCR0_LEARN_EN_SHIFT	15
>> +#define FSPI_MCR0_LEARN_EN_MASK		(1 << FSPI_MCR0_LEARN_EN_SHIFT)
>> +#define FSPI_MCR0_SCRFRUN_EN_SHIFT	14
>> +#define FSPI_MCR0_SCRFRUN_EN_MASK	(1 << FSPI_MCR0_SCRFRUN_EN_SHIFT)
>> +#define FSPI_MCR0_OCTCOMB_EN_SHIFT	13
>> +#define FSPI_MCR0_OCTCOMB_EN_MASK	(1 << FSPI_MCR0_OCTCOMB_EN_SHIFT)
>> +#define FSPI_MCR0_DOZE_EN_SHIFT		12
>> +#define FSPI_MCR0_DOZE_EN_MASK		(1 << FSPI_MCR0_DOZE_EN_SHIFT)
>> +#define FSPI_MCR0_HSEN_SHIFT		11
>> +#define FSPI_MCR0_HSEN_MASK		(1 << FSPI_MCR0_HSEN_SHIFT)
>> +#define FSPI_MCR0_SERCLKDIV_SHIFT	8
>> +#define FSPI_MCR0_SERCLKDIV_MASK	(7 << FSPI_MCR0_SERCLKDIV_SHIFT)
>> +#define FSPI_MCR0_ATDF_EN_SHIFT		7
>> +#define FSPI_MCR0_ATDF_EN_MASK		(1 << FSPI_MCR0_ATDF_EN_SHIFT)
>> +#define FSPI_MCR0_ARDF_EN_SHIFT		6
>> +#define FSPI_MCR0_ARDF_EN_MASK		(1 << FSPI_MCR0_ARDF_EN_SHIFT)
>> +#define FSPI_MCR0_RXCLKSRC_SHIFT	4
>> +#define FSPI_MCR0_RXCLKSRC_MASK		(3 << FSPI_MCR0_RXCLKSRC_SHIFT)
>> +#define FSPI_MCR0_END_CFG_SHIFT		2
>> +#define FSPI_MCR0_END_CFG_MASK		(3 << FSPI_MCR0_END_CFG_SHIFT)
>> +#define FSPI_MCR0_MDIS_SHIFT		1
>> +#define FSPI_MCR0_MDIS_MASK		(1 << FSPI_MCR0_MDIS_SHIFT)
>> +#define FSPI_MCR0_SWRST_SHIFT		0
>> +#define FSPI_MCR0_SWRST_MASK		(1 << FSPI_MCR0_SWRST_SHIFT)
> 
> Do we really need all those _SHIFT/_MASK defs? I mean
> 
> #define FSPI_MCR0_SWRST		BIT(0)
> 
> or
> 
> #define FSPI_MCR0_AHB_TIMEOUT(x)	((x) << 24)
> #define FSPI_MCR0_AHB_TIMEOUT_MASK	GENMASK(31, 24)
> 
> are just fine.
> 
>> +
>> +enum nxp_fspi_devtype {
>> +	NXP_FSPI_LX2160A,
>> +};
> 
> I'm pretty sure you don't need this enum if you describe all dev caps
> in the nxp_fspi_devtype_data struct.
> 
>> +
>> +struct nxp_fspi_devtype_data {
>> +	enum nxp_fspi_devtype devtype;
>> +	unsigned int rxfifo;
>> +	unsigned int txfifo;
>> +	unsigned int ahb_buf_size;
>> +	unsigned int quirks;
>> +	bool endianness;
> 
> How about renaming this variable big_endian and dropping the
> {L,B}_ENDIAN macros?
> 
>> +};
> 
> [...]
> 
>> +struct nxp_fspi {
>> +	void __iomem *iobase;
>> +	void __iomem *ahb_addr;
>> +	u32 memmap_phy;
>> +	u32 memmap_phy_size;
>> +	struct clk *clk, *clk_en;
>> +	struct device *dev;
>> +	struct completion c;
>> +	const struct nxp_fspi_devtype_data *devtype_data;
>> +	struct mutex lock;
>> +	struct pm_qos_request pm_qos_req;
>> +	int selected;
>> +	void (*write)(u32 val, void __iomem *addr);
>> +	u32 (*read)(void __iomem *addr);
>> +};
>> +
>> +static void fspi_writel_be(u32 val, void __iomem *addr)
>> +{
>> +	iowrite32be(val, addr);
>> +}
>> +
>> +static void fspi_writel(u32 val, void __iomem *addr)
>> +{
>> +	iowrite32(val, addr);
>> +}
>> +
>> +static u32 fspi_readl_be(void __iomem *addr)
>> +{
>> +	return ioread32be(addr);
>> +}
>> +
>> +static u32 fspi_readl(void __iomem *addr)
>> +{
>> +	return ioread32(addr);
>> +}
> 
> Hm, I'd recommend dropping the ->read/write() hooks and providing the
> following functions:
> 
> static void fspi_writel(struct nxp_fspi *f, u32 val, void __iomem *addr)
> {
> 	if (f->big_endian)
> 		iowrite32be(val, addr);
> 	else
> 		iowrite32(val, addr);
> }
> 
> 
> static u32 fspi_readl(struct nxp_fspi *f, void __iomem *addr)
> {
> 	if (f->big_endian)
> 		return ioread32be(addr);
> 	else
> 		return ioread32(addr);
> }

I introduced the ->read/write() hooks in the QSPI driver because I was 
told to remove the conditional in the read/write path, but I can't 
really tell if this really makes any difference.

Regards,
Frieder

> 
>> +
>> +static irqreturn_t nxp_fspi_irq_handler(int irq, void *dev_id)
>> +{
>> +	struct nxp_fspi *f = dev_id;
>> +	u32 reg;
>> +
>> +	/* clear interrupt */
>> +	reg = f->read(f->iobase + FSPI_INTR);
>> +	f->write(FSPI_INTR_IPCMDDONE_MASK, f->iobase + FSPI_INTR);
>> +
>> +	if (reg & FSPI_INTR_IPCMDDONE_MASK)
>> +		complete(&f->c);
>> +
>> +	return IRQ_HANDLED;
>> +}
> 
> [...]
> 
>> +/*
>> + * If the slave device content being changed by Write/Erase, need to
>> + * invalidate the AHB buffer. This can be achieved by doing the reset
>> + * of controller after setting MCR0[SWRESET] bit.
>> + */
>> +static inline void nxp_fspi_invalid(struct nxp_fspi *f)
>> +{
>> +	u32 reg;
>> +
>> +	reg = f->read(f->iobase + FSPI_MCR0);
>> +	f->write(reg | FSPI_MCR0_SWRST_MASK, f->iobase + FSPI_MCR0);
>> +
>> +	while (f->read(f->iobase + FSPI_MCR0) & FSPI_MCR0_SWRST_MASK)
>> +		;
> 
> Did you consider using readl_poll_timeout[_atomic]()?
> 
> 	if (f->big_endian)
> 		mask = (u32)cpu_to_be32(FSPI_MCR0_SWRST_MASK);
> 	else
> 		mask = (u32)cpu_to_be32(FSPI_MCR0_SWRST_MASK);
> 
> 	ret = readl_poll_timeout(f->iobase + FSPI_MCR0, reg,
> 				 reg & mask, 0, FSPI_SWRST_TIMEOUT);
> 	WARN_ON(ret);
> 
>> +}
> 
> [...]
> 
>> +static void nxp_fspi_read_ahb(struct nxp_fspi *f, const struct spi_mem_op *op)
>> +{
>> +	u32 len = op->data.nbytes;
>> +
>> +	/* Read out the data directly from the AHB buffer. */
>> +	memcpy_fromio(op->data.buf.in, (f->ahb_addr + op->addr.val), len);
> 
> Don't know if it's supported, but if it is, I recommend using DMA to do
> this copy, because otherwise you might stall the CPU for quite a long
> time if the flash is operating in a low-speed mode, and RT maintainers
> will complain about that at some point ;-).
> 
>> +}
>> +
>> +static void nxp_fspi_fill_txfifo(struct nxp_fspi *f,
>> +				 const struct spi_mem_op *op)
>> +{
>> +	void __iomem *base = f->iobase;
>> +	int i, j;
>> +	int size, tmp_size, wm_size;
>> +	u32 data = 0;
>> +	u32 *txbuf = (u32 *) op->data.buf.out;
>> +
>> +	/* clear the TX FIFO. */
>> +	f->write(FSPI_IPTXFCR_CLR_MASK, base + FSPI_IPTXFCR);
>> +
>> +	/* Default value of water mark level is 8 bytes. */
>> +	wm_size = 8;
>> +	size = op->data.nbytes / wm_size;
>> +	for (i = 0; i < size; i++) {
>> +		/* Wait for TXFIFO empty */
>> +		while (!(f->read(base + FSPI_INTR) & FSPI_INTR_IPTXWE_MASK))
>> +			;
> 
> Use readl_poll_timeout(), or even better, provide an helper
> (fspi_readl_poll_timeout()?) that hides the BE/LE stuff, so that you
> can reuse it when this pattern occurs.
> 
> [...]
> 
>> +static int nxp_fspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
>> +{
>> +	struct nxp_fspi *f = spi_controller_get_devdata(mem->spi->master);
>> +	void __iomem *base = f->iobase;
>> +	int err = 0;
>> +	unsigned int timeout = 1000;
>> +
>> +	mutex_lock(&f->lock);
>> +
>> +	/* wait for the controller being ready */
>> +	do {
>> +		u32 status;
>> +
>> +		status = f->read(base + FSPI_STS0);
>> +		if ((status & FSPI_STS0_ARB_IDLE_MASK) &&
>> +		    (status & FSPI_STS0_SEQ_IDLE_MASK))
>> +			break;
>> +		udelay(1);
>> +		dev_dbg(f->dev, "The controller is busy, 0x%x\n", status);
> 
> Same here.
> 
> Note that I didn't spend time looking at how the IP works, which
> explains why I focus on tiny details here. Unfortunately, I won't have
> time to review the driver in more details, so I'll leave that to
> someone else, or let Mark decides if he's happy enough with the current
> version.
> 
> Regards,
> 
> Boris
> 
