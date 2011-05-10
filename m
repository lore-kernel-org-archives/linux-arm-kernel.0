From: toddpoynor@google.com (Todd Poynor)
Date: Tue, 10 May 2011 09:04:04 -0700
Subject: [PATCH 1/2 v3] OMAP2+: hwmod: Add API to enable IO ring wakeup.
In-Reply-To: <1305023405-9561-2-git-send-email-govindraj.raja@ti.com>
References: <1305023405-9561-1-git-send-email-govindraj.raja@ti.com>
	<1305023405-9561-2-git-send-email-govindraj.raja@ti.com>
Message-ID: <BANLkTikVKV6DcuQ7nVHm=L_+hqeYjcyv0g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 10, 2011 at 3:30 AM, Govindraj.R <govindraj.raja@ti.com> wrote:
...
>
> +/**
> + * omap_device_enable_ioring_wakeup - Set wakeup bit for iopad ring.
> + * @pdev: platform_device for which wakeup needs to be set.
> + *
> + * Caller should ensure this is called if device_may_wakeup(dev) is true
> + * traverse through each hwmod and check each available pads
> + * if pad is enabled then set wakeup enable flag for the mux pin.
> + * Return error if pads are not enabled or not available.
> + * Wakeup enable flag will be we used during hwmod idle transistion.
> + */
> +int omap_device_enable_ioring_wakeup(struct platform_device *pdev)
> +{
> +       int ret = -EINVAL, i;
> +       struct omap_device *od;
> +       struct omap_hwmod *oh;
> +
> +       od = _find_by_pdev(pdev);
> +       for (i = 0; i < od->hwmods_cnt; i++) {
> +               oh = od->hwmods[i];
> +               ret = omap_hwmod_enable_ioring_wakeup(oh);
> +       }
> +
> +       return ret;
>

Error returns from all but the last hwmod are discarded.  If the error
returns are meaningful and need corrective action (or warning messages) by
callers then these should be preserved.

...

Todd
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110510/2cc3e67a/attachment-0001.html>
