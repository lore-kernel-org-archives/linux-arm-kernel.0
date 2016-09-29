From: atull@opensource.altera.com (atull)
Date: Thu, 29 Sep 2016 16:35:39 -0500
Subject: [PATCH v19 12/12] fpga-manager: Add Socfpga Arria10 support
In-Reply-To: <CAAtXAHe927JSxaCs0LK8bm57mPRKvZ7ZaAvus_XDnzcQMmdAWw@mail.gmail.com>
References: <20160928182200.15800-1-atull@opensource.altera.com>
 <20160928182200.15800-13-atull@opensource.altera.com>
 <CAAtXAHe927JSxaCs0LK8bm57mPRKvZ7ZaAvus_XDnzcQMmdAWw@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1609291615050.30756@linuxheads99>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 29 Sep 2016, Moritz Fischer wrote:

> Hi Alan,
> 
> On Wed, Sep 28, 2016 at 11:22 AM, Alan Tull <atull@opensource.altera.com> wrote:
> 
> > +static void socfpga_a10_fpga_generate_dclks(struct a10_fpga_priv *priv,
> > +                                           u32 count)
> > +{
> > +       u32 val;
> > +       unsigned int i;
> > +
> > +       /* Clear any existing DONE status. */
> > +       regmap_write(priv->regmap, A10_FPGAMGR_DCLKSTAT_OFST,
> > +                    A10_FPGAMGR_DCLKSTAT_DCLKDONE);
> > +
> > +       /* Issue the DCLK regmap. */
> > +       regmap_write(priv->regmap, A10_FPGAMGR_DCLKCNT_OFST, count);
> > +
> > +       /* wait till the dclkcnt done */
> > +       for (i = 0; i < 100; i++) {
> > +               regmap_read(priv->regmap, A10_FPGAMGR_DCLKSTAT_OFST, &val);
> > +               if (val)
> > +                       break;
> > +               udelay(1);
> > +       }
> 
> It's quite new, but regmap_read_poll_timeout() might be a good fit here?

Yes

> 
> > +static int socfpga_a10_fpga_encrypted(struct fpga_manager *mgr,
> > +                                     u32 *buf32, size_t buf32_size)
> > +{
> > +       int encrypt;
> > +
> > +       if (buf32_size < 70)
> > +               return -EINVAL;
> > +
> > +       encrypt = ((buf32[69] >> 2) & 3) != 0;
> > +
> > +       dev_dbg(&mgr->dev, "header word %d = %08x encrypt=%d\n",
> > +               69, buf32[69], encrypt);
> Maybe a named constants for magic 69 / 70 value :)

Sure

> 
> > +static int socfpga_a10_fpga_compressed(struct fpga_manager *mgr,
> > +                                      u32 *buf32, size_t buf32_size)
> > +{
> > +       int compress;
> > +
> > +       if (buf32_size < 230)
> > +               return -EINVAL;
> > +
> > +       compress = !((buf32[229] >> 1) & 1);
> > +
> > +       dev_dbg(&mgr->dev, "header word %d = %08x compress=%d\n",
> > +               229, buf32[229], compress);
> > +
> > +       return compress;
> > +}
> Same here, a comment on 229/230 would work too I guess.
> 
> > +/* Start the FPGA programming by initialize the FPGA Manager */
> > +static int socfpga_a10_fpga_write_init(struct fpga_manager *mgr,
> > +                                      struct fpga_image_info *info,
> > +                                      const char *buf, size_t count)
> > +{
> > +       struct a10_fpga_priv *priv = mgr->priv;
> > +       unsigned int cfg_width;
> > +       u32 msel, stat, mask;
> > +       int ret;
> > +
> > +       if (info->flags & FPGA_MGR_PARTIAL_RECONFIG)
> > +               cfg_width = CFGWDTH_16;
> > +       else
> > +               return -EINVAL;
> 
> So we can *only* do partial reconfig? Am I missing something here?

Correct, only PR for now.

> 
> > +       /* Do some dclks, wait for pr_ready */
> > +       socfpga_a10_fpga_generate_dclks(priv, 0x7ff);
> 
> Maybe a named constant?

OK.  Thanks for the review!

Alan

> 
> Cheers,
> Moritz
> 
