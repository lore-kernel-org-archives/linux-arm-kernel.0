From: groeck@google.com (Guenter Roeck)
Date: Thu, 23 Jun 2016 14:47:18 -0700
Subject: [v3 PATCH 3/5] phy: Add USB Type-C PHY driver for rk3399
In-Reply-To: <1466686264-6744-4-git-send-email-zyw@rock-chips.com>
References: <1466686264-6744-1-git-send-email-zyw@rock-chips.com>
 <1466686264-6744-4-git-send-email-zyw@rock-chips.com>
Message-ID: <CABXOdTcZ2O7tK8yNSJH_Unap8RweUa_iW8aT3Hb_NWCZRoyAzQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chris,

On Thu, Jun 23, 2016 at 5:51 AM, Chris Zhong <zyw@rock-chips.com> wrote:
> Add a PHY provider driver for the rk3399 SoC Type-c PHY. The USB
> Type-C PHY is designed to support the USB3 and DP applications. The
> PHY basically has two main components: USB3 and DisplyPort. USB3
> operates in SuperSpeed mode and the DP can operate at RBR, HBR and
> HBR2 data rates.
>
> Signed-off-by: Chris Zhong <zyw@rock-chips.com>
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
>
[ ... ]

> +
> +static void tcphy_get_state(struct rockchip_typec_phy *tcphy,
> +                           struct extcon_dev *edev)
> +{
> +       int mode;
> +       bool plugged, flip, pin_assign, dfp, ufp, dp;
> +
> +       ufp = extcon_get_cable_state_(edev, EXTCON_USB);
> +       dfp = extcon_get_cable_state_(edev, EXTCON_USB_HOST);
> +       dp = extcon_get_cable_state_(edev, EXTCON_DISP_DP);
> +       flip = extcon_get_cable_state_(edev, EXTCON_TYPEC_POLARITY);
> +       pin_assign = extcon_get_cable_state_(edev, EXTCON_TYPEC_PIN_ASSIGN);
> +
> +       plugged = ufp | dfp | dp;
> +       tcphy->flip = flip;
> +
> +       if (plugged) {
> +               if (ufp) {
> +                       mode = MODE_UFP_USB;
> +               } else if (dfp && !dp) {
> +                       mode = MODE_DFP_USB;
> +               } else if (dfp && dp) {
> +                       mode = MODE_DFP_USB | MODE_DFP_DP;
> +                       tcphy->pin_assign = pin_assign ? PIN_MAP_D : PIN_MAP_B;
> +               } else {
> +                       mode = MODE_DFP_DP;
> +                       tcphy->pin_assign = pin_assign ? PIN_MAP_C : PIN_MAP_A;

I am having trouble extracting pin_assign from our code. What
determines if map A or C should be selected ?

Thanks,
Guenter
