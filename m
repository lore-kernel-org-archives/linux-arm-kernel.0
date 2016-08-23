From: hverkuil@xs4all.nl (Hans Verkuil)
Date: Tue, 23 Aug 2016 10:03:03 +0200
Subject: [PATCH RFC 4/5] drm/bridge: add dw-hdmi cec driver using Hans
 Verkil's CEC code
In-Reply-To: <E1bYDEs-0004rs-FP@rmk-PC.armlinux.org.uk>
References: <20160812141421.GB1041@n2100.armlinux.org.uk>
 <E1bYDEs-0004rs-FP@rmk-PC.armlinux.org.uk>
Message-ID: <57BC0337.2080203@xs4all.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On 08/12/16 16:15, Russell King wrote:
> +	ret = devm_request_threaded_irq(&pdev->dev, cec->irq,
> +					dw_hdmi_cec_hardirq,
> +					dw_hdmi_cec_thread, IRQF_SHARED,
> +					DEV_NAME, cec->adap);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = cec_register_adapter(cec->adap);
> +	if (ret < 0)
> +		return ret;
> +
> +	/*
> +	 * CEC documentation says we must not call cec_delete_adapter
> +	 * after a successful call to cec_register_adapter().
> +	 */
> +	devm_remove_action(&pdev->dev, dw_hdmi_cec_del, cec);
> +
> +	hdmi_register_notifier(&cec->nb);

The notifier is registered here, but who provides CEC with the initial
physical address? As I understand it, it only tells you when things change,
not what the initial state is.

Regards,

	Hans
