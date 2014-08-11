From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon, 11 Aug 2014 10:28:43 -0600
Subject: [PATCH 07/10 v3] coresight-etm: add CoreSight ETM/PTM driver
In-Reply-To: <DEE44AFE682197449410588EB783A5146887DDED0F@BUNGLE.Emea.Arm.com>
References: <1407435706-19441-1-git-send-email-mathieu.poirier@linaro.org>
 <1407435706-19441-8-git-send-email-mathieu.poirier@linaro.org>
 <DEE44AFE682197449410588EB783A5146887DDED0F@BUNGLE.Emea.Arm.com>
Message-ID: <CANLsYkxmCg2fZaORYzCHiBx4ugtP+67TJfPmiB7WiqG_s760Mg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 August 2014 10:58, Al Grant <Al.Grant@arm.com> wrote:
> Hi,
>
> Comments inline...
>
>
>> -----Original Message-----
>> From: mathieu.poirier at linaro.org [mailto:mathieu.poirier at linaro.org]

SNIP...

>> ETMCNTVRn(i));
>> +     }
>> +     etm_writel(drvdata, drvdata->seq_12_event, ETMSQ12EVR);
>> +     etm_writel(drvdata, drvdata->seq_21_event, ETMSQ21EVR);
>> +     etm_writel(drvdata, drvdata->seq_23_event, ETMSQ23EVR);
>> +     etm_writel(drvdata, drvdata->seq_31_event, ETMSQ31EVR);
>> +     etm_writel(drvdata, drvdata->seq_32_event, ETMSQ32EVR);
>> +     etm_writel(drvdata, drvdata->seq_13_event, ETMSQ13EVR);
>> +     etm_writel(drvdata, drvdata->seq_curr_state, ETMSQR);
>> +     for (i = 0; i < drvdata->nr_ext_out; i++)
>> +             etm_writel(drvdata, ETM_DEFAULT_EVENT_VAL,
>> ETMEXTOUTEVRn(i));
>> +     for (i = 0; i < drvdata->nr_ctxid_cmp; i++)
>> +             etm_writel(drvdata, drvdata->ctxid_val[i],
>> ETMCIDCVRn(i));
>> +     etm_writel(drvdata, drvdata->ctxid_mask, ETMCIDCMR);
>> +     etm_writel(drvdata, drvdata->sync_freq, ETMSYNCFR);
>> +     /* no external input selected */
>> +     etm_writel(drvdata, 0x0, ETMEXTINSELR);
>> +     etm_writel(drvdata, drvdata->timestamp_event, ETMTSEVR);
>> +     /* no auxiliary control selected */
>> +     etm_writel(drvdata, 0x0, ETMAUXCR);
>> +     etm_writel(drvdata, drvdata->cpu + 1, ETMTRACEIDR);
>
> This seems slightly hardwired.  When you have additional non-CPU trace
> sources like STM (perhaps several STM) there will need to be a scheme
> for allocating the trace ids uniquely across the sources.  Numbering
> the ETMs statically from 1 upwards and the non-CPU sources dynamically
> from say 0x70 downwards is fine, but something ought to check they
> don't collide.

I think you are right - source IDs should be configurable from
userspace.  On the flip side I don't think the kernel should enforce
having unique IDs among sources - what if someone want to have source
of the same type have the same ID?  I think we can display a warning
message when the ID of a source that is about become active matches an
already active one but nothing more.  Get back to me if you feel
differently about that.

>
> Also, if the intention is the user can find the configuration of a
> component from the drvdata without a device read, this needs to be true
> of TRACEID too.

Sorry, I don't quite get your comment.  Could you please be more
specific of provide an example?  That way I can be sure that your
comment is addressed.

>
>
>> +     /* no VMID comparator value selected */
>> +     etm_writel(drvdata, 0x0, ETMVMIDCVR);
>> +
>> +     /* ensures trace output is enabled from this ETM */
>> +     etm_writel(drvdata, drvdata->ctrl | ETMCR_ETM_EN | etmcr,
>> ETMCR);
>> +
>> +     etm_clr_prog(drvdata);
>> +     CS_LOCK(drvdata->base);
>> +
>> +     dev_dbg(drvdata->dev, "cpu: %d enable smp call done\n",
>> drvdata->cpu);
>> +}
>> +
>> +static int etm_enable(struct coresight_device *csdev)
>> +{
>> +     struct etm_drvdata *drvdata = dev_get_drvdata(csdev-
>> >dev.parent);
>> +     int ret;
>> +
>> +     ret = clk_prepare_enable(drvdata->clk);
>> +     if (ret)
>> +             goto err_clk;
>> +
>> +     spin_lock(&drvdata->spinlock);
>> +
>> +     /*
>> +      * Executing etm_enable_hw on the cpu whose ETM is being
>> enabled
>> +      * ensures that register writes occur when cpu is powered.
>> +      */
>
> Does that mean ETM can't be enabled over cpu power-down?
> In the case where an ETM is powered up and the cpu is not,
> you might want to program and enable the ETM, to trace the
> cpu's power-up sequence.

This a valid usecase that I had not considered - ok, I'll look into that.

>
> Or, if the ETM is powered down but can be powered up independently
> of the CPU, etm_enable could do so.

Once again, I'm not sure that I fully grasp your train of thoughts -
please rephrase or be more specific.

>
>
>> +     ret = smp_call_function_single(drvdata->cpu, etm_enable_hw,
>> drvdata, 1);
>> +     if (ret)
>> +             goto err;
>> +     drvdata->enable = true;
>> +     drvdata->sticky_enable = true;
>> +
>> +     spin_unlock(&drvdata->spinlock);
>> +
>> +     dev_info(drvdata->dev, "ETM tracing enabled\n");
>> +     return 0;
>> +err:
>> +     spin_unlock(&drvdata->spinlock);
>> +     clk_disable_unprepare(drvdata->clk);
>> +err_clk:
>> +     return ret;
>> +}
>> +

SNIP...

>> +static ssize_t debugfs_mode_set(void *data, u64 val)
>> +{
>> +     struct etm_drvdata *drvdata = data;
>> +
>> +     spin_lock(&drvdata->spinlock);
>> +     drvdata->mode = val & ETM_MODE_ALL;
>> +
>> +     if (drvdata->mode & ETM_MODE_EXCLUDE)
>> +             drvdata->enable_ctrl1 |= ETMTECR1_INC_EXC;
>> +     else
>> +             drvdata->enable_ctrl1 &= ~ETMTECR1_INC_EXC;
>> +
>> +     if (drvdata->mode & ETM_MODE_CYCACC)
>> +             drvdata->ctrl |= ETMCR_CYC_ACC;
>> +     else
>> +             drvdata->ctrl &= ~ETMCR_CYC_ACC;
>> +
>> +     if (drvdata->mode & ETM_MODE_STALL)
>> +             drvdata->ctrl |= ETMCR_STALL_MODE;
>> +     else
>> +             drvdata->ctrl &= ~ETMCR_STALL_MODE;
>
> It could return EINVAL if the ETM doesn't support stall mode, as
> indicated by ETMCCR bit 23.  A readback of the data should report that
> stall mode hasn't successfully been set.

You got it.

>
>
>> +
>> +     if (drvdata->mode & ETM_MODE_TIMESTAMP)
>> +             drvdata->ctrl |= ETMCR_TIMESTAMP_EN;
>> +     else
>> +             drvdata->ctrl &= ~ETMCR_TIMESTAMP_EN;
>> +
>> +     if (drvdata->mode & ETM_MODE_CTXID)
>> +             drvdata->ctrl |= ETMCR_CTXID_SIZE;
>> +     else
>> +             drvdata->ctrl &= ~ETMCR_CTXID_SIZE;
>> +     spin_unlock(&drvdata->spinlock);
>> +
>> +     return 0;
>> +}

SNIP...

>> +static ssize_t debugfs_seq_curr_state_get(void *data, u64 *val)
>> +{
>> +     struct etm_drvdata *drvdata = data;
>> +
>> +     *val = drvdata->seq_curr_state;
>> +     return 0;
>> +}
>
> So does this actually read the current sequencer state or just what you
> last programmed it to?

You're touching on something I've been thinking about for a while...
Since configuration is pushed to the HW when a source is "enabled",
there is a window where what the SW report is different from how the
HW is configured.  One can't really live without the other - when
configuring the system it is always good to have the "current" value
held by a register.  I'll have to think about how to represent ongoing
configuration (SW) and what the HW really reports.

> It would be good to have a way of directly reading
> and changing the sequencer state via debugfs, since that could enable
> some quite interesting kinds of trace control.  The same applies to the
> counter values.

You mean while an ETM/PTM is configured and tracing?

>
>
>> +
>> +static ssize_t debugfs_seq_curr_state_set(void *data, u64 val)
>> +{
>> +     struct etm_drvdata *drvdata = data;
>> +
>> +     if (val > ETM_SEQ_STATE_MAX_VAL)
>> +             return -EINVAL;
>> +
>> +     drvdata->seq_curr_state = val;
>> +     return 0;
>> +}
>> +CORESIGHT_DEBUGFS_ENTRY(debugfs_seq_curr_state, "seq_curr_state",
>> +                     S_IRUGO | S_IWUSR, debugfs_seq_curr_state_get,
>> +                     debugfs_seq_curr_state_set, "%llx\n");
>> +
>> +static ssize_t debugfs_ctxid_idx_get(void *data, u64 *val)
>> +{
>> +     struct etm_drvdata *drvdata = data;
>> +
>> +     *val = drvdata->ctxid_idx;
>> +     return 0;
>> +}
>> +
>> +static ssize_t debugfs_ctxid_idx_set(void *data, u64 val)
>> +{
>> +     struct etm_drvdata *drvdata = data;
>> +
>> +     if (val >= drvdata->nr_ctxid_cmp)
>> +             return -EINVAL;
>> +
>> +     /*
>> +      * Use spinlock to ensure index doesn't change while it gets
>> +      * dereferenced multiple times within a spinlock block
>> elsewhere.
>> +      */
>> +     spin_lock(&drvdata->spinlock);
>> +     drvdata->ctxid_idx = val;
>> +     spin_unlock(&drvdata->spinlock);
>> +     return 0;
>> +}
>> +CORESIGHT_DEBUGFS_ENTRY(debugfs_ctxid_idx, "ctxid_idx",
>> +                     S_IRUGO | S_IWUSR, debugfs_ctxid_idx_get,
>> +                     debugfs_ctxid_idx_set, "%llx\n");
>> +
>> +static ssize_t debugfs_ctxid_val_get(void *data, u64 *val)
>> +{
>> +     struct etm_drvdata *drvdata = data;
>> +
>> +     spin_lock(&drvdata->spinlock);
>> +     *val = drvdata->ctxid_val[drvdata->ctxid_idx];
>> +     spin_unlock(&drvdata->spinlock);
>> +
>> +     return 0;
>> +}
>> +
>> +static ssize_t debugfs_ctxid_val_set(void *data, u64 val)
>> +{
>> +     struct etm_drvdata *drvdata = data;
>> +
>> +     spin_lock(&drvdata->spinlock);
>> +     drvdata->ctxid_val[drvdata->ctxid_idx] = val;
>> +     spin_unlock(&drvdata->spinlock);
>> +
>> +     return 0;
>> +}
>> +CORESIGHT_DEBUGFS_ENTRY(debugfs_ctxid_val, "ctxid_val",
>> +                     S_IRUGO | S_IWUSR, debugfs_ctxid_val_get,
>> +                     debugfs_ctxid_val_set, "%llx\n");
>> +
>> +static ssize_t debugfs_ctxid_mask_get(void *data, u64 *val)
>> +{
>> +     struct etm_drvdata *drvdata = data;
>> +
>> +     *val = drvdata->ctxid_mask;
>> +     return 0;
>> +}
>> +
>> +static ssize_t debugfs_ctxid_mask_set(void *data, u64 val)
>> +{
>> +     struct etm_drvdata *drvdata = data;
>> +
>> +     drvdata->ctxid_mask = val;
>> +     return 0;
>> +}
>> +CORESIGHT_DEBUGFS_ENTRY(debugfs_ctxid_mask, "ctxid_mask",
>> +                     S_IRUGO | S_IWUSR, debugfs_ctxid_mask_get,
>> +                     debugfs_ctxid_mask_set, "%llx\n");
>> +
>> +static ssize_t debugfs_sync_freq_get(void *data, u64 *val)
>> +{
>> +     struct etm_drvdata *drvdata = data;
>> +
>> +     *val = drvdata->sync_freq;
>> +     return 0;
>> +}
>> +
>> +static ssize_t debugfs_sync_freq_set(void *data, u64 val)
>> +{
>> +     struct etm_drvdata *drvdata = data;
>> +
>> +     drvdata->sync_freq = val & ETM_SYNC_MASK;
>> +     return 0;
>> +}
>> +CORESIGHT_DEBUGFS_ENTRY(debugfs_sync_freq, "sync_freq",
>> +                     S_IRUGO | S_IWUSR, debugfs_sync_freq_get,
>> +                     debugfs_sync_freq_set, "%llx\n");
>> +
>> +static ssize_t debugfs_timestamp_event_get(void *data, u64 *val)
>> +{
>> +     struct etm_drvdata *drvdata = data;
>> +
>> +     *val = drvdata->timestamp_event;
>> +     return 0;
>> +}
>> +
>> +static ssize_t debugfs_timestamp_event_set(void *data, u64 val)
>> +{
>> +     struct etm_drvdata *drvdata = data;
>> +
>> +     drvdata->timestamp_event = val & ETM_EVENT_MASK;
>> +     return 0;
>> +}
>> +CORESIGHT_DEBUGFS_ENTRY(debugfs_timestamp_event, "timestamp_event",
>> +                     S_IRUGO | S_IWUSR, debugfs_timestamp_event_get,
>> +                     debugfs_timestamp_event_set, "%llx\n");
>> +
>> +static ssize_t debugfs_status_get(struct seq_file *f, void *ptr)
>> +{
>> +     unsigned long flags;
>> +     struct etm_drvdata *drvdata = f->private;
>> +
>> +     if (clk_prepare_enable(drvdata->clk))
>> +             goto out;
>> +
>> +     spin_lock_irqsave(&drvdata->spinlock, flags);
>> +
>> +     CS_UNLOCK(drvdata->base);
>> +     seq_printf(f,
>> +                "ETMCCR: 0x%08x\n"
>> +                "ETMCCER: 0x%08x\n"
>> +                "ETMSCR: 0x%08x\n"
>> +                "ETMIDR: 0x%08x\n"
>> +                "ETMCR: 0x%08x\n"
>> +                "ETMTRACEIDR: 0x%08x\n"
>> +                "Enable event: 0x%08x\n"
>> +                "Enable start/stop: 0x%08x\n"
>> +                "Enable control: CR1 0x%08x CR2 0x%08x\n",
>> +                etm_readl(drvdata, ETMCCR), etm_readl(drvdata,
>> ETMCCER),
>> +                etm_readl(drvdata, ETMSCR), etm_readl(drvdata,
>> ETMIDR),
>> +                etm_readl(drvdata, ETMCR), etm_readl(drvdata,
>> ETMTRACEIDR),
>> +                etm_readl(drvdata, ETMTEEVR), etm_readl(drvdata,
>> ETMTSSCR),
>> +                etm_readl(drvdata, ETMTECR1), etm_readl(drvdata,
>> ETMTECR2));
>> +     CS_LOCK(drvdata->base);
>> +
>> +     spin_unlock_irqrestore(&drvdata->spinlock, flags);
>> +     clk_disable_unprepare(drvdata->clk);
>> +out:
>> +     return 0;
>
> It would be good to show the dynamically changing status here too,
> e.g. counter values and sequencer state.

Sure thing.

>
>
>
>> +}
>> +static int debugfs_status_show_open(struct inode *inode, struct
>> file *file)
>> +{
>> +     return single_open(file, debugfs_status_get, inode-
>> >i_private);
>> +}
>> +
>
