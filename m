From: toddpoynor@google.com (Todd Poynor)
Date: Sat, 7 May 2011 10:54:34 -0700
Subject: [PATCH 1/2] OMAP2+: hwmod: Add API to enable IO ring wakeup.
In-Reply-To: <1304676557-15613-2-git-send-email-govindraj.raja@ti.com>
References: <1304676557-15613-1-git-send-email-govindraj.raja@ti.com>
	<1304676557-15613-2-git-send-email-govindraj.raja@ti.com>
Message-ID: <BANLkTikoYy1E2vyFjR-fKqOsC7B-xWDWbw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 6, 2011 at 3:09 AM, Govindraj.R <govindraj.raja@ti.com> wrote:

> ...
> +
> +/**
> + * omap_hwmod_enable_ioring_wakeup - Set wakeup bit for iopad ring.
> + * @oh: struct omap_hwmod *
> + * @enable: based on 0 or 1 set or unset wakeup bit.
> + *
> + * Traverse through dynamic pads, if pad is enabled then
> + * set wakeup enable bit flag for the mux pin. Wakeup pad bit
> + * will be set during hwmod idle transistion.
> + * Return error if pads are not enabled or not available.
> + */
> +int omap_hwmod_enable_ioring_wakeup(struct omap_hwmod *oh, bool enable)
> +{
> +       struct omap_device_pad *pad;
> +       int ret = -EINVAL, j;
> +       int val = 0;
> +
> +       /* Enable pin mux to make pad wake-up capable */
> +       if (enable)
> +               val = OMAP_WAKEUP_EN;
> +       else
> +               val = ~OMAP_WAKEUP_EN;
> +
> +       if (oh->mux->enabled) {
> +               for (j = 0; j < oh->mux->nr_pads_dynamic; j++) {
> +                       pad = oh->mux->pads_dynamic[j];
> +                       if (pad->flags & OMAP_DEVICE_PAD_WAKEUP) {
> +                               pad->idle = pad->enable | val;
>

I haven't gone to find the patch uses the pad->idle value (or the TRM docs),
but the !enable case that OR's in every bit except for OMAP_WAKEUP_EN seems
strange, should the non-wakeup-enabled idle value for the pad set all other
bits in that reg?

..

Todd
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110507/796e9df6/attachment-0001.html>
