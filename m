From: bengardiner@nanometrics.ca (Ben Gardiner)
Date: Thu, 1 Nov 2012 09:52:05 -0400
Subject: [PATCH v2 5/6] ARM: davinci: remoteproc board support for
 OMAP-L138 DSP
In-Reply-To: <1351197357-23528-5-git-send-email-rtivy@ti.com>
References: <1351197357-23528-1-git-send-email-rtivy@ti.com>
 <1351197357-23528-5-git-send-email-rtivy@ti.com>
Message-ID: <CAPcSpEKDAEp5rS8RRpcyHN9WUUtJNppUuKvnZ6YX-tgertJBNQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Thu, Oct 25, 2012 at 4:35 PM, Robert Tivy <rtivy@ti.com> wrote:
> [...]
> @@ -660,6 +667,99 @@ int __init da850_register_mmcsd1(struct davinci_mmc_config *config)
>  }
>  #endif
>
> +static struct platform_device *da8xx_dsp;
> +
> +#ifdef CONFIG_CMA
> +
> +/*
> + * The following address range was chosen because the XDC Platform for
> + * OMAP-L138 DSP has this range as its default code/data placement.
> + */
> +#define DA8XX_RPROC_CMA_BASE  (0xc3000000)
> [...]
> +/*
> + * The following address range was chosen because the XDC Platform for
> + * OMAP-L138 DSP has this range as its default code/data placement.
> + *
> + * System integrators must ensure that Linux does not own this range.
> + */
> +#define DA_CONTIG_BASE (0xc3000000)
> +#define DA_CONTIG_SIZE (0x02000000)

I am concerned with the rigidity of the memory hole as its definition
is currently proposed.

As you noted DA_CONTIG_BASE and DA_CONTIG_SIZE must describe a range
that is not used by Linux. Ideally this hole would not be in the
middle of the usuable memory but instead at the top. For L138 boards
with larger DDR packages this would mean carrying a patch to this
file.

I think the same also applies to DA8XX_RPROC_CMA_BASE but I have no
hands-on experience yet with CMA.

Is there any other means by which the hole's location and size can be
specified which does not require patching this file? I imagine KConfig
would work, but is this an acceptable use of KConfig?

Best Regards,
Ben Gardiner

---
Nanometrics Inc.
http://www.nanometrics.ca
