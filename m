From: balbi@ti.com (Felipe Balbi)
Date: Fri, 27 Jun 2014 10:00:04 -0500
Subject: [PATCH v1 4/9] pinctrl: tegra-xusb: Add USB PHY support
In-Reply-To: <CAL1qeaHhoqEPu-j+drNiRMyeutz=qqZPxSP8H+v-sgjZSfS5tQ@mail.gmail.com>
References: <1403072180-4944-1-git-send-email-abrestic@chromium.org>
 <1403072180-4944-5-git-send-email-abrestic@chromium.org>
 <53AB493F.3030802@wwwdotorg.org>
 <CAL1qeaHhoqEPu-j+drNiRMyeutz=qqZPxSP8H+v-sgjZSfS5tQ@mail.gmail.com>
Message-ID: <20140627150004.GF8069@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 25, 2014 at 04:30:48PM -0700, Andrew Bresticker wrote:
> >> +static int usb3_phy_power_on(struct phy *phy)
> >> +{
> >> +     struct tegra_xusb_padctl *padctl = phy_get_drvdata(phy);
> >> +     int port = usb3_phy_to_port(phy);
> >> +     int lane = padctl->usb3_ports[port].lane;
> >> +     u32 value, offset;
> >> +
> >> +     value = padctl_readl(padctl, XUSB_PADCTL_IOPHY_USB3_PADX_CTL2(port));
> >> +     value &= ~((XUSB_PADCTL_IOPHY_USB3_PAD_CTL2_RX_WANDER_MASK <<
> >> +                 XUSB_PADCTL_IOPHY_USB3_PAD_CTL2_RX_WANDER_SHIFT) |
> >> +                (XUSB_PADCTL_IOPHY_USB3_PAD_CTL2_RX_EQ_MASK <<
> >> +                 XUSB_PADCTL_IOPHY_USB3_PAD_CTL2_RX_EQ_SHIFT) |
> >> +                (XUSB_PADCTL_IOPHY_USB3_PAD_CTL2_CDR_CNTL_MASK <<
> >> +                 XUSB_PADCTL_IOPHY_USB3_PAD_CTL2_CDR_CNTL_SHIFT));
> >
> > Hmm. So there is a lot of "PHY" stuff here after all.
> >
> > However, the PHYs implemented here appear to implement very low-level
> > I/O pad code, whereas the PHYs we have for our USB 2.0 controller are
> > somewhat higher-level; they're more USB-oriented than just IO pad
> > oriented. Do you know which level of abstraction a Linux PHY object is
> > supposed to be? I could never get an answer when I asked before.
> 
> The only other PHY driver I've worked with (Exynos USB2/3 PHYs) also
> mainly only did low-level pad control stuff, but looking at a couple
> of other USB PHYs (MSM, MV), there appear to be others that have
> higher-level USB stuff in the PHY driver.  Perhaps Kishon or Felipe
> could offer us some guidance?

well, if you're adding a new driver, I'd rather see folks moving over to
the generic phy framework (drivers/phy) because we're trying really hard
to get rid of drivers/usb/phy/. And I think, in your case, it's actually
ok to use pinctrl because you actually are muxing pads to the USB3 PHY,
you just do it lazyly.

my 2 cents

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140627/87a7c7d7/attachment.sig>
