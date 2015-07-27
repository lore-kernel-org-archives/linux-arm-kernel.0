From: dev@lynxeye.de (Lucas Stach)
Date: Mon, 27 Jul 2015 21:12:39 +0200
Subject: [Patch v3 2/5] mtd: nand: add NVIDIA Tegra NAND Flash
 controller driver
In-Reply-To: <20150722231025.GB8876@google.com>
References: <1431282602-7137-1-git-send-email-dev@lynxeye.de>
 <1431282602-7137-3-git-send-email-dev@lynxeye.de>
 <20150721212710.GN24125@google.com> <1437597760.2289.13.camel@lynxeye.de>
 <20150722231025.GB8876@google.com>
Message-ID: <1438024359.2313.4.camel@lynxeye.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Brian,

a bit of investigation later I have some coherent answers to your
requests. :)

Am Mittwoch, den 22.07.2015, 16:10 -0700 schrieb Brian Norris:
> Hi,
> 
> On Wed, Jul 22, 2015 at 10:42:40PM +0200, Lucas Stach wrote:
> > Am Dienstag, den 21.07.2015, 14:27 -0700 schrieb Brian Norris:
> > > On Sun, May 10, 2015 at 08:29:59PM +0200, Lucas Stach wrote:
> > > > --- /dev/null
> > > > +++ b/drivers/mtd/nand/tegra_nand.c
> > > > @@ -0,0 +1,801 @@
> ...
> > > > +static int tegra_nand_read_page(struct mtd_info *mtd, struct nand_chip *chip,
> > > > +				uint8_t *buf, int oob_required, int page)
> > > > +{
> ...
> > > > +	value = readl(nand->regs + DEC_STATUS);
> > > > +
> > > > +	if (value & DEC_STATUS_A_ECC_FAIL) {
> > > > +		/*
> > > > +		 * The ECC isn't smart enough to figure out if a page is
> > > > +		 * completely erased and flags an error in this case. So we
> > > > +		 * check the read data here to figure out if it's a legitimate
> > > > +		 * error or a false positive.
> > > > +		 */
> > > > +		int i;
> > > > +		u32 *data = (u32 *)buf;
> > > > +		for (i = 0; i < mtd->writesize / 4; i++) {
> > > > +			if (data[i] != 0xffffffff) {
> > > > +				mtd->ecc_stats.failed++;
> > > > +				return -EBADMSG;
> > > > +			}
> > > > +		}
> > > 
> > > Hmm, what about OOB? It's possible to actually write 0xff to the entire
> > > page. This hunk means that such a data pattern would then be
> > > unprotected. You should probably check that *both* the main and OOB data
> > > are all 0xff; if there are non-0xff bytes, then that (probably, see the
> > > following) means someone intentionally wrote all 0xff to the page. [1]
> > > 
> > 
> > This check is only executed if the ECC engine flagged a non-correctable
> > error. If someone wrote all 0xff to the page there will be a proper ECC
> > checksum calculated and we won't get into this path. So to get this
> > check to wrongly paper over a legitimate error someone would need to
> > write almost all 0xff with a few bits 0, which then flip to a 1
> > afterwards, which is highly unlikely as far as I understand flash
> > technology.
> 
> On second thought, the case I mentioned is not a problem for you
> currently. You'll just have more problems once you start seeing bitflips
> in erased pages.
> 
> And I agree, the latter case you mention is probably pretty unlikely,
> though I'm not really an EE expert to tell you cannot see such a 0->1
> "stuck bit".
> 
> But anyway, why don't you check the spare area too? It turns the
> "unlikely" problem into a non-issue.
> 
If I'm using the HWECC/DMA functions I have no way to check the OOB ECC
area. The controller just skips over it and only transfers user
available OOB data into the buffer. So checking the OOB is unfortunately
not easily done.

> At the same time, I see that you don't support raw page reads/writes. Is
> it impossible? Or is it just an oversight?
> 
It's possible, but I've skipped it for now, as this would increase the
amount of testing I have to do to validate each round of those patches
even more and I don't see much benefit right now. So this remains a
TODO.

[...]
> > > > +	unsigned long rate = clk_get_rate(nand->clk) / 1000000;
> 
> ^^ conversion to MHz? Why? (comment) How about DIV_ROUND_UP, so you
> don't overestimate the clock period (and thus underestimate the number
> of clock periods needed)?
> 
> > > > +	unsigned long period = 1000000 / rate;
> 
> And period is... in picoseconds? It took me a minute to figure that out
> for sure, so IMO it deserves a comment.
> 
> > > > +	const struct nand_sdr_timings *timings;
> > > > +	u32 val, reg = 0;
> > > > +
> > > > +	timings = onfi_async_timing_mode_to_sdr_timings(mode);
> > > > +
> > > > +	val = max3(timings->tAR_min, timings->tRR_min,
> > > > +		   timings->tRC_min) / period;
> 
> DIV_ROUND_UP()? You don't want to lop off a partial timing cycle, right?
> Simliar comments apply throughout. Or please correct me if I'm wrong.
> 

I agree with the reasoning here and made those changes for v4.

> > > > +	if (val > 2)
> > > > +		val -= 3;
> > > > +	reg |= TIMING_TCR_TAR_TRR(val);
> > > > +
> > > > +	val = max(max(timings->tCS_min, timings->tCH_min),
> > > > +		  max(timings->tALS_min, timings->tALH_min)) / period;
> > > > +	if (val > 1)
> > > > +		val -= 2;
> > > > +	reg |= TIMING_TCS(val);
> > > > +
> > > > +	val = (max(timings->tRP_min, timings->tREA_max) + 6000) / period;
> > > > +	reg |= (TIMING_TRP(val) | TIMING_TRP_RESP(val));
> > > > +
> > > > +	reg |= TIMING_TWB(timings->tWB_max / period);
> > > > +	reg |= TIMING_TWHR(timings->tWHR_min / period);
> > > > +	reg |= TIMING_TWH(timings->tWH_min / period);
> > > > +	reg |= TIMING_TWP(timings->tWP_min / period);
> > > > +	reg |= TIMING_TRH(timings->tRHW_min / period);
> > > > +
> > > > +	writel(reg, nand->regs + TIMING_1);
> > > > +
> > > > +	val = timings->tADL_min / period;
> > > > +	if (val > 2)
> > > > +		val -= 3;
> > > > +	reg = TIMING_TADL(val);
> > > > +
> > > > +	writel(reg, nand->regs + TIMING_2);
> > > > +}
> 
Regards,
Lucas
