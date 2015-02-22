From: baruch@tkos.co.il (Baruch Siach)
Date: Sun, 22 Feb 2015 10:19:23 +0200
Subject: [PATCH 2/2] mtd: nand: driver for Conexant Digicolor NAND Flash
 Controller
In-Reply-To: <20150219115223.40378b17@bbrezillon>
References: <e6a998f130c40cee0a72e23b4f7f65bece0d6b21.1423739332.git.baruch@tkos.co.il>
 <ffec2fc232083355fdb171efb9daf59686ac2fed.1423739332.git.baruch@tkos.co.il>
 <20150219001704.40874da0@bbrezillon>
 <20150219094301.GE2937@tarshish>
 <20150219115223.40378b17@bbrezillon>
Message-ID: <20150222081923.GB2402@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

On Thu, Feb 19, 2015 at 11:52:23AM +0100, Boris Brezillon wrote:
> On Thu, 19 Feb 2015 11:43:01 +0200
> Baruch Siach <baruch@tkos.co.il> wrote:
> > On Thu, Feb 19, 2015 at 12:17:04AM +0100, Boris Brezillon wrote:
> > > On Thu, 12 Feb 2015 13:10:19 +0200
> > > Baruch Siach <baruch@tkos.co.il> wrote:
> > I understand you concern. However, since I don't have the needed hardware 
> > to test the multi nand chip setup I want to keep the code simple. These 
> > two fields are separated from the others by a blank line on purpose, and 
> > I'll also add a comment to explain that these are per nand chip files.
> 
> I'm not asking you to support multiple chips right now.
> What I'm asking here is to dispatch NFC and NAND fields in different
> structures:
> 
> struct digicolor_nand {
> 	struct mtd_info		mtd;
> 	struct nand_chip	nand;
> 
> 	u32 nand_cs;
> 	int t_ccs;
> }
> 
> struct digicolor_nfc {
> 	struct nand_hw_control	base;
> 	void __iomem		*regs;
> 	struct device		*dev;
> 
> 	unsigned long		clk_rate;
> 
> 	u32 ale_cmd;
> 	u32 ale_data;
> 	int ale_data_bytes;
> 
> 	/* Only support one NAND for now */
> 	struct digicolor_nand	nand;
> };
> 
> You'll keep the same logic except that this separation will be clearly
> visible.

Sounds reasonable. Will do.

[...]

> > It's just that the INT flag name is quite long, and it make the code using 
> > it less readable IMO. Maybe some macro trickery would do the job here.
> 
> Yep, if that's about avoiding over 80 character lines you could define
> such a macro:
> 
> #define NFC_RDY(flag)		NFC_INT_ ## flag ## _READY

Thanks for the tip. Will do.

[...]

> > I have no control of that. This command goes into a pipe that is managed 
> > at the hardware level. If the nand device does not activate the ready/busy 
> > signal, the pipe will just stall, and the command FIFO will overflow (the 
> > command FIFO has 8 entries). So you will notice the error eventually.
> 
> My point is: you should not return 1 if the NAND is not ready,
> waiting forever is not what I'm suggesting here, but you should find a
> way to return the actual NAND chip R/B status.
> If you don't have any solution to do that from your controller then you
> might consider relying on the default dev_ready implementation which is
> sending a NAND STATUS command to retrieve the R/B status.
> 
> What I'll say is in contradiction with what's done in the sunxi
> driver :-) (actually I'm considering fixing that), but after taking a
> closer look, dev_ready should only return the status of the NAND, and
> not wait for the NAND to be ready.
> The function responsible for waiting is waitfunc, maybe this is the one
> you should overload.

OK. I'll look into overloading waitfunc.

[...]

> > > > +static void digicolor_nfc_cmd_ctrl(struct mtd_info *mtd, int cmd,
> > > > +				   unsigned int ctrl)
> > > > +{
> > > > +	struct nand_chip *chip = mtd->priv;
> > > > +	struct digicolor_nfc *nfc = chip->priv;
> > > > +	u32 cs = nfc->nand_cs;
> > > > +
> > > > +	if (ctrl & NAND_CLE) {
> > > > +		digicolor_nfc_cmd_write(nfc,
> > > > +					CMD_CLE | CMD_CHIP_ENABLE(cs) | cmd);
> > > > +		if (cmd == NAND_CMD_RNDOUTSTART || cmd == NAND_CMD_RNDIN) {
> > > > +			digicolor_nfc_wait_ns(nfc, nfc->t_ccs);
> > > > +		} else if (cmd == NAND_CMD_RESET) {
> > > > +			digicolor_nfc_wait_ns(nfc, 200);
> > > > +			digicolor_nfc_dev_ready(mtd);
> > > > +		}
> > > 
> > > These wait and dev_ready calls are supposed to be part of the generic
> > > cmdfunc implementation, did you encounter any issues when relying on the
> > > default implementation ?
> > 
> > The generic code just waits. This doesn't help here. Hardware does all the 
> > command processing in its own schedule. To make the hardware wait I must 
> > explicitly insert a wait command into the pipe.
> 
> I'm not sure to understand here.
> There's a difference between:
> 1/ waiting for a NAND command to be send on the NAND bus
> 2/ waiting for the NAND to be ready (for DATA read or after a PROGRAM
>    operation)
> 
> NAND core is taking care of the 2/, but 1/ is your responsibility
> (and this is what you have to wait for here).

The generic code in nand_command_lp() sends NAND_CMD_STATUS immediately after 
NAND_CMD_RESET. According to the datasheet you must wait tWB (200ns max) 
before sending any command, including NAND_CMD_STATUS. Setting chip_delay is 
not enough as I explain above. That's way I added digicolor_nfc_wait_ns(). 
That timed wait is what I referred to. You are right that the 
digicolor_nfc_dev_ready() call is not needed here. Will remove.

[...]

> > > > +	while (len >= 4) {
> > > > +		if (digicolor_nfc_wait_ready(nfc, op))
> > > > +			return;
> > > > +		if (op == DATA_READ)
> > > > +			*pr++ = readl_relaxed(nfc->regs + NFC_DATA);
> > > > +		else
> > > > +			writel_relaxed(*pw++, nfc->regs + NFC_DATA);
> > > > +		len -= 4;
> > > > +	}
> > > 
> > > How about using readsl/writesl here (instead of this loop) ?
> > 
> > How can I add the wait condition in readsl/writesl?
> 
> Are you sure you have to wait after each readl access (is NFC_DATA
> interfaced with a FIFO or directly doing PIO access) ?

That's what the datasheet says. There is no mention of data FIFO in the 
datasheet.

[...]

> > > > +	/*
> > > > +	 * Maximum assert/deassert time; asynchronous SDR mode 0
> > > > +	 * Deassert time = max(tWH,tREH) = 30ns
> > > > +	 * Assert time = max(tRC,tRP,tWC,tWP) = 100ns
> > > > +	 * Sample time = 0
> > > > +	 */
> > > > +	timing |= TIMING_DEASSERT(DIV_ROUND_UP(30, ns_per_clk));
> > > > +	timing |= TIMING_ASSERT(DIV_ROUND_UP(100, ns_per_clk));
> > > > +	timing |= TIMING_SAMPLE(0);
> > > > +	writel_relaxed(timing, nfc->regs + NFC_TIMING_CONFIG);
> > > > +	writel_relaxed(NFC_CONTROL_ENABLE, nfc->regs + NFC_CONTROL);
> > > 
> > > Helper functions are provided to extract timings from ONFI timing modes
> > > (either those defined by the chip if it supports ONFI commands, or
> > > those extracted from the datasheet):
> > > 
> > > http://lxr.free-electrons.com/source/include/linux/mtd/nand.h#L976
> > 
> > I wanted to keep that for future improvement. The NAND chip on the EVK board 
> > is actually an old style one, neither ONFI nor JEDEC. I expect to test this 
> > driver on our target hardware that should have something newer.
> 
> Timings are not only related to ONFI chips, and
> onfi_timing_mode_default is extracted from the nand_ids table which is
> describing non-ONFI chips.
> 
> This is not my call to make, but IMHO, dynamic NAND timing
> configuration should be mandatory for new drivers.

I'll look into this for v2.

> > > > +static int digicolor_nfc_ecc_init(struct digicolor_nfc *nfc,
> > > > +				  struct device_node *np)
> > > > +{
> > > > +	struct mtd_info *mtd = &nfc->mtd;
> > > > +	struct nand_chip *chip = &nfc->nand;
> > > > +	int bch_data_range, bch_t, steps, mode, i;
> > > > +	u32 ctrl = NFC_CONTROL_ENABLE | NFC_CONTROL_BCH_KCONFIG;
> > > > +	struct nand_ecclayout *layout;
> > > > +
> > > > +	mode = of_get_nand_ecc_mode(np);
> > > > +	if (mode < 0)
> > > > +		return mode;
> > > > +	if (mode != NAND_ECC_HW_SYNDROME) {
> > > > +		dev_err(nfc->dev, "unsupported ECC mode\n");
> > > > +		return -EINVAL;
> > > > +	}
> > > > +
> > > > +	bch_data_range = of_get_nand_ecc_step_size(np);
> > > > +	if (bch_data_range < 0)
> > > > +		return bch_data_range;
> > > > +	if (bch_data_range != 512 && bch_data_range != 1024) {
> > > > +		dev_err(nfc->dev, "unsupported nand-ecc-step-size value\n");
> > > > +		return -EINVAL;
> > > > +	}
> > > > +	if (bch_data_range == 1024)
> > > > +		ctrl |= NFC_CONTROL_BCH_DATA_FIELD_RANGE_1024;
> > > > +	steps = mtd->writesize / bch_data_range;
> > > > +
> > > > +	bch_t = of_get_nand_ecc_strength(np);
> > > > +	if (bch_t < 0)
> > > > +		return bch_t;
> > > 
> > > You should fallback to datasheet values (ecc_strength_ds and
> > > ecc_step_ds) if ECC strength and step are not specified in the DT.
> > 
> > I can only choose from a fix number of strength configuration alternatives. 
> > Should I choose the lowest value that is larger than ecc_strength_ds?
> 
> Yep, this applies to both cases (information extracted from the DT and
> _ds values).

OK. Will do.

Thanks again for your valuable feedback,
baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
