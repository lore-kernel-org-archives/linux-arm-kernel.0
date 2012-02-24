From: balajitk@ti.com (T Krishnamoorthy, Balaji)
Date: Fri, 24 Feb 2012 17:02:07 +0530
Subject: [PATCH v2 1/4] mmc: omap_hsmmc: Convert hsmmc driver to use
 device tree
In-Reply-To: <1329998490-27555-2-git-send-email-rnayak@ti.com>
References: <1329998490-27555-1-git-send-email-rnayak@ti.com>
 <1329998490-27555-2-git-send-email-rnayak@ti.com>
Message-ID: <CANrkHUarg5ntUW=S7k20LXuYe+ZNCN-cYJhfvvLKM=X8+Db4fg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 23, 2012 at 5:31 PM, Rajendra Nayak <rnayak@ti.com> wrote:
> Define dt bindings for the ti-omap-hsmmc, and adapt
> the driver to extract data (which was earlier passed as
> platform_data) from device tree.
>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> ---
> ?.../devicetree/bindings/mmc/ti-omap-hsmmc.txt ? ? ?| ? 31 +++++++++
> ?drivers/mmc/host/omap_hsmmc.c ? ? ? ? ? ? ? ? ? ? ?| ? 68 ++++++++++++++++++++
> ?2 files changed, 99 insertions(+), 0 deletions(-)
> ?create mode 100644 Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
>
> diff --git a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
> new file mode 100644
> index 0000000..e4fa8f0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
> @@ -0,0 +1,31 @@
> +* TI Highspeed MMC host controller for OMAP
> +
> +The Highspeed MMC Host Controller on TI OMAP family
> +provides an interface for MMC, SD, and SDIO types of memory cards.
> +
> +Required properties:
> +- compatible:
> + Should be "ti,omap2-hsmmc", for OMAP2/3 controllers

omap_hsmmc is applicable for omap2430 and omap3.
omap2420 has non high speed controller mmci-omap - drivers/mmc/host/omap.c
May be omap3-hsmmc compatible with omap2430 ?

> + Should be "ti,omap4-hsmmc", for OMAP4 controllers
> +- ti,hwmods: Must be "mmc<n>", n is controller instance starting 1
> +- reg : should contain hsmmc registers location and length
> +
> +Optional properties:
> +ti,dual-volt: boolean, supports dual voltage cards
> +<supply-name>-supply: phandle to the regulator device tree node
> +"supply-name" examples are "vmmc", "vmmc_aux" etc
> +ti,bus-width: Number of data lines, default assumed is 1 if the property is missing.
> +cd-gpios: GPIOs for card detection
> +wp-gpios: GPIOs for write protection
> +ti,non-removable: non-removable slot (like eMMC)
> +
> +Example:
> + ? ? ? mmc1: mmc at 0x4809c000 {
> + ? ? ? ? ? ? ? compatible = "ti,omap4-hsmmc";
> + ? ? ? ? ? ? ? reg = <0x4809c000 0x400>;
> + ? ? ? ? ? ? ? ti,hwmods = "mmc1";
> + ? ? ? ? ? ? ? ti,dual-volt;
> + ? ? ? ? ? ? ? ti,bus-width = <4>;
> + ? ? ? ? ? ? ? vmmc-supply = <&vmmc>; /* phandle to regulator node */
> + ? ? ? ? ? ? ? ti,non-removable;
> + ? ? ? };
