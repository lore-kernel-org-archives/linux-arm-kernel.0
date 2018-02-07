From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 8 Feb 2018 00:03:10 +0100
Subject: [RFC v4 13/26] watchdog: renesas_wdt: Add restart handler
In-Reply-To: <1517423070-24236-14-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1517423070-24236-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1517423070-24236-14-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <20180207230309.goxig2irkpxrw5el@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> +static int rwdt_restart(struct watchdog_device *wdev, unsigned long action,
> +			void *data)
> +{
> +	struct rwdt_priv *priv = watchdog_get_drvdata(wdev);
> +
> +	pm_runtime_get_sync(wdev->parent);
> +
> +	rwdt_write(priv, 0x00, RWTCSRB);
> +	rwdt_write(priv, 0x00, RWTCSRA);
> +	rwdt_write(priv, 0xffff, RWTCNT);
> +
> +	while (readb_relaxed(priv->base + RWTCSRA) & RWTCSRA_WRFLG)
> +		cpu_relax();
> +
> +	rwdt_write(priv, 0x80, RWTCSRA);
> +	return 0;
> +}

I used to have this simpler version (back then for the UP case):

+	rwdt_start(wdev);
+	rwdt_write(priv, 0xffff, RWTCNT);
+	return 0;

It should still work probably...

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180208/0ab2397a/attachment.sig>
