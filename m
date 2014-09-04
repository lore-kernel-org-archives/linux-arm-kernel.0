From: broonie@kernel.org (Mark Brown)
Date: Thu, 4 Sep 2014 20:19:54 +0100
Subject: [PATCH 2/8] spi: sirf: request and free cs gpio in setup and
 cleanup callbacks
In-Reply-To: <1409648468-5436-3-git-send-email-Barry.Song@csr.com>
References: <1409648468-5436-1-git-send-email-Barry.Song@csr.com>
 <1409648468-5436-3-git-send-email-Barry.Song@csr.com>
Message-ID: <20140904191954.GO29327@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 02, 2014 at 05:01:02PM +0800, Barry Song wrote:
> From: Qipan Li <Qipan.Li@csr.com>
> 
> move spi controller's gpio request work out from probe() to spi device
> register stage, so after spi device register spi controller can deactive
> device's gpio chipselect. old code can't do it because gpio request has
> not be done until device register is finised in spi_bitbang_start.
> and add cleanup function to free CS gpio.

I'm not quite sure I understand the rationale here - as far as I can
tell this is making the GPIO request happen later not earlier so it's
not clear to me what the problem this is fixing in the existing code.
If the goal is to move the request around in the probe function why not
just move the existing code earlier in probe()?

This also won't interact well with deferred probe, though a better
solution here would be some kind of deferred device registration and
typically the link ordering will mean it won't be an issue when
everything is built in.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140904/2453b10c/attachment.sig>
