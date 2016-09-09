From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Fri, 9 Sep 2016 18:14:03 +0200
Subject: [PATCH 4/7] phy: meson: add USB2 PHY support for Meson8b and GXBB
In-Reply-To: <m2sht9gkau.fsf@baylibre.com>
References: <20160904213152.25837-1-martin.blumenstingl@googlemail.com>
 <20160904213152.25837-5-martin.blumenstingl@googlemail.com>
 <m260q6jibf.fsf@baylibre.com>
 <CAFBinCA4Yvw5pbOFmJ8SqyOASADavyEPmHywSdOiUazcqe_Zmg@mail.gmail.com>
 <e3b1f611-d6f6-c98b-a53b-98e94ef5bd96@codethink.co.uk>
 <m2eg4ui0nl.fsf@baylibre.com>
 <ffdd0188-72bc-4575-f997-e8547f4c31d2@codethink.co.uk>
 <CAFBinCC4gkMrJtertYevg_hXDLJEZ0PqfKKLL5UKXo8B=SXsPw@mail.gmail.com>
 <m2sht9gkau.fsf@baylibre.com>
Message-ID: <CAFBinCCDDwydB+RP0CZKoAW5Suxotn224ZFVWvt2OGW3gNJR1g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 9, 2016 at 5:33 PM, Kevin Hilman <khilman@baylibre.com> wrote:
> However, the problem with all of the solutions proposed (runtime PM ones
> included) is that we're forcing a board-specific design issue (2 devices
> sharing a reset line) into a driver that should not have any
> board-specific assumptions in it.
>
> For example, if this driver is used on another platform where different
> PHYs have different reset lines, then one of them (the unlucky one who
> is not probed first) will never get reset.  So any form of per-device
> ref-counting is not a portable solution.
maybe we should also consider Ben's solution: he played with the USB
PHY on his Meson8b board. His approach was to have only one USB PHY
driver instance which exposes two PHYs.
The downside of this: the driver would have to know the offset of the
PHYs (0x0 for the first PHY, 0x20 for the second), but we could handle
the reset using runtime PM without any hacks.

I checked the USB PHY reference driver: it seems that there will be a
new USB PHY with the GXL/GXM SoCs.
So maybe we could live with the assumption that the PHYs are at
consecutive addresses.

> I'm not sure yet how the reset framework is supposed to handle shared
> reset lines, but that needs some investigation.  I quick glance and it
> seems that reset controllers can have shared lines, so that should be
> investigated.
unfortunately shared resets are not allowed to use reset_control_reset, see [0]


[0] http://lxr.free-electrons.com/source/drivers/reset/core.c#L102
