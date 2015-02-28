From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Sat, 28 Feb 2015 14:10:22 -0800
Subject: [PATCH v4 2/2] Input: bcm-keypad: Add Broadcom keypad controller
In-Reply-To: <1425141357-7807-3-git-send-email-sbranden@broadcom.com>
References: <sbranden@broadcom.com>
 <1425141357-7807-1-git-send-email-sbranden@broadcom.com>
 <1425141357-7807-3-git-send-email-sbranden@broadcom.com>
Message-ID: <20150228221022.GA36282@dtor-ws>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Scott,

On Sat, Feb 28, 2015 at 08:35:57AM -0800, Scott Branden wrote:
> +	/* Enable clock */
> +
> +	kp->clk = devm_clk_get(&pdev->dev, "peri_clk");
> +	if (IS_ERR(kp->clk)) {
> +		dev_info(&pdev->dev,
> +			"No clock specified. Assuming it's enabled\n");

I was doing the final pass before applying and I think that this is not
quite correct, as it does not handle -EPROBE_DEFER properly which is
quite common. I think we should do something like this:

		error = PTR_ERR(kp->clk);
		if (error != -ENOENT) {
			if (error != -EPROBE_DEFER)
				dev_err(.. "Failed to get clock" ...);
			return error;
		}
		dev_dbg(... "No clock specified" ...);

No need to resubmit if you are OK with this, I can make the change
locally.

> +	}
> +	else {

Checkpach should have warned you that it should have been "} else {";
I'll fix it up locally along with few other cosmetic changes and
dropping a few extra headers.

Thanks.

-- 
Dmitry
