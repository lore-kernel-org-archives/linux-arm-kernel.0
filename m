From: computersforpeace@gmail.com (Brian Norris)
Date: Wed, 22 Jul 2015 16:10:25 -0700
Subject: [Patch v3 2/5] mtd: nand: add NVIDIA Tegra NAND Flash controller
 driver
In-Reply-To: <1437597760.2289.13.camel@lynxeye.de>
References: <1431282602-7137-1-git-send-email-dev@lynxeye.de>
 <1431282602-7137-3-git-send-email-dev@lynxeye.de>
 <20150721212710.GN24125@google.com>
 <1437597760.2289.13.camel@lynxeye.de>
Message-ID: <20150722231025.GB8876@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jul 22, 2015 at 10:42:40PM +0200, Lucas Stach wrote:
> Am Dienstag, den 21.07.2015, 14:27 -0700 schrieb Brian Norris:
> > On Sun, May 10, 2015 at 08:29:59PM +0200, Lucas Stach wrote:
> > > --- /dev/null
> > > +++ b/drivers/mtd/nand/tegra_nand.c
> > > @@ -0,0 +1,801 @@
...
> > > +static int tegra_nand_read_page(struct mtd_info *mtd, struct nand_chip *chip,
> > > +				uint8_t *buf, int oob_required, int page)
> > > +{
...
> > > +	value = readl(nand->regs + DEC_STATUS);
> > > +
> > > +	if (value & DEC_STATUS_A_ECC_FAIL) {
> > > +		/*
> > > +		 * The ECC isn't smart enough to figure out if a page is
> > > +		 * completely erased and flags an error in this case. So we
> > > +		 * check the read data here to figure out if it's a legitimate
> > > +		 * error or a false positive.
> > > +		 */
> > > +		int i;
> > > +		u32 *data = (u32 *)buf;
> > > +		for (i = 0; i < mtd->writesize / 4; i++) {
> > > +			if (data[i] != 0xffffffff) {
> > > +				mtd->ecc_stats.failed++;
> > > +				return -EBADMSG;
> > > +			}
> > > +		}
> > 
> > Hmm, what about OOB? It's possible to actually write 0xff to the entire
> > page. This hunk means that such a data pattern would then be
> > unprotected. You should probably check that *both* the main and OOB data
> > are all 0xff; if there are non-0xff bytes, then that (probably, see the
> > following) means someone intentionally wrote all 0xff to the page. [1]
> > 
> 
> This check is only executed if the ECC engine flagged a non-correctable
> error. If someone wrote all 0xff to the page there will be a proper ECC
> checksum calculated and we won't get into this path. So to get this
> check to wrongly paper over a legitimate error someone would need to
> write almost all 0xff with a few bits 0, which then flip to a 1
> afterwards, which is highly unlikely as far as I understand flash
> technology.

On second thought, the case I mentioned is not a problem for you
currently. You'll just have more problems once you start seeing bitflips
in erased pages.

And I agree, the latter case you mention is probably pretty unlikely,
though I'm not really an EE expert to tell you cannot see such a 0->1
"stuck bit".

But anyway, why don't you check the spare area too? It turns the
"unlikely" problem into a non-issue.

At the same time, I see that you don't support raw page reads/writes. Is
it impossible? Or is it just an oversight?

> > Also, your check doesn't handle the case of finding bitflips in erased
> > pages. So not only do you need to check for all 0xff, but you also need
> > to tolerate a few flips. e.g., using hweight*() functions. There is
> > plenty of discussion on this subject, as many people have tried to
> > resolve this for their various drivers. But none have really done this
> > in a thorough and correct way, so few have been merged. Thus, I'd really
> > like to get something like this merged to nand_base.c, with a NAND_*
> > flag or two to enable it. That would help drivers like yours to easily
> > grab a good (albeit, likely slow) implementation.
> > 
> Did those discussion lead somewhere? It seems they got stuck some time
> ago. I'm all for using common infrastructure that does the right thing,
> but I wouldn't like to base this driver on top of future work with no
> clear roadmap.

That was really just an FYI. No, the discussion didn't lead much of
anywhere. A bunch of half-assed implementations, and me with no time
(and even less hardware, now).

> > So, I'd like to see the first request (about OOB checks) solved, and if
> > the larger bitflips-in-erased-pages issue isn't addressed, please
> > include a FIXME comment, or something similar.

I'd still either like to see a good reason not to check the OOB for
oob[:] == 0xffffffff, or else fix that up. The rest (which is, like you
say, "bas[ing] this driver on top of future work") is not your problem
ATM [1].

...
> > > +static void tegra_nand_setup_timing(struct tegra_nand *nand, int mode)
> > > +{
> > 
> > This function could use some comments. The math can be easy to get
> > wrong, especially without the annotation of units (e.g., picoseconds).
> > Also, look out for rounding inaccuracies. DIV_ROUND_UP() is nice for
> > getting conservative conversions at times.
> > 
> The timing formulas are listed in the TRM and I don't think it makes
> sense to repeat them here. Are you okay with a pointer to the relevant
> section in the TRM?

I don't think we need to see all the formulas again, but a TRM reference
could be nice. I was asking mostly about units, and also about the
round-down division. I'll add a few more comments below.

> > > +	unsigned long rate = clk_get_rate(nand->clk) / 1000000;

^^ conversion to MHz? Why? (comment) How about DIV_ROUND_UP, so you
don't overestimate the clock period (and thus underestimate the number
of clock periods needed)?

> > > +	unsigned long period = 1000000 / rate;

And period is... in picoseconds? It took me a minute to figure that out
for sure, so IMO it deserves a comment.

> > > +	const struct nand_sdr_timings *timings;
> > > +	u32 val, reg = 0;
> > > +
> > > +	timings = onfi_async_timing_mode_to_sdr_timings(mode);
> > > +
> > > +	val = max3(timings->tAR_min, timings->tRR_min,
> > > +		   timings->tRC_min) / period;

DIV_ROUND_UP()? You don't want to lop off a partial timing cycle, right?
Simliar comments apply throughout. Or please correct me if I'm wrong.

> > > +	if (val > 2)
> > > +		val -= 3;
> > > +	reg |= TIMING_TCR_TAR_TRR(val);
> > > +
> > > +	val = max(max(timings->tCS_min, timings->tCH_min),
> > > +		  max(timings->tALS_min, timings->tALH_min)) / period;
> > > +	if (val > 1)
> > > +		val -= 2;
> > > +	reg |= TIMING_TCS(val);
> > > +
> > > +	val = (max(timings->tRP_min, timings->tREA_max) + 6000) / period;
> > > +	reg |= (TIMING_TRP(val) | TIMING_TRP_RESP(val));
> > > +
> > > +	reg |= TIMING_TWB(timings->tWB_max / period);
> > > +	reg |= TIMING_TWHR(timings->tWHR_min / period);
> > > +	reg |= TIMING_TWH(timings->tWH_min / period);
> > > +	reg |= TIMING_TWP(timings->tWP_min / period);
> > > +	reg |= TIMING_TRH(timings->tRHW_min / period);
> > > +
> > > +	writel(reg, nand->regs + TIMING_1);
> > > +
> > > +	val = timings->tADL_min / period;
> > > +	if (val > 2)
> > > +		val -= 3;
> > > +	reg = TIMING_TADL(val);
> > > +
> > > +	writel(reg, nand->regs + TIMING_2);
> > > +}

Brian

[1] Unless, of course, you start using NAND flash that sees bitflips in
    erased pages.
