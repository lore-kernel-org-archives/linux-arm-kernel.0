From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Tue, 23 Apr 2013 10:17:02 -0700
Subject: [PATCH 18/21] usb: phy: tegra: don't call into tegra-ehci directly
In-Reply-To: <1366734653-488286-19-git-send-email-arnd@arndb.de>
References: <1366734653-488286-1-git-send-email-arnd@arndb.de>
 <1366734653-488286-19-git-send-email-arnd@arndb.de>
Message-ID: <20130423171701.GA31397@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 23, 2013 at 06:30:50PM +0200, Arnd Bergmann wrote:
> Both phy-tegra-usb.c and ehci-tegra.c export symbols used by the other one,
> which does not work if one of them or both are loadable modules, resulting
> in an error like:
> 
> drivers/built-in.o: In function `utmi_phy_clk_disable':
> drivers/usb/phy/phy-tegra-usb.c:302: undefined reference to `tegra_ehci_set_phcd'
> drivers/built-in.o: In function `utmi_phy_clk_enable':
> drivers/usb/phy/phy-tegra-usb.c:324: undefined reference to `tegra_ehci_set_phcd'
> drivers/built-in.o: In function `utmi_phy_power_on':
> drivers/usb/phy/phy-tegra-usb.c:447: undefined reference to `tegra_ehci_set_pts'
> 
> This turns the interface into a one-way dependency by letting the tegra ehci
> driver pass two function pointers for callbacks that need to be called by
> the phy driver.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Venu Byravarasu <vbyravarasu@nvidia.com>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Stephen Warren <swarren@nvidia.com>
> Cc: linux-usb at vger.kernel.org
> ---
>  drivers/usb/host/ehci-tegra.c     | 10 +++++-----
>  drivers/usb/phy/tegra_usb_phy.c   | 13 +++++++++----
>  include/linux/usb/tegra_usb_phy.h | 10 +++++-----
>  3 files changed, 19 insertions(+), 14 deletions(-)

Not all of these files are in my usb-next tree, so I can't take this
patch, sorry.

greg k-h
