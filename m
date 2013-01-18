From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 18 Jan 2013 15:02:42 +0000
Subject: [PATCH v8 06/22] mfd: omap-usb-tll: introduce and use
 mode_needs_tll()
In-Reply-To: <1358511445-26656-7-git-send-email-rogerq@ti.com>
References: <1358511445-26656-1-git-send-email-rogerq@ti.com>
 <1358511445-26656-7-git-send-email-rogerq@ti.com>
Message-ID: <20130118150242.GF23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 18, 2013 at 02:17:09PM +0200, Roger Quadros wrote:
> +/* only PHY and UNUSED modes don't need TLL */
> +#define omap_usb_mode_needs_tll(x)	((x != OMAP_USBHS_PORT_MODE_UNUSED) &&\
> +					 (x != OMAP_EHCI_PORT_MODE_PHY))

Growl.

These parens do not make anything safer at all - they just obfuscate.  The
safe version of the above macro would have been:

#define omap_usb_mode_needs_tll(x)	((x) != OMAP_USBHS_PORT_MODE_UNUSED &&\
					 (x) != OMAP_EHCI_PORT_MODE_PHY)

If you're going to use a macro argument in an expression, it needs parens.
Simple expressions like a != b && c != d do _not_ need parens.
