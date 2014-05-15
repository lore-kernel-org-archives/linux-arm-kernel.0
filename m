From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 15 May 2014 13:33:51 -0600
Subject: [RFC PATCH 00/10] Tegra XHCI support
In-Reply-To: <1400113986-339-1-git-send-email-abrestic@chromium.org>
References: <1400113986-339-1-git-send-email-abrestic@chromium.org>
Message-ID: <5375169F.3060809@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/14/2014 06:32 PM, Andrew Bresticker wrote:
> This is a first pass at the host and PHY drivers necessary for USB3.0
> support on Tegra114 and Tegra124.  The Tegra XHCI host controller requires
> external firmware [1] which must be loaded before using any USB ports owned
> by the controller.  The XUSB PHY driver handles mapping and enabling of
> the UTMI, HSIC, and SuperSpeed pads to the XHCI controller.
> 
> Tested on a Venice2 with a variety of USB2.0 and USB3.0 memory sticks
> and ethernet dongles.  
> 
> Notes:
>  - I've included support for Tegra114, but since I don't have Tegra114-based
>    hardware, it is completely untested.
>  - The PCIe and SATA PHYs also are programmed using the XUSB_PADCTL space
>    as well.  At least some of the code can be re-used, specifically with
>    respect to lane programming.  I believe Thierry is working on the PCIe
>    parts of this.

If I understand the HW correctly, there's a separate "pad control" HW
block that provides routing/sharing of signals from USB2(?), USB3, SATA,
and PCIe to the pads.

I believe Thierry is working on exposing this block as a pinctrl driver,
or at least something that the other drivers can call into in order to
configure that block. It'd be good if you can co-ordinate with him to
rebase this driver on top of that, rather than (I assume; haven't read
the code yet...) directly manipulating the padctrl registers inside each
of the different drivers. Co-ordinating that could turn out to be
problematic, and presumably if each driver does its own thing, we end up
duplicating defines, code, and DT bindings for configuring the padctrl HW.
