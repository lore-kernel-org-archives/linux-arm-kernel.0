From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon, 4 Apr 2016 10:52:32 -0600
Subject: coresight: tmc: allocating memory when needed
In-Reply-To: <20160402053209.GA15353@mwanda>
References: <20160402053209.GA15353@mwanda>
Message-ID: <CANLsYkyTvx+TnScayzn0_wbnW+T6kknP-_r__Fv_cPYByZDb1w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 April 2016 at 23:32, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> Hello Mathieu Poirier,
>
> The patch 06ec4671e5d1: "coresight: tmc: allocating memory when
> needed" from Dec 9, 2015, leads to the following static checker
> warning:
>
>         drivers/hwtracing/coresight/coresight-tmc-etf.c:125 tmc_enable_etf_sink_sysfs()
>         warn: passing devm_ allocated variable to kfree. 'buf'
>
> drivers/hwtracing/coresight/coresight-tmc-etf.c
>    109  static int tmc_enable_etf_sink_sysfs(struct coresight_device *csdev, u32 mode)
>    110  {
>    111          u32 val;
>    112          bool allocated = false;
>    113          char *buf = NULL;
>                       ^^^^^^^^^^
> This bogus initialization disables GCC's checks for uninitialized
> memory.  Don't disable static analysis for no reason.

Yes, this one doesn't do anything.

>
>    114          unsigned long flags;
>    115          struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>    116
>    117          /* Allocating the memory here while outside of the spinlock */
>    118          buf = devm_kzalloc(drvdata->dev, drvdata->size, GFP_KERNEL);
>    119          if (!buf)
>    120                  return -ENOMEM;
>    121
>    122          spin_lock_irqsave(&drvdata->spinlock, flags);
>    123          if (drvdata->reading) {
>    124                  spin_unlock_irqrestore(&drvdata->spinlock, flags);
>    125                  kfree(buf);
>                         ^^^^^^^^^^
> This is a double free because the buffer is allocated with
> devm_kzalloc().  There are lots more double frees.  We double free in
> tmc_read_unprepare_etf() as well.  It's hard to find all the bugs
> without knowing the code more than I do.  Please review and test
> unloading.

This is obviously the wrong kind of memory allocator and the same will
be true on the ETF side since they were tailored to be as similar as
possible.  I'll revise this.

Thanks,
Mathieu

>
>    126                  return -EBUSY;
>    127          }
>    128
>
> regards,
> dan carpenter
