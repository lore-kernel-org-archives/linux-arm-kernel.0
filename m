From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 4 Feb 2015 10:35:22 +0100
Subject: [PATCH v2 1/3] usb: XHCI: platform: Move the Marvell quirks
 after the enabling the clocks
In-Reply-To: <1421672474-2945-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1421672474-2945-1-git-send-email-maxime.ripard@free-electrons.com>
 <1421672474-2945-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20150204093522.GB5492@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mathias, Greg,

On Mon, Jan 19, 2015 at 02:01:12PM +0100, Maxime Ripard wrote:
> The commit 973747928514 ("usb: host: xhci-plat: add support for the Armada
> 375/38x XHCI controllers") extended the xhci-plat driver to support the Armada
> 375/38x SoCs, mostly by adding a quirk configuring the MBUS window.
> 
> However, that quirk was run before the clock the controllers needs has been
> enabled. This usually worked because the clock was first enabled by the
> bootloader, and left as such until the driver is probe, where it tries to
> access the MBUS configuration registers before enabling the clock.
> 
> Things get messy when EPROBE_DEFER is involved during the probe, since as part
> of its error path, the driver will rightfully disable the clock. When the
> driver will be reprobed, it will retry to access the MBUS registers, but this
> time with the clock disabled, which hangs forever.
> 
> Fix this by running the quirks after the clock has been enabled by the driver.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: <stable@vger.kernel.org> # v3.16+

Any chance for this to go in 3.19?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150204/6c6f3cf9/attachment.sig>
