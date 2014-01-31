From: broonie@kernel.org (Mark Brown)
Date: Fri, 31 Jan 2014 12:12:15 +0000
Subject: [PATCH 0/3] spi: core: Introduce devm_spi_alloc_master
In-Reply-To: <1391163792-21819-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1391163792-21819-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20140131121215.GB22609@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 31, 2014 at 11:23:09AM +0100, Maxime Ripard wrote:

> This patchset introduces a devm_spi_alloc_master to the spi core. While most of
> the drivers have a spi_master_put call in the probe, a lot of them using the
> devm_spi_register_master function are missing it in the remove function,
> leading to leaked resources.

This seems confusing - the idea here is that if we've handed the device
off to the managed function then the managed function deals with
destroying it.  Note that spi_alloc_master() says that the put is only
required after errors adding the device (which would be the expected
behaviour if you look at other APIs).  Looking at the code I think there
is an issue here but I'm not at all clear that this is the best fix.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140131/b7e655ca/attachment.sig>
