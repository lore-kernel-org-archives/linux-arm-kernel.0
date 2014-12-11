From: dianders@chromium.org (Doug Anderson)
Date: Thu, 11 Dec 2014 10:09:40 -0800
Subject: [PATCH v6 1/5] phy: add a driver for the Rockchip SoC internal
 USB2.0 PHY
In-Reply-To: <1418291722-25448-2-git-send-email-lyz@rock-chips.com>
References: <1418291722-25448-1-git-send-email-lyz@rock-chips.com>
 <1418291722-25448-2-git-send-email-lyz@rock-chips.com>
Message-ID: <CAD=FV=WcAJAgj2triu1W4863BT1ew2wf-z6YNHHwiDKpnYmK4w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Yunzhi,

On Thu, Dec 11, 2014 at 1:55 AM, Yunzhi Li <lyz@rock-chips.com> wrote:
> +               rk_phy->clk = of_clk_get(child, 0);
> +               if (IS_ERR(rk_phy->clk)) {
> +                       dev_warn(dev, "failed to get clock\n");
> +                       rk_phy->clk = NULL;
> +               }

The device tree bindings don't specify a clock and the "dtsi" added to
rk3288 don't reference a clock.  Take that code out and avoid a
warning in the logs at bootup.

...or should there be a clock?


> +               rk_phy->phy = devm_phy_create(dev, NULL, &ops);

This has the wrong number of arguments.  Even before the change that
added the 4th argument, this is still wrong because "ops" is supposed
to be the 2nd argument, not the 3rd.

...so I'm confused how this compiled for you.  I think this ought to be:

rk_phy->phy = devm_phy_create(dev, child, &ops, NULL);

...but please correct me if I'm mistaken!
