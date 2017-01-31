From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 31 Jan 2017 20:43:11 +0530
Subject: [PATCH v7 11/14] sata: ahci-da850: un-hardcode the MPY bits
In-Reply-To: <1485770531-6772-12-git-send-email-bgolaszewski@baylibre.com>
References: <1485770531-6772-1-git-send-email-bgolaszewski@baylibre.com>
 <1485770531-6772-12-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <3bcc927a-f074-7f18-cdeb-e40655c39118@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 30 January 2017 03:32 PM, Bartosz Golaszewski wrote:

> +	/*
> +	 * The second clock used by ahci-da850 is the external REFCLK. If we
> +	 * didn't get it from ahci_platform_get_resources(), let's try to
> +	 * specify the con_id in clk_get().
> +	 */
> +	if (!hpriv->clks[1]) {
> +		clk = clk_get(dev, "refclk");
> +		if (IS_ERR(clk)) {
> +			dev_err(dev, "unable to obtain the reference clock");
> +			return -ENODEV;
> +		} else {
> +			hpriv->clks[1] = clk;
> +		}

This results in a checkpatch warning about the unneeded else. I fixed 
this locally to look like:

+        */
+       if (!hpriv->clks[1]) {
+               clk = clk_get(dev, "refclk");
+               if (IS_ERR(clk)) {
+                       dev_err(dev, "unable to obtain the reference clock");
+                       return -ENODEV;
+               }
+
+               hpriv->clks[1] = clk;
+       }

Thanks,
Sekhar
