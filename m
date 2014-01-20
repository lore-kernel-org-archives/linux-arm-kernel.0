From: broonie@kernel.org (Mark Brown)
Date: Mon, 20 Jan 2014 16:36:27 +0000
Subject: [PATCH 1/3] mmc: add support for power-on sequencing through DT
In-Reply-To: <1390190215-22700-2-git-send-email-olof@lixom.net>
References: <1390190215-22700-1-git-send-email-olof@lixom.net>
 <1390190215-22700-2-git-send-email-olof@lixom.net>
Message-ID: <20140120163627.GT17314@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 19, 2014 at 07:56:53PM -0800, Olof Johansson wrote:

> +	if (host->card_regulator) {

NULL is a potentially valid regulator; use IS_ERR().  Also see below...

> +		dev_dbg(host->parent, "Enabling external regulator");
> +		if (regulator_enable(host->card_regulator))
> +			dev_err(host->parent, "Failed to enable external regulator");

You should really log the error code here.

> +	host->card_regulator = regulator_get(host->parent, "card-external-vcc");
> +

...this won't handle probe deferral or other errors.  Given what this is
for it should probably be using regulator_get_optional(), the driver is
happy to carry on if a supply isn't available.  On the other hand it
just enables and disables so it's probably easier to just ignore that
and let the stub regulator get used anyway.

I have to say I do worry what happens if the device has multiple
supplies that need to be managed (which is common enough, for example
analogue and digital supplies tend to be decoupled) or if the device can
do useful things with the supplies.  In the case of SDIO it's *probably*
less relevant though I have seen applications where it might be.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140120/39e9521a/attachment.sig>
