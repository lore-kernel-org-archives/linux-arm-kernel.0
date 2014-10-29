From: computersforpeace@gmail.com (Brian Norris)
Date: Wed, 29 Oct 2014 10:08:43 -0700
Subject: [PATCH v7 1/2] mtd: nand: add sunxi NAND flash controller support
In-Reply-To: <20141029140251.142fed10@bbrezillon>
References: <1413896922-11680-1-git-send-email-boris.brezillon@free-electrons.com>
 <1413896922-11680-2-git-send-email-boris.brezillon@free-electrons.com>
 <20141028181310.GA23619@ld-irv-0074>
 <20141029140251.142fed10@bbrezillon>
Message-ID: <20141029170843.GD23619@ld-irv-0074>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 29, 2014 at 02:02:51PM +0100, Boris Brezillon wrote:
> On Tue, 28 Oct 2014 11:13:11 -0700 Brian Norris <computersforpeace@gmail.com> wrote:
> > On Tue, Oct 21, 2014 at 03:08:41PM +0200, Boris Brezillon wrote:
> > > +static int sunxi_nand_hw_ecc_ctrl_init(struct mtd_info *mtd,
> > > +				       struct nand_ecc_ctrl *ecc,
> > > +				       struct device_node *np)
> > > +{
> > > +	struct nand_ecclayout *layout;
> > > +	int i, j;
> > > +	int ret;
> > > +
> > > +	ret = sunxi_nand_hw_common_ecc_ctrl_init(mtd, ecc, np);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ecc->read_page = sunxi_nfc_hw_ecc_read_page;
> > > +	ecc->write_page = sunxi_nfc_hw_ecc_write_page;
> > > +	layout = ecc->layout;
> > > +
> > > +	for (i = 0; i < ecc->steps; i++) {
> > 
> > Hmm, did you retest this since changing this to ecc->steps? I think this
> > won't work, since ecc->steps is only initialized in nand_scan_tail(),
> > which comes after this. I only recommended the change for the
> > {read,write}_page() type of functions, not the initialization functions.
> > 
> > [snip the rest]
> > 
> > So I'd suggest the following additional patch, and otherwise, the series
> > is fine with me. If you give your ack, I can just squash this in and
> > apply it to my tree:
> 
> It works, you can squash those changes into my first patch.

OK, pushed both (+ my fixes) to l2-mtd.git. Thanks!

Brian
