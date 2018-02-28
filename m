From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 28 Feb 2018 09:32:14 +0100
Subject: [PATCH 3/3] mailbox: sunxi-msgbox: Add a new mailbox driver
In-Reply-To: <20180228022714.30068-4-samuel@sholland.org>
References: <20180228022714.30068-1-samuel@sholland.org>
 <20180228022714.30068-4-samuel@sholland.org>
Message-ID: <20180228083214.h4oi2kmjjqmoyfhn@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 27, 2018 at 08:27:14PM -0600, Samuel Holland wrote:
> +	/*
> +	 * The failure path should not disable the clock or assert the reset,
> +	 * because the PSCI implementation in firmware relies on this device
> +	 * being functional. Claiming the clock in this driver is required to
> +	 * prevent Linux from turning it off.
> +	 */
> +	ret = clk_prepare_enable(clk);
> +	if (ret) {
> +		dev_err(dev, "Failed to enable bus clock: %d\n", ret);
> +		return ret;
> +	}

You don't need it to be always on though. You only need it to be
enabled when you access the registers (on both sides I guess?). So you
could very well enable the clock in your registers accessors in Linux,
and do the same in the ARISC firmware. That should work.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180228/707f091c/attachment.sig>
