From: sre@kernel.org (Sebastian Reichel)
Date: Tue, 23 Aug 2016 04:40:59 +0200
Subject: [PATCH v7 5/7] power: act8945a_charger: Add capacity level
 property
In-Reply-To: <1471848557-27278-6-git-send-email-wenyou.yang@atmel.com>
References: <1471848557-27278-1-git-send-email-wenyou.yang@atmel.com>
 <1471848557-27278-6-git-send-email-wenyou.yang@atmel.com>
Message-ID: <20160823024059.i7mvsef4t7flskcv@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Aug 22, 2016 at 02:49:15PM +0800, Wenyou Yang wrote:
> [...]
>
> +	charger->lbo_gpio = gpiod_get(dev->parent, "active-semi,lbo", GPIOD_IN);
> +	if (PTR_ERR(charger->lbo_gpio) == -EPROBE_DEFER) {
> +		dev_info(dev, "probe retry requested for gpio \"lbo\"\n");
> +	} else if (IS_ERR(charger->lbo_gpio)) {
> +		dev_err(dev, "unable to claim gpio \"lbo\"\n");
> +		charger->lbo_gpio = NULL;
> +	}
> +
> +	ret = devm_request_irq(dev, gpiod_to_irq(charger->lbo_gpio),
> +			       act8945a_status_changed,
> +			       (IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING),
> +			       "act8945a_lbo_detect", charger);
> +	if (ret)
> +		dev_info(dev, "failed to request gpio \"lbo\" IRQ\n");

that does not work, since you need to release the irq before
releasing the gpio. So if the gpio is not requested via devm_
than you can't request the irq via devm_ (actually you can by
using devm_free_irq in remove(), but then you can also drop
the devm_ alltogether).

> [...]

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160823/034aade0/attachment.sig>
