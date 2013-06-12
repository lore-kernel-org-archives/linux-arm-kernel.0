From: balbi@ti.com (Felipe Balbi)
Date: Wed, 12 Jun 2013 18:13:26 +0300
Subject: [PATCH 2/3] USB: OMAP: add omap-otg
In-Reply-To: <1370817606-1008-3-git-send-email-aaro.koskinen@iki.fi>
References: <1370817606-1008-1-git-send-email-aaro.koskinen@iki.fi>
 <1370817606-1008-3-git-send-email-aaro.koskinen@iki.fi>
Message-ID: <20130612151326.GE15056@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jun 10, 2013 at 01:40:05AM +0300, Aaro Koskinen wrote:
> +void omap_otg_set_mode(enum omap_otg_mode mode)
> +{
> +	if (!otg_dev) {
> +		WARN(1, "%s: controller not present\n", __func__);
> +		return;
> +	}
> +	mutex_lock(&otg_dev->serialize);
> +	switch (mode) {
> +	case OMAP_OTG_MODE_DEVICE:
> +		/*
> +		 * Set B-session valid.
> +		 */
> +		omap_otg_ctrl(OMAP_OTG_ID | OMAP_OTG_BSESSVLD);
> +		break;
> +	case OMAP_OTG_MODE_HOST:
> +		/*
> +		 * Set A-session valid.
> +		 */
> +		omap_otg_ctrl(OMAP_OTG_ASESSVLD);
> +		break;
> +	case OMAP_OTG_MODE_DISCONNECT:
> +		/*
> +		 * Set B-session end to indicate no VBUS.
> +		 */
> +		omap_otg_ctrl(OMAP_OTG_ID | OMAP_OTG_BSESSEND);
> +		break;
> +	default:
> +		WARN(1, "%s: unknown mode: %d\n", __func__, mode);
> +	}
> +	mutex_unlock(&otg_dev->serialize);
> +}
> +EXPORT_SYMBOL_GPL(omap_otg_set_mode);

looks like this should provide a extcon interface for its users.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130612/0e3e9e91/attachment.sig>
