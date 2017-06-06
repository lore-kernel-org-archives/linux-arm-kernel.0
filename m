From: tony@atomide.com (Tony Lindgren)
Date: Tue, 6 Jun 2017 03:51:31 -0700
Subject: [PATCH 0/7] dra7: Fixes for MMC devicetree node
In-Reply-To: <1d15c9e9-f257-fd97-a9a2-055ee90d7e84@ti.com>
References: <20170601143401.16852-1-kishon@ti.com>
 <CAPDyKFqHHjZQnnaGLP=xDj3eYgzADDYoomzBuXRviBgh-n2QFw@mail.gmail.com>
 <f78dd61c-6689-4dbc-d1db-128f92be8e51@ti.com>
 <1d15c9e9-f257-fd97-a9a2-055ee90d7e84@ti.com>
Message-ID: <20170606105131.GZ3730@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kishon Vijay Abraham I <kishon@ti.com> [170606 03:40]:
> omap3-overo-base.dtsi has the following dt node for mmc.
> /* optional on board WiFi */
> &mmc2 {
>         pinctrl-names = "default";
>         pinctrl-0 = <&mmc2_pins>;
>         vmmc-supply = <&w3cbw003c_npoweron>;
>         vqmmc-supply = <&w3cbw003c_bt_nreset>;
>         vmmc_aux-supply = <&w3cbw003c_wifi_nreset>;
>         bus-width = <4>;
>         cap-sdio-irq;
>         non-removable;
> };
> 
> It has both "vqmmc-supply" and "vmmc_aux-supply". However omap-hsmmc driver has
> never parsed vqmmc so far. So I'd assume bt was never functional and it's used
> only for wifi.

Hmm yeah the vqmmc-supply probably got copied from some
other SoC for w3cbw003c.

> So for the change suggested by Ulf, Can I do something like below, so that we
> can keep wifi functional (ignoring bt since that was never functional)?
> -       vqmmc-supply = <&w3cbw003c_bt_nreset>;
> -       vmmc_aux-supply = <&w3cbw003c_wifi_nreset>;
> +       vqmmc-supply = <&w3cbw003c_wifi_nreset>;

Optional sdio pins 4 - 8 need separate power and that's
why we have the vmmc_aux supply to start with. But here
there are only four pins, so my guess is that only one
regulator is needed and the the other two are gpio pins
for wland and bt that nowadays should be handled by the
mmc power sequence driver.

Regards,

Tony
