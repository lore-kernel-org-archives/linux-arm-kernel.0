From: leo.yan@linaro.org (Leo Yan)
Date: Tue, 11 Apr 2017 21:46:45 +0800
Subject: [PATCH RFC 2/4] coresight: tmc: set read pointer before dump RAM
In-Reply-To: <CAAfSe-vtq6TYaemE5R9H-80uVQ+4eVkKQp3Jom+RvXjFG2r-vQ@mail.gmail.com>
References: <1491901829-18477-1-git-send-email-leo.yan@linaro.org>
 <1491901829-18477-3-git-send-email-leo.yan@linaro.org>
 <CAAfSe-vtq6TYaemE5R9H-80uVQ+4eVkKQp3Jom+RvXjFG2r-vQ@mail.gmail.com>
Message-ID: <20170411134645.GB8996@leoy-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 11, 2017 at 07:25:30PM +0800, Chunyan Zhang wrote:
> On 11 April 2017 at 17:10, Leo Yan <leo.yan@linaro.org> wrote:
> > When dump RAM, we need set read pointer so can make sure every time read
> > the consistent content. If the RAM is full by checking status register
> > (STS), so set the read pointer to same value with write pointer,
> > otherwise set read point to 0 so can read from the start of RAM.
> >
> > Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> > Cc: Mike Leach <mike.leach@linaro.org>
> > Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  drivers/hwtracing/coresight/coresight-tmc-etf.c | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> >
> > diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> > index 6150dac..43cfeaa 100644
> > --- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
> > +++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> > @@ -43,10 +43,28 @@ static void tmc_etb_enable_hw(struct tmc_drvdata *drvdata)
> >
> >  static void tmc_etb_dump_hw(struct tmc_drvdata *drvdata)
> >  {
> > +       u32 write_ptr, status;
> >         char *bufp;
> >         u32 read_data;
> >         int i;
> >
> > +       write_ptr = readl_relaxed(drvdata->base + TMC_RWP);
> 
> Since 'write_ptr' is only used in the below 'if' branch, I would
> suggest to move this statement into that.

Thanks, Chunyan. Agree, will fix.

> > +
> > +       /*
> > +        * Get a hold of the status register and see if a wrap around
> > +        * has occurred.  If so adjust things accordingly.
> > +        */
> > +       status = readl_relaxed(drvdata->base + TMC_STS);
> > +       if (status & TMC_STS_FULL)
> > +               /* Tell the HW the reading start point */
> > +               writel_relaxed(write_ptr, drvdata->base + TMC_RRP);
> > +       else
> > +               /*
> > +                * In case this is not first time to read ETB RAM,
> > +                * always write 0 for reading pointer.
> > +                */
> > +               writel_relaxed(0x0, drvdata->base + TMC_RRP);
> > +
> >         bufp = drvdata->buf;
> >         drvdata->len = 0;
> >         while (1) {
> > --
> > 2.7.4
> >
