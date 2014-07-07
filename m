From: stern@rowland.harvard.edu (Alan Stern)
Date: Mon, 7 Jul 2014 10:16:09 -0400 (EDT)
Subject: [PATCH v2 3/4] USB: EHCI: tegra: Fix probe order issue leading
 to broken USB
In-Reply-To: <1404436179-10745-4-git-send-email-ttynkkynen@nvidia.com>
Message-ID: <Pine.LNX.4.44L0.1407071015470.871-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 4 Jul 2014, Tuomas Tynkkynen wrote:

> The Tegra USB complex has a particularly annoying misdesign: some of the
> UTMI pad configuration registers are global for all the 3 USB controllers
> on the chip, but those registers are located in the first controller's
> register space and will be cleared when the reset to the first
> controller is asserted. Currently, this means that if the 1st controller
> were to finish probing after the 2nd or 3rd controller, USB would not
> work at all.
> 
> Fix this situation by always resetting the 1st controller before doing
> any other setup to any of the controllers, and then never ever reset the
> first controller again. As the UTMI registers are related to the PHY,
> the PHY driver should probably reset the Tegra controllers instead,
> but since old device trees only have reset phandles in the EHCI nodes,
> do it here, which means a bit of device tree groveling. Those old DTs
> also won't get the reset fix from this commit, so we'll dev_warn() them,
> but the driver will still keep probing successfully.
> 
> Signed-off-by: Tuomas Tynkkynen <ttynkkynen@nvidia.com>
> ---
> v2 changes: assume we can find the usb1 reset from the PHY DT node,
>             don't fail if it's not found but just issue a warning
>  drivers/usb/host/ehci-tegra.c |   62 +++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 59 insertions(+), 3 deletions(-)

Acked-by: Alan Stern <stern@rowland.harvard.edu>
