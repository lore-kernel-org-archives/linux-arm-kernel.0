From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Fri, 16 Sep 2016 11:07:32 -0600
Subject: [PATCH] coresight: tmc: Cleanup operation mode handling
In-Reply-To: <1473861230-5666-1-git-send-email-suzuki.poulose@arm.com>
References: <1473861230-5666-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <CANLsYkxWSQFgBYHi6dosjut78uohCtX8Wv3Kw=eHk0L_7jmFVw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 September 2016 at 07:53, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
> The mode of operation of the TMC tracked in drvdata->mode is defined
> as a local_t type. This is always checked and modified under the
> drvdata->spinlock and hence we don't need local_t for it and the
> unnecessary synchronisation instructions that comes with it. This
> change makes the code a bit more cleaner.
>
> Also fixes the order in which we update the drvdata->mode to
> CS_MODE_DISABLED. i.e, in tmc_disable_etX_sink we change the
> mode to CS_MODE_DISABLED before invoking tmc_disable_etX_hw()
> which in turn depends on the mode to decide whether to dump the
> trace to a buffer.

Thank you for the patch - just a few comments below.

Regards,
Mathieu

>
> Applies on mathieu's coresight/next tree [1]
>
> https://git.linaro.org/kernel/coresight.git next
>
> Reported-by: Venkatesh Vivekanandan <venkatesh.vivekanandan@broadcom.com>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-tmc-etf.c | 32 +++++++++++--------------
>  drivers/hwtracing/coresight/coresight-tmc-etr.c | 30 ++++++++++-------------
>  drivers/hwtracing/coresight/coresight-tmc.h     |  2 +-
>  3 files changed, 28 insertions(+), 36 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> index d6941ea..c51ce45 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> @@ -70,7 +70,7 @@ static void tmc_etb_disable_hw(struct tmc_drvdata *drvdata)
>          * When operating in sysFS mode the content of the buffer needs to be
>          * read before the TMC is disabled.
>          */
> -       if (local_read(&drvdata->mode) == CS_MODE_SYSFS)
> +       if (drvdata->mode == CS_MODE_SYSFS)
>                 tmc_etb_dump_hw(drvdata);
>         tmc_disable_hw(drvdata);
>
> @@ -108,7 +108,6 @@ static int tmc_enable_etf_sink_sysfs(struct coresight_device *csdev, u32 mode)
>         int ret = 0;
>         bool used = false;
>         char *buf = NULL;
> -       long val;
>         unsigned long flags;
>         struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>
> @@ -138,13 +137,12 @@ static int tmc_enable_etf_sink_sysfs(struct coresight_device *csdev, u32 mode)
>                 goto out;
>         }
>
> -       val = local_xchg(&drvdata->mode, mode);
>         /*
>          * In sysFS mode we can have multiple writers per sink.  Since this
>          * sink is already enabled no memory is needed and the HW need not be
>          * touched.
>          */
> -       if (val == CS_MODE_SYSFS)
> +       if (drvdata->mode == CS_MODE_SYSFS)
>                 goto out;
>
>         /*
> @@ -163,6 +161,7 @@ static int tmc_enable_etf_sink_sysfs(struct coresight_device *csdev, u32 mode)
>                 drvdata->buf = buf;
>         }
>
> +       drvdata->mode = CS_MODE_SYSFS;
>         tmc_etb_enable_hw(drvdata);
>  out:
>         spin_unlock_irqrestore(&drvdata->spinlock, flags);
> @@ -180,7 +179,6 @@ out:
>  static int tmc_enable_etf_sink_perf(struct coresight_device *csdev, u32 mode)
>  {
>         int ret = 0;
> -       long val;
>         unsigned long flags;
>         struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>
> @@ -194,17 +192,17 @@ static int tmc_enable_etf_sink_perf(struct coresight_device *csdev, u32 mode)
>                 goto out;
>         }
>
> -       val = local_xchg(&drvdata->mode, mode);
>         /*
>          * In Perf mode there can be only one writer per sink.  There
>          * is also no need to continue if the ETB/ETR is already operated
>          * from sysFS.
>          */
> -       if (val != CS_MODE_DISABLED) {
> +       if (drvdata->mode != CS_MODE_DISABLED) {
>                 ret = -EINVAL;
>                 goto out;
>         }
>
> +       drvdata->mode = mode;

Given the way tmc_enable_etf_sink_perf() is called in
tmc_enable_etf_sink(), I think it is time to get rid of the 'mode'
parameter - it doesn't do anything nowadays.  Same thing for
tmc_enable_etf_sink_sysfs() and ETR.

>         tmc_etb_enable_hw(drvdata);
>  out:
>         spin_unlock_irqrestore(&drvdata->spinlock, flags);
> @@ -227,7 +225,6 @@ static int tmc_enable_etf_sink(struct coresight_device *csdev, u32 mode)
>
>  static void tmc_disable_etf_sink(struct coresight_device *csdev)
>  {
> -       long val;
>         unsigned long flags;
>         struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>
> @@ -237,10 +234,11 @@ static void tmc_disable_etf_sink(struct coresight_device *csdev)
>                 return;
>         }
>
> -       val = local_xchg(&drvdata->mode, CS_MODE_DISABLED);
>         /* Disable the TMC only if it needs to */
> -       if (val != CS_MODE_DISABLED)
> +       if (drvdata->mode != CS_MODE_DISABLED) {
>                 tmc_etb_disable_hw(drvdata);
> +               drvdata->mode = CS_MODE_DISABLED;
> +       }
>
>         spin_unlock_irqrestore(&drvdata->spinlock, flags);
>
> @@ -260,7 +258,7 @@ static int tmc_enable_etf_link(struct coresight_device *csdev,
>         }
>
>         tmc_etf_enable_hw(drvdata);
> -       local_set(&drvdata->mode, CS_MODE_SYSFS);
> +       drvdata->mode = CS_MODE_SYSFS;
>         spin_unlock_irqrestore(&drvdata->spinlock, flags);
>
>         dev_info(drvdata->dev, "TMC-ETF enabled\n");
> @@ -279,8 +277,8 @@ static void tmc_disable_etf_link(struct coresight_device *csdev,
>                 return;
>         }
>
> +       drvdata->mode = CS_MODE_DISABLED;
>         tmc_etf_disable_hw(drvdata);
> -       local_set(&drvdata->mode, CS_MODE_DISABLED);

I think setting the mode should come after tmc_etf_disable_hw(), as it
was before.


>         spin_unlock_irqrestore(&drvdata->spinlock, flags);
>
>         dev_info(drvdata->dev, "TMC disabled\n");
> @@ -383,7 +381,7 @@ static void tmc_update_etf_buffer(struct coresight_device *csdev,
>                 return;
>
>         /* This shouldn't happen */
> -       if (WARN_ON_ONCE(local_read(&drvdata->mode) != CS_MODE_PERF))
> +       if (WARN_ON_ONCE(drvdata->mode != CS_MODE_PERF))
>                 return;
>
>         CS_UNLOCK(drvdata->base);
> @@ -504,7 +502,6 @@ const struct coresight_ops tmc_etf_cs_ops = {
>
>  int tmc_read_prepare_etb(struct tmc_drvdata *drvdata)
>  {
> -       long val;
>         enum tmc_mode mode;
>         int ret = 0;
>         unsigned long flags;
> @@ -528,9 +525,8 @@ int tmc_read_prepare_etb(struct tmc_drvdata *drvdata)
>                 goto out;
>         }
>
> -       val = local_read(&drvdata->mode);
>         /* Don't interfere if operated from Perf */
> -       if (val == CS_MODE_PERF) {
> +       if (drvdata->mode == CS_MODE_PERF) {
>                 ret = -EINVAL;
>                 goto out;
>         }
> @@ -542,7 +538,7 @@ int tmc_read_prepare_etb(struct tmc_drvdata *drvdata)
>         }
>
>         /* Disable the TMC if need be */
> -       if (val == CS_MODE_SYSFS)
> +       if (drvdata->mode == CS_MODE_SYSFS)
>                 tmc_etb_disable_hw(drvdata);
>
>         drvdata->reading = true;
> @@ -573,7 +569,7 @@ int tmc_read_unprepare_etb(struct tmc_drvdata *drvdata)
>         }
>
>         /* Re-enable the TMC if need be */
> -       if (local_read(&drvdata->mode) == CS_MODE_SYSFS) {
> +       if (drvdata->mode == CS_MODE_SYSFS) {
>                 /*
>                  * The trace run will continue with the same allocated trace
>                  * buffer. As such zero-out the buffer so that we don't end
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> index 886ea83..cf2bf60 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> @@ -86,7 +86,7 @@ static void tmc_etr_disable_hw(struct tmc_drvdata *drvdata)
>          * When operating in sysFS mode the content of the buffer needs to be
>          * read before the TMC is disabled.
>          */
> -       if (local_read(&drvdata->mode) == CS_MODE_SYSFS)
> +       if (drvdata->mode == CS_MODE_SYSFS)
>                 tmc_etr_dump_hw(drvdata);
>         tmc_disable_hw(drvdata);
>
> @@ -97,7 +97,6 @@ static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev, u32 mode)
>  {
>         int ret = 0;
>         bool used = false;
> -       long val;
>         unsigned long flags;
>         void __iomem *vaddr = NULL;
>         dma_addr_t paddr;
> @@ -134,13 +133,12 @@ static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev, u32 mode)
>                 goto out;
>         }
>
> -       val = local_xchg(&drvdata->mode, mode);
>         /*
>          * In sysFS mode we can have multiple writers per sink.  Since this
>          * sink is already enabled no memory is needed and the HW need not be
>          * touched.
>          */
> -       if (val == CS_MODE_SYSFS)
> +       if (drvdata->mode == CS_MODE_SYSFS)
>                 goto out;
>
>         /*
> @@ -157,6 +155,7 @@ static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev, u32 mode)
>
>         memset(drvdata->vaddr, 0, drvdata->size);
>
> +       drvdata->mode = CS_MODE_SYSFS;
>         tmc_etr_enable_hw(drvdata);
>  out:
>         spin_unlock_irqrestore(&drvdata->spinlock, flags);
> @@ -174,7 +173,6 @@ out:
>  static int tmc_enable_etr_sink_perf(struct coresight_device *csdev, u32 mode)
>  {
>         int ret = 0;
> -       long val;
>         unsigned long flags;
>         struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>
> @@ -188,18 +186,18 @@ static int tmc_enable_etr_sink_perf(struct coresight_device *csdev, u32 mode)
>                 goto out;
>         }
>
> -       val = local_xchg(&drvdata->mode, mode);
>         /*
>          * In Perf mode there can be only one writer per sink.  There
>          * is also no need to continue if the ETR is already operated
>          * from sysFS.
>          */
> -       if (val != CS_MODE_DISABLED) {
> +       if (drvdata->mode == CS_MODE_DISABLED) {
> +               drvdata->mode = CS_MODE_PERF;
> +               tmc_etr_enable_hw(drvdata);
> +       } else {
>                 ret = -EINVAL;
> -               goto out;
>         }
>
> -       tmc_etr_enable_hw(drvdata);

Is there a reason for not proceeding the same way as in
tmc_enable_etr_sink_perf()?  I thought that was a better approach.

>  out:
>         spin_unlock_irqrestore(&drvdata->spinlock, flags);
>
> @@ -221,7 +219,6 @@ static int tmc_enable_etr_sink(struct coresight_device *csdev, u32 mode)
>
>  static void tmc_disable_etr_sink(struct coresight_device *csdev)
>  {
> -       long val;
>         unsigned long flags;
>         struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>
> @@ -231,10 +228,11 @@ static void tmc_disable_etr_sink(struct coresight_device *csdev)
>                 return;
>         }
>
> -       val = local_xchg(&drvdata->mode, CS_MODE_DISABLED);
>         /* Disable the TMC only if it needs to */
> -       if (val != CS_MODE_DISABLED)
> +       if (drvdata->mode != CS_MODE_DISABLED) {
>                 tmc_etr_disable_hw(drvdata);
> +               drvdata->mode = CS_MODE_DISABLED;
> +       }
>
>         spin_unlock_irqrestore(&drvdata->spinlock, flags);
>
> @@ -253,7 +251,6 @@ const struct coresight_ops tmc_etr_cs_ops = {
>  int tmc_read_prepare_etr(struct tmc_drvdata *drvdata)
>  {
>         int ret = 0;
> -       long val;
>         unsigned long flags;
>
>         /* config types are set a boot time and never change */
> @@ -266,9 +263,8 @@ int tmc_read_prepare_etr(struct tmc_drvdata *drvdata)
>                 goto out;
>         }
>
> -       val = local_read(&drvdata->mode);
>         /* Don't interfere if operated from Perf */
> -       if (val == CS_MODE_PERF) {
> +       if (drvdata->mode == CS_MODE_PERF) {
>                 ret = -EINVAL;
>                 goto out;
>         }
> @@ -280,7 +276,7 @@ int tmc_read_prepare_etr(struct tmc_drvdata *drvdata)
>         }
>
>         /* Disable the TMC if need be */
> -       if (val == CS_MODE_SYSFS)
> +       if (drvdata->mode == CS_MODE_SYSFS)
>                 tmc_etr_disable_hw(drvdata);
>
>         drvdata->reading = true;
> @@ -303,7 +299,7 @@ int tmc_read_unprepare_etr(struct tmc_drvdata *drvdata)
>         spin_lock_irqsave(&drvdata->spinlock, flags);
>
>         /* RE-enable the TMC if need be */
> -       if (local_read(&drvdata->mode) == CS_MODE_SYSFS) {
> +       if (drvdata->mode == CS_MODE_SYSFS) {
>                 /*
>                  * The trace run will continue with the same allocated trace
>                  * buffer. The trace buffer is cleared in tmc_etr_enable_hw(),
> diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
> index 44b3ae3..51c0185 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc.h
> +++ b/drivers/hwtracing/coresight/coresight-tmc.h
> @@ -117,7 +117,7 @@ struct tmc_drvdata {
>         void __iomem            *vaddr;
>         u32                     size;
>         u32                     len;
> -       local_t                 mode;
> +       u32                     mode;
>         enum tmc_config_type    config_type;
>         enum tmc_mem_intf_width memwidth;
>         u32                     trigger_cntr;
> --
> 2.7.4
>
