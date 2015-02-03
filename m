From: broonie@kernel.org (Mark Brown)
Date: Tue, 3 Feb 2015 12:44:41 +0000
Subject: [RFC PATCH] ASoC: wm8731: let codec to manage clock by itself
In-Reply-To: <CAOLZvyE6W8-X2_M+-KQNry2VPwLzwbBLuxr5Z5EdBQo7Skv2RQ@mail.gmail.com>
References: <1422934415-24957-1-git-send-email-voice.shen@atmel.com>
 <CAOLZvyE6W8-X2_M+-KQNry2VPwLzwbBLuxr5Z5EdBQo7Skv2RQ@mail.gmail.com>
Message-ID: <20150203124441.GK21293@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 03, 2015 at 08:54:57AM +0100, Manuel Lauss wrote:

> +    wm8731->mclk = devm_clk_get(&spi->dev, "mclk");
> +    if (IS_ERR(wm8731->mclk)) {
> +        wm8731->mclk = NULL;
> +        dev_warn(&spi->dev, "assuming static MCLK\n");
> +    }

This is broken for both deferred probe and in the case where the clock
API genuinely returns a NULL clock.  Other than that it's the kind of
thing that we've done for some other drivers, though it's not good to
have to do this.  Check them for correct behaviour.

The coding style is also not right for the whole patch and there's a
lot of missing error checking.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150203/18ab4af5/attachment.sig>
