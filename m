From: B04825@freescale.com (Tabi Timur-B04825)
Date: Fri, 9 Mar 2012 02:09:57 +0000
Subject: [PATCH v3 08/11] ASoC: fsl: make fsl_ssi driver compilable on
 ARM/IMX
In-Reply-To: <20120309012653.GG2499@S2101-09.ap.freescale.net>
References: <1331225990-27308-1-git-send-email-shawn.guo@linaro.org>
 <1331225990-27308-9-git-send-email-shawn.guo@linaro.org>
 <4F5912D0.2090800@freescale.com>
 <20120309012653.GG2499@S2101-09.ap.freescale.net>
Message-ID: <4F596674.5030405@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn Guo wrote:

> Something like this:
>
> @@ -496,6 +494,10 @@ static int fsl_ssi_trigger(struct snd_pcm_substream *substream, int cmd,
>          struct snd_soc_pcm_runtime *rtd = substream->private_data;
>          struct fsl_ssi_private *ssi_private = snd_soc_dai_get_drvdata(rtd->cpu_dai);
>          struct ccsr_ssi __iomem *ssi = ssi_private->ssi;
> +       unsigned long flags;
> +       int ret = 0;
> +
> +       spin_lock_irqsave(&ssi_lock, flags);
>
>          switch (cmd) {
>          case SNDRV_PCM_TRIGGER_START:
> @@ -517,10 +519,12 @@ static int fsl_ssi_trigger(struct snd_pcm_substream *substream, int cmd,
>                  break;
>
>          default:
> -               return -EINVAL;
> +               ret = -EINVAL;
>          }
>
> -       return 0;
> +       spin_unlock_irqrestore(&ssi_lock, flags);
> +
> +       return ret;
>   }

That's the general idea, but I think it needs more study.  I don't 
consider this to be a bug that needs to be fixed ASAP, since it's never 
been an actual problem so far.  For instance, do we need to protect 
between hw_params and _trigger?

-- 
Timur Tabi
Linux kernel developer at Freescale
