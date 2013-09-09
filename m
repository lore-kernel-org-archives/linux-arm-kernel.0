From: broonie@kernel.org (Mark Brown)
Date: Mon, 9 Sep 2013 16:40:28 +0100
Subject: [PATCH RESEND 1/2] i2c: prepare runtime PM support for I2C
 client devices
In-Reply-To: <1378733679-19500-2-git-send-email-mika.westerberg@linux.intel.com>
References: <1378733679-19500-1-git-send-email-mika.westerberg@linux.intel.com>
 <1378733679-19500-2-git-send-email-mika.westerberg@linux.intel.com>
Message-ID: <20130909154028.GP29403@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 09, 2013 at 04:34:38PM +0300, Mika Westerberg wrote:

> +	/*
> +	 * Enable runtime PM for the client device. If the client wants to
> +	 * participate on runtime PM it should call pm_runtime_put() in its
> +	 * probe() callback.
> +	 *
> +	 * User still needs to allow the PM runtime before it can actually
> +	 * happen.
> +	 */
> +	pm_runtime_forbid(&client->dev);
> +	pm_runtime_get_noresume(&client->dev);
> +	pm_runtime_set_active(&client->dev);
> +	pm_runtime_enable(&client->dev);

How is this going to interact with client devices which are already
enabling runtime PM for themselves, and what are the advantages of doing
this over having the client device enable runtime PM for itself (given
that the client still needs an explicit put() adding)?

Given that it's relatively common for devices to have both I2C and SPI
control it seems like it'd be sensible to keep the policy common between
the two buses to simplify driver implementation.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130909/5e302705/attachment.sig>
