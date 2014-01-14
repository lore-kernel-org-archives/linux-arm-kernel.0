From: stern@rowland.harvard.edu (Alan Stern)
Date: Tue, 14 Jan 2014 14:18:08 -0500 (EST)
Subject: [PATCH v5 2/2] ehci-platform: Add support for clks and phy passed
 through devicetree
In-Reply-To: <1389653115-11028-3-git-send-email-hdegoede@redhat.com>
Message-ID: <Pine.LNX.4.44L0.1401141413430.1310-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 13 Jan 2014, Hans de Goede wrote:

> Currently ehci-platform is only used in combination with devicetree when used
> with some Via socs. By extending it to (optionally) get clks and a phy from
> devicetree, and enabling / disabling those on power_on / off, it can be used
> more generically. Specifically after this commit it can be used for the
> ehci controller on Allwinner sunxi SoCs.
> 
> Since ehci-platform is intended to handle any generic enough non pci ehci
> device, add a "usb-ehci" compatibility string.
> 
> There already is a usb-ehci device-tree bindings document, update this
> with clks and phy bindings info.
> 
> Although actually quite generic so far the via,vt8500 compatibilty string
> had its own bindings document. Somehow we even ended up with 2 of them. Since
> these provide no extra information over the generic usb-ehci documentation,
> this patch removes them.
> 
> The ehci-ppc-of.c driver also claims the usb-ehci compatibility string,
> even though it mostly is ibm,usb-ehci-440epx specific. ehci-platform.c is
> not needed on ppc platforms, so add a !PPC_OF dependency to it to avoid
> 2 drivers claiming the same compatibility string getting build on ppc.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Same comment as the ohci-platform patch.

Oh, and one other thing I almost missed.  (This applies to both 
patches.)

> +static int ehci_platform_power_on(struct platform_device *dev)
> +{
> +	struct usb_hcd *hcd = platform_get_drvdata(dev);
> +	struct ehci_platform_priv *priv = hcd_to_ehci_priv(hcd);
> +	int clk, ret;
> +
> +	for (clk = 0; priv->clks[clk] && clk < EHCI_MAX_CLKS; clk++) {

Here and in ehci_platform_remove, you need to check clk < EHCI_MAX_CLKS
_before_ dereferencing priv->clks[clk].  Yes, it probably won't make
any difference in real life, but it's still wrong in principle.  In
fact, this is the sort of thing a static checker might find.

Alan Stern
