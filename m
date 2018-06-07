From: tony@atomide.com (Tony Lindgren)
Date: Thu, 7 Jun 2018 00:35:30 -0700
Subject: [PATCH v3 4/6] bus: ti-sysc: Add support for software reset
In-Reply-To: <20180606060826.14671-5-faiz_abbas@ti.com>
References: <20180606060826.14671-1-faiz_abbas@ti.com>
 <20180606060826.14671-5-faiz_abbas@ti.com>
Message-ID: <20180607073530.GH5738@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Faiz Abbas <faiz_abbas@ti.com> [180606 06:14]:
> +static int sysc_reset(struct sysc *ddata)
> +{
> +	int offset = ddata->offsets[SYSC_SYSCONFIG];
> +	int val = sysc_read(ddata, offset);
> +
> +	val |= (0x1 << ddata->cap->regbits->srst_shift);
> +	sysc_write(ddata, offset, val);
> +
> +	/* Poll on reset status */
> +	if (ddata->cfg.quirks & SYSC_QUIRK_RESET_STATUS) {
> +		offset = ddata->offsets[SYSC_SYSSTATUS];
> +
> +		return readl_poll_timeout(ddata->module_va + offset, val,
> +				(val & ddata->cfg.syss_mask) == 0x0,
> +				100, MAX_MODULE_SOFTRESET_WAIT);
> +	}
> +
> +	return 0;
> +}

I wonder if we should also add SYSS_QUIRK_RESET_STATUS in
addition to SYSC_QUIRK_RESET status to make it easy to
read the right register?

Then we can add support for SYSC_QUIRK_RESET_STATUS later on
when tested and return error for now.

Regards,

Tony
