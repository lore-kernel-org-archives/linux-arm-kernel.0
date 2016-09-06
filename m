From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 6 Sep 2016 14:52:37 +0200
Subject: [PATCH 6/7] mtd: nand: mxc: implement onfi get/set features
In-Reply-To: <20160906124714.5bidphcpp2oa5yxn@pengutronix.de>
References: <1473158355-22451-1-git-send-email-s.hauer@pengutronix.de>
 <1473158355-22451-7-git-send-email-s.hauer@pengutronix.de>
 <20160906140521.508a2861@bbrezillon>
 <20160906124714.5bidphcpp2oa5yxn@pengutronix.de>
Message-ID: <20160906145237.0d2c936b@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 6 Sep 2016 14:47:14 +0200
Sascha Hauer <s.hauer@pengutronix.de> wrote:

> On Tue, Sep 06, 2016 at 02:05:21PM +0200, Boris Brezillon wrote:
> > On Tue,  6 Sep 2016 12:39:14 +0200
> > Sascha Hauer <s.hauer@pengutronix.de> wrote:
> >   
> > > To be able to support different ONFI timing modes we have to implement
> > > the onfi_set_features and onfi_get_features. Tested on an i.MX25 SoC.
> > > 
> > > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > > ---
> > >  drivers/mtd/nand/mxc_nand.c | 53 +++++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 53 insertions(+)
> > > 
> > > diff --git a/drivers/mtd/nand/mxc_nand.c b/drivers/mtd/nand/mxc_nand.c
> > > index 5173fad..1db8299 100644
> > > --- a/drivers/mtd/nand/mxc_nand.c
> > > +++ b/drivers/mtd/nand/mxc_nand.c
> > > @@ -1239,6 +1239,57 @@ static void mxc_nand_command(struct mtd_info *mtd, unsigned command,
> > >  	}
> > >  }
> > >  
> > > +static int mxc_nand_onfi_set_features(struct mtd_info *mtd, struct nand_chip *chip,
> > > +			int addr, uint8_t *subfeature_param)
> > > +{
> > > +	struct nand_chip *nand_chip = mtd_to_nand(mtd);
> > > +	struct mxc_nand_host *host = nand_get_controller_data(nand_chip);
> > > +	int i;
> > > +
> > > +	if (!chip->onfi_version ||
> > > +	    !(le16_to_cpu(chip->onfi_params.opt_cmd)
> > > +	      & ONFI_OPT_CMD_SET_GET_FEATURES))
> > > +		return -EINVAL;
> > > +
> > > +	host->buf_start = 0;
> > > +
> > > +	for (i = 0; i < ONFI_SUBFEATURE_PARAM_LEN; ++i)
> > > +		chip->write_byte(mtd, subfeature_param[i]);
> > > +
> > > +	memcpy32_toio(host->main_area0, host->data_buf, mtd->writesize);
> > > +	host->devtype_data->send_cmd(host, NAND_CMD_SET_FEATURES, false);
> > > +	mxc_do_addr_cycle(mtd, addr, -1);
> > > +	host->devtype_data->send_page(mtd, NFC_INPUT);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int mxc_nand_onfi_get_features(struct mtd_info *mtd, struct nand_chip *chip,
> > > +			int addr, uint8_t *subfeature_param)
> > > +{
> > > +	struct nand_chip *nand_chip = mtd_to_nand(mtd);
> > > +	struct mxc_nand_host *host = nand_get_controller_data(nand_chip);
> > > +	int i;
> > > +
> > > +	if (!chip->onfi_version ||
> > > +	    !(le16_to_cpu(chip->onfi_params.opt_cmd)
> > > +	      & ONFI_OPT_CMD_SET_GET_FEATURES))
> > > +		return -EINVAL;
> > > +
> > > +	*(uint32_t *)host->main_area0 = 0xdeadbeef;  
> 
> This line should be removed by the way.
> 
> > > +
> > > +	host->devtype_data->send_cmd(host, NAND_CMD_GET_FEATURES, false);
> > > +	mxc_do_addr_cycle(mtd, addr, -1);
> > > +	host->devtype_data->send_page(mtd, NFC_OUTPUT);
> > > +	memcpy32_fromio(host->data_buf, host->main_area0, 512);
> > > +	host->buf_start = 0;
> > > +
> > > +	for (i = 0; i < ONFI_SUBFEATURE_PARAM_LEN; ++i)
> > > +		*subfeature_param++ = chip->read_byte(mtd);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >  /*
> > >   * The generic flash bbt decriptors overlap with our ecc
> > >   * hardware, so define some i.MX specific ones.
> > > @@ -1513,6 +1564,8 @@ static int mxcnd_probe(struct platform_device *pdev)
> > >  	this->read_word = mxc_nand_read_word;
> > >  	this->write_buf = mxc_nand_write_buf;
> > >  	this->read_buf = mxc_nand_read_buf;
> > > +	this->onfi_set_features = mxc_nand_onfi_set_features;
> > > +	this->onfi_get_features = mxc_nand_onfi_get_features;  
> > 
> > Do you really have to re-implement ->onfi_{set,get}_features()?
> > How about adding support for this command in your ->cmdfunc()
> > implementation and relying on the default ->onfi_{set,get}_features()
> > provided by the core?  
> 
> I probably could. The problem is that the generic
> nand_onfi_set_features() first sends the command then afterwards uses
> chip->write_byte to actually send the data. This is not how the mxc_nand
> controller works. On mxc_nand I first need the data before I can issue
> the command.
> I could implement it in the ->cmdfunc() like: When NAND_CMD_SET_FEATURES
> is issued, track that information. Then I have to count how many times
> ->write_byte() has been called and when I reach  
> ONFI_SUBFEATURE_PARAM_LEN I have to send the command. While that would
> probably work I was glad that I could avoid that. It's one of the
> places where one realizes that the nand core layer is built around the
> nand controllers of the late nineties.

Okay. Actually I have some plans for these problems, but let's stick to
mxc_nand_onfi_{set,get}_features() for now.
