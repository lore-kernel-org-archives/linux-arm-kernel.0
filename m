From: sre@kernel.org (Sebastian Reichel)
Date: Fri, 19 Aug 2016 17:50:32 +0200
Subject: [PATCH v6 3/7] power: act8945a_charger: Add status change update
 support
In-Reply-To: <1471569215-6046-4-git-send-email-wenyou.yang@atmel.com>
References: <1471569215-6046-1-git-send-email-wenyou.yang@atmel.com>
 <1471569215-6046-4-git-send-email-wenyou.yang@atmel.com>
Message-ID: <20160819155032.3efkx7cizhh5viv4@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Aug 19, 2016 at 09:13:31AM +0800, Wenyou Yang wrote:
>  - Fix the 'dev' argument of devm_request_irq() to pdev->dev.parent.

This is not a fix.

> +	ret = devm_request_irq(pdev->dev.parent, irq, act8945a_status_changed,
> +			       IRQF_TRIGGER_FALLING, "act8945a_interrupt",
> +			       charger);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to request nIRQ pin IRQ\n");
> +		return ret;
> +	}

This will result in the irq not being free'd during device remove,
but when the parent device is removed.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160819/98823aed/attachment.sig>
