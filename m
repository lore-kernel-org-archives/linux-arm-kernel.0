From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 27 Nov 2015 09:53:32 +0100
Subject: [linux-sunxi] Re: [PATCH v3 1/2] phy-sun4i-usb: Use
 of_match_node to get model specific config data
In-Reply-To: <5656F6F4.1040801@redhat.com>
References: <1448470202-3628-1-git-send-email-hdegoede@redhat.com>
 <CAGb2v64XL=bptxoCwiVkf8u-EfckpuASS3Foo=Q3i4a_6CaJYA@mail.gmail.com>
 <5656F6F4.1040801@redhat.com>
Message-ID: <20151127085332.GU32142@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 26, 2015 at 01:11:32PM +0100, Hans de Goede wrote:
> >>+enum sun4i_usb_phy_type {
> >>+       sun4i_a10_phy,
> >>+       sun8i_a33_phy,
> >>+};
> >>+
> >>+struct sun4i_usb_phy_cfg {
> >>+       int num_phys;
> >>+       u32 disc_thresh;
> >>+       enum sun4i_usb_phy_type type;
> >>+       bool dedicated_clocks;
> >>+};
> >>+
> >>  struct sun4i_usb_phy_data {
> >>         void __iomem *base;
> >>+       const struct sun4i_usb_phy_cfg *cfg;
> >>         struct mutex mutex;
> >>-       int num_phys;
> >>-       u32 disc_thresh;
> >>-       bool has_a33_phyctl;
> >>         struct sun4i_usb_phy {
> >>                 struct phy *phy;
> >>                 void __iomem *pmu;
> >>@@ -164,12 +174,15 @@ static void sun4i_usb_phy_write(struct sun4i_usb_phy *phy, u32 addr, u32 data,
> >>
> >>         mutex_lock(&phy_data->mutex);
> >>
> >>-       if (phy_data->has_a33_phyctl) {
> >>+       switch (phy_data->cfg->type) {
> >>+       case sun4i_a10_phy:
> >>+               phyctl = phy_data->base + REG_PHYCTL_A10;
> >
> >Any reason why this offset isn't incorporated into phy_data?
> 
> You mean in phy_data->cfg I assume, the difference needed for
> the "sun4i_usb_phy_write" functionality are not just the phyctl
> register offset...
> 
> >
> >>+               break;
> >>+       case sun8i_a33_phy:
> >>                 phyctl = phy_data->base + REG_PHYCTL_A33;
> >>                 /* A33 needs us to set phyctl to 0 explicitly */
> >>                 writel(0, phyctl);
> 
> e.g. the A33 needs this extra write, and on the H3 we need to do
> similar bitbanging, but slightly different, see:
> 
> https://github.com/allwinner-zh/linux-3.4-sunxi/blob/master/drivers/usb/host/sunxi_hci.c#L899
> 
> Notice how it uses different addr and write register addresses
> their through the usb_phy_csr_add and usb_phy_csr_write helper
> functions as well as directly poking offset 0x20.

Then it easy to support: one u8 for each register that changes, one
bool to tell if you need to clear the phyctl register or not, And you
don't have to duplicate the switch everywhere, and basically just
reimplement of_device_is_compatible without an actual compatible to
workaround the review ;)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151127/a54dd928/attachment.sig>
