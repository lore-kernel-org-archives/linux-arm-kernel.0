From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Wed, 4 Feb 2015 05:04:18 -0800
Subject: [PATCH v2 1/3] usb: XHCI: platform: Move the Marvell quirks
 after the enabling the clocks
In-Reply-To: <20150204093522.GB5492@lukather>
References: <1421672474-2945-1-git-send-email-maxime.ripard@free-electrons.com>
 <1421672474-2945-2-git-send-email-maxime.ripard@free-electrons.com>
 <20150204093522.GB5492@lukather>
Message-ID: <20150204130418.GB5659@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 04, 2015 at 10:35:22AM +0100, Maxime Ripard wrote:
> Hi Mathias, Greg,
> 
> On Mon, Jan 19, 2015 at 02:01:12PM +0100, Maxime Ripard wrote:
> > The commit 973747928514 ("usb: host: xhci-plat: add support for the Armada
> > 375/38x XHCI controllers") extended the xhci-plat driver to support the Armada
> > 375/38x SoCs, mostly by adding a quirk configuring the MBUS window.
> > 
> > However, that quirk was run before the clock the controllers needs has been
> > enabled. This usually worked because the clock was first enabled by the
> > bootloader, and left as such until the driver is probe, where it tries to
> > access the MBUS configuration registers before enabling the clock.
> > 
> > Things get messy when EPROBE_DEFER is involved during the probe, since as part
> > of its error path, the driver will rightfully disable the clock. When the
> > driver will be reprobed, it will retry to access the MBUS registers, but this
> > time with the clock disabled, which hangs forever.
> > 
> > Fix this by running the quirks after the clock has been enabled by the driver.
> > 
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > Cc: <stable@vger.kernel.org> # v3.16+
> 
> Any chance for this to go in 3.19?

For 3.19?  It's too late, I'm not sending anything else to Linus as 3.19
will be out in a few days.

thanks,

greg k-h
