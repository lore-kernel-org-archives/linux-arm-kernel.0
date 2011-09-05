From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 5 Sep 2011 11:33:39 +0100
Subject: [PATCH] [media] at91: add code to initialize and manage the
	ISI_MCK for Atmel ISI driver.
In-Reply-To: <1315218593-10822-1-git-send-email-josh.wu@atmel.com>
References: <1315218593-10822-1-git-send-email-josh.wu@atmel.com>
Message-ID: <20110905103339.GG6619@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 05, 2011 at 06:29:53PM +0800, Josh Wu wrote:
> +static int initialize_mck(struct atmel_isi *isi,
> +			struct isi_platform_data *pdata)
> +{
> +	int ret;
> +	struct clk *pck_parent;
> +
> +	if (!strlen(pdata->pck_name) || !strlen(pdata->pck_parent_name))
> +		return -EINVAL;
> +
> +	/* ISI_MCK is provided by PCK clock */
> +	isi->mck = clk_get(NULL, pdata->pck_name);

No, this is not how you use the clk API.  You do not pass clock names via
platform data.

You pass clk_get() the struct device.  You then pass clk_get() a
_connection id_ on that _device_ if you have more than one struct clk
associated with the _device_.  You then use clkdev to associate the
struct device plus the connection id with the appropriate struct clk.
