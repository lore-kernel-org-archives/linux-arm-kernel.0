From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 9 Mar 2012 09:26:55 +0800
Subject: [PATCH v3 08/11] ASoC: fsl: make fsl_ssi driver compilable on
 ARM/IMX
In-Reply-To: <4F5912D0.2090800@freescale.com>
References: <1331225990-27308-1-git-send-email-shawn.guo@linaro.org>
 <1331225990-27308-9-git-send-email-shawn.guo@linaro.org>
 <4F5912D0.2090800@freescale.com>
Message-ID: <20120309012653.GG2499@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 08, 2012 at 02:13:04PM -0600, Timur Tabi wrote:
> Shawn Guo wrote:
> > +static DEFINE_SPINLOCK(ssi_reg_lock);
> > +static inline void write_ssi_mask(u32 __iomem *addr, u32 clear, u32 set)
> > +{
> > +	u32 val;
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&ssi_reg_lock, flags);
> > +	val = readl(addr);
> > +	val = (val & ~clear) | set;
> > +	writel(val, addr);
> > +	spin_unlock_irqrestore(&ssi_reg_lock, flags);
> > +}
> > +#endif
> 
> I think this spinlock is the wrong approach.  The problem with
> read-modify-write is on the function level, not the register level.
> 
Something like this:

@@ -496,6 +494,10 @@ static int fsl_ssi_trigger(struct snd_pcm_substream *substream, int cmd,
        struct snd_soc_pcm_runtime *rtd = substream->private_data;
        struct fsl_ssi_private *ssi_private = snd_soc_dai_get_drvdata(rtd->cpu_dai);
        struct ccsr_ssi __iomem *ssi = ssi_private->ssi;
+       unsigned long flags;
+       int ret = 0;
+
+       spin_lock_irqsave(&ssi_lock, flags);

        switch (cmd) {
        case SNDRV_PCM_TRIGGER_START:
@@ -517,10 +519,12 @@ static int fsl_ssi_trigger(struct snd_pcm_substream *substream, int cmd,
                break;

        default:
-               return -EINVAL;
+               ret = -EINVAL;
        }

-       return 0;
+       spin_unlock_irqrestore(&ssi_lock, flags);
+
+       return ret;
 }

-- 
Regards,
Shawn
