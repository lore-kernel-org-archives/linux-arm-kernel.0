From: broonie@kernel.org (Mark Brown)
Date: Thu, 12 Jun 2014 00:42:12 +0100
Subject: [PATCH] spi/pxa2xx: fix incorrect SW mode chipselect setting for
 BayTrail LPSS SPI
In-Reply-To: <1402502222-19520-1-git-send-email-chiau.ee.chew@intel.com>
References: <1402502222-19520-1-git-send-email-chiau.ee.chew@intel.com>
Message-ID: <20140611234212.GR5099@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 11, 2014 at 11:57:02PM +0800, Chew Chiau Ee wrote:

> It was observed that after module removal followed by insertion,
> the SW mode chipselect is not properly set. Thus causing transfer
> failure due to incorrect CS toggling.

> -	value &= ~SPI_CS_CONTROL_SW_MODE;
> +	orig = value &= ~SPI_CS_CONTROL_SW_MODE;
>  	writel(value, drv_data->ioaddr + offset + SPI_CS_CONTROL);
>  	value = readl(drv_data->ioaddr + offset + SPI_CS_CONTROL);
>  	if (value != orig) {

This is a *really* non-obvious fix, I'd have expected the original value
to be re-read from the hardware here rather than just tweaked, or at
least some comment explaining what's going on.  Possibly also saving to
a differently named temporary variable would do it but whatever I had to
go look at the context to figure out what was happening and even there I
was unclear.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140612/37f43ef6/attachment.sig>
