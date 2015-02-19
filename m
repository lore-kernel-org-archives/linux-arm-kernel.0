From: baruch@tkos.co.il (Baruch Siach)
Date: Thu, 19 Feb 2015 11:43:01 +0200
Subject: [PATCH 2/2] mtd: nand: driver for Conexant Digicolor NAND Flash
 Controller
In-Reply-To: <20150219001704.40874da0@bbrezillon>
References: <e6a998f130c40cee0a72e23b4f7f65bece0d6b21.1423739332.git.baruch@tkos.co.il>
 <ffec2fc232083355fdb171efb9daf59686ac2fed.1423739332.git.baruch@tkos.co.il>
 <20150219001704.40874da0@bbrezillon>
Message-ID: <20150219094301.GE2937@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

On Thu, Feb 19, 2015 at 12:17:04AM +0100, Boris Brezillon wrote:
> On Thu, 12 Feb 2015 13:10:19 +0200
> Baruch Siach <baruch@tkos.co.il> wrote:
> > This commit adds driver for the NAND flash controller on the CX92755 SoC. 
> > This
> > SoC is one of the Conexant Digicolor series, and this driver should support
> > other SoCs in this series.
> 
> I haven't done any coding style review here, so make sure to fix
> all errors/warnings reported by checkpatch if any.
> 
> > Only hardware syndrome ECC mode is currently supported.
> > 
> > This driver was tested on the Equinox CX92755 EVK, with the Samsung K9GAG08U0E
> > NAND chip (MLC, 8K pages, 436 bytes OOB). Test included attach of UBI volume,
> > mount of UBIFS filesystem, and files read/write.
> 
> Could you also run mtd test (kernel module tests) and provide their
> results in your next version ?

OK. Will do.

[...]

> > +#define CMD_NUMBER_BYTES(n)		((n) << 8) /* ALE command */
> 
> Unless you have good reason to keep this name I would name it
> CMD_ADDR_CYCLES.

I used the wording of the datasheet. Actually this field also applies to the 
CLE command, but currently we assume that CLE is always a single byte.

[...]

> > +struct digicolor_nfc {
> > +	void __iomem		*regs;
> > +	struct mtd_info		mtd;
> > +	struct nand_chip	nand;
> > +	struct device		*dev;
> > +
> > +	unsigned long		clk_rate;
> > +
> > +	u32 ale_cmd;
> > +	u32 ale_data;
> > +	int ale_data_bytes;
> > +
> > +	u32 nand_cs;
> > +	int t_ccs;
> > +};
> 
> Sorry, you're the first one I'll bother with this.
> Even if most drivers are already mixing the NAND chips and NAND
> controller concepts, I really think those 2 elements should be properly
> separated.
> 
> Correct me if I'm wrong, but I'm pretty sure _nfc stands for NAND Flash
> Controller, and as such, NFC related fields should be part of your NAND
> controller implementation (inherited from the struct nand_hw_control)
> and not your NAND chip implementation (inherited from nand_chip).
> 
> If you need an example of such NAND chip/NAND controller separation,
> you can take a look at the sunxi driver ;-). 

I understand you concern. However, since I don't have the needed hardware to 
test the multi nand chip setup I want to keep the code simple. These two 
fields are separated from the others by a blank line on purpose, and I'll also 
add a comment to explain that these are per nand chip files.

> > +/*
> > + * Table of BCH configuration options. The index of this table (0 - 5) is set
> > + * in the BchTconfig field of the NFC_CONTROL register.
> > + */
> > +struct bch_configs_t {
> 
> I haven't seen any struct defined with an _t, AFAIK _t are reserved for
> typedef definitions.

Well, there are some precedents:

$ git grep 'struct.*_t {$' -- include/ |grep -v typedef
include/crypto/vmac.h:struct vmac_ctx_t {
include/linux/dcache.h:struct dentry_stat_t {
include/linux/dma-buf.h:	struct dma_buf_poll_cb_t {
include/linux/kgdb.h:struct dbg_reg_def_t {
include/linux/sctp.h:struct sctp_shutdown_chunk_t {
include/net/9p/client.h:struct p9_req_t {
include/net/tso.h:struct tso_t {
include/uapi/linux/fs.h:struct inodes_stat_t {
include/uapi/linux/pkt_cls.h:struct tcf_t {

The 'typedef' variant for structs is somewhat more prevalent but not 
overwhelmingly so.

> > +	int bits;	/* correctable error bits number (strength) per step */
> > +	int r_bytes;	/* extra bytes needed per step */
> > +} bch_configs[] = {
> > +	{  6, 11 },
> > +	{  7, 13 },
> > +	{  8, 14 },
> > +	{ 24, 42 },
> > +	{ 28, 49 },
> > +	{ 30, 53 },
> > +};
> 
> Just giving my opinion here, but I don't like when values assignment
> and struct (or type) definitions are mixed.

OK. I'll change that.

[...]

> > +static int digicolor_nfc_wait_ready(struct digicolor_nfc *nfc, int op)
> > +{
> > +	unsigned long timeout = jiffies + msecs_to_jiffies(TIMEOUT_MS);
> > +	u32 mask;
> > +
> > +	switch (op) {
> > +	case CMD:		mask = NFC_INT_CMDREG_READY; break;
> > +	case DATA_READ:		mask = NFC_INT_READ_DATAREG_READY; break;
> > +	case DATA_WRITE:	mask = NFC_INT_WRITE_DATAREG_READY; break;
> > +	case ECC_STATUS:	mask = NFC_INT_ECC_STATUS_READY; break;
> > +	}
> 
> I had a look at digicolor_nfc_wait_ready callers, and IMHO this
> op -> mask conversion is pretty much useless.
> Callers already know what they expect and could easily pass flags
> directly.

It's just that the INT flag name is quite long, and it make the code using it 
less readable IMO. Maybe some macro trickery would do the job here.

[...]

> > +static void digicolor_nfc_cmd_write(struct digicolor_nfc *nfc, u32 data)
> > +{
> > +	if (digicolor_nfc_wait_ready(nfc, CMD))
> > +		return;
> > +	writel_relaxed(data, nfc->regs + NFC_COMMAND);
> 
> Are you sure you shouldn't provide a return code here ?
> If the wait_ready call times out, you're just assuming it succeed,
> which is not really safe.

Right. I'll change that.

> > +static int digicolor_nfc_ecc_status(struct digicolor_nfc *nfc)
> > +{
> > +	u32 status;
> > +
> > +	if (digicolor_nfc_wait_ready(nfc, ECC_STATUS))
> > +		return -1;
> 
> 		return -ETIMEDOUT
> 
> would be more appropriate (or just returning the
> digicolor_nfc_wait_ready result if it's not 0).

Originally I intended for this return value to be an internal error 
indication. You are right though that the code should handle the timeout error 
differently.

> > +	status = readl_relaxed(nfc->regs + NFC_STATUS_1);
> > +	writel_relaxed(NFC_INT_ECC_STATUS_READY, nfc->regs + NFC_INTFLAG_CLEAR);
> > +
> > +	if (status & NFC_STATUS_1_UNCORRECTED_ERROR)
> > +		return -1;
> 
> 		return -EIO;
> 
> (or something else, but I don't recall).

OK.

[...]

> > +static int digicolor_nfc_dev_ready(struct mtd_info *mtd)
> > +{
> > +	struct nand_chip *chip = mtd->priv;
> > +	struct digicolor_nfc *nfc = chip->priv;
> > +	u32 readready;
> > +	u32 cs = nfc->nand_cs;
> > +
> > +	readready = CMD_WAITREADY | CMD_CHIP_ENABLE(cs) | CMD_RB_MASK(cs)
> > +		| CMD_TOGGLE | CMD_RB_DATA;
> > +	digicolor_nfc_cmd_write(nfc, readready);
> > +
> > +	return 1;
> 
> Is your device always ready ?

I have no control of that. This command goes into a pipe that is managed at 
the hardware level. If the nand device does not activate the ready/busy 
signal, the pipe will just stall, and the command FIFO will overflow (the 
command FIFO has 8 entries). So you will notice the error eventually.

There is an option to flag this command, and let the hardware indicate when it 
has completed successfully. But the current upper layer only gives up to 20ms 
for the nand chip to become ready. Depending on the commands currently waiting 
for processing it might take longer.

> What if your digicolor_nfc_cmd_write timed out ?

What should I return in this case? Returning 0 means that the device is not 
YET ready. But that's not what actually happens here. I'm not sure that the 
right solution is here.

> > +static void digicolor_nfc_cmd_ctrl(struct mtd_info *mtd, int cmd,
> > +				   unsigned int ctrl)
> > +{
> > +	struct nand_chip *chip = mtd->priv;
> > +	struct digicolor_nfc *nfc = chip->priv;
> > +	u32 cs = nfc->nand_cs;
> > +
> > +	if (ctrl & NAND_CLE) {
> > +		digicolor_nfc_cmd_write(nfc,
> > +					CMD_CLE | CMD_CHIP_ENABLE(cs) | cmd);
> > +		if (cmd == NAND_CMD_RNDOUTSTART || cmd == NAND_CMD_RNDIN) {
> > +			digicolor_nfc_wait_ns(nfc, nfc->t_ccs);
> > +		} else if (cmd == NAND_CMD_RESET) {
> > +			digicolor_nfc_wait_ns(nfc, 200);
> > +			digicolor_nfc_dev_ready(mtd);
> > +		}
> 
> These wait and dev_ready calls are supposed to be part of the generic
> cmdfunc implementation, did you encounter any issues when relying on the
> default implementation ?

The generic code just waits. This doesn't help here. Hardware does all the 
command processing in its own schedule. To make the hardware wait I must 
explicitly insert a wait command into the pipe.

[...]

> > +static uint8_t digicolor_nfc_rw_byte(struct digicolor_nfc *nfc, int byte)
> > +{
> > +	bool read = (byte == -1);
> > +	u32 cs = nfc->nand_cs;
> > +
> > +	digicolor_nfc_cmd_write(nfc, read ? CMD_PAGEREAD : CMD_PAGEWRITE
> > +				| CMD_CHIP_ENABLE(cs));
> > +	digicolor_nfc_cmd_write(nfc, 1);
> > +
> > +	if (digicolor_nfc_wait_ready(nfc, read ? DATA_READ : DATA_WRITE))
> > +		return 0;
> > +
> > +	if (read)
> > +		return readl_relaxed(nfc->regs + NFC_DATA);
> > +	else
> > +		writel_relaxed(byte & 0xff, nfc->regs + NFC_DATA);
> > +
> > +	return 0;
> > +}
> 
> Is there a real need to keep read and write handling in the same
> function ?

Well, I really hate seeing two functions that are almost identical next to 
each other. Maybe I take the DRY principle too extremely, but that is not the 
case here IMO.

> You're testing twice the operation type in a ~10 lines function.

Three times, actually. But I trust the compiler to be smart enough to test it 
only once when generating code.

> Just move the appropriate code in the following functions.

I don't agree. These operations are almost identical. Keeping them together 
should make future refactoring easier.

If I added function parameters for CMD_ and DATA_ (thus eliminating two 
operation tests) would it make the code better in your opinion?

> > +static uint8_t digicolor_nfc_read_byte(struct mtd_info *mtd)
> > +{
> > +	struct nand_chip *chip = mtd->priv;
> > +	struct digicolor_nfc *nfc = chip->priv;
> > +
> > +	return digicolor_nfc_rw_byte(nfc, -1);
> > +}
> > +
> > +static void digicolor_nfc_write_byte(struct mtd_info *mtd, uint8_t byte)
> > +{
> > +	struct nand_chip *chip = mtd->priv;
> > +	struct digicolor_nfc *nfc = chip->priv;
> > +
> > +	digicolor_nfc_rw_byte(nfc, byte);
> > +}

[...]

> > +	while (len >= 4) {
> > +		if (digicolor_nfc_wait_ready(nfc, op))
> > +			return;
> > +		if (op == DATA_READ)
> > +			*pr++ = readl_relaxed(nfc->regs + NFC_DATA);
> > +		else
> > +			writel_relaxed(*pw++, nfc->regs + NFC_DATA);
> > +		len -= 4;
> > +	}
> 
> How about using readsl/writesl here (instead of this loop) ?

How can I add the wait condition in readsl/writesl?

> > +	if (len > 0) {
> > +		if (digicolor_nfc_wait_ready(nfc, op))
> > +			return;
> > +		if (op == DATA_READ)
> > +			buf_tail = readl_relaxed(nfc->regs + NFC_DATA);
> > +		for (i = 0; i < len; i++) {
> > +			u8 *tr = (u8 *)pr;
> > +			const u8 *tw = (const u8 *)pw;
> > +
> > +			if (op == DATA_READ) {
> > +				tr[i] = buf_tail & 0xff;
> > +				buf_tail >>= 8;
> > +			} else {
> > +				buf_tail <<= 8;
> > +				buf_tail |= tw[i];
> > +			}
> > +		}
> 
> I still don't get that part, but I guess you have a good reason for
> doing that.
> Could add a comment explaining what you're doing and why you're doing
> it ?

This code processes tail of the buffer that is the reminder of the /4 
division. Originally I relied on the fact that pages size are always a 
multiple of 4. But later I added OOB read/write using this routine, so this 
assumption is no longer true.

Anyway, I'll add a comment.

> > +		if (op == DATA_WRITE)
> > +			writel_relaxed(buf_tail, nfc->regs + NFC_DATA);
> > +	}
> > +}
> 
> Again, the code in this function should be dispatched in the
> digicolor_nfc_read/write_buf functions.

See above.

[...]

> > +static int digicolor_nfc_read_page_syndrome(struct mtd_info *mtd,
> > +					    struct nand_chip *chip,
> > +					    uint8_t *buf, int oob_required,
> > +					    int page)
> > +{
> > +	struct digicolor_nfc *nfc = chip->priv;
> > +	int step, ecc_stat;
> > +	struct nand_oobfree *oobfree = &chip->ecc.layout->oobfree[0];
> > +	u8 *oob = chip->oob_poi + oobfree->offset;
> > +	unsigned int max_bitflips = 0;
> > +
> > +	for (step = 0; step < chip->ecc.steps; step++) {
> > +		digicolor_nfc_rw_buf(nfc, buf, NULL, chip->ecc.size, true);
> > +
> > +		ecc_stat = digicolor_nfc_ecc_status(nfc);
> 
> If the returned error is a timeout you might want to stop the whole
> operation.

Right. I'll fix that.

[...]

> > +static void digicolor_nfc_hw_init(struct digicolor_nfc *nfc)
> > +{
> > +	unsigned int ns_per_clk = NSEC_PER_SEC / nfc->clk_rate;
> > +	u32 timing = 0;
> > +
> > +	writel_relaxed(NFC_CONTROL_LOCAL_RESET, nfc->regs + NFC_CONTROL);
> > +	udelay(10);
> > +	writel_relaxed(0, nfc->regs + NFC_CONTROL);
> > +	udelay(5);
> > +	/*
> > +	 * Maximum assert/deassert time; asynchronous SDR mode 0
> > +	 * Deassert time = max(tWH,tREH) = 30ns
> > +	 * Assert time = max(tRC,tRP,tWC,tWP) = 100ns
> > +	 * Sample time = 0
> > +	 */
> > +	timing |= TIMING_DEASSERT(DIV_ROUND_UP(30, ns_per_clk));
> > +	timing |= TIMING_ASSERT(DIV_ROUND_UP(100, ns_per_clk));
> > +	timing |= TIMING_SAMPLE(0);
> > +	writel_relaxed(timing, nfc->regs + NFC_TIMING_CONFIG);
> > +	writel_relaxed(NFC_CONTROL_ENABLE, nfc->regs + NFC_CONTROL);
> 
> Helper functions are provided to extract timings from ONFI timing modes
> (either those defined by the chip if it supports ONFI commands, or
> those extracted from the datasheet):
> 
> http://lxr.free-electrons.com/source/include/linux/mtd/nand.h#L976

I wanted to keep that for future improvement. The NAND chip on the EVK board 
is actually an old style one, neither ONFI nor JEDEC. I expect to test this 
driver on our target hardware that should have something newer.

> > +static int digicolor_nfc_ecc_init(struct digicolor_nfc *nfc,
> > +				  struct device_node *np)
> > +{
> > +	struct mtd_info *mtd = &nfc->mtd;
> > +	struct nand_chip *chip = &nfc->nand;
> > +	int bch_data_range, bch_t, steps, mode, i;
> > +	u32 ctrl = NFC_CONTROL_ENABLE | NFC_CONTROL_BCH_KCONFIG;
> > +	struct nand_ecclayout *layout;
> > +
> > +	mode = of_get_nand_ecc_mode(np);
> > +	if (mode < 0)
> > +		return mode;
> > +	if (mode != NAND_ECC_HW_SYNDROME) {
> > +		dev_err(nfc->dev, "unsupported ECC mode\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	bch_data_range = of_get_nand_ecc_step_size(np);
> > +	if (bch_data_range < 0)
> > +		return bch_data_range;
> > +	if (bch_data_range != 512 && bch_data_range != 1024) {
> > +		dev_err(nfc->dev, "unsupported nand-ecc-step-size value\n");
> > +		return -EINVAL;
> > +	}
> > +	if (bch_data_range == 1024)
> > +		ctrl |= NFC_CONTROL_BCH_DATA_FIELD_RANGE_1024;
> > +	steps = mtd->writesize / bch_data_range;
> > +
> > +	bch_t = of_get_nand_ecc_strength(np);
> > +	if (bch_t < 0)
> > +		return bch_t;
> 
> You should fallback to datasheet values (ecc_strength_ds and
> ecc_step_ds) if ECC strength and step are not specified in the DT.

I can only choose from a fix number of strength configuration alternatives. 
Should I choose the lowest value that is larger than ecc_strength_ds?

> > +MODULE_DEVICE_TABLE(of, sunxi_nfc_ids);
> 
> Hm, let me guess, you've based your work on the sunxi driver, isn't
> it ? :-)

You got me. Actually it was the only NAND driver that I found from recent 
time. All other are 3+ years old. But since last night we also have the 
hisi504_nand in mainline. Interesting times.

> That's all I got for now.
> 
> I might have missed some details, but all in all I really like the way
> this driver was designed (but I'm not sure to be objective since this
> one is based on the sunxi driver ;-)):
> - pretty straightforward implementation
> - make use, as much as possible, of the NAND infrastructure (no specific
>   cmdfunc, seems to support raw accesses, ...)
> 
> The only missing parts are:
> - proper timing configuration
> - replace active waits (polling) by passive waits (interrupt +
>   waitqueue)
> 
> But that should be fixed quite easily.

It's on my TODO. I don't think it should block the driver, though.

Thank you very much for your thorough review.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
