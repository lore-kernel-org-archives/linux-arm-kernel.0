From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Fri, 9 Nov 2018 10:59:25 -0700
Subject: [PATCH v2 3/4] coresight: etm3x: Deal with CLAIM tag before and
 after accessing HW
In-Reply-To: <102c6181-189e-0ce4-02be-15c1a2744334@arm.com>
References: <1541632132-1252-1-git-send-email-mathieu.poirier@linaro.org>
 <1541632132-1252-4-git-send-email-mathieu.poirier@linaro.org>
 <102c6181-189e-0ce4-02be-15c1a2744334@arm.com>
Message-ID: <CANLsYkxbzk3=uA0Tx6HNNoXGBnDUPAhgnWZM9Q7jqLSzBhDr-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 8 Nov 2018 at 10:13, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> Hi,
>
> On 07/11/2018 23:08, Mathieu Poirier wrote:
> > This patch moves access to the CLAIM tag so that no modification to the HW
> > happens before and after the CLAIM operation has been carried.
> >
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > ---
> >   drivers/hwtracing/coresight/coresight-etm3x.c | 16 ++++++++--------
> >   1 file changed, 8 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
> > index fd5c4cca7db5..4f638d81a66a 100644
> > --- a/drivers/hwtracing/coresight/coresight-etm3x.c
> > +++ b/drivers/hwtracing/coresight/coresight-etm3x.c
> > @@ -363,15 +363,16 @@ static int etm_enable_hw(struct etm_drvdata *drvdata)
> >
> >       CS_UNLOCK(drvdata->base);
> >
> > +     rc = coresight_claim_device_unlocked(drvdata->base);
> > +     if (rc)
> > +             goto done;
> > +
> >       /* Turn engine on */
> >       etm_clr_pwrdwn(drvdata);
> >       /* Apply power to trace registers */
> >       etm_set_pwrup(drvdata);
> >       /* Make sure all registers are accessible */
> >       etm_os_unlock(drvdata);
> > -     rc = coresight_claim_device_unlocked(drvdata->base);
> > -     if (rc)
> > -             goto done;
> >
> >       etm_set_prog(drvdata);
> >
> > @@ -422,12 +423,11 @@ static int etm_enable_hw(struct etm_drvdata *drvdata)
> >       etm_clr_prog(drvdata);
> >
> >   done:
> > -     if (rc)
> > -             etm_set_pwrdwn(drvdata);
> >       CS_LOCK(drvdata->base);
> >
> > -     dev_dbg(drvdata->dev, "cpu: %d enable smp call done: %d\n",
> > -             drvdata->cpu, rc);
> > +     if (!rc)
> > +             dev_dbg(drvdata->dev, "cpu: %d enable smp call done: %d\n",
> > +                     drvdata->cpu, rc);
>
> Isn't it good to report the failure case too ? Anyway it is dev_dbg and
> will be a useful info when we debug issues. Otherwise,

Simply removing the "if (!rc)" will do the trick.  Can I do the
modification and add your tag or you prefer to see another revision?

>
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>
> >       return rc;
> >   }
> >
> > @@ -577,9 +577,9 @@ static void etm_disable_hw(void *info)
> >       for (i = 0; i < drvdata->nr_cntr; i++)
> >               config->cntr_val[i] = etm_readl(drvdata, ETMCNTVRn(i));
> >
> > +     etm_set_pwrdwn(drvdata);
> >       coresight_disclaim_device_unlocked(drvdata->base);
> >
> > -     etm_set_pwrdwn(drvdata);
> >       CS_LOCK(drvdata->base);
> >
> >       dev_dbg(drvdata->dev, "cpu: %d disable smp call done\n", drvdata->cpu);
> >
>
