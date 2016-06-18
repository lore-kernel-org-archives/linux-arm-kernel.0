From: groeck@google.com (Guenter Roeck)
Date: Sat, 18 Jun 2016 08:45:48 -0700
Subject: [v2 PATCH 2/4] phy: Add USB Type-C PHY driver for rk3399
In-Reply-To: <1465810789-22303-3-git-send-email-zyw@rock-chips.com>
References: <1465810789-22303-1-git-send-email-zyw@rock-chips.com>
 <1465810789-22303-3-git-send-email-zyw@rock-chips.com>
Message-ID: <CABXOdTd+U51KY7P-Gj6TySxoAZpJY=zcXs_4_9MVD1gnmnFH0w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chris,

On Mon, Jun 13, 2016 at 2:39 AM, Chris Zhong <zyw@rock-chips.com> wrote:
> Add a PHY provider driver for the rk3399 SoC Type-c PHY. The USB
> Type-C PHY is designed to support the USB3 and DP applications. The
> PHY basically has two main components: USB3 and DisplyPort. USB3
> operates in SuperSpeed mode and the DP can operate at RBR, HBR and
> HBR2 data rates.
>

I started integrating the driver with our code.
Doing so, I realized a problem in the way you are using extcon.

[ ... ]

> +
> +static int tcphy_pd_event(struct notifier_block *nb,
> +                         unsigned long event, void *priv)
> +{
> +       struct rockchip_typec_phy *tcphy;
> +       struct extcon_dev *edev = priv;
> +       int value = edev->state;
> +       int mode;
> +       u8 is_plugged, dfp;
> +
> +       tcphy = container_of(nb, struct rockchip_typec_phy, event_nb);
> +
> +       is_plugged = GET_PLUGGED(value);
> +       tcphy->flip = GET_FLIP(value);
> +       dfp = GET_DFP(value);
> +       tcphy->map = GET_PIN_MAP(value);
> +

I don't think it is a good idea to use the extcon 'state' field like
this. I don't even think it is possible.

The state is supposed to be a bit mask, each bit indicating if a
specific connector (or functionality) on the cable is attached. The
extcon notifier code walks through this bit mask and determines based
on changed bits if the notifier should be called. So the notifier in
this case would only be called if bit 1 (EXTCON_USB) of 'state' has
changed, but not if one of the other bits has changed. One would have
to define 32 "virtual" cables, one for each bit, for this to work, and
then you would have to register a notifier for each of the bits. That
would not really make sense.

Of course, that makes using the extcon notifier quite useless for our
purpose, since we need the callback not only if a cable has been
attached or deattached, but also if some secondary state changes. I
don't really know myself how to solve the problem; I'll need to think
about it some more. Maybe we can add a callback into the type-c
infrastructure code and somehow tie into that code, but I don't know
yet if that is feasible either.

Guenter
